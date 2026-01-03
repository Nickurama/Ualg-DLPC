
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

(* Global variables *)
let (global_vars: (string, (int * ty * bit_size)) Hashtbl.t) = Hashtbl.create 17 (* string -> pos, type, bits *)

(* Constant pool *)
let (constants_int: (int64, (int * ty * bit_size)) Hashtbl.t) = Hashtbl.create 17 (* string -> pos, type, bits *)
let (constants_float: (float, (int * ty * bit_size)) Hashtbl.t) = Hashtbl.create 17 (* string -> pos, type, bits *)

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

(* Expression compilation *)
let compile_expr =
    let rec comprec env next = function
        | ICst i ->
            let i_64 = Int64.of_int32 i in
            let pos = dl_length constants_i32 in
            let rel_pos = Int64.of_int (4 * pos) in 
            let lbl = Constants.constants_label_i32 in

            if not (Hashtbl.mem constants_int (i_64)) then
                Hashtbl.add constants_int (i_64) (pos, TInt, T_32bit);
                dl_push constants_i32 i;

            movq (label_ref lbl rel_pos) !%rax ++
            pushq !%rax
        | LCst i ->
            movq (imm64 i) !%rax ++
            pushq !%rax
        | FCst i ->
            (* movq (imm i) !%rax ++ *)
            (* pushq !%rax *)
            nop
        | DCst i ->
            (* movq (imm i) !%rax ++ *)
            (* pushq !%rax *)
            nop
        | Var (t, x) ->
            (* let first_offset = 8 * (Hashtbl.length global_vars - 1) in *)
            (* let bottom_offset = 8 * (Hashtbl.find global_vars x) in *)
            (* let bottom_offset = 8 in *)
            (* let var_offset = first_offset - bottom_offset in *)
            (* movq (ind ~ofs:var_offset rsp) !%rax ++ *)
            pushq !%rax
        | Binop (o, t1, e1, t2, e2) -> (
            comprec env next e1 ++
            comprec env next e2 ++
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
            )

            ++ pushq !%rax
        )
        (* | Letin (x, e1, e2) -> *)
        (*     if !frame_size = next then frame_size := 8 + !frame_size; *)
        (*     nop (* TODO *) *)
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

(* let get_number_vars = function *)
(*     | Set (t, x, e) -> () *)
(*   (* | Set (t, x, e) -> *) *)
(*   (*     if Hashtbl.mem global_vars x then *) *)
(*   (*         () *) *)
(*   (*     else *) *)
(*   (*         Hashtbl.add global_vars x () *) *)
(*     | Print e -> () *)

(* let rec get_constants_from_expr = function *)
(*     | ICst i -> *)
(*         (* label dint [i] *) *)
(*         dint [i] *)
(*     | LCst i -> *)
(*         nop *)
(*     | FCst i -> *)
(*         nop *)
(*     | DCst i -> *)
(*         nop *)
(*     | Var (t, x) -> nop *)
(*     | Binop (o, t1, e1, t2, e2) -> ( *)
(*         get_constants_from_expr e1 ++ *)
(*         get_constants_from_expr e2 *)
(*     ) *)


(* let get_constants = function *)
(*     | Set (t, x, e) -> get_constants_from_expr e *)
(*     | Print e -> get_constants_from_expr e *)


(* Compiles program p and saves to file ofile *)
let compile_program p ofile =
    (* List.iter get_number_vars p; *)
    (* let constants = List.map get_constants p in *)
    (* let constants = List.fold_right (++) constants nop in *)
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
                pushq !%rbp ++ (* assegura, em particular, as questões de alignamento *)
                movq !%rdi !%rsi ++
                leaq (lab ".Sprint_int") rdi ++
                movq (imm 0) !%rax ++
                call "printf" ++
                popq rbp ++
                ret;

            data = 
                label ".Sprint_int" ++
                string "%d\n" ++

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
