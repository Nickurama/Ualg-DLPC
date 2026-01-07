
/* Parser */

%{
  open Ast
%}

%token <int32> ICST
%token <int64> LCST
%token <float> FCST
%token <float> DCST
%token <string> IDENT
%token <Ast.ty> TYPE
%token PRINT
%token END_INST
%token COMMA
%token EOF
%token IF IFELSE ELSE
%token RETURN
%token LP RP
%token LB RB
%token PLUS MINUS TIMES DIV
%token EQ

/* Definition of priority and associativity of tokens */

(* %nonassoc IN *)
%left PLUS MINUS
%left TIMES DIV
%nonassoc uminus

/* Entry point for grammar */
%start prog

/* Type of the values returned by the parser */
%type <Ast.program> prog

%%

prog:
| p = stmts EOF { List.rev p }
;

stmts:
| i = stmt           { [i] }
| l = stmts i = stmt { i :: l }
;

stmt:
| t = TYPE id = IDENT EQ e = expr END_INST      { Set (t, id, NoType, e) }
| t = TYPE id = IDENT LP a = args RP sc = scope { Function (t, id, List.rev a, sc)}
;

args:
|                               { [] }
| a = arg                       { [a] }
| ars = args COMMA a = arg      { a :: ars }
;

arg:
| t = TYPE id = IDENT           { Arg (t, id) }
;

expr_list:
|                                   { [] }
| e = expr                          { [e] }
| exprs = expr_list COMMA e = expr  { e :: exprs }
;

scope:
| LB RB                         { [] }
| LB i = insts RB               { List.rev i }
;

insts:
| i = inst END_INST                     { [i] }
| l = insts i = inst END_INST           { i :: l }
;

inst:
| t = TYPE id = IDENT EQ e = expr               { Set (t, id, NoType, e) }
| id = IDENT EQ e = expr                        { Assign (id, NoType, e) }
| PRINT LP e = expr RP                          { Print (NoType, e) }
| id = IDENT LP es = expr_list RP               { FunCall (id, List.rev es) }
| IF LP e = expr RP sc = scope el = elif        { If (NoType, e, sc, el)}
| RETURN e = expr                               { Ret (NoType, e) }
;

elif:
|                                                   { None }
| IFELSE LP e = expr RP sc = scope el = elif        { Elif (NoType, e, sc, el) }
| ELSE LP e = expr RP sc = scope                    { Else (NoType, e, sc) }
;

expr:
| c = ICST                          { ICst c }
| c = LCST                          { LCst c }
| c = FCST                          { FCst c }
| c = DCST                          { DCst c }
| id = IDENT                        { Var (NoType, id) }
| e1 = expr o = op e2 = expr        { Binop (NoType, o, NoType, e1, NoType, e2) }
| MINUS e = expr %prec uminus       { Binop (NoType, Sub, NoType, ICst 0l, NoType, e) }
| LP e = expr RP                    { e }
| id = IDENT LP es = expr_list RP   { FunCall (id, List.rev es) }
;

%inline op:
| PLUS  { Add }
| MINUS { Sub }
| TIMES { Mul }
| DIV   { Div }
;



