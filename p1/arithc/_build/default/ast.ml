
(* Abstract syntax tree *)

type program = stmt list

and stmt =
    | Set of ty * string * expr
    | Print of expr

and expr =
    | ICst of int32
    | LCst of int64
    | FCst of float
    | DCst of float
    | Var of ty * string
    | Binop of binop * ty * expr * ty * expr

and ty =
    | NoType (* placeholder *)
    | TInt
    | TLong
    | TFloat
    | TDouble


and binop =
    | Add
    | Sub
    | Mul
    | Div
