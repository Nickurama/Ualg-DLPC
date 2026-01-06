
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
end

(* Exception to raise when a variable (local or global) isn't used as intended *)
exception VarUndef of string (* variable not defined *)
exception VarDup of string (* duplicate variable *)

(* Frame size, in bytes (each local variables occupies 8 bytes) *)
let frame_size = ref 0

type bit_size =
    | T_8bit
    | T_16bit
    | T_32bit
    | T_64bit
    | T_f32bit
    | T_f64bit

type var_info = {
    pos: int;
    var_type: ty;
    num_bits: bit_size;
}

type i_var = {
    i_value: int64;
    var_type: ty;
}

type f_var = {
    f_value: float;
    var_type: ty;
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
let (constants_int: (i_var, var_info) Hashtbl.t) = Hashtbl.create 17 (* string -> pos, type, bits *)
let (constants_float: (f_var, var_info) Hashtbl.t) = Hashtbl.create 17 (* string -> pos, type, bits *)

let constants_i8 = dl_create ()
let constants_i16 = dl_create ()
let constants_i32 = dl_create ()
let constants_i64 = dl_create ()
let constants_f32 = dl_create ()
let constants_f64 = dl_create ()


(* hashtable with number of variables for a given function *)
let (func_var_num : (string, int) Hashtbl.t) = Hashtbl.create 17

(* Usamos uma tabela associativa cujas chaves são variáveis locais, i.e. uma tabela de
   símbolos locais cujas chaves são strings e os valores são a posição desta variável
   relativamente a %rbp (em bytes) *)
module StrMap = Map.Make(String)

let pop_int32 r =
    movl (ind rsp) r ++
    addq (imm 4) !%rsp

let push_int32 r =
    subq (imm 4) !%rsp ++
    movl r (ind rsp)

let pop_int64 r =
    popq r

let push_int64 r =
    pushq r

let pop_float32 r =
    movss (ind rsp) r ++
    addq (imm 4) !%rsp

let push_float32 r =
    subq (imm 4) !%rsp ++
    movss r (ind rsp)

let pop_float64 r =
    movsd (ind rsp) r ++
    addq (imm 8) !%rsp

let push_float64 r =
    subq (imm 8) !%rsp ++
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
        pop_int64 rax ++
        movl !%eax !%eax ++
        push_int32 !%eax
    | (TLong, TFloat) ->
        pop_int64 rax ++
        cvtsi2ssq !%rax !%xmm0 ++
        push_float32 !%xmm0
    | (TLong, TDouble) ->
        pop_int64 rax ++
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


(* Expression compilation *)
let compile_expr =
    let rec comprec env next = function
        | ICst i ->
            let i_64 = {i_value = Int64.of_int32 i; var_type = TInt}in
            let lbl = Constants.constants_label_i32 in

            if not (Hashtbl.mem constants_int i_64) then begin
                Hashtbl.add constants_int (i_64) {pos = dl_length constants_i32; var_type = TInt; num_bits = T_32bit};
                dl_push constants_i32 i
            end;

            let pos = (Hashtbl.find constants_int i_64).pos in
            let rel_pos = Int64.of_int (4 * pos) in

            movl (label_ref lbl rel_pos) !%eax ++
            push_int32 !%eax
        | LCst i ->
            let i_64 = {i_value = i; var_type = TLong} in
            let lbl = Constants.constants_label_i64 in

            if not (Hashtbl.mem constants_int i_64) then begin
                Hashtbl.add constants_int (i_64) {pos = dl_length constants_i64; var_type = TLong; num_bits = T_64bit};
                dl_push constants_i64 i
            end;

            let pos = (Hashtbl.find constants_int i_64).pos in
            let rel_pos = Int64.of_int (8 * pos) in

            movq (label_ref lbl rel_pos) !%rax ++
            push_int64 !%rax
        | FCst i ->
            let var = {f_value = i; var_type = TFloat} in
            let lbl = Constants.constants_label_f32 in

            if not (Hashtbl.mem constants_float var) then begin
                Hashtbl.add constants_float (var) {pos = dl_length constants_f32; var_type = TFloat; num_bits = T_32bit};
                dl_push constants_f32 i
            end;

            let pos = (Hashtbl.find constants_float var).pos in
            let rel_pos = Int64.of_int (4 * pos) in

            movsd (label_ref lbl rel_pos) !%xmm0 ++
            push_float32 !%xmm0
        | DCst i ->
            let var = {f_value = i; var_type = TDouble} in
            let lbl = Constants.constants_label_f64 in

            if not (Hashtbl.mem constants_float var) then begin
                Hashtbl.add constants_float (var) {pos = dl_length constants_f64; var_type = TDouble; num_bits = T_64bit};
                dl_push constants_f64 i
            end;

            let pos = (Hashtbl.find constants_float var).pos in
            let rel_pos = Int64.of_int (8 * pos) in

            movsd (label_ref lbl rel_pos) !%xmm0 ++
            push_float64 !%xmm0
        | Var (t, x) ->
            (
                match t with
                | NoType -> raise (VarUndef "Variable with no type! (compile var)")
                | TInt ->
                    let lbl = Constants.g_var_label_i32 in
                    let pos = Int64.of_int (Hashtbl.find global_vars x).pos in
                    movl (label_ref lbl pos) !%eax ++
                    push_int32 !%eax
                | TLong ->
                    let lbl = Constants.g_var_label_i64 in
                    let pos = Int64.of_int (Hashtbl.find global_vars x).pos in
                    movq (label_ref lbl pos) !%rax ++
                    push_int64 !%rax
                | TFloat ->
                    let lbl = Constants.g_var_label_f32 in
                    let pos = Int64.of_int (Hashtbl.find global_vars x).pos in
                    movss (label_ref lbl pos) !%xmm0 ++
                    push_float32 !%xmm0
                | TDouble ->
                    let lbl = Constants.g_var_label_f64 in
                    let pos = Int64.of_int (Hashtbl.find global_vars x).pos in
                    movsd (label_ref lbl pos) !%xmm0 ++
                    push_float64 !%xmm0
            )
        | Binop (t_result, o, t1, e1, t2, e2) -> (
            comprec env next e1 ++
            convert t1 t_result ++

            comprec env next e2 ++
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
                ) ++
                push_int32 !%eax
            | TLong ->
                pop_int64 rax ++
                pop_int64 rdi ++
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
                ) ++
                push_float64 !%xmm1
        )
  in
  comprec StrMap.empty 0

(* assumes the value to assign is currently at the top of the stack *)
let assign_var t x =
    (
        match t with
        | NoType -> raise (VarUndef "Variable with no type (compile Set 2)!") (* not supposed to happen *)
        | TInt ->
            let lbl = Constants.g_var_label_i32 in
            let pos = Int64.of_int (Hashtbl.find global_vars x).pos in
            pop_int32 !%eax ++
            movl !%eax (label_ref lbl pos)
        | TLong ->
            let lbl = Constants.g_var_label_i64 in
            let pos = Int64.of_int (Hashtbl.find global_vars x).pos in
            pop_int64 rax ++
            movq !%rax (label_ref lbl pos)
        | TFloat ->
            let lbl = Constants.g_var_label_f32 in
            let pos = Int64.of_int (Hashtbl.find global_vars x).pos in
            pop_float32 !%xmm0 ++
            movss !%xmm0 (label_ref lbl pos)
        | TDouble ->
            let lbl = Constants.g_var_label_f64 in
            let pos = Int64.of_int (Hashtbl.find global_vars x).pos in
            pop_float64 !%xmm0 ++
            movsd !%xmm0 (label_ref lbl pos)
    )

(* Instruction compilation *)
let compile_instr = function
    | Set (t1, x, t2, e) ->
        compile_expr e ++
        convert t2 t1 ++
        assign_var t1 x
    | Assign (x, t, e) ->
        let var_type = (Hashtbl.find global_vars x).var_type in
        compile_expr e ++
        convert t var_type ++
        assign_var var_type x
    | Print (t, e) ->
        compile_expr e ++
        match t with
        | NoType -> raise (VarUndef "Variable with no type! (compile Print)") (* not supposed to happen *)
        | TInt ->
            pop_int32 !%edi ++
            call "print_int"
        | TLong ->
            pop_int64 rdi ++
            call "print_long"
        | TFloat ->
            (* pxor *)
            pop_float32 !%xmm0 ++
            call "print_float"
        | TDouble ->
            pop_float64 !%xmm0 ++
            call "print_double"

let infer_type = function
    | ICst i -> TInt
    | LCst i -> TLong
    | FCst i -> TFloat
    | DCst i -> TDouble
    | Var (t, x) -> t
    | Binop (t_result, o, t1, e1, t2, e2) -> t_result

let type_of_binop o t1 t2 =
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

let get_var_type = function x ->
    if not (Hashtbl.mem global_vars x) then
        raise (VarUndef ("Variable '" ^ x ^ "' not found."))
    else
        (Hashtbl.find global_vars x).var_type

let rec gen_typing_expr = function
        | ICst i -> ICst (i)
        | LCst i -> LCst (i)
        | FCst i -> FCst (i)
        | DCst i -> DCst (i)
        | Var (t, x) ->
            let actual_t = get_var_type x in
            Var (actual_t, x)
        | Binop (_, o, _, e1, _, e2) ->

                let typed_e1 = gen_typing_expr e1 in
                let typed_e2 = gen_typing_expr e2 in

                let t1 = infer_type typed_e1 in
                let t2 = infer_type typed_e2 in

                let t_result = type_of_binop o t1 t2 in
                Binop (t_result, o, t1, typed_e1, t2, typed_e2)

let gen_typing = function
    | Set (t1, x, _, e) ->
        let typed_e = gen_typing_expr e in
        let t2 = infer_type typed_e in
        if Hashtbl.mem global_vars x then
            raise (VarDup ("Redefinition of '" ^ x ^ "'."))
        else begin
            match t1 with
            | NoType -> raise (VarUndef "Variable with no type! (compile Set)") (* not supposed to happen *)
            | TInt ->
                    Hashtbl.add global_vars x {pos = g_vars_i32.length; var_type = t1; num_bits = T_32bit};
                    dl_push g_vars_i32 x
            | TLong ->
                    Hashtbl.add global_vars x {pos = g_vars_i64.length; var_type = t1; num_bits = T_64bit};
                    dl_push g_vars_i64 x
            | TFloat ->
                    Hashtbl.add global_vars x {pos = g_vars_f32.length; var_type = t1; num_bits = T_f32bit};
                    dl_push g_vars_f32 x
            | TDouble ->
                    Hashtbl.add global_vars x {pos = g_vars_f64.length; var_type = t1; num_bits = T_f64bit};
                    dl_push g_vars_f64 x
        end;
        Set (t1, x, t2, typed_e)
    | Assign (x, _, e) ->
        let expr_typed = gen_typing_expr e in
        let t = infer_type expr_typed in
        Assign (x, t, expr_typed)
    | Print (_, e) ->
        let expr_typed = gen_typing_expr e in
        let t = infer_type expr_typed in
        Print (t, expr_typed)

(* Compiles program p and saves to file ofile *)
let compile_program p ofile =
    let p = List.map gen_typing p in (* generate typing *)
    (* List.iter get_number_vars p; *)
    let code = List.map compile_instr p in
    let code = List.fold_right (++) code nop in
    if !frame_size mod 16 = 8 then frame_size := 8 + !frame_size;
    let p =
        {
            text =
                globl "main" ++ label "main" ++

                (* starting sequence *)
                pushq !%rbp ++
                movq !%rsp !%rbp ++

                (* code *)
                code ++

                (* remove global variables *)
                (* Hashtbl.fold (fun _ _ acc -> acc ++ popq rax) global_vars nop ++ *)

                (* ending sequence *)
                popq rbp ++
                movq (imm 0) !%rax ++
                ret ++

                (* helper functions *)

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
                ret;

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


                (* Hashtbl.fold (fun x _ l -> label x ++ dquad [1] ++ l) global_vars *)
                (*   (label ".Sprint_int" ++ string "%d\n") *)
    }
    in
    let f = open_out ofile in
    let fmt = formatter_of_out_channel f in
    X86_64.print_program fmt p;
    (* "flush" of the buffer to ensure that everything that needs to be saved is in fact saved before closing *)
    fprintf fmt "@?";
    close_out f
