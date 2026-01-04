
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

let is_int = function
    | NoType -> false
    | TInt -> true
    | TLong -> true
    | TFloat -> false
    | TDouble -> false

let convert from_t to_t =
    if (is_int from_t) && (is_int to_t) then nop
    else if (not (is_int from_t)) && (not (is_int to_t)) then nop
    else if (is_int from_t) && (not (is_int to_t)) then (* convert from int to float *)
        popq rax ++
        cvtsi2sdq !%rax !%xmm0 ++
        subq (imm 16) !%rsp ++
        movsd !%xmm0 !%rsp
    else if (not (is_int from_t)) && (is_int to_t) then (* convert from float to int *)
        movsd !%rsp !%xmm0 ++
        addq (imm 16) !%rsp ++
        cvttsd2si !%xmm0 !%rax ++
        pushq !%rax ++
        nop 
    else nop


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

            movq (label_ref lbl rel_pos) !%rax ++
            pushq !%rax
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
            pushq !%rax
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
            (* pushq !%rax *)
            (* subq (imm 8) !%rsp ++ *)
            subq (imm 16) !%rsp ++
            movsd !%xmm0 !%rsp
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
            (* pushq !%rax *)
            (* subq (imm 8) !%rsp ++ *)
            subq (imm 16) !%rsp ++
            movsd !%xmm0 !%rsp
        | Var (t, x) ->
            (* TODO *)
            (* let first_offset = 8 * (Hashtbl.length global_vars - 1) in *)
            (* let bottom_offset = 8 * (Hashtbl.find global_vars x) in *)
            (* let bottom_offset = 8 in *)
            (* let var_offset = first_offset - bottom_offset in *)
            (* movq (ind ~ofs:var_offset rsp) !%rax ++ *)
            pushq !%rax
        | Binop (t_result, o, t1, e1, t2, e2) -> (
            comprec env next e1 ++
            convert t1 t_result ++

            comprec env next e2 ++
            convert t2 t_result ++

            if is_int t_result then
                popq rax ++
                popq rdi ++

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
                pushq !%rax
            else
                movsd !%rsp !%xmm0 ++
                addq (imm 16) !%rsp ++
                movsd !%rsp !%xmm1 ++
                addq (imm 16) !%rsp ++
                (
                    match o with
                    | Add -> addsd !%xmm0 !%xmm1
                    | Sub -> subsd !%xmm0 !%xmm1
                    | Mul -> mulsd !%xmm0 !%xmm1
                    | Div -> divsd !%xmm0 !%xmm1
                ) ++
                subq (imm 16) !%rsp ++
                movsd !%xmm1 !%rsp
        )
        (* | Letin (x, e1, e2) -> *)
        (*     if !frame_size = next then frame_size := 8 + !frame_size; *)
  in
  comprec StrMap.empty 0

(* Instruction compilation *)
let compile_instr = function
    | Set (t, x, e) ->
        (* if Hashtbl.mem global_vars_type x then *)
        (*     raise (VarDup ("Redefinition of '" ^ x ^ "'.")) *)
        (* else begin *)
        (*     Hashtbl.add global_vars_type x t; *)
        (*     match t with *)
        (*     | NoType -> raise (VarUndef "Variable with no type!") (* not supposed to happen *) *)
        (*     | TInt -> Hashtbl.add global_vars_32bit x (Hashtbl.length global_vars_32bit) *)
        (*     | TLong -> Hashtbl.add global_vars_64bit x (Hashtbl.length global_vars_64bit) *)
        (*     | TFloat -> Hashtbl.add global_vars_f32bit x (Hashtbl.length global_vars_f32bit) *)
        (*     | TDouble -> Hashtbl.add global_vars_f64bit x (Hashtbl.length global_vars_f64bit) *)
        (* end; *)
        compile_expr e
    | Print e ->
        compile_expr e ++
        popq rdi ++
        call "print_int"

let infer_type = function
    | ICst i -> TInt
    | LCst i -> TLong
    | FCst i -> TFloat
    | DCst i -> TDouble
    | Var (t, x) -> t
    | Binop (t_result, o, t1, e1, t2, e2) -> t_result

let type_of_binop o t1 t2 =
        match (t1, t2) with
        | (NoType, _) | (_, NoType) -> raise (VarUndef "Variable with no type!") (* not supposed to happen *)
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

let get_var_type = function x -> NoType (* TODO *)

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
    | Set (t, x, e) ->
        (* let expr_type = gen_typing_expr e in *)
        Set (t, x, e) (* TODO *)
    | Print e ->
        let expr_typed = gen_typing_expr e in
        Print (expr_typed)

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
                label "convert_i_to_f" ++
                pushq !%rbp ++
                movq !%rsp !%rbp ++

                movq !%rdi !%rax ++
                (* cvtsi2sdq !%rax !%xmm0 ++ *)
                

                popq rbp ++
                ret ++

                label "print_int" ++
                pushq !%rbp ++ (* makes sure, in particular, of alignment issues *)
                movq !%rdi !%rsi ++
                leaq (lab ".Sprint_int") rdi ++
                movq (imm 0) !%rax ++
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
                ddouble (dl_get_list constants_f64)


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
