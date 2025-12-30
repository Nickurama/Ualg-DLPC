
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
%token EOF
%token LP RP
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
| TYPE id = IDENT EQ e = expr END_INST { Set ($1, id, e) }
| PRINT e = expr END_INST             { Print e }
;

expr:
| c = ICST                        { ICst c }
| c = LCST                        { LCst c }
| c = FCST                        { FCst c }
| c = DCST                        { DCst c }
| id = IDENT                     { Var (NoType id) }
| e1 = expr o = op e2 = expr     { Binop (o, NoType, e1, NoType, e2) }
| MINUS e = expr %prec uminus    { Binop (Sub, TInt, ICst 0, NoType, e) }
| LP e = expr RP                 { e }
(* | LET id = IDENT EQ e1 = expr IN e2 = expr { Letin (id, e1, e2) } *)
;

%inline op:
| PLUS  { Add }
| MINUS { Sub }
| TIMES { Mul }
| DIV   { Div }
;



