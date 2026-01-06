
(* The type of tokens. *)

type token = 
  | TYPE of (Ast.ty)
  | TIMES
  | RP
  | RB
  | PRINT
  | PLUS
  | MINUS
  | LP
  | LCST of (int64)
  | LB
  | IDENT of (string)
  | ICST of (int32)
  | FCST of (float)
  | EQ
  | EOF
  | END_INST
  | DIV
  | DCST of (float)
  | COMMA

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.program)
