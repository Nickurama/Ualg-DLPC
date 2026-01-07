
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
    | RB
    | PRINT
    | PLUS
    | MINUS
    | LP
    | LCST of (
# 9 "parser.mly"
       (int64)
# 27 "parser.ml"
  )
    | LB
    | IDENT of (
# 12 "parser.mly"
       (string)
# 33 "parser.ml"
  )
    | ICST of (
# 8 "parser.mly"
       (int32)
# 38 "parser.ml"
  )
    | FCST of (
# 10 "parser.mly"
       (float)
# 43 "parser.ml"
  )
    | EQ
    | EOF
    | END_INST
    | DIV
    | DCST of (
# 11 "parser.mly"
       (float)
# 52 "parser.ml"
  )
    | COMMA
  
end

include MenhirBasics

# 4 "parser.mly"
  
  open Ast

# 64 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_prog) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: prog. *)

  | MenhirState03 : (('s, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 03.
        Stack shape : TYPE IDENT.
        Start symbol: prog. *)

  | MenhirState08 : ((('s, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 08.
        Stack shape : TYPE IDENT args.
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

  | MenhirState38 : (('s, _menhir_box_prog) _menhir_cell1_PRINT, _menhir_box_prog) _menhir_state
    (** State 38.
        Stack shape : PRINT.
        Start symbol: prog. *)

  | MenhirState42 : (('s, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_state
    (** State 42.
        Stack shape : IDENT.
        Start symbol: prog. *)

  | MenhirState45 : (('s, _menhir_box_prog) _menhir_cell1_IDENT, _menhir_box_prog) _menhir_state
    (** State 45.
        Stack shape : IDENT.
        Start symbol: prog. *)

  | MenhirState47 : (((('s, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_cell1_insts, _menhir_box_prog) _menhir_state
    (** State 47.
        Stack shape : TYPE IDENT args insts.
        Start symbol: prog. *)

  | MenhirState54 : ((('s, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_state
    (** State 54.
        Stack shape : TYPE IDENT args.
        Start symbol: prog. *)

  | MenhirState57 : (('s, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_state
    (** State 57.
        Stack shape : TYPE IDENT.
        Start symbol: prog. *)

  | MenhirState60 : (('s, _menhir_box_prog) _menhir_cell1_stmts, _menhir_box_prog) _menhir_state
    (** State 60.
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

and ('s, 'r) _menhir_cell1_stmts = 
  | MenhirCell1_stmts of 's * ('s, 'r) _menhir_state * (Ast.stmt list)

and ('s, 'r) _menhir_cell1_IDENT = 
  | MenhirCell1_IDENT of 's * ('s, 'r) _menhir_state * (
# 12 "parser.mly"
       (string)
# 182 "parser.ml"
)

and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * (
# 12 "parser.mly"
       (string)
# 189 "parser.ml"
)

and ('s, 'r) _menhir_cell1_LP = 
  | MenhirCell1_LP of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MINUS = 
  | MenhirCell1_MINUS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PRINT = 
  | MenhirCell1_PRINT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TYPE = 
  | MenhirCell1_TYPE of 's * ('s, 'r) _menhir_state * (
# 13 "parser.mly"
       (Ast.ty)
# 205 "parser.ml"
)

and _menhir_box_prog = 
  | MenhirBox_prog of (Ast.program) [@@unboxed]

let _menhir_action_01 =
  fun id t ->
    (
# 59 "parser.mly"
                                ( Arg (t, id) )
# 216 "parser.ml"
     : (Ast.arg))

let _menhir_action_02 =
  fun () ->
    (
# 53 "parser.mly"
                                ( [] )
# 224 "parser.ml"
     : (Ast.arg list))

let _menhir_action_03 =
  fun a ->
    (
# 54 "parser.mly"
                                ( [a] )
# 232 "parser.ml"
     : (Ast.arg list))

let _menhir_action_04 =
  fun a ars ->
    (
# 55 "parser.mly"
                                ( a :: ars )
# 240 "parser.ml"
     : (Ast.arg list))

let _menhir_action_05 =
  fun c ->
    (
# 85 "parser.mly"
                                    ( ICst c )
# 248 "parser.ml"
     : (Ast.expr))

let _menhir_action_06 =
  fun c ->
    (
# 86 "parser.mly"
                                    ( LCst c )
# 256 "parser.ml"
     : (Ast.expr))

let _menhir_action_07 =
  fun c ->
    (
# 87 "parser.mly"
                                    ( FCst c )
# 264 "parser.ml"
     : (Ast.expr))

let _menhir_action_08 =
  fun c ->
    (
# 88 "parser.mly"
                                    ( DCst c )
# 272 "parser.ml"
     : (Ast.expr))

let _menhir_action_09 =
  fun id ->
    (
# 89 "parser.mly"
                                    ( Var (NoType, id) )
# 280 "parser.ml"
     : (Ast.expr))

let _menhir_action_10 =
  fun e1 e2 ->
    let o = 
# 97 "parser.mly"
        ( Add )
# 288 "parser.ml"
     in
    (
# 90 "parser.mly"
                                    ( Binop (NoType, o, NoType, e1, NoType, e2) )
# 293 "parser.ml"
     : (Ast.expr))

let _menhir_action_11 =
  fun e1 e2 ->
    let o = 
# 98 "parser.mly"
        ( Sub )
# 301 "parser.ml"
     in
    (
# 90 "parser.mly"
                                    ( Binop (NoType, o, NoType, e1, NoType, e2) )
# 306 "parser.ml"
     : (Ast.expr))

let _menhir_action_12 =
  fun e1 e2 ->
    let o = 
# 99 "parser.mly"
        ( Mul )
# 314 "parser.ml"
     in
    (
# 90 "parser.mly"
                                    ( Binop (NoType, o, NoType, e1, NoType, e2) )
# 319 "parser.ml"
     : (Ast.expr))

let _menhir_action_13 =
  fun e1 e2 ->
    let o = 
# 100 "parser.mly"
        ( Div )
# 327 "parser.ml"
     in
    (
# 90 "parser.mly"
                                    ( Binop (NoType, o, NoType, e1, NoType, e2) )
# 332 "parser.ml"
     : (Ast.expr))

let _menhir_action_14 =
  fun e ->
    (
# 91 "parser.mly"
                                    ( Binop (NoType, Sub, NoType, ICst 0l, NoType, e) )
# 340 "parser.ml"
     : (Ast.expr))

let _menhir_action_15 =
  fun e ->
    (
# 92 "parser.mly"
                                    ( e )
# 348 "parser.ml"
     : (Ast.expr))

let _menhir_action_16 =
  fun es id ->
    (
# 93 "parser.mly"
                                    ( FunCall (id, List.rev es) )
# 356 "parser.ml"
     : (Ast.expr))

let _menhir_action_17 =
  fun () ->
    (
# 63 "parser.mly"
                                    ( [] )
# 364 "parser.ml"
     : (Ast.expr list))

let _menhir_action_18 =
  fun e ->
    (
# 64 "parser.mly"
                                    ( [e] )
# 372 "parser.ml"
     : (Ast.expr list))

let _menhir_action_19 =
  fun e exprs ->
    (
# 65 "parser.mly"
                                    ( e :: exprs )
# 380 "parser.ml"
     : (Ast.expr list))

let _menhir_action_20 =
  fun e id t ->
    (
# 78 "parser.mly"
                                                ( Set (t, id, NoType, e) )
# 388 "parser.ml"
     : (Ast.inst))

let _menhir_action_21 =
  fun e id ->
    (
# 79 "parser.mly"
                                                ( Assign (id, NoType, e) )
# 396 "parser.ml"
     : (Ast.inst))

let _menhir_action_22 =
  fun e ->
    (
# 80 "parser.mly"
                                                ( Print (NoType, e) )
# 404 "parser.ml"
     : (Ast.inst))

let _menhir_action_23 =
  fun es id ->
    (
# 81 "parser.mly"
                                                 ( FunCall (id, List.rev es) )
# 412 "parser.ml"
     : (Ast.inst))

let _menhir_action_24 =
  fun i ->
    (
# 73 "parser.mly"
                                        ( [i] )
# 420 "parser.ml"
     : (Ast.inst list))

let _menhir_action_25 =
  fun i l ->
    (
# 74 "parser.mly"
                                        ( i :: l )
# 428 "parser.ml"
     : (Ast.inst list))

let _menhir_action_26 =
  fun p ->
    (
# 39 "parser.mly"
                ( List.rev p )
# 436 "parser.ml"
     : (Ast.program))

let _menhir_action_27 =
  fun i ->
    (
# 69 "parser.mly"
                                ( List.rev i )
# 444 "parser.ml"
     : (Ast.scope))

let _menhir_action_28 =
  fun e id t ->
    (
# 48 "parser.mly"
                                                ( Set (t, id, NoType, e) )
# 452 "parser.ml"
     : (Ast.stmt))

let _menhir_action_29 =
  fun a id sc t ->
    (
# 49 "parser.mly"
                                                ( Function (t, id, List.rev a, sc))
# 460 "parser.ml"
     : (Ast.stmt))

let _menhir_action_30 =
  fun i ->
    (
# 43 "parser.mly"
                     ( [i] )
# 468 "parser.ml"
     : (Ast.stmt list))

let _menhir_action_31 =
  fun i l ->
    (
# 44 "parser.mly"
                     ( i :: l )
# 476 "parser.ml"
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
              let _menhir_s = MenhirState57 in
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
          _menhir_run_56 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState54 ->
          _menhir_run_55 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_56 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let a = _v in
      let _v = _menhir_action_03 a in
      _menhir_goto_args _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_args : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_args (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | RP ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LB ->
              let _menhir_s = MenhirState08 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TYPE _v ->
                  _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | PRINT ->
                  _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | COMMA ->
          let _menhir_s = MenhirState54 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TYPE _v ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
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
      let _v = _menhir_action_06 c in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState57 ->
          _menhir_run_58 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState45 ->
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState38 ->
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState11 ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState12 ->
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState13 ->
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState42 ->
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
  
  and _menhir_run_58 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
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
          let _v = _menhir_action_28 e id t in
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
              let _v_5 = _menhir_action_17 () in
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 MenhirState16 _tok
          | _ ->
              _eRR ())
      | COMMA | DIV | END_INST | MINUS | PLUS | RP | TIMES ->
          let id = _v in
          let _v = _menhir_action_09 id in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_17 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let c = _v in
      let _v = _menhir_action_05 c in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_18 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let c = _v in
      let _v = _menhir_action_07 c in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_19 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let c = _v in
      let _v = _menhir_action_08 c in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_20 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RP ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let es = _v in
          let _v = _menhir_action_16 es id in
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
          _menhir_run_63 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState60 ->
          _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_63 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let i = _v in
      let _v = _menhir_action_30 i in
      _menhir_goto_stmts _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_stmts : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TYPE _v_0 ->
          let _menhir_stack = MenhirCell1_stmts (_menhir_stack, _menhir_s, _v) in
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState60
      | EOF ->
          let p = _v in
          let _v = _menhir_action_26 p in
          MenhirBox_prog _v
      | _ ->
          _eRR ()
  
  and _menhir_run_62 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_stmts -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_stmts (_menhir_stack, _menhir_s, l) = _menhir_stack in
      let i = _v in
      let _v = _menhir_action_31 i l in
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
  
  and _menhir_run_46 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
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
          let _v = _menhir_action_21 e id in
          _menhir_goto_inst _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_inst : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState08 ->
          _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState47 ->
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_51 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | END_INST ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i = _v in
          let _v = _menhir_action_24 i in
          _menhir_goto_insts _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_insts : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TYPE _v_0 ->
          let _menhir_stack = MenhirCell1_insts (_menhir_stack, _menhir_s, _v) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState47
      | RB ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i = _v in
          let _v = _menhir_action_27 i in
          let MenhirCell1_args (_menhir_stack, _, a) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, id) = _menhir_stack in
          let MenhirCell1_TYPE (_menhir_stack, _menhir_s, t) = _menhir_stack in
          let sc = _v in
          let _v = _menhir_action_29 a id sc t in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PRINT ->
          let _menhir_stack = MenhirCell1_insts (_menhir_stack, _menhir_s, _v) in
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState47
      | IDENT _v_1 ->
          let _menhir_stack = MenhirCell1_insts (_menhir_stack, _menhir_s, _v) in
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState47
      | _ ->
          _eRR ()
  
  and _menhir_run_37 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PRINT (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LP ->
          let _menhir_s = MenhirState38 in
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
  
  and _menhir_run_41 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LP ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MINUS ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState42
          | LP ->
              _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState42
          | LCST _v_0 ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState42
          | IDENT _v_1 ->
              _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState42
          | ICST _v_2 ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState42
          | FCST _v_3 ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState42
          | DCST _v_4 ->
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState42
          | COMMA | RP ->
              let _v_5 = _menhir_action_17 () in
              _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 MenhirState42 _tok
          | _ ->
              _eRR ())
      | EQ ->
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
  
  and _menhir_run_43 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RP ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let es = _v in
          let _v = _menhir_action_23 es id in
          _menhir_goto_inst _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr_list (_menhir_stack, _menhir_s, _v) in
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_49 : type  ttv_stack. (((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args, _menhir_box_prog) _menhir_cell1_insts -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | END_INST ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_insts (_menhir_stack, _menhir_s, l) = _menhir_stack in
          let i = _v in
          let _v = _menhir_action_25 i l in
          _menhir_goto_insts _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_39 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_PRINT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RP ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_PRINT (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_22 e in
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
          let _v = _menhir_action_20 e id t in
          _menhir_goto_inst _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_35 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_MINUS -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_MINUS (_menhir_stack, _menhir_s) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_14 e in
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
          let _v = _menhir_action_15 e in
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
          let _v = _menhir_action_18 e in
          _menhir_goto_expr_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_expr_list : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState42 ->
          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
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
          let _v = _menhir_action_11 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_29 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
      let e2 = _v in
      let _v = _menhir_action_13 e1 e2 in
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
          let _v = _menhir_action_10 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_25 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
      let e2 = _v in
      let _v = _menhir_action_12 e1 e2 in
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
          let _v = _menhir_action_19 e exprs in
          _menhir_goto_expr_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_55 : type  ttv_stack. ((ttv_stack, _menhir_box_prog) _menhir_cell1_TYPE _menhir_cell0_IDENT, _menhir_box_prog) _menhir_cell1_args -> _ -> _ -> _ -> _ -> _menhir_box_prog =
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
