
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | TYPE of (
# 13 "parser.mly"
       (Ast.ty)
# 15 "parser.ml"
  )
    | TIMES
    | RP
    | RETURN
    | RB
    | PRINT
    | PLUS
    | MINUS
    | LP
    | LCST of (
# 9 "parser.mly"
       (int64)
# 28 "parser.ml"
  )
    | LB
    | IFELSE
    | IF
    | IDENT of (
# 12 "parser.mly"
       (string)
# 36 "parser.ml"
  )
    | ICST of (
# 8 "parser.mly"
       (int32)
# 41 "parser.ml"
  )
    | FCST of (
# 10 "parser.mly"
       (float)
# 46 "parser.ml"
  )
    | EQ
    | EOF
    | END_INST
    | ELSE
    | DIV
    | DCST of (
# 11 "parser.mly"
       (float)
# 56 "parser.ml"
  )
    | COMMA
  
end

include MenhirBasics

# 4 "parser.mly"
  
  open Ast

# 68 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_prog) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: prog. *)

  | MenhirState03 : (('s, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 03.
        Stack shape : TYPE IDENT.
        Start symbol: prog. *)

  | MenhirState07 : ((('s, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 07.
        Stack shape : TYPE IDENT args.
        Start symbol: prog. *)

  | MenhirState08 : (('s, _menhir_box_prog) _menhir_cell1_LB, _menhir_box_prog) _menhir_state
    (** State 08.
        Stack shape : LB.
        Start symbol: prog. *)

  | MenhirState11 : (('s, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 11.
        Stack shape : TYPE IDENT.
        Start symbol: prog. *)

  | MenhirState12 : (('s, _menhir_box_prog) _menhir_cell1_MINUS, _menhir_box_prog) _menhir_state
    (** State 12.
        Stack shape : MINUS.
        Start symbol: prog. *)

  | MenhirState13 : (('s, _menhir_box_prog) _menhir_cell1_LP, _menhir_box_prog) _menhir_state
    (** State 13.
        Stack shape : LP.
        Start symbol: prog. *)

  | MenhirState16 : (('s, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_state
    (** State 16.
        Stack shape : IDENT.
        Start symbol: prog. *)

  | MenhirState22 : ((('s, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_cell1_expr_list, _menhir_box_prog) _menhir_state
    (** State 22.
        Stack shape : IDENT expr_list.
        Start symbol: prog. *)

  | MenhirState24 : (('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 24.
        Stack shape : expr.
        Start symbol: prog. *)

  | MenhirState26 : (('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 26.
        Stack shape : expr.
        Start symbol: prog. *)

  | MenhirState28 : (('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 28.
        Stack shape : expr.
        Start symbol: prog. *)

  | MenhirState30 : (('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 30.
        Stack shape : expr.
        Start symbol: prog. *)

  | MenhirState37 : (('s, _menhir_box_prog) _menhir_cell1_RETURN, _menhir_box_prog) _menhir_state
    (** State 37.
        Stack shape : RETURN.
        Start symbol: prog. *)

  | MenhirState41 : (('s, _menhir_box_prog) _menhir_cell1_PRINT, _menhir_box_prog) _menhir_state
    (** State 41.
        Stack shape : PRINT.
        Start symbol: prog. *)

  | MenhirState45 : (('s, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_state
    (** State 45.
        Stack shape : IF.
        Start symbol: prog. *)

  | MenhirState47 : ((('s, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 47.
        Stack shape : IF expr.
        Start symbol: prog. *)

  | MenhirState48 : (((('s, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope, _menhir_box_prog) _menhir_state
    (** State 48.
        Stack shape : IF expr scope.
        Start symbol: prog. *)

  | MenhirState50 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope, _menhir_box_prog) _menhir_cell1_IFELSE, _menhir_box_prog) _menhir_state
    (** State 50.
        Stack shape : expr scope IFELSE.
        Start symbol: prog. *)

  | MenhirState52 : ((((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope, _menhir_box_prog) _menhir_cell1_IFELSE, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 52.
        Stack shape : expr scope IFELSE expr.
        Start symbol: prog. *)

  | MenhirState53 : (((((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope, _menhir_box_prog) _menhir_cell1_IFELSE, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope, _menhir_box_prog) _menhir_state
    (** State 53.
        Stack shape : expr scope IFELSE expr scope.
        Start symbol: prog. *)

  | MenhirState55 : (((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope, _menhir_box_prog) _menhir_cell1_ELSE, _menhir_box_prog) _menhir_state
    (** State 55.
        Stack shape : expr scope ELSE.
        Start symbol: prog. *)

  | MenhirState57 : ((((('s, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope, _menhir_box_prog) _menhir_cell1_ELSE, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_state
    (** State 57.
        Stack shape : expr scope ELSE expr.
        Start symbol: prog. *)

  | MenhirState62 : (('s, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_state
    (** State 62.
        Stack shape : IDENT.
        Start symbol: prog. *)

  | MenhirState65 : (('s, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_state
    (** State 65.
        Stack shape : IDENT.
        Start symbol: prog. *)

  | MenhirState67 : ((('s, _menhir_box_prog) _menhir_cell1_LB, _menhir_box_prog) _menhir_cell1_insts, _menhir_box_prog) _menhir_state
    (** State 67.
        Stack shape : LB insts.
        Start symbol: prog. *)

  | MenhirState74 : ((('s, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 74.
        Stack shape : TYPE IDENT args.
        Start symbol: prog. *)

  | MenhirState77 : (('s, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 77.
        Stack shape : TYPE IDENT.
        Start symbol: prog. *)

  | MenhirState80 : (('s, _menhir_box_prog) _menhir_cell1_stmts, _menhir_box_prog) _menhir_state
    (** State 80.
        Stack shape : stmts.
        Start symbol: prog. *)


and ('s, 'r) _menhir_cell1_args = 
  | MenhirCell1_args of 's * ('s, 'r) _menhir_state * (Ast.arg list)

and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Ast.expr)

and ('s, 'r) _menhir_cell1_expr_list = 
  | MenhirCell1_expr_list of 's * ('s, 'r) _menhir_state * (Ast.expr list)

and ('s, 'r) _menhir_cell1_insts = 
  | MenhirCell1_insts of 's * ('s, 'r) _menhir_state * (Ast.inst list)

and ('s, 'r) _menhir_cell1_scope = 
  | MenhirCell1_scope of 's * ('s, 'r) _menhir_state * (Ast.scope)

and ('s, 'r) _menhir_cell1_stmts = 
  | MenhirCell1_stmts of 's * ('s, 'r) _menhir_state * (Ast.stmt list)

and ('s, 'r) _menhir_cell1_ELSE = 
  | MenhirCell1_ELSE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IDENT = 
  | MenhirCell1_IDENT of 's * ('s, 'r) _menhir_state * (
# 12 "parser.mly"
       (string)
# 242 "parser.ml"
)

and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * (
# 12 "parser.mly"
       (string)
# 249 "parser.ml"
)

and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IFELSE = 
  | MenhirCell1_IFELSE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LB = 
  | MenhirCell1_LB of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LP = 
  | MenhirCell1_LP of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MINUS = 
  | MenhirCell1_MINUS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PRINT = 
  | MenhirCell1_PRINT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RETURN = 
  | MenhirCell1_RETURN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TYPE = 
  | MenhirCell1_TYPE of 's * ('s, 'r) _menhir_state * (
# 13 "parser.mly"
       (Ast.ty)
# 277 "parser.ml"
)

and _menhir_box_prog = 
  | MenhirBox_prog of (Ast.program) [@@unboxed]

let _menhir_action_01 =
  fun id t ->
    (
# 61 "parser.mly"
                                ( Arg (t, id) )
# 288 "parser.ml"
     : (Ast.arg))

let _menhir_action_02 =
  fun () ->
    (
# 55 "parser.mly"
                                ( [] )
# 296 "parser.ml"
     : (Ast.arg list))

let _menhir_action_03 =
  fun a ->
    (
# 56 "parser.mly"
                                ( [a] )
# 304 "parser.ml"
     : (Ast.arg list))

let _menhir_action_04 =
  fun a ars ->
    (
# 57 "parser.mly"
                                ( a :: ars )
# 312 "parser.ml"
     : (Ast.arg list))

let _menhir_action_05 =
  fun () ->
    (
# 90 "parser.mly"
                                                    ( None )
# 320 "parser.ml"
     : (Ast.elif))

let _menhir_action_06 =
  fun e el sc ->
    (
# 91 "parser.mly"
                                                    ( Elif (NoType, e, sc, el) )
# 328 "parser.ml"
     : (Ast.elif))

let _menhir_action_07 =
  fun e sc ->
    (
# 92 "parser.mly"
                                                    ( Else (NoType, e, sc) )
# 336 "parser.ml"
     : (Ast.elif))

let _menhir_action_08 =
  fun c ->
    (
# 96 "parser.mly"
                                    ( ICst c )
# 344 "parser.ml"
     : (Ast.expr))

let _menhir_action_09 =
  fun c ->
    (
# 97 "parser.mly"
                                    ( LCst c )
# 352 "parser.ml"
     : (Ast.expr))

let _menhir_action_10 =
  fun c ->
    (
# 98 "parser.mly"
                                    ( FCst c )
# 360 "parser.ml"
     : (Ast.expr))

let _menhir_action_11 =
  fun c ->
    (
# 99 "parser.mly"
                                    ( DCst c )
# 368 "parser.ml"
     : (Ast.expr))

let _menhir_action_12 =
  fun id ->
    (
# 100 "parser.mly"
                                    ( Var (NoType, id) )
# 376 "parser.ml"
     : (Ast.expr))

let _menhir_action_13 =
  fun e1 e2 ->
    let o = 
# 108 "parser.mly"
        ( Add )
# 384 "parser.ml"
     in
    (
# 101 "parser.mly"
                                    ( Binop (NoType, o, NoType, e1, NoType, e2) )
# 389 "parser.ml"
     : (Ast.expr))

let _menhir_action_14 =
  fun e1 e2 ->
    let o = 
# 109 "parser.mly"
        ( Sub )
# 397 "parser.ml"
     in
    (
# 101 "parser.mly"
                                    ( Binop (NoType, o, NoType, e1, NoType, e2) )
# 402 "parser.ml"
     : (Ast.expr))

let _menhir_action_15 =
  fun e1 e2 ->
    let o = 
# 110 "parser.mly"
        ( Mul )
# 410 "parser.ml"
     in
    (
# 101 "parser.mly"
                                    ( Binop (NoType, o, NoType, e1, NoType, e2) )
# 415 "parser.ml"
     : (Ast.expr))

let _menhir_action_16 =
  fun e1 e2 ->
    let o = 
# 111 "parser.mly"
        ( Div )
# 423 "parser.ml"
     in
    (
# 101 "parser.mly"
                                    ( Binop (NoType, o, NoType, e1, NoType, e2) )
# 428 "parser.ml"
     : (Ast.expr))

let _menhir_action_17 =
  fun e ->
    (
# 102 "parser.mly"
                                    ( Binop (NoType, Sub, NoType, ICst 0l, NoType, e) )
# 436 "parser.ml"
     : (Ast.expr))

let _menhir_action_18 =
  fun e ->
    (
# 103 "parser.mly"
                                    ( e )
# 444 "parser.ml"
     : (Ast.expr))

let _menhir_action_19 =
  fun es id ->
    (
# 104 "parser.mly"
                                    ( FunCall (id, List.rev es) )
# 452 "parser.ml"
     : (Ast.expr))

let _menhir_action_20 =
  fun () ->
    (
# 65 "parser.mly"
                                    ( [] )
# 460 "parser.ml"
     : (Ast.expr list))

let _menhir_action_21 =
  fun e ->
    (
# 66 "parser.mly"
                                    ( [e] )
# 468 "parser.ml"
     : (Ast.expr list))

let _menhir_action_22 =
  fun e exprs ->
    (
# 67 "parser.mly"
                                    ( e :: exprs )
# 476 "parser.ml"
     : (Ast.expr list))

let _menhir_action_23 =
  fun e id t ->
    (
# 81 "parser.mly"
                                                ( Set (t, id, NoType, e) )
# 484 "parser.ml"
     : (Ast.inst))

let _menhir_action_24 =
  fun e id ->
    (
# 82 "parser.mly"
                                                ( Assign (id, NoType, e) )
# 492 "parser.ml"
     : (Ast.inst))

let _menhir_action_25 =
  fun e ->
    (
# 83 "parser.mly"
                                                ( Print (NoType, e) )
# 500 "parser.ml"
     : (Ast.inst))

let _menhir_action_26 =
  fun es id ->
    (
# 84 "parser.mly"
                                                ( FunCall (id, List.rev es) )
# 508 "parser.ml"
     : (Ast.inst))

let _menhir_action_27 =
  fun e el sc ->
    (
# 85 "parser.mly"
                                                ( If (NoType, e, sc, el))
# 516 "parser.ml"
     : (Ast.inst))

let _menhir_action_28 =
  fun e ->
    (
# 86 "parser.mly"
                                                ( Ret (NoType, e) )
# 524 "parser.ml"
     : (Ast.inst))

let _menhir_action_29 =
  fun i ->
    (
# 76 "parser.mly"
                                        ( [i] )
# 532 "parser.ml"
     : (Ast.inst list))

let _menhir_action_30 =
  fun i l ->
    (
# 77 "parser.mly"
                                        ( i :: l )
# 540 "parser.ml"
     : (Ast.inst list))

let _menhir_action_31 =
  fun p ->
    (
# 41 "parser.mly"
                ( List.rev p )
# 548 "parser.ml"
     : (Ast.program))

let _menhir_action_32 =
  fun () ->
    (
# 71 "parser.mly"
                                ( [] )
# 556 "parser.ml"
     : (Ast.scope))

let _menhir_action_33 =
  fun i ->
    (
# 72 "parser.mly"
                                ( List.rev i )
# 564 "parser.ml"
     : (Ast.scope))

let _menhir_action_34 =
  fun e id t ->
    (
# 50 "parser.mly"
                                                ( Set (t, id, NoType, e) )
# 572 "parser.ml"
     : (Ast.stmt))

let _menhir_action_35 =
  fun a id sc t ->
    (
# 51 "parser.mly"
                                                ( Function (t, id, List.rev a, sc))
# 580 "parser.ml"
     : (Ast.stmt))

let _menhir_action_36 =
  fun i ->
    (
# 45 "parser.mly"
                     ( [i] )
# 588 "parser.ml"
     : (Ast.stmt list))

let _menhir_action_37 =
  fun i l ->
    (
# 46 "parser.mly"
                     ( i :: l )
# 596 "parser.ml"
     : (Ast.stmt list))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | COMMA ->
        "COMMA"
    | DCST _ ->
        "DCST"
    | DIV ->
        "DIV"
    | ELSE ->
        "ELSE"
    | END_INST ->
        "END_INST"
    | EOF ->
        "EOF"
    | EQ ->
        "EQ"
    | FCST _ ->
        "FCST"
    | ICST _ ->
        "ICST"
    | IDENT _ ->
        "IDENT"
    | IF ->
        "IF"
    | IFELSE ->
        "IFELSE"
    | LB ->
        "LB"
    | LCST _ ->
        "LCST"
    | LP ->
        "LP"
    | MINUS ->
        "MINUS"
    | PLUS ->
        "PLUS"
    | PRINT ->
        "PRINT"
    | RB ->
        "RB"
    | RETURN ->
        "RETURN"
    | RP ->
        "RP"
    | TIMES ->
        "TIMES"
    | TYPE _ ->
        "TYPE"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_TYPE (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LP ->
              let _menhir_s = MenhirState03 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TYPE _v ->
                  _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | COMMA | RP ->
                  let _v = _menhir_action_02 () in
                  _menhir_goto_args _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
              | _ ->
                  _eRR ())
          | EQ ->
              let _menhir_s = MenhirState77 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | MINUS ->
                  _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LP ->
                  _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LCST _v ->
                  _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | IDENT _v ->
                  _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | ICST _v ->
                  _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | FCST _v ->
                  _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | DCST _v ->
                  _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (id, t) = (_v_0, _v) in
          let _v = _menhir_action_01 id t in
          _menhir_goto_arg _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_arg : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState03 ->
          _menhir_run_76 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState74 ->
          _menhir_run_75 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_76 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let a = _v in
      let _v = _menhir_action_03 a in
      _menhir_goto_args _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_args : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_args (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | RP ->
          let _menhir_s = MenhirState07 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LB ->
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | COMMA ->
          let _menhir_s = MenhirState74 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TYPE _v ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_08 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TYPE _v ->
          let _menhir_stack = MenhirCell1_LB (_menhir_stack, _menhir_s) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState08
      | RETURN ->
          let _menhir_stack = MenhirCell1_LB (_menhir_stack, _menhir_s) in
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | RB ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_32 () in
          _menhir_goto_scope _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PRINT ->
          let _menhir_stack = MenhirCell1_LB (_menhir_stack, _menhir_s) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | IF ->
          let _menhir_stack = MenhirCell1_LB (_menhir_stack, _menhir_s) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | IDENT _v ->
          let _menhir_stack = MenhirCell1_LB (_menhir_stack, _menhir_s) in
          _menhir_run_61 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState08
      | _ ->
          _eRR ()
  
  and _menhir_run_09 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_TYPE (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | EQ ->
              let _menhir_s = MenhirState11 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | MINUS ->
                  _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LP ->
                  _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LCST _v ->
                  _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | IDENT _v ->
                  _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | ICST _v ->
                  _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | FCST _v ->
                  _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | DCST _v ->
                  _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_12 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState12 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LP ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LCST _v ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ICST _v ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FCST _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DCST _v ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_13 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LP (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState13 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LP ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LCST _v ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ICST _v ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FCST _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DCST _v ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_14 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let c = _v in
      let _v = _menhir_action_09 c in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState77 ->
          _menhir_run_78 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState65 ->
          _menhir_run_66 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState55 ->
          _menhir_run_56 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState50 ->
          _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState45 ->
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState41 ->
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState37 ->
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState11 ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState12 ->
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState13 ->
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState62 ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState16 ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState30 ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState28 ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState26 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState24 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState22 ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_78 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer
      | END_INST ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_IDENT (_menhir_stack, id) = _menhir_stack in
          let MenhirCell1_TYPE (_menhir_stack, _menhir_s, t) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_34 e id t in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_24 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState24 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LP ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LCST _v ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ICST _v ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FCST _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DCST _v ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_15 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LP ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MINUS ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState16
          | LP ->
              _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState16
          | LCST _v_0 ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState16
          | IDENT _v_1 ->
              _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState16
          | ICST _v_2 ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState16
          | FCST _v_3 ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState16
          | DCST _v_4 ->
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState16
          | COMMA | RP ->
              let _v_5 = _menhir_action_20 () in
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 MenhirState16 _tok
          | _ ->
              _eRR ())
      | COMMA | DIV | END_INST | MINUS | PLUS | RP | TIMES ->
          let id = _v in
          let _v = _menhir_action_12 id in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_17 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let c = _v in
      let _v = _menhir_action_08 c in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_18 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let c = _v in
      let _v = _menhir_action_10 c in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_19 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let c = _v in
      let _v = _menhir_action_11 c in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_20 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RP ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let es = _v in
          let _v = _menhir_action_19 es id in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr_list (_menhir_stack, _menhir_s, _v) in
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_22 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_cell1_expr_list -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState22 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LP ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LCST _v ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ICST _v ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FCST _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DCST _v ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_26 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState26 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LP ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LCST _v ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ICST _v ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FCST _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DCST _v ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_30 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState30 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LP ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LCST _v ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ICST _v ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FCST _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DCST _v ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_stmt : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_83 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState80 ->
          _menhir_run_82 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_83 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let i = _v in
      let _v = _menhir_action_36 i in
      _menhir_goto_stmts _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_stmts : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TYPE _v_0 ->
          let _menhir_stack = MenhirCell1_stmts (_menhir_stack, _menhir_s, _v) in
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState80
      | EOF ->
          let p = _v in
          let _v = _menhir_action_31 p in
          MenhirBox_prog _v
      | _ ->
          _eRR ()
  
  and _menhir_run_82 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_stmts -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_stmts (_menhir_stack, _menhir_s, l) = _menhir_stack in
      let i = _v in
      let _v = _menhir_action_37 i l in
      _menhir_goto_stmts _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_28 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState28 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LP ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LCST _v ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ICST _v ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FCST _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DCST _v ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_66 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | END_INST ->
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_24 e id in
          _menhir_goto_inst _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_inst : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState08 ->
          _menhir_run_71 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState67 ->
          _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_71 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LB as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | END_INST ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i = _v in
          let _v = _menhir_action_29 i in
          _menhir_goto_insts _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_insts : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LB as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TYPE _v_0 ->
          let _menhir_stack = MenhirCell1_insts (_menhir_stack, _menhir_s, _v) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState67
      | RETURN ->
          let _menhir_stack = MenhirCell1_insts (_menhir_stack, _menhir_s, _v) in
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | RB ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LB (_menhir_stack, _menhir_s) = _menhir_stack in
          let i = _v in
          let _v = _menhir_action_33 i in
          _menhir_goto_scope _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PRINT ->
          let _menhir_stack = MenhirCell1_insts (_menhir_stack, _menhir_s, _v) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | IF ->
          let _menhir_stack = MenhirCell1_insts (_menhir_stack, _menhir_s, _v) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | IDENT _v_1 ->
          let _menhir_stack = MenhirCell1_insts (_menhir_stack, _menhir_s, _v) in
          _menhir_run_61 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState67
      | _ ->
          _eRR ()
  
  and _menhir_run_37 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_RETURN (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState37 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LP ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LCST _v ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ICST _v ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FCST _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DCST _v ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_scope : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState07 ->
          _menhir_run_73 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState57 ->
          _menhir_run_58 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState52 ->
          _menhir_run_53 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState47 ->
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_73 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_args (_menhir_stack, _, a) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, id) = _menhir_stack in
      let MenhirCell1_TYPE (_menhir_stack, _menhir_s, t) = _menhir_stack in
      let sc = _v in
      let _v = _menhir_action_35 a id sc t in
      _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_58 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope, _menhir_box_prog) _menhir_cell1_ELSE, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _, e) = _menhir_stack in
      let MenhirCell1_ELSE (_menhir_stack, _menhir_s) = _menhir_stack in
      let sc = _v in
      let _v = _menhir_action_07 e sc in
      _menhir_goto_elif _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_elif : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState48 ->
          _menhir_run_60 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState53 ->
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_60 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_scope (_menhir_stack, _, sc) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, e) = _menhir_stack in
      let MenhirCell1_IF (_menhir_stack, _menhir_s) = _menhir_stack in
      let el = _v in
      let _v = _menhir_action_27 e el sc in
      _menhir_goto_inst _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_59 : type  ttv_stack. (((((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope, _menhir_box_prog) _menhir_cell1_IFELSE, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_scope (_menhir_stack, _, sc) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, e) = _menhir_stack in
      let MenhirCell1_IFELSE (_menhir_stack, _menhir_s) = _menhir_stack in
      let el = _v in
      let _v = _menhir_action_06 e el sc in
      _menhir_goto_elif _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_53 : type  ttv_stack. (((((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope, _menhir_box_prog) _menhir_cell1_IFELSE, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_scope (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | IFELSE ->
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState53
      | ELSE ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState53
      | END_INST ->
          let _v_0 = _menhir_action_05 () in
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_49 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IFELSE (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LP ->
          let _menhir_s = MenhirState50 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MINUS ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LP ->
              _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LCST _v ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ICST _v ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FCST _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DCST _v ->
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_54 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope as 'stack) -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_ELSE (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LP ->
          let _menhir_s = MenhirState55 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MINUS ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LP ->
              _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LCST _v ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ICST _v ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FCST _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DCST _v ->
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_48 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_IF, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_scope (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | IFELSE ->
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | ELSE ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
      | END_INST ->
          let _v_0 = _menhir_action_05 () in
          _menhir_run_60 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_40 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PRINT (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LP ->
          let _menhir_s = MenhirState41 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MINUS ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LP ->
              _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LCST _v ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ICST _v ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FCST _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DCST _v ->
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_44 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LP ->
          let _menhir_s = MenhirState45 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MINUS ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LP ->
              _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LCST _v ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ICST _v ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FCST _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DCST _v ->
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_61 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LP ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MINUS ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState62
          | LP ->
              _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState62
          | LCST _v_0 ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState62
          | IDENT _v_1 ->
              _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState62
          | ICST _v_2 ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState62
          | FCST _v_3 ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState62
          | DCST _v_4 ->
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState62
          | COMMA | RP ->
              let _v_5 = _menhir_action_20 () in
              _menhir_run_63 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 MenhirState62 _tok
          | _ ->
              _eRR ())
      | EQ ->
          let _menhir_s = MenhirState65 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MINUS ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LP ->
              _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LCST _v ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ICST _v ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FCST _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DCST _v ->
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_63 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RP ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let es = _v in
          let _v = _menhir_action_26 es id in
          _menhir_goto_inst _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr_list (_menhir_stack, _menhir_s, _v) in
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_69 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LB, _menhir_box_prog) _menhir_cell1_insts -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | END_INST ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_insts (_menhir_stack, _menhir_s, l) = _menhir_stack in
          let i = _v in
          let _v = _menhir_action_30 i l in
          _menhir_goto_insts _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_56 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope, _menhir_box_prog) _menhir_cell1_ELSE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RP ->
          let _menhir_s = MenhirState57 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LB ->
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | PLUS ->
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_51 : type  ttv_stack. ((((ttv_stack, _menhir_box_prog) _menhir_cell1_expr, _menhir_box_prog) _menhir_cell1_scope, _menhir_box_prog) _menhir_cell1_IFELSE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RP ->
          let _menhir_s = MenhirState52 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LB ->
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | PLUS ->
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_46 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RP ->
          let _menhir_s = MenhirState47 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LB ->
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | PLUS ->
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_42 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_PRINT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RP ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_PRINT (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_25 e in
          _menhir_goto_inst _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_38 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_RETURN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | END_INST ->
          let MenhirCell1_RETURN (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_28 e in
          _menhir_goto_inst _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_36 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | END_INST ->
          let MenhirCell0_IDENT (_menhir_stack, id) = _menhir_stack in
          let MenhirCell1_TYPE (_menhir_stack, _menhir_s, t) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_23 e id t in
          _menhir_goto_inst _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_35 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_MINUS -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_MINUS (_menhir_stack, _menhir_s) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_17 e in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_33 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_LP as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RP ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LP (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_18 e in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_32 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | RP ->
          let e = _v in
          let _v = _menhir_action_21 e in
          _menhir_goto_expr_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_expr_list : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState62 ->
          _menhir_run_63 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState16 ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_31 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | END_INST | MINUS | PLUS | RP ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_14 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_29 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
      let e2 = _v in
      let _v = _menhir_action_16 e1 e2 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_27 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | END_INST | MINUS | PLUS | RP ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_13 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_25 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
      let e2 = _v in
      let _v = _menhir_action_15 e1 e2 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_23 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_cell1_expr_list as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | RP ->
          let MenhirCell1_expr_list (_menhir_stack, _menhir_s, exprs) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_22 e exprs in
          _menhir_goto_expr_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_75 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_args (_menhir_stack, _menhir_s, ars) = _menhir_stack in
      let a = _v in
      let _v = _menhir_action_04 a ars in
      _menhir_goto_args _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  let _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState00 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TYPE _v ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
end

let prog =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_prog v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
