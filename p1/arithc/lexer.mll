
(* Analisador léxico para Arith *)

{
    open Lexing
    open Parser

    exception Lexing_error of char

    let kwd_tbl = [
        (* "let",LET; *)
        (* "in",IN; *)
        (* "set",SET; *)
        "print",PRINT;
        "int",INT;
        "long",LONG;
        "float",FLOAT;
        "double",DOUBLE
    ]
    let id_or_kwd s = try List.assoc s kwd_tbl with _ -> IDENT s
}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let ident = letter (letter | digit)*
let integer = ['0'-'9']+
let space = [' ' '\t']

rule token = parse
  | '\n'    { new_line lexbuf; token lexbuf }
  | "#" [^'\n']* '\n' { new_line lexbuf; token lexbuf }
  | space+  { token lexbuf }
  | ident as id { id_or_kwd id }
  | '+'     { PLUS }
  | '-'     { MINUS }
  | '*'     { TIMES }
  | '/'     { DIV }
  | '='     { EQ }
  | '('     { LP }
  | ')'     { RP }
  | ';'     { END_INST }
  | integer as s { ICST (int_of_string s) }
  | integer 'l' as s {LCST (Int64.of_string s)}
  | integer '.' integer as s { FCST (float_of_string f) }
  | integer '.' integer 'd' as s { DCST (float_of_string f) }
  | eof     { EOF }
  | _ as c  { raise (Lexing_error c) }
