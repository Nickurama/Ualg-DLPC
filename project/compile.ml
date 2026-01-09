
(* Code generation *)

open Format
open X86_64
open Ast
open Dyn_list

module Constants = struct
    let constants_label_i8 = ".csts_i8"
    let constants_label_i16 = ".csts_i16"
    let constants_label_i32 = ".csts_i32"
    let constants_label_i64 = ".csts_i64"
    let constants_label_f32 = ".csts_f32"
    let constants_label_f64 = ".csts_f64"

    let g_var_label_i8 = ".gvar_i8"
    let g_var_label_i16 = ".gvar_i16"
    let g_var_label_i32 = ".gvar_i32"
    let g_var_label_i64 = ".gvar_i64"
    let g_var_label_f32 = ".gvar_f32"
    let g_var_label_f64 = ".gvar_f64"

    let main_func_name = "main"
end

(* Exception to raise when a variable (local or global) isn't used as intended *)
exception VarUndef of string (* variable not defined *)
exception VarDup of string (* duplicate variable *)
exception VarTy of string
exception FuncWrongArgs of string
exception FuncNoMain of string
exception FuncNoReturn of string

(* Frame size, in bytes (each local variables occupies 8 bytes) *)
let frame_size = ref 0

(* type bit_size = *)
(*     | T_8bit *)
(*     | T_16bit *)
(*     | T_32bit *)
(*     | T_64bit *)
(*     | T_f32bit *)
(*     | T_f64bit *)

type var_info = {
    pos: int;
    var_type: ty;
}

type func_var = {
    func: string;
    var: string;
    scope: int;
}

type typed_var = {
    id: string;
    var_type: ty;
    scope: int;
}

type var_nature =
    | Local
    | Argument
    | Global

type i_var = {
    i_value: int64;
    v_type: ty;
}

type f_var = {
    f_value: float;
    v_type: ty;
}

type func_data = {
    ret_type: ty;
    args: typed_var list;
}

(* Global variables *)
let (global_vars: (string, var_info) Hashtbl.t) = Hashtbl.create 17 (* string -> pos, type, bits *)

let g_vars_i8 = dl_create ()
let g_vars_i16 = dl_create ()
let g_vars_i32 = dl_create ()
let g_vars_i64 = dl_create ()
let g_vars_f32 = dl_create ()
let g_vars_f64 = dl_create ()

(* Constant pool *)
let (constants_int: (i_var, var_info) Hashtbl.t) = Hashtbl.create 17
let (constants_float: (f_var, var_info) Hashtbl.t) = Hashtbl.create 17

let constants_i8 = dl_create ()
let constants_i16 = dl_create ()
let constants_i32 = dl_create ()
let constants_i64 = dl_create ()
let constants_f32 = dl_create ()
let constants_f64 = dl_create ()

(* local variables *)
let (local_vars: (func_var, var_info) Hashtbl.t) = Hashtbl.create 17
let (func_vars: (string, typed_var dyn_list) Hashtbl.t) = Hashtbl.create 17
let (func_args: (string, typed_var dyn_list) Hashtbl.t) = Hashtbl.create 17

(* function data *)
let (function_data: (string, func_data) Hashtbl.t) = Hashtbl.create 17
let (func_ifs: (string, int ref)  Hashtbl.t) = Hashtbl.create 17

let gen_func_name x =
    ".f_" ^ x

let type_bytes = function
    | NoType -> raise (VarUndef "Variable with no type! (push arg)") (* not supposed to happen *)
    | TInt -> 4
    | TLong -> 8
    | TFloat -> 4
    | TDouble -> 8

(* let pop_val t reg = *)
(*     movl (ind rsp) reg ++ *)
(*     addq (imm (type_bytes t)) !%rsp *)
(**)
(* let push_val t reg = *)
(*     subq (imm (type_bytes t)) !%rsp ++ *)
(*     movl reg (ind rsp) *)

let pop_int32 r =
    movl (ind rsp) r ++
    addq (imm (type_bytes TInt)) !%rsp

let push_int32 r =
    subq (imm (type_bytes TInt)) !%rsp ++
    movl r (ind rsp)

let pop_int64 r =
    movq (ind rsp) r ++
    addq (imm (type_bytes TLong)) !%rsp

let push_int64 r =
    subq (imm (type_bytes TLong)) !%rsp ++
    movq r (ind rsp)

let pop_float32 r =
    movss (ind rsp) r ++
    addq (imm (type_bytes TFloat)) !%rsp

let push_float32 r =
    subq (imm (type_bytes TFloat)) !%rsp ++
    movss r (ind rsp)

let pop_float64 r =
    movsd (ind rsp) r ++
    addq (imm (type_bytes TDouble)) !%rsp

let push_float64 r =
    subq (imm (type_bytes TDouble)) !%rsp ++
    movsd r (ind rsp)

let convert from_t to_t =
    (* pop *)
    (* convert *)
    (* push *)
    match (from_t, to_t) with
    | (NoType, _) | (_, NoType) -> raise (VarUndef "Variable with no type! (convert)") (* not supposed to happen *)
    | (TInt, TInt) | (TLong, TLong) | (TFloat, TFloat) | (TDouble, TDouble) -> nop
    | (TInt, TLong) ->
        pop_int32 !%eax ++
        movslq !%eax rax ++
        push_int64 !%rax
    | (TInt, TFloat) ->
        pop_int32 !%eax ++
        cvtsi2ssl !%eax !%xmm0 ++
        push_float32 !%xmm0
    | (TInt, TDouble) ->
        pop_int32 !%eax ++
        cvtsi2sdl !%eax !%xmm0 ++
        push_float64 !%xmm0
    | (TLong, TInt) ->
        pop_int64 !%rax ++
        movl !%eax !%eax ++
        push_int32 !%eax
    | (TLong, TFloat) ->
        pop_int64 !%rax ++
        cvtsi2ssq !%rax !%xmm0 ++
        push_float32 !%xmm0
    | (TLong, TDouble) ->
        pop_int64 !%rax ++
        cvtsi2sdq !%rax !%xmm0 ++
        push_float64 !%xmm0
    | (TFloat, TInt) ->
        pop_float32 !%xmm0 ++
        cvttss2si !%xmm0 !%eax ++
        push_int32 !%eax
    | (TFloat, TLong) ->
        pop_float32 !%xmm0 ++
        cvttss2siq !%xmm0 !%rax ++
        push_int64 !%rax
    | (TFloat, TDouble) ->
        pop_float32 !%xmm0 ++
        cvtss2sd !%xmm0 !%xmm0 ++
        push_float64 !%xmm0
    | (TDouble, TInt) ->
        pop_float64 !%xmm0 ++
        cvttsd2si !%xmm0 !%eax ++
        push_int32 !%eax
    | (TDouble, TLong) ->
        pop_float64 !%xmm0 ++
        cvttsd2siq !%xmm0 !%rax ++
        push_int64 !%rax
    | (TDouble, TFloat) ->
        pop_float64 !%xmm0 ++
        cvtsd2ss !%xmm0 !%xmm0 ++
        push_float32 !%xmm0


let find_highest_scope_matching_var_for_map f_id var_id map max_scope =
    let dummy_var = { id = ""; var_type = NoType; scope = -1 } in
    if (Hashtbl.mem map f_id) then begin
        let f_vars = !((Hashtbl.find map f_id).items) in
        let matches = List.fold_right (fun x acc -> if x.id = var_id then x :: acc else acc) f_vars [] in
        List.fold_right (
            fun x acc -> if x.scope > acc.scope && x.scope <= max_scope then x else acc
        ) matches dummy_var
    end
    else dummy_var

let find_highest_scope_matching_var f_id var_id scope =
    let vars_highest_matching = find_highest_scope_matching_var_for_map f_id var_id func_vars scope in
    let args_highest_matching = find_highest_scope_matching_var_for_map f_id var_id func_args scope in

    if (vars_highest_matching.scope > args_highest_matching.scope ) then vars_highest_matching
    else args_highest_matching

let get_bytes_until_local_var f_id var_id =
    let l_vars = !((Hashtbl.find func_vars f_id).items) in
    let local_var_type = ref NoType in
    let previous_vars = List.fold_right (
        fun x acc ->
            if !local_var_type = NoType then begin
                if var_id = x.id then
                    (local_var_type := x.var_type);
                x :: acc
            end
            else acc
    ) l_vars [] in
    (List.fold_right (fun x acc -> acc + (type_bytes x.var_type)) previous_vars 0)

let get_bytes_after_arg_var f_id var_id =
    let l_vars = !((Hashtbl.find func_args f_id).items) in
    let local_var_type = ref NoType in
    let following_vars = List.fold_left (
        fun acc x ->
            if !local_var_type = NoType then begin
                if var_id = x.id then
                    (local_var_type := x.var_type);
                x :: acc
            end
            else acc
    ) [] l_vars in
    (List.fold_right (fun x acc -> acc + (type_bytes x.var_type)) following_vars 0) - (type_bytes !local_var_type)

let get_var_nature f_id scope var_id =
    let vars_highest_matching = find_highest_scope_matching_var_for_map f_id var_id func_vars scope in
    let args_highest_matching = find_highest_scope_matching_var_for_map f_id var_id func_args scope in

    if vars_highest_matching.scope >= 0 then
        Local
    else if args_highest_matching.scope >= 0 then
        Argument
    else if Hashtbl.mem global_vars var_id then
        Global
    else
        raise (VarUndef ("Variable '" ^ var_id ^ "' doesn't exist!?"))

let get_var_pos f_id scope var_id var_t =
    let curr_var_nature = get_var_nature f_id scope var_id in
    match curr_var_nature with
    | Local ->
        Int64.of_int (get_bytes_until_local_var f_id var_id)
    | Argument ->
        Int64.of_int ((get_bytes_after_arg_var f_id var_id) + 16)
    | Global ->
        let pos = (Hashtbl.find global_vars var_id).pos in
        Int64.of_int ((type_bytes var_t) * pos)

let move_to_based_on_nature lbl real_pos = function
    | Local -> (ind64 ~ofs:(Int64.neg real_pos) rbp)
    | Argument -> (ind64 ~ofs:(real_pos) rbp)
    | Global -> (label_ref lbl real_pos)

let infer_type = function
    | ICst i -> TInt
    | LCst i -> TLong
    | FCst i -> TFloat
    | DCst i -> TDouble
    | Var (t, x) -> t
    | Binop (t_result, t_true, o, t1, e1, t2, e2) -> t_result
    | FunCall (f_id, args) ->
        if not (Hashtbl.mem function_data f_id) then
            raise (VarUndef ("Undefined function '" ^ f_id ^ "'."));
        (Hashtbl.find function_data f_id).ret_type

(* Expression compilation *)
let rec compile_expr f_id scope = function
    | ICst i ->
        let i_64 = {i_value = Int64.of_int32 i; v_type = TInt}in
        let lbl = Constants.constants_label_i32 in

        if not (Hashtbl.mem constants_int i_64) then begin
            Hashtbl.add constants_int (i_64) {pos = dl_length constants_i32; var_type = TInt};
            dl_push constants_i32 i
        end;

        let pos = (Hashtbl.find constants_int i_64).pos in
        let rel_pos = Int64.of_int (4 * pos) in

        movl (label_ref lbl rel_pos) !%eax ++
        push_int32 !%eax
    | LCst i ->
        let i_64 = {i_value = i; v_type = TLong} in
        let lbl = Constants.constants_label_i64 in

        if not (Hashtbl.mem constants_int i_64) then begin
            Hashtbl.add constants_int (i_64) {pos = dl_length constants_i64; var_type = TLong};
            dl_push constants_i64 i
        end;

        let pos = (Hashtbl.find constants_int i_64).pos in
        let rel_pos = Int64.of_int (8 * pos) in

        movq (label_ref lbl rel_pos) !%rax ++
        push_int64 !%rax
    | FCst i ->
        let var = {f_value = i; v_type = TFloat} in
        let lbl = Constants.constants_label_f32 in

        if not (Hashtbl.mem constants_float var) then begin
            Hashtbl.add constants_float (var) {pos = dl_length constants_f32; var_type = TFloat};
            dl_push constants_f32 i
        end;

        let pos = (Hashtbl.find constants_float var).pos in
        let rel_pos = Int64.of_int (4 * pos) in

        movsd (label_ref lbl rel_pos) !%xmm0 ++
        push_float32 !%xmm0
    | DCst i ->
        let var = {f_value = i; v_type = TDouble} in
        let lbl = Constants.constants_label_f64 in

        if not (Hashtbl.mem constants_float var) then begin
            Hashtbl.add constants_float (var) {pos = dl_length constants_f64; var_type = TDouble};
            dl_push constants_f64 i
        end;

        let pos = (Hashtbl.find constants_float var).pos in
        let rel_pos = Int64.of_int (8 * pos) in

        movsd (label_ref lbl rel_pos) !%xmm0 ++
        push_float64 !%xmm0
    | Var (t, x) ->
        let v_nature = get_var_nature f_id scope x in
        (
            match t with
            | NoType -> raise (VarUndef "Variable with no type! (compile var)")
            | TInt ->
                let lbl = Constants.g_var_label_i32 in
                let real_pos = get_var_pos f_id scope x t in
                movl (move_to_based_on_nature lbl real_pos v_nature) !%eax ++
                push_int32 !%eax
            | TLong ->
                let lbl = Constants.g_var_label_i64 in
                let real_pos = get_var_pos f_id scope x t in
                movq (move_to_based_on_nature lbl real_pos v_nature) !%rax ++
                push_int64 !%rax
            | TFloat ->
                let lbl = Constants.g_var_label_f32 in
                let real_pos = get_var_pos f_id scope x t in
                movss(move_to_based_on_nature lbl real_pos v_nature) !%xmm0 ++
                push_float32 !%xmm0
            | TDouble ->
                let lbl = Constants.g_var_label_f64 in
                let real_pos = get_var_pos f_id scope x t in
                movsd(move_to_based_on_nature lbl real_pos v_nature) !%xmm0 ++
                push_float64 !%xmm0
        )
    | Binop (t_result, t_true, o, t1, e1, t2, e2) ->
        (
            match o with
            | Add | Sub | Mul | Div ->
                compile_binop_arith f_id scope t_result t_true o t1 e1 t2 e2
            | Not | Eq | Neq | Less | Leq | Grtr | Geq ->
                compile_binop_bool f_id scope t_result t_true o t1 e1 t2 e2
        )
    | FunCall (id, args) ->
        compile_fun_call f_id scope id args true
and compile_fun_call outer_f_id scope id args should_push_result_to_stack =
        if not (Hashtbl.mem function_data id) then
            raise (VarUndef ("Function '" ^ id ^ "' not defined."));
        let f_data = Hashtbl.find function_data id in
        let arg_code = List.map2 (fun expr arg ->
            let expr_t = infer_type expr in
            compile_expr outer_f_id scope expr ++
            convert expr_t arg.var_type
        ) args f_data.args in
        let arg_code = List.fold_right (++) arg_code nop in
        let sum_bytes = List.fold_right (fun x acc ->
            acc + (type_bytes x.var_type)
        ) f_data.args 0 in
        let remainder_align = Int64.sub (Int64.of_int 16) (Int64.rem (Int64.of_int sum_bytes) (Int64.of_int 16)) in
        let bytes_total = Int64.add (Int64.of_int sum_bytes) remainder_align in

        (* push arguments to stack *)
        subq (imm64 remainder_align) !%rsp ++
        arg_code ++

        (* call function *)
        call (gen_func_name id) ++

        (* pop arguments *)
        addq (imm64 bytes_total) !%rsp ++

        (* push return value into stack *)
        if should_push_result_to_stack then (
            match f_data.ret_type with
            | NoType -> raise (VarUndef "Variable with no type! (type of binop)")
            | TInt -> push_int32 !%eax
            | TLong -> push_int64 !%rax
            | TFloat -> push_float32 !%xmm0
            | TDouble -> push_float64 !%xmm0
        )
        else nop
and compile_binop_arith f_id scope t_result t_true o t1 e1 t2 e2 =
    compile_expr f_id scope e1 ++
    convert t1 t_result ++

    compile_expr f_id scope e2 ++
    convert t2 t_result ++

    match t_result with
    | NoType -> raise (VarUndef "Variable with no type! (compile binop)") (* not supposed to happen *)
    | TInt ->
        pop_int32 !%eax ++
        pop_int32 !%edi ++
        (
            match o with
            | Add -> addl !%edi !%eax
            | Sub -> subl !%eax !%edi ++
                    movl !%edi !%eax
            | Mul -> imull !%edi !%eax
            | Div -> cltd ++
                    idivl !%ecx
            | _ -> nop
        ) ++
        push_int32 !%eax
    | TLong ->
        pop_int64 !%rax ++
        pop_int64 !%rdi ++
        (
            match o with
            | Add -> addq !%rdi !%rax
            | Sub -> subq !%rax !%rdi ++
                    movq !%rdi !%rax
            | Mul -> imulq !%rdi !%rax
            | Div -> movq !%rax !%rsi ++
                    movq !%rdi !%rax ++
                    cqto ++
                    idivq !%rsi
            | _ -> nop
        ) ++
        push_int64 !%rax
    | TFloat ->
        pop_float32 !%xmm0 ++
        pop_float32 !%xmm1 ++
        (
            match o with
            | Add -> addss !%xmm0 !%xmm1
            | Sub -> subss !%xmm0 !%xmm1
            | Mul -> mulss !%xmm0 !%xmm1
            | Div -> divss !%xmm0 !%xmm1
            | _ -> nop
        ) ++
        push_float32 !%xmm1
    | TDouble ->
        pop_float64 !%xmm0 ++
        pop_float64 !%xmm1 ++
        (
            match o with
            | Add -> addsd !%xmm0 !%xmm1
            | Sub -> subsd !%xmm0 !%xmm1
            | Mul -> mulsd !%xmm0 !%xmm1
            | Div -> divsd !%xmm0 !%xmm1
            | _ -> nop
        ) ++
        push_float64 !%xmm1
and compile_binop_bool f_id scope t_result t_true o t1 e1 t2 e2 =
    compile_expr f_id scope e1 ++
    convert t1 t_true ++

    compile_expr f_id scope e2 ++
    convert t2 t_true ++

    match t_true with
    | NoType -> raise (VarUndef "Variable with no type! (compile binop)") (* not supposed to happen *)
    | TInt ->
        pop_int32 !%eax ++
        pop_int32 !%edi ++

        cmpl !%eax !%edi ++
        (
            match o with
            | Not ->
                test !%eax !%eax ++
                sete !%al
            | Eq -> sete !%al
            | Neq -> setne !%al
            | Less -> setl !%al
            | Leq -> setle !%al
            | Grtr -> setg !%al
            | Geq -> setge !%al
            | _ -> nop
        ) ++
        movzbl !%al eax ++
        push_int32 !%eax
    | TLong ->
        pop_int64 !%rax ++
        pop_int64 !%rdi ++

        cmpq !%rax !%rdi ++
        (
            match o with
            | Not ->
                raise (VarTy ("Cannot use not operator on a variable that isn't of type int"))
            | Eq -> sete !%al
            | Neq -> setne !%al
            | Less -> setl !%al
            | Leq -> setle !%al
            | Grtr -> setg !%al
            | Geq -> setge !%al
            | _ -> nop
        ) ++
        movzbl !%al eax ++
        push_int32 !%eax
    | TFloat ->
        pop_float32 !%xmm0 ++
        pop_float32 !%xmm1 ++

        ucomiss !%xmm0 !%xmm1 ++
        (
            match o with
            | Not ->
                raise (VarTy ("Cannot use not operator on a variable that isn't of type int"))
            | Eq -> sete !%al
            | Neq -> setne !%al
            | Less -> setb !%al
            | Leq -> setbe !%al
            | Grtr -> seta !%al
            | Geq -> setae !%al
            | _ -> nop
        ) ++
        movzbl !%al eax ++
        push_int32 !%eax
    | TDouble ->
        pop_float64 !%xmm0 ++
        pop_float64 !%xmm1 ++

        ucomisd !%xmm0 !%xmm1 ++
        (
            match o with
            | Not ->
                raise (VarTy ("Cannot use not operator on a variable that isn't of type int"))
            | Eq -> sete !%al
            | Neq -> setne !%al
            | Less -> setb !%al
            | Leq -> setbe !%al
            | Grtr -> seta !%al
            | Geq -> setae !%al
            | _ -> nop
        ) ++
        movzbl !%al eax ++
        push_int32 !%eax



(* assumes the value to assign is currently at the top of the stack *)
let assign_var f_id scope t x =
    let v_nature = get_var_nature f_id scope x in
    (
        match t with
        | NoType -> raise (VarUndef "Variable with no type (compile Set 2)!") (* not supposed to happen *)
        | TInt ->
            let lbl = Constants.g_var_label_i32 in
            let real_pos = get_var_pos f_id scope x t in
            pop_int32 !%eax ++
            movl !%eax (move_to_based_on_nature lbl real_pos v_nature)
        | TLong ->
            let lbl = Constants.g_var_label_i64 in
            let real_pos = get_var_pos f_id scope x t in
            pop_int64 !%rax ++
            movq !%rax (move_to_based_on_nature lbl real_pos v_nature)
        | TFloat ->
            let lbl = Constants.g_var_label_f32 in
            let real_pos = get_var_pos f_id scope x t in
            pop_float32 !%xmm0 ++
            movss !%xmm0 (move_to_based_on_nature lbl real_pos v_nature)
        | TDouble ->
            let lbl = Constants.g_var_label_f64 in
            let real_pos = get_var_pos f_id scope x t in
            pop_float64 !%xmm0 ++
            movsd !%xmm0 (move_to_based_on_nature lbl real_pos v_nature)
    )

let gen_if_name f_id if_num count =
    ".if_" ^ f_id ^ "_" ^ (string_of_int if_num) ^ "_" ^ (string_of_int count)

let gen_if_name_end f_id if_num =
    ".if_" ^ f_id ^ "_" ^ (string_of_int if_num) ^ "_end"

(* Instruction compilation *)
let rec compile_instr f_id scope = function
    | Set (t1, x, t2, e) ->
        compile_expr f_id scope e ++
        convert t2 t1 ++
        assign_var f_id scope t1 x
    | Assign (x, t, e) ->
        let v_nature = get_var_nature f_id scope x in
        let var_type = match v_nature with
        | Local | Argument -> (Hashtbl.find local_vars { func = f_id; var = x; scope = scope }).var_type
        | Global -> (Hashtbl.find global_vars x).var_type
        in
        compile_expr f_id scope e ++
        convert t var_type ++
        assign_var f_id scope var_type x
    | Print (t, e) ->
        compile_expr f_id scope e ++
        (
            match t with
            | NoType -> raise (VarUndef "Variable with no type! (compile Print)") (* not supposed to happen *)
            | TInt ->
                pop_int32 !%edi ++
                call "print_int"
            | TLong ->
                pop_int64 !%rdi ++
                call "print_long"
            | TFloat ->
                (* pxor *)
                pop_float32 !%xmm0 ++
                call "print_float"
            | TDouble ->
                pop_float64 !%xmm0 ++
                call "print_double"
        )
    | FunCall (id, args) ->
        compile_fun_call f_id scope id args false
    | Ret (t, e) ->
        let f_data = Hashtbl.find function_data f_id in
        let sum_bytes = List.fold_right (fun x acc ->
            acc + (type_bytes x.var_type)
        ) f_data.args 0 in
        let remainder_align = Int64.sub (Int64.of_int 16) (Int64.rem (Int64.of_int sum_bytes) (Int64.of_int 16)) in
        let bytes_total = Int64.add (Int64.of_int sum_bytes) remainder_align in
        compile_expr f_id scope e ++
        convert t f_data.ret_type ++
        (
            match f_data.ret_type with
            | NoType -> nop
            | TInt -> pop_int32 !%eax
            | TLong -> pop_int64 !%rax
            | TFloat -> pop_float32 !%xmm0
            | TDouble -> pop_float64 !%xmm0
        ) ++
        addq (imm64 bytes_total) !%rsp ++
        popq rbp ++
        ret
    | If (t, e, sc, elif) ->
        let if_num = if Hashtbl.mem func_ifs f_id then
            let num = !(Hashtbl.find func_ifs f_id) + 1 in
            (Hashtbl.find func_ifs f_id) := num;
            num
        else begin
            Hashtbl.add func_ifs f_id (ref 0); 0
        end in
        let rec compile_elif in_t in_e in_sc in_elif curr_num =
            let () = printf "num: %d\n" curr_num in
            label (gen_if_name f_id if_num curr_num) ++ (* current if label *)
            compile_expr f_id scope in_e ++
            pop_int32 !%eax ++
            test !%eax !%eax ++
            (
                match in_elif with
                | None -> jz (gen_if_name_end f_id if_num) (* jump to end *)
                | Elif (_, _, _, _) -> jz (gen_if_name f_id if_num (curr_num + 1)) (* jump to next elif *)
                | Else (_) -> jz (gen_if_name f_id if_num (curr_num + 1)) (* jump to else ("next elif") *)
            ) ++
            let code = List.map (compile_instr f_id (scope + 1)) in_sc in
            let code = List.fold_right (++) code nop in
            code ++
            jmp (gen_if_name_end f_id if_num) ++ (* end of whole if *)
            (
                match in_elif with
                | None -> nop
                | Elif (in_t, in_e, in_sc, in_elif) -> compile_elif in_t in_e in_sc in_elif (curr_num + 1)
                | Else (in_sc) ->
                    let else_code = List.map (compile_instr f_id (scope + 1)) sc in
                    let else_code = List.fold_right (++) else_code nop in
                    label (gen_if_name f_id if_num (curr_num + 1)) ++ (* else label ("next elif") *)
                    else_code
            )
        in
        compile_elif t e sc elif 0 ++
        label (gen_if_name_end f_id if_num) (* end of if label *)

let arg_bytes = function
    | Arg (t, _) -> type_bytes t

let compile_stmt = function
    | Function (t, id, args, scope) ->
        let f_local_vars = if Hashtbl.mem func_vars id then !((Hashtbl.find func_vars id).items) else [] in
        let f_local_vars_bytes = List.fold_right (fun x acc -> acc + (type_bytes x.var_type)) f_local_vars 0 in
        let remainder_align = Int64.sub (Int64.of_int 16) (Int64.rem (Int64.of_int f_local_vars_bytes) (Int64.of_int 16)) in
        let bytes_real = Int64.add (Int64.of_int f_local_vars_bytes) remainder_align in
        let code = List.map (compile_instr id 1) scope in
        let code = List.fold_right (++) code nop in

        (* function init *)
        label (gen_func_name id) ++
        pushq !%rbp ++
        movq !%rsp !%rbp ++

        (* add args *)
        subq (imm64 bytes_real) !%rsp ++
        (* subq (imm f_local_vars_bytes) !%rsp ++ *)

        (* scope *)
        code ++

        (* remove args *)
        addq (imm64 bytes_real) !%rsp ++
        (* addq (imm f_local_vars_bytes) !%rsp ++ *)

        (* function end *)
        popq rbp ++
        ret

    | Set (t1, x, t2, e) -> nop

let compile_stmt_g_vars = function
    | Function (t, id, args, scope) -> nop
    | Set (t1, x, t2, e) ->
        compile_expr "" 0 e ++
        convert t2 t1 ++
        assign_var "" 0 t1 x

let arithmetic_type_of_binop o t1 t2 =
    match (t1, t2) with
    | (NoType, _) | (_, NoType) -> raise (VarUndef "Variable with no type! (type of binop)") (* not supposed to happen *)
    | (TInt, TInt) -> TInt
    | (TInt, TLong) | (TLong, TInt) -> TLong
    | (TInt, TFloat) | (TFloat, TInt) -> TFloat
    | (TInt, TDouble) | (TDouble, TInt) -> TDouble
    | (TLong, TLong) -> TLong
    | (TLong, TFloat) | (TFloat, TLong) -> TFloat
    | (TLong, TDouble) | (TDouble, TLong) -> TDouble
    | (TFloat, TFloat) -> TFloat
    | (TFloat, TDouble) | (TDouble, TFloat) -> TDouble
    | (TDouble, TDouble) -> TDouble

(* let logic_type_of_binop o t1 t2 = arithmetic_type_of_binop o t1 t2 *)
let logic_type_of_binop o t1 t2 = TInt

let get_var_type f_id scope var_id =
    let highest_scope_local_var = find_highest_scope_matching_var f_id var_id scope in
    if highest_scope_local_var.scope >= 0 then
        highest_scope_local_var.var_type
    else if not (Hashtbl.mem global_vars var_id) then
        raise (VarUndef ("Variable '" ^ var_id ^ "' not found."))
    else
        (Hashtbl.find global_vars var_id).var_type

let rec gen_typing_expr f_id scope = function
    | ICst i -> ICst (i)
    | LCst i -> LCst (i)
    | FCst i -> FCst (i)
    | DCst i -> DCst (i)
    | Var (t, x) ->
        let actual_t = get_var_type f_id scope x in
        Var (actual_t, x)
    | Binop (_, _, o, _, e1, _, e2) ->
        let typed_e1 = gen_typing_expr f_id scope e1 in
        let typed_e2 = gen_typing_expr f_id scope e2 in

        let t1 = infer_type typed_e1 in
        let t2 = infer_type typed_e2 in

        let t_result = ref NoType in
        let t_true = ref NoType in
        (
        match o with
        | Add | Sub | Mul | Div ->
            t_result := arithmetic_type_of_binop o t1 t2;
            t_true := !t_result
        | Not | Eq | Neq | Less | Leq | Grtr | Geq ->
            t_result := logic_type_of_binop o t1 t2;
            t_true := arithmetic_type_of_binop o t1 t2
        );
        Binop (!t_result, !t_true, o, t1, typed_e1, t2, typed_e2)
    | FunCall (id, args) ->
        FunCall (id, check_func_call_type id args scope)
and check_func_call_type f_id args scope =
    let typed_args = List.map (gen_typing_expr f_id scope) args in
    let arg_types = List.map (infer_type) typed_args in
    if not (Hashtbl.mem function_data f_id) then
        raise (VarUndef ("Function '" ^ f_id ^ "' not defined."));
    let decl_f_data = Hashtbl.find function_data f_id in
    let rec matches_declaration call_arg_types original_args = match call_arg_types, original_args with
    | [], [] -> true
    | [], _ | _, [] -> false
    | x::xs, y::ys -> matches_declaration xs ys
    (* | x::xs, y::ys -> *)
    (*     if x != y.var_type then false *)
    (*     else matches_declaration xs ys *)
    in
    let does_match = matches_declaration arg_types decl_f_data.args in
    if not does_match then
        raise (FuncWrongArgs ("Function call does not match function declaration for '" ^ f_id ^ "'."));
    typed_args

let gen_typing_cmp_bexpr f_id scope cmp_ty e1 e2 =
    let typed_e1 = gen_typing_expr f_id scope e1 in
    let t1 = infer_type typed_e1 in
    let typed_e2 = gen_typing_expr f_id scope e2 in
    let t2 = infer_type typed_e2 in
    cmp_ty (t1, typed_e1, t2, typed_e2)

let rec gen_typing_inst f_id scope = function
    | Set (t1, x, _, e) ->
        let typed_e = gen_typing_expr f_id scope e in
        let t2 = infer_type typed_e in
        let curr_func_var = { func = f_id; var = x; scope = scope } in
        if Hashtbl.mem local_vars curr_func_var then
            raise (VarDup ("Redefinition of local scope variable'" ^ x ^ "'."))
        else begin
            if (Hashtbl.mem func_vars f_id) then begin
                dl_push (Hashtbl.find func_vars f_id) {id = x; var_type = t1; scope = scope};
            end
            else begin
                Hashtbl.add func_vars f_id (dl_create ());
                dl_push (Hashtbl.find func_vars f_id) {id = x; var_type = t1; scope = scope};
            end;

            Hashtbl.add local_vars curr_func_var {
                pos = (Hashtbl.find func_vars f_id).length - 1;
                var_type = t1;
            };
        end;
        Set (t1, x, t2, typed_e)
    | Assign (x, _, e) ->
        let expr_typed = gen_typing_expr f_id scope e in
        let t = infer_type expr_typed in
        let highest_local_matching_var = find_highest_scope_matching_var f_id x scope in
        let local_var_exists = highest_local_matching_var.scope >= 0 in
        let global_var_exists = Hashtbl.mem global_vars x in
        if not local_var_exists && not global_var_exists then
            raise (VarUndef ("Variable '" ^ x ^ "' not defined"));
        Assign (x, t, expr_typed)
    | Print (_, e) ->
        let expr_typed = gen_typing_expr f_id scope e in
        let t = infer_type expr_typed in
        Print (t, expr_typed)
    | FunCall (id, args) ->
        FunCall (id, check_func_call_type id args scope)
    | Ret (_, e) ->
        let expr_typed = gen_typing_expr f_id scope e in
        let t = infer_type expr_typed in
        Ret (t, expr_typed)
    | If (_, e, if_scope, elif) ->
        let expr_typed = gen_typing_expr f_id scope e in
        let t = infer_type expr_typed in
        if t != TInt then raise (VarTy ("If statement requires an expression of type Int"));
        let scope_typed = List.map (fun x -> gen_typing_inst f_id (scope + 1) x) if_scope in
        let rec get_typed_elif = function
            | None -> None
            | Elif (_, e, sc, nested_elif) ->
                let e_typed = gen_typing_expr f_id (scope) e in
                let t_in = infer_type e_typed in
                if t_in != TInt then raise (VarTy ("If statement requires an expression of type Int"));
                let sc_typed = List.map (fun x -> gen_typing_inst f_id (scope + 1) x) if_scope in
                let elif_t = get_typed_elif nested_elif in
                Elif (t_in, e_typed, sc_typed, elif_t)
            | Else (sc) ->
                let sc_typed = List.map (fun x -> gen_typing_inst f_id (scope + 1) x) if_scope in
                Else (sc_typed)
        in
        let elif_typed = get_typed_elif elif in
        If (t, expr_typed, scope_typed, elif_typed)



let process_arg f_id = function
    | Arg (t, id) ->
        let arg_var = { func = f_id; var = id; scope = 1 } in
        let arg_typed_var = { id = id; var_type = t; scope = 1 } in
        if Hashtbl.mem local_vars arg_var then
            raise (VarDup ("Redefinition of argument variable'" ^ id ^ "'."))
        else begin
            if (Hashtbl.mem func_args f_id) then begin
                dl_push (Hashtbl.find func_args f_id) arg_typed_var;
            end
            else begin
                Hashtbl.add func_args f_id (dl_create ());
                dl_push (Hashtbl.find func_args f_id) arg_typed_var;
            end;

            Hashtbl.add local_vars arg_var {
                pos = - (Hashtbl.find func_args f_id).length;
                var_type = t;
            };
        end

let map_args_to_typed_var_list args scope = List.map (
        fun x -> match x with Arg (t, id) -> { id = id; var_type = t; scope = scope }
    ) args

let gen_typing = function
    | Function (t, id, args, scope) ->
        List.iter (process_arg id) args;
        let arg_list = map_args_to_typed_var_list args 1 in
        let f_data = { ret_type = t; args = arg_list } in
        if (Hashtbl.mem function_data id) then
            raise (VarDup ("Duplicate funcion '" ^ id ^ "'."))
            else begin
                Hashtbl.add function_data id f_data
        end;
        let typed_scope = List.map (gen_typing_inst id 1) scope in
        Function (t, id, args, typed_scope)
    | Set (t1, x, _, e) ->
        let typed_e = gen_typing_expr "" 0 e in
        let t2 = infer_type typed_e in
        if Hashtbl.mem global_vars x then
            raise (VarDup ("Redefinition of '" ^ x ^ "'."))
        else begin
            match t1 with
            | NoType -> raise (VarUndef "Variable with no type! (compile Set)") (* not supposed to happen *)
            | TInt ->
                    Hashtbl.add global_vars x {pos = g_vars_i32.length; var_type = t1};
                    dl_push g_vars_i32 x
            | TLong ->
                    Hashtbl.add global_vars x {pos = g_vars_i64.length; var_type = t1};
                    dl_push g_vars_i64 x
            | TFloat ->
                    Hashtbl.add global_vars x {pos = g_vars_f32.length; var_type = t1};
                    dl_push g_vars_f32 x
            | TDouble ->
                    Hashtbl.add global_vars x {pos = g_vars_f64.length; var_type = t1};
                    dl_push g_vars_f64 x
        end;
        Set (t1, x, t2, typed_e)

let helper_functions = 
    label "print_int" ++
    pushq !%rbp ++ (* makes sure, in particular, of alignment issues *)
    movq !%rsp !%rbp ++
    movq !%rdi !%rsi ++
    leaq (lab ".Sprint_int") rdi ++
    movq (imm 0) !%rax ++
    call "printf" ++
    popq rbp ++
    ret ++

    label "print_long" ++
    pushq !%rbp ++ (* makes sure, in particular, of alignment issues *)
    movq !%rsp !%rbp ++
    movq !%rdi !%rsi ++
    leaq (lab ".Sprint_long") rdi ++
    movq (imm 0) !%rax ++
    call "printf" ++
    popq rbp ++
    ret ++

    label "print_float" ++
    pushq !%rbp ++ (* makes sure, in particular, of alignment issues *)
    movq !%rsp !%rbp ++
    cvtss2sd !%xmm0 !%xmm0 ++
    leaq (lab ".Sprint_float") rdi ++
    movq (imm 1) !%rax ++
    call "printf" ++
    popq rbp ++
    ret ++

    label "print_double" ++
    pushq !%rbp ++ (* makes sure, in particular, of alignment issues *)
    movq !%rsp !%rbp ++
    leaq (lab ".Sprint_double") rdi ++
    movq (imm 1) !%rax ++
    call "printf" ++
    popq rbp ++
    ret

let check_function_returns p =
    let found_main = ref false in
    List.iter ( fun x -> match x with
        | Function (t, id, args, scope) ->
            let has_return = ref false in
            List.iter (fun x ->
                match x with
                | Set (_, _, _, _) -> ()
                | Assign (_, _, _) -> ()
                | Print (_, _) -> ()
                | FunCall (_, _) -> ()
                | If (_, _, _, _) -> ()
                | Ret (_, _) -> has_return := true
            ) scope;
            if not !has_return && t != NoType then
                raise (FuncNoReturn ("Non-void function '" ^ id ^ "' should have a return"));
            if id = "main" then found_main := true
        | Set (t1, x, _, e) -> ()
    ) p;
    if not !found_main then
        raise (FuncNoMain ("There is no main function!"))

(* Compiles program p and saves to file ofile *)
let compile_program (p: Ast.program) ofile =
    let p = List.map gen_typing p in (* generate typing *)
    check_function_returns p;
    let g_vars_code = List.map compile_stmt_g_vars p in
    let g_vars_code = List.fold_right (++) g_vars_code nop in
    let code = List.map compile_stmt p in
    let code = List.fold_right (++) code nop in
    if !frame_size mod 16 = 8 then frame_size := 8 + !frame_size;
    let p =
        {
            text =
                globl "main" ++ label "main" ++

                (* starting sequence *)
                pushq !%rbp ++
                movq !%rsp !%rbp ++

                (* global vars code *)
                g_vars_code ++

                (* call main function *)
                call (gen_func_name Constants.main_func_name) ++

                (* ending sequence *)
                popq rbp ++
                movq (imm 0) !%rax ++
                ret ++

                (* code *)
                code ++

                (* helper functions *)
                helper_functions;

            data = 
                label ".Sprint_int" ++
                string "%d\n" ++

                label ".Sprint_long" ++
                string "%ld\n" ++

                label ".Sprint_float" ++
                string "%f\n" ++

                label ".Sprint_double" ++
                string "%lf\n" ++

                (* constant pool *)
                label Constants.constants_label_i8 ++
                dbyte (dl_get_list constants_i8) ++
                label Constants.constants_label_i16 ++
                dword (dl_get_list constants_i16) ++
                label Constants.constants_label_i32 ++
                dint (dl_get_list constants_i32) ++
                label Constants.constants_label_i64 ++
                dquad (dl_get_list constants_i64) ++
                label Constants.constants_label_f32 ++
                dfloat (dl_get_list constants_f32) ++
                label Constants.constants_label_f64 ++
                ddouble (dl_get_list constants_f64) ++

                (* global variables *)
                label Constants.g_var_label_i8 ++
                dbyte (List.init g_vars_i8.length (fun _ -> 0)) ++
                label Constants.g_var_label_i16 ++
                dword (List.init g_vars_i16.length (fun _ -> 0)) ++
                label Constants.g_var_label_i32 ++
                dint (List.init g_vars_i32.length (fun _ -> Int32.of_int 0)) ++
                label Constants.g_var_label_i64 ++
                dquad (List.init g_vars_i64.length (fun _ -> Int64.of_int 0)) ++
                label Constants.g_var_label_f32 ++
                dfloat (List.init g_vars_f32.length (fun _ -> 0.0)) ++
                label Constants.g_var_label_f64 ++
                ddouble (List.init g_vars_f64.length (fun _ -> 0.0))
    }
    in
    let f = open_out ofile in
    let fmt = formatter_of_out_channel f in
    X86_64.print_program fmt p;
    (* "flush" of the buffer to ensure that everything that needs to be saved is in fact saved before closing *)
    fprintf fmt "@?";
    close_out f
