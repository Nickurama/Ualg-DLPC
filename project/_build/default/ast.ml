
(* Abstract syntax tree *)

type program = stmt list

and stmt =
    | Function of ty * string * arg list * scope
    | Set of ty * string * ty * expr

and arg =
    | Arg of ty * string

and scope = inst list
    (* | Scope of inst list *)

and inst =
    | Set of ty * string * ty * expr
    | Assign of string * ty * expr
    | Print of ty * expr
    | FunCall of string * expr list
    | Ret of ty * expr

and expr =
    | ICst of int32
    | LCst of int64
    | FCst of float
    | DCst of float
    | Var of ty * string
    | Binop of ty * binop * ty * expr * ty * expr
    | FunCall of string * expr list

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
