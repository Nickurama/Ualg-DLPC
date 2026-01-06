{
    open Lexing
    open Parser
    open Ast

    exception Lexing_error of char

    let kwd_tbl = [
        "print", PRINT;
        "int", TYPE TInt;
        "long", TYPE TLong;
        "float", TYPE TFloat;
        "double", TYPE TDouble;
        "void", TYPE NoType
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
  | '{'     { LB }
  | '}'     { RB }
  | '('     { LP }
  | ')'     { RP }
  | ';'     { END_INST }
  | ','     { COMMA }
  | integer as s { ICST (Int32.of_string s) }
  | integer 'l' as s {
      let len = String.length s in
      let s_cropped = String.sub s 0 (len - 1) in
      LCST (Int64.of_string s_cropped)
  }
  | integer '.' integer as s { FCST (float_of_string s) }
  | integer '.' integer 'd' as s { 
      let len = String.length s in
      let s_cropped = String.sub s 0 (len - 1) in
      DCST (float_of_string s_cropped)
  }
  | eof     { EOF }
  | _ as c  { raise (Lexing_error c) }
