
(* Sintaxe abstracta para a linguagem Arith *)

type ty =
    | TInt
    | TLong
    | TFloat
    | TDouble
    | TBool

type program = stmt list

and stmt =
    | Set of string * expr
    | Print of expr

and expr =
    | Cst of int
    | Var of string
    | Binop of binop * expr * expr

and binop =
    | Add
    | Sub
    | Mul
    | Div

