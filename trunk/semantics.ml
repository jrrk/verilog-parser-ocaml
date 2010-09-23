(******************************************************************************
*
*    DESCRIPTION: Verilog parser semantics parser tree file
*
******************************************************************************
*
* Copyright 2010 by Jonathan Kimmitt.  This program is free software; you can
* redistribute it and/or modify it under the terms of either the GNU
* General Public License or the Perl Artistic License.
*
* This code is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
******************************************************************************
* Based on verilator parser code by Paul Wasson, Duane Galbi and Wilson Snyder
*******************************************************************************)

open List
open Printf
open Vparser
open Globals
open Setup

type exprtree = { entry: token; symbol: Set.Make(Setup.OrdTok).t };;

type exprt =
| DYADIC of (token * exprtree * exprtree)
| ASSIGNMENT of (exprtree * exprt)
| UNHANDLED of token
;;

let stmts = ref [];;

let enter_a_sym symbols id attr = 
if Hashtbl.mem symbols id then begin
(*  printf "Update %s: %s\n" id (Ord.getstr attr); *)
  let newset = (Hashtbl.find symbols id) in
  Hashtbl.replace symbols id (TokSet.add attr newset); end
else begin
(*  printf "Enter %s: %s\n" id (Ord.getstr attr); *)
  Hashtbl.add symbols id (TokSet.singleton attr)
  end
;;

let iter_ semantics gsyms (stem:string) syms list =
  List.iter (fun x -> semantics gsyms stem ({Globals.tree=x; symbols=syms})) list
;;

exception MyException of string * int (* exceptions can carry a value *);;

let unhandled_exception s =
  try
    raise (MyException (s, 2));
  with
  | MyException (s, i) -> 
      Printf.printf "MyException: %s, %d\n" s i
  | e ->  (* catch all exceptions *)
     Printf.eprintf "Unexpected exception : %s" (Printexc.to_string e);
     (*If using Ocaml >= 3.11, it is possible to also print a backtrace: *)
     Printexc.print_backtrace stderr;
       (* Needs to beforehand enable backtrace recording with
           Printexc.record_backtrace true
         or by setting the environment variable OCAMLRUNPARAM="b1"*)
;;

let unhand_array=DynArray.init 1 (fun x -> EMPTY);;

let unhandled arg = (fun xx t -> DynArray.add xx t ) unhand_array arg;Printexc.print_backtrace stderr(*;raise (MyException (Ord.getstr(arg), 1))*);;

let not_found syms w = printf "wire/port %s not found\n" w; enter_a_sym syms w IMPLICIT;;

let find_ident gsyms dir stem syms tok = match tok with ID id -> begin
if Hashtbl.mem syms id == false then begin
  printf "Creating implicit wire %s\n" id;
  Hashtbl.add syms id (TokSet.singleton IMPLICIT)
  end;
enter_a_sym gsyms (stem^id) dir;
Hashtbl.find syms id
end
| BINNUM lev -> TokSet.singleton tok
| _ -> unhandled tok; TokSet.singleton tok
;;

let enter_sym_attrs gsyms dir stem symbols (tok:token) list = match tok with
| ID id -> enter_a_sym gsyms (stem^id) dir ;
  iter (fun x -> enter_a_sym symbols id x) list
| _ -> unhandled tok;
;;

let subexp gsyms stem syms exp = match exp with
| ID id -> find_ident gsyms DRIVER stem syms exp
| TRIPLE (BITSEL, ID id, INTNUM n) -> find_ident gsyms DRIVER stem syms (ID id)
| _ -> unhandled exp; TokSet.singleton exp;;

let subexp2 gsyms stem syms exp = {entry=exp; symbol=(subexp gsyms stem syms exp)};;

let expr_dyadic gsyms stem syms op left right = DYADIC(op, subexp2 gsyms stem syms left, subexp2 gsyms stem syms right);;

let expression gsyms stem syms (tree:token) = match tree with
| TRIPLE (PLUS as op, left, right) -> expr_dyadic gsyms stem syms op left right
| _ -> UNHANDLED tree;;

let statement gsyms stem syms tok var expr = (
let x = subexp gsyms stem syms var in
let r = {entry=var; symbol=x} in
stmts := ASSIGNMENT(r, expr) :: !stmts );;

let inner_chk gsyms stem syms kind subcct inner wireport = let enter2 = enter_a_sym gsyms and innersym = (Hashtbl.find Globals.modprims kind).symbols in begin
if (Hashtbl.mem innersym inner) then let hier = (stem^wireport) and hier2 = (stem^subcct^"."^inner) in 
  begin
  if (TokSet.mem IOPORT (Hashtbl.find innersym inner) == false) then printf "Instance port %s not an ioport\n" inner
  else if (TokSet.mem INPUT (Hashtbl.find innersym inner)) then ( enter2 hier DRIVER; enter2 hier2 RECEIVER )
  else if (TokSet.mem OUTPUT (Hashtbl.find innersym inner)) then ( enter2 hier RECEIVER; enter2 hier2 DRIVER )
  else if (TokSet.mem INOUT (Hashtbl.find innersym inner)) then ( enter2 hier BIDIR; enter2 hier2 BIDIR )
  end
else printf "Instance port %s not found\n" inner;
end

let rec connect gsyms stem syms kind subcct inner tok = match tok with
| ID wireport -> if (Hashtbl.mem syms wireport) then inner_chk gsyms stem syms kind subcct inner wireport else not_found syms wireport
| TRIPLE(BITSEL, ID wireport, INTNUM sel) -> if (Hashtbl.mem syms wireport) then inner_chk gsyms stem syms kind subcct inner wireport else not_found syms wireport
| QUADRUPLE(PARTSEL, ID wireport, INTNUM hi, INTNUM lo) -> if (Hashtbl.mem syms wireport) then inner_chk gsyms stem syms kind subcct inner wireport else not_found syms wireport
| INTNUM lev -> ()
| BINNUM lev -> ()
| TLIST concat -> iter (fun item -> connect gsyms stem syms kind subcct inner item) concat
| _ -> unhandled tok

let vbuf gsyms stem syms (x:token) a =
ignore(find_ident gsyms RECEIVER stem syms x);
ignore(find_ident gsyms DRIVER stem syms a);;

let vbufif gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | BINNUM lev -> () | _ -> unhandled t) inlist;;

let vnot gsyms stem syms (x:token) a =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun w -> ignore(find_ident gsyms DRIVER stem syms w)) [x;a];;

let vand gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | _ -> unhandled t) inlist;;

let vor gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | _ -> unhandled t) inlist;;

let vxor gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | _ -> unhandled t) inlist;;

let vnand gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | _ -> unhandled t) inlist;;

let vnor gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | _ -> unhandled t) inlist;;

let vxnor gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | _ -> unhandled t) inlist;;

let rec semantics gsyms (stem:string) (tree:Globals.modtree) =
   let exp = tree.Globals.tree and syms = tree.Globals.symbols in match exp with
(* These patterns are temporary till we decide on the proper general form *)
DOUBLE
 (ALWAYS,
   DOUBLE
    (DOUBLE (AT, TLIST [DOUBLE (POSEDGE, ID clk)]),
   QUADRUPLE
    (IF, ID rst,
      QUADRUPLE
       (EQUALS, ID var1, EMPTY, INTNUM start),
      QUADRUPLE
       (EQUALS, ID var2, EMPTY,
        TRIPLE
          (PLUS, ID var3, INTNUM inc)))))
-> iter (fun v -> try ignore(Hashtbl.find syms v); with Not_found -> not_found syms v) [clk;rst;var1;var2;var3];
| TRIPLE(ASSIGN, EMPTY, TLIST assignlist)
-> iter (fun a -> match a with TRIPLE (EQUALS, var1, expr) -> statement gsyms stem syms ASSIGN var1 (expression gsyms stem syms expr) | _ -> unhandled a) assignlist
| TRIPLE(EQUALS, TLIST arg1, TLIST arg2) -> iter_ semantics gsyms stem syms arg1; iter_ semantics gsyms stem syms arg2
| TRIPLE(IF, TLIST arg1, TLIST arg2) -> iter_ semantics gsyms stem syms arg1; iter_ semantics gsyms stem syms arg2
| TRIPLE(PLUS, TLIST arg1, TLIST arg2) -> iter_ semantics gsyms stem syms arg1; iter_ semantics gsyms stem syms arg2
| TRIPLE(BUF,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, a) -> vbuf gsyms stem syms x a
      | _ -> unhandled inst) instances
| TRIPLE(NOT,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, a) -> vnot gsyms stem syms x a
      | _ -> unhandled inst) instances
| TRIPLE(AND,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vand gsyms stem syms x inlist
      | _ -> unhandled inst) instances
| TRIPLE(OR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vor gsyms stem syms x inlist
      | _ -> unhandled inst) instances
| TRIPLE(XOR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vxor gsyms stem syms x inlist
      | _ -> unhandled inst) instances
| TRIPLE(NAND,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vand gsyms stem syms x inlist
      | _ -> unhandled inst) instances
| TRIPLE(NOR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vor gsyms stem syms x inlist
      | _ -> unhandled inst) instances
| TRIPLE(XNOR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vxor gsyms stem syms x inlist
      | _ -> unhandled inst) instances
| TRIPLE(BUFIF lev, TLIST [WEAK "weak0"; WEAK "weak1"], TLIST instances) ->
    iter (fun inst -> match inst with
      | DOUBLE (x, TLIST inlist) -> vbufif gsyms stem syms x inlist
      | _ -> unhandled inst) instances
(* Parse primitive instance *)
| TRIPLE(ID prim,ID q, TLIST inlist) ->
    (try
      semantics gsyms (stem^prim^".") (Hashtbl.find Globals.modprims prim); (* scan the inner primitive *)
    with Not_found -> printf "primitive %s not found\n" prim );
    enter_a_sym syms prim PRIMITIVE;
iter (fun t -> match t with ID w -> ignore ( find_ident gsyms DRIVER stem syms t ) | _ -> unhandled t) inlist
(* Parse module instance *)
| TRIPLE(ID kind,EMPTY, TLIST instances) ->
      if (Hashtbl.mem Globals.modprims kind == false) then printf "sub-module %s not found\n" kind;
(*    printf "Scanning sub-module %s\n" kind;  *)
    enter_a_sym syms kind SUBMODULE;
    iter (fun inst -> match inst with
      | TRIPLE (ID subcct, EMPTY, TLIST termlist) -> semantics gsyms (stem^subcct^".") (Hashtbl.find Globals.modprims kind); enter_a_sym syms subcct SUBCCT; iter (fun term -> match term with
          | TRIPLE (DOT, ID inner, tok) -> connect gsyms stem syms kind subcct inner tok
	  | _ -> unhandled term) termlist
      | _ -> unhandled inst) instances
| QUADRUPLE(EQUALS, TLIST arg1, TLIST arg2, TLIST arg3) -> iter_ semantics gsyms stem syms arg1; iter_ semantics gsyms stem syms arg2; iter_ semantics gsyms stem syms arg3
| QUADRUPLE(IF, TLIST arg1, TLIST arg2, TLIST arg3) -> iter_ semantics gsyms stem syms arg1; iter_ semantics gsyms stem syms arg2; iter_ semantics gsyms stem syms arg3
(* Parse wire/reg declarations *)
| QUADRUPLE((WIRE|REG) as kind, arg1, arg2, TLIST arg3) ->
    let width = ref [kind] in begin
    semantics gsyms stem {Globals.tree=arg1; symbols=syms};
    (match arg2 with
      | RANGE(INTNUM hi, INTNUM lo) as rangehilo -> width := rangehilo :: !width
      | TRIPLE(EMPTY,(RANGE(INTNUM hi, INTNUM lo) as rangehilo),EMPTY) -> width := rangehilo :: !width
      | TLIST arg7 ->  List.iter (fun arg -> unhandled arg) arg7
      | EMPTY -> ()
      | TRIPLE(EMPTY,EMPTY,EMPTY) -> ()
      | _ ->  unhandled arg2);
    ( List.iter (fun x -> match x with
      | TRIPLE(id, arg5, arg6) -> enter_sym_attrs gsyms kind stem syms id !width
      | DOUBLE(id, EMPTY) -> enter_sym_attrs gsyms kind stem syms id !width
      | _ -> unhandled x) arg3); end
(* Parse module declarations *)
| QUINTUPLE(MODULE,ID arg1, arg2, TLIST arg3, TLIST arg4) ->
    enter_a_sym syms arg1 MODULE; (* print_endline (stem^arg1); *)
    semantics gsyms stem {Globals.tree=arg2; symbols=syms};
    iter (fun arg -> match arg with ID id -> enter_a_sym syms id IOPORT | _ -> semantics gsyms stem {Globals.tree=arg; symbols=syms}) arg3;
    iter_ semantics gsyms stem syms arg4
(* Parse primitive declarations *)
| QUINTUPLE(PRIMITIVE,ID arg1, EMPTY, TLIST arg3, TLIST arg4) ->
    enter_a_sym syms arg1 PRIMITIVE;
    iter (fun arg -> match arg with ID id -> enter_a_sym syms id IOPORT | _ -> semantics gsyms stem {Globals.tree=arg; symbols=syms}) arg3;
    iter_ semantics gsyms stem syms arg4
(* Parse IO declarations *)
| QUINTUPLE((INPUT|OUTPUT|INOUT) as dir, arg1, arg2, arg3, arg4) ->
    let width = ref [IOPORT;dir] in begin
    semantics gsyms stem {Globals.tree=arg1; symbols=syms};
    semantics gsyms stem {Globals.tree=arg2; symbols=syms};
    (match arg3 with
      | RANGE(INTNUM hi,INTNUM lo) as rangehilo -> width := rangehilo :: !width
      | TLIST arg9 ->  List.iter (fun arg -> unhandled arg) arg9
      | EMPTY -> ()
      | _ -> unhandled arg3);
    ( match arg4 with
      | DOUBLE(id, arg5) -> enter_sym_attrs gsyms dir stem syms id !width
      | TRIPLE(id, TLIST arg5, TLIST arg6) -> enter_sym_attrs gsyms dir stem syms id !width
      | TLIST arg9 ->  List.iter (fun x -> match x with TRIPLE(id, arg5, arg6) -> enter_sym_attrs gsyms dir stem syms id !width | _ -> unhandled x) arg9
      | EMPTY -> ()
      | _ -> unhandled arg4); end
| QUINTUPLE(MODULE,ID arg1, EMPTY, EMPTY, EMPTY) -> enter_a_sym syms arg1 MODULE
| RANGE(arg1, arg2) -> semantics gsyms stem {Globals.tree=arg1; symbols=syms}; semantics gsyms stem {Globals.tree=arg2; symbols=syms}
| ID id -> enter_a_sym syms id EMPTY
| SPECIFY -> ()
| PREPROC txt -> ()
| TABLE -> ()
| EMPTY -> ()
| _ -> unhandled exp;;

(* let moditer k (x:Globals.modtree) = semantics gsyms k x;; *)

let find_glob gsyms s = Setup.show_sym s ( Hashtbl.find gsyms s);;

let find_glob_substr gsyms s = let reg = Str.regexp s in Hashtbl.iter (fun k x -> try Printf.printf "%s %d\n" k (Str.search_forward reg k 0); with Not_found -> ()) gsyms;;

let dotted s = try String.index s '.' > 0 ; with Not_found -> false;;

let erc_chk nam sym =
  begin
	begin
	  if (TokSet.mem WIRE sym) && not (TokSet.mem RECEIVER sym) then Printf.printf "%s is a dangling wire\n" nam
	  else if (dotted nam) && (TokSet.mem INPUT sym) && not (TokSet.mem RECEIVER sym) then  Printf.printf "%s is a dangling input\n" nam
	  else if (dotted nam) && (TokSet.mem OUTPUT sym) && not (TokSet.mem DRIVER sym)  then Printf.printf "%s is a dangling output\n" nam
	  else if (dotted nam) && (TokSet.mem INOUT sym) then Printf.printf "%s is a inout\n" nam
	end
  end
;;

let check_glob gsyms = Hashtbl.iter erc_chk gsyms;;
