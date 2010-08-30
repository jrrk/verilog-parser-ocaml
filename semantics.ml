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
  Hashtbl.add symbols id (TokSet.add attr (TokSet.singleton (ID id)))
  end
;;

let enter_syms symbols id list = let f x = enter_a_sym symbols id x in iter f list;;

let iter_ semantics syms list =
  List.iter (fun x -> semantics ({Globals.tree=x; symbols=syms})) list
;;

let unhand_str = "**unhandled**";;

let unhandled syms arg = enter_a_sym syms unhand_str arg;;

let find_ident syms v = try (Hashtbl.find syms v; true); with Not_found -> printf "variable %s not found\n" v;false ;;

let subexp syms exp = match exp with
| ID id -> if (find_ident syms id) then Hashtbl.find syms id else Hashtbl.find syms unhand_str
| _ -> unhandled syms exp; Hashtbl.find syms unhand_str;;

let subexp2 syms exp = {entry=exp; symbol=(subexp syms exp)};;

let expr_dyadic syms op left right = DYADIC(op, subexp2 syms left, subexp2 syms right);;

let expression syms (tree:token) = match tree with
| TRIPLE (PLUS as op, left, right) -> expr_dyadic syms op left right
| _ -> UNHANDLED tree;;

let statement syms tok var expr = (
let x = subexp syms var in
let r = {entry=var; symbol=x} in
stmts := ASSIGNMENT(r, expr) :: !stmts );;

let rec semantics (tree:Globals.modtree) =
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
-> iter (fun v -> try ignore(Hashtbl.find syms v); with Not_found -> printf "variable %s not found\n" v) [clk;rst;var1;var2;var3];
| TRIPLE(ASSIGN, EMPTY, TLIST assignlist)
-> iter (fun a -> match a with TRIPLE (EQUALS, var1, expr) -> statement syms ASSIGN var1 (expression syms expr) | _ -> unhandled syms a) assignlist
| TRIPLE(EQUALS, TLIST arg1, TLIST arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| TRIPLE(IF, TLIST arg1, TLIST arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| TRIPLE(PLUS, TLIST arg1, TLIST arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| TRIPLE(ID kind,EMPTY, TLIST instances) ->
    (try
      ignore(Hashtbl.find Globals.modprims kind);
    with Not_found -> printf "sub-module %s not found\n" kind );
    enter_a_sym syms kind SUBMODULE;
    iter (fun inst -> match inst with TRIPLE (ID subcct, EMPTY, termlist) -> enter_a_sym syms subcct SUBCCT | _ -> unhandled syms inst) instances
| QUADRUPLE(EQUALS, TLIST arg1, TLIST arg2, TLIST arg3) -> iter_ semantics syms arg1; iter_ semantics syms arg2; iter_ semantics syms arg3
| QUADRUPLE(IF, TLIST arg1, TLIST arg2, TLIST arg3) -> iter_ semantics syms arg1; iter_ semantics syms arg2; iter_ semantics syms arg3
| QUADRUPLE(REG, arg1, arg2, TLIST arg3) ->
    let width = ref [REG] in begin
    semantics {Globals.tree=arg1; symbols=syms};
    (match arg2 with RANGE(INTNUM hi, INTNUM lo) as rangehilo -> width := rangehilo :: !width
      | TLIST arg7 ->  List.iter (fun arg -> unhandled syms arg) arg7
      | EMPTY -> ()
      | _ ->  unhandled syms arg2);
    ( List.iter (fun x -> match x with TRIPLE(ID id, arg5, arg6) -> enter_syms syms id !width | _ -> unhandled syms x) arg3); end
| QUINTUPLE(MODULE,ID arg1, arg2, TLIST arg3, TLIST arg4) ->
    enter_a_sym syms arg1 MODULE;
    semantics {Globals.tree=arg2; symbols=syms};
    iter (fun arg -> match arg with ID id -> enter_a_sym syms id IOPORT | _ -> semantics {Globals.tree=arg; symbols=syms}) arg3;
    iter_ semantics syms arg4
| QUINTUPLE((INPUT|OUTPUT|INOUT) as dir, arg1, arg2, arg3, arg4) ->
    let width = ref [dir] in begin
    semantics {Globals.tree=arg1; symbols=syms};
    semantics {Globals.tree=arg2; symbols=syms};
    (match arg3 with RANGE(INTNUM hi,INTNUM lo) as rangehilo -> width := rangehilo :: !width
      | TLIST arg9 ->  List.iter (fun arg -> unhandled syms arg) arg9
      | EMPTY -> ()
      | _ -> unhandled syms arg3);
    ( match arg4 with DOUBLE(ID id, arg5) ->
      enter_syms syms id !width
      | TRIPLE(ID id, TLIST arg5, TLIST arg6) -> enter_syms syms id !width
      | TLIST arg9 ->  List.iter (fun x -> match x with TRIPLE(ID id, arg5, arg6) -> enter_syms syms id !width | _ -> unhandled syms x) arg9
      | EMPTY -> ()
      | _ -> unhandled syms arg4); end
| RANGE(arg1, arg2) -> semantics {Globals.tree=arg1; symbols=syms}; semantics {Globals.tree=arg2; symbols=syms}
| ID id -> enter_a_sym syms id EMPTY
| EMPTY -> ()
| _ -> unhandled syms exp;;

let moditer k (x:Globals.modtree) = semantics x;;
