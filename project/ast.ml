
(* Abstract syntax tree *)

type program = stmt list

and stmt =
    | Function of ty * string * arg list * scope
    | Set of ty * string * ty * expr

and arg =
    | Arg of ty * string

and scope = inst list

and inst =
    | Set of ty * string * ty * expr
    | Assign of string * ty * expr
    | Print of ty * expr
    | FunCall of string * expr list
    | Ret of ty * expr
    | If of ty * expr * scope * elif

and elif =
    | None
    | Elif of ty * expr * scope * elif
    | Else of scope

and expr =
    | ICst of int32
    | LCst of int64
    | FCst of float
    | DCst of float
    | Var of ty * string
    | Binop of ty * ty * binop * ty * expr * ty * expr
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
    | Not
    | Eq
    | Neq
    | Less
    | Leq
    | Grtr
    | Geq
