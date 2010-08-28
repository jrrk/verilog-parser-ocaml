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

let unhandled syms arg = enter_a_sym syms "**unhandled**" arg;;

let rec semantics (tree:Globals.modtree) =
   let exp = tree.Globals.tree and syms = tree.Globals.symbols in match exp with
(* These patterns are temporary till we decide on the proper general form *)
DOUBLE
 (ALWAYS,
  [DOUBLE
    (AT, [DOUBLE (POSEDGE, [ID clk])]);
   QUADRUPLE
    (IF, [ID rst],
     [QUADRUPLE
       (EQUALS, [ID var1], [], [INTNUM start])],
     [QUADRUPLE
       (EQUALS, [ID var2], [],
        [TRIPLE
          (PLUS, [ID var3], [INTNUM inc])])])])
-> iter (fun v -> try ignore(Hashtbl.find syms v); with Not_found -> printf "variable %s not found\n" v) [clk;rst;var1;var2;var3];
| TRIPLE
 (ASSIGN, [],
  [TRIPLE (EQUALS, [ID var1], [TRIPLE (PLUS, [ID var2], [ID var3])])])
-> iter (fun v -> try ignore(Hashtbl.find syms v); with Not_found -> printf "variable %s not found\n" v) [var1;var2;var3];
| TRIPLE(EQUALS,arg1,arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| TRIPLE(IF,arg1,arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| TRIPLE(PLUS,arg1,arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| TRIPLE(ID kind,[],instances) ->
    (try
      ignore(Hashtbl.find Globals.modprims kind);
    with Not_found -> printf "sub-module %s not found\n" kind );
    enter_a_sym syms kind SUBMODULE;
    iter (fun inst -> match inst with TRIPLE (ID subcct, [], termlist) -> enter_a_sym syms subcct SUBCCT | _ -> unhandled syms inst) instances
| QUADRUPLE(EQUALS,arg1,arg2,arg3) -> iter_ semantics syms arg1; iter_ semantics syms arg2; iter_ semantics syms arg3
| QUADRUPLE(IF,arg1,arg2,arg3) -> iter_ semantics syms arg1; iter_ semantics syms arg2; iter_ semantics syms arg3
| QUADRUPLE(REG,arg1,arg2,arg3) ->
    let width = ref [REG] in begin
    iter_ semantics syms arg1;
    (match arg2 with [RANGE([INTNUM hi],[INTNUM lo]) as rangehilo] -> width := rangehilo :: !width
      | _ ->  List.iter (fun arg -> unhandled syms arg) arg2);
    ( List.iter (fun x -> match x with TRIPLE(ID id,arg5,arg6) -> enter_syms syms id !width | _ -> unhandled syms x) arg3); end
| QUINTUPLE(MODULE,[ID arg1],arg2,arg3,arg4) ->
    enter_a_sym syms arg1 MODULE;
    iter_ semantics syms arg2;
    iter (fun arg -> match arg with ID id -> enter_a_sym syms id IOPORT | _ -> semantics {Globals.tree=arg; symbols=syms}) arg3;
    iter_ semantics syms arg4
| QUINTUPLE((INPUT|OUTPUT|INOUT) as dir,arg1,arg2,arg3,arg4) ->
    let width = ref [dir] in begin
    iter_ semantics syms arg1;
    iter_ semantics syms arg2;
    (match arg3 with [RANGE([INTNUM hi],[INTNUM lo]) as rangehilo] -> width := rangehilo :: !width
      | _ ->  List.iter (fun arg -> unhandled syms arg) arg3);
    ( match arg4 with [DOUBLE(ID id,arg5)] ->
      enter_syms syms id !width
      | [TRIPLE(ID id,arg5,arg6)] -> enter_syms syms id !width
      | _ ->  List.iter (fun x -> match x with TRIPLE(ID id,arg5,arg6) -> enter_syms syms id !width | _ -> unhandled syms x) arg4); end
| RANGE(arg1,arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| ID id -> enter_a_sym syms id EMPTY
| _ -> unhandled syms exp;;

let moditer k (x:Globals.modtree) = semantics x;;
