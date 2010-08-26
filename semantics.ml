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

let range hi lo = printf "[%d:%d] " (Nativeint.to_int hi) (Nativeint.to_int lo);;

let enter_a_sym symbols id attr = 
if Hashtbl.mem symbols id then begin
(*  printf "Update %s: %s\n" id (Ord.getstr attr); *)
  let newset = (Hashtbl.find symbols id) in
  Hashtbl.replace symbols id (TokSet.add attr newset); end
else begin
(*  printf "Enter %s: %s\n" id (Ord.getstr attr); *)
  Hashtbl.add symbols id (TokSet.singleton (ID id))
  end
;;

let enter_syms symbols id list = let f x = enter_a_sym symbols id x in iter f list;;

let iter_ semantics syms list =
  List.iter (fun x -> semantics ({Globals.tree=x; symbols=syms})) list
;;

let unhandled arg = ignore(Ord.getstr(arg));;

let rec semantics (tree:Globals.modtree) =
   let exp = tree.Globals.tree and syms = tree.Globals.symbols in match exp with
| TRIPLE(EQUALS,arg1,arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| TRIPLE(IF,arg1,arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| TRIPLE(PLUS,arg1,arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| QUADRUPLE(EQUALS,arg1,arg2,arg3) -> iter_ semantics syms arg1; iter_ semantics syms arg2; iter_ semantics syms arg3
| QUADRUPLE(IF,arg1,arg2,arg3) -> iter_ semantics syms arg1; iter_ semantics syms arg2; iter_ semantics syms arg3
| QUINTUPLE(MODULE,[ID arg1],arg2,arg3,arg4) ->
    enter_a_sym syms arg1 MODULE;
    iter_ semantics syms arg2;
    iter (fun arg -> match arg with ID id -> enter_a_sym syms id IOPORT | _ -> unhandled arg) arg3;
    iter_ semantics syms arg4
| QUINTUPLE((INPUT|OUTPUT|INOUT|REG) as dir,arg1,arg2,arg3,arg4) ->
    let width = ref [dir] in begin
    iter_ semantics syms arg1;
    iter_ semantics syms arg2;
    (match arg3 with [RANGE([INTNUM hi],[INTNUM lo]) as rangehilo] -> width := rangehilo :: !width
      | _ ->  List.iter unhandled arg3);
    ( match arg4 with [DOUBLE(ID id,arg5)] ->
      enter_syms syms id !width
      | [TRIPLE(ID id,arg5,arg6)] -> enter_syms syms id !width
      | _ ->  List.iter (fun x -> match x with TRIPLE(ID id,arg5,arg6) -> enter_syms syms id !width | _ -> unhandled x) arg4); end
| RANGE(arg1,arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| ID id -> enter_a_sym syms id EMPTY
| _ -> unhandled(exp);;

let moditer k (x:Globals.modtree) = semantics x;;
