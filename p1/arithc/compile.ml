
(* Produção de código para a linguagem Arith *)

open Format
open X86_64
open Ast

(* Excepção por lançar quando uma variável (local ou global) não é usada como deve ser *)
exception VarUndef of string

(* Tamanho da frame, em byte (cada variável local ocupa 8 bytes) *)
let frame_size = ref 0

(* As variáveis globais são arquivadas numa hash table (uma tabela de símbolos globais) *)
let (global_vars : (string, int) Hashtbl.t) = Hashtbl.create 17

(* hashtable with number of variables for a given function *)
let (func_var_num : (string, int) Hashtbl.t) = Hashtbl.create 17

(* Usamos uma tabela associativa cujas chaves são variáveis locais, i.e. uma tabela de
   símbolos locais cujas chaves são strings e os valores são a posição desta variável
   relativamente a %rbp (em bytes) *)
module StrMap = Map.Make(String)

(* Compilação de uma expressão *)
let compile_expr =
(* Função recursiva local à compile_expr usada para gerar o código máquina a partir
   da árvore de sintaxe abstracta associada ao valor de tipo Ast.expr.
   No fim da execução deste código, o valor *deve* estar no topo da pilha *)
  let rec comprec env next = function
    | Cst i ->
        movq (imm i) !%rax ++
        pushq !%rax
    | Var x ->
        let first_offset = 8 * (Hashtbl.length global_vars - 1) in
        let bottom_offset = 8 * (Hashtbl.find global_vars x) in
        let var_offset = first_offset - bottom_offset in
        movq (ind ~ofs:var_offset rsp) !%rax ++
        pushq !%rax
    | Binop (o, e1, e2) -> (
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
    | Letin (x, e1, e2) ->
        if !frame_size = next then frame_size := 8 + !frame_size;
        nop (* TODO *)
  in
  comprec StrMap.empty 0

(* Compilação de uma instrução *)
let compile_instr = function
  | Set (x, e) ->
      compile_expr e
  | Print e ->
      compile_expr e ++
      popq rdi ++
      call "print_int"

(* Compilação de uma instrução *)
let get_number_vars = function
  | Set (x, e) ->
      if Hashtbl.mem global_vars x then
          Hashtbl.replace global_vars x (Hashtbl.find global_vars x)
      else
          Hashtbl.add global_vars x (Hashtbl.length global_vars)
  | Print e -> ()


(* Compila o programa p e grava o código no ficheiro ofile *)
let compile_program p ofile =
  let code = List.map compile_instr p in
  let code = List.fold_right (++) code nop in
  if !frame_size mod 16 = 8 then frame_size := 8 + !frame_size;
  let p =
    { text =
        globl "main" ++ label "main" ++

        (* starting sequence *)
        pushq !%rbp ++
        movq !%rsp !%rbp ++

        (* code *)
        code ++

        (* remove global variables *)
        Hashtbl.fold (fun _ _ acc -> acc ++ popq rax) global_vars nop ++

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
        Hashtbl.fold (fun x _ l -> label x ++ dquad [1] ++ l) global_vars
          (label ".Sprint_int" ++ string "%d\n")
    }
  in
  let f = open_out ofile in
  let fmt = formatter_of_out_channel f in
  X86_64.print_program fmt p;
  (* "flush" do buffer para assegurar que tudo o que há por gravar foi de facto gravado antes de fecha-lo *)
  fprintf fmt "@?";
  close_out f
