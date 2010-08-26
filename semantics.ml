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

let enter_sym symbols id attr = 
if Hashtbl.mem symbols id then begin
  printf "Update %s: %s\n" id (Ord.getstr attr);
  let newset = (Hashtbl.find symbols id) in
  Hashtbl.replace symbols id (TokSet.add attr newset); end
else begin
  printf "Enter %s: %s\n" id (Ord.getstr attr);
  Hashtbl.add symbols id (TokSet.singleton (ID id))
  end
;;

let iter_ semantics syms list =
  List.iter (fun x -> semantics ({Globals.tree=x; symbols=syms})) list
;;

let rec semantics (tree:Globals.modtree) =
   let exp = tree.Globals.tree and syms = tree.Globals.symbols in match exp with
| DOUBLE(tok,arg) -> printf "%s " (Ord.getstr(tok)) ; iter_ semantics syms arg
| TRIPLE(EQUALS,arg1,arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| TRIPLE(IF,arg1,arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| TRIPLE(PLUS,arg1,arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| TRIPLE(tok,arg1,arg2) -> printf "%s " (Ord.getstr(tok)) ; iter_ semantics syms arg1; iter_ semantics syms arg2
| QUADRUPLE(EQUALS,arg1,arg2,arg3) -> iter_ semantics syms arg1; iter_ semantics syms arg2; iter_ semantics syms arg3
| QUADRUPLE(IF,arg1,arg2,arg3) -> iter_ semantics syms arg1; iter_ semantics syms arg2; iter_ semantics syms arg3
| QUADRUPLE(tok,arg1,arg2,arg3) -> printf "%s " (Ord.getstr(tok)) ; iter_ semantics syms arg1; iter_ semantics syms arg2; iter_ semantics syms arg3
| QUINTUPLE(MODULE,[ID arg1],arg2,arg3,arg4) ->
    enter_sym syms arg1 MODULE;
    iter_ semantics syms arg2;
    iter (fun arg -> match arg with ID id -> enter_sym syms id IOPORT | _ -> printf "Error ") arg3;
    iter_ semantics syms arg4
| QUINTUPLE((INPUT|OUTPUT|INOUT) as dir,arg1,arg2,arg3,arg4) ->
    iter_ semantics syms arg1;
    iter_ semantics syms arg2;
    (match arg3 with [RANGE([INTNUM hi],[INTNUM lo])] -> range hi lo
      | _ ->  List.iter (fun x -> printf "unmatched arg3 %s" (Ord.getstr x)) arg3);
    ( match arg4 with [DOUBLE(ID id,arg5)] ->
      enter_sym syms id dir
      | [TRIPLE(ID id,arg5,arg6)] -> enter_sym syms id dir
      | _ ->  List.iter (fun x -> match x with TRIPLE(ID id,arg5,arg6) -> enter_sym syms id dir | _ -> printf "unmatched arg4 %s\n" (Ord.getstr x)) arg4);
| QUINTUPLE(tok,arg1,arg2,arg3,arg4) -> printf "%s " (Ord.getstr(tok)) ; iter_ semantics syms arg1; iter_ semantics syms arg2; iter_ semantics syms arg3; iter_ semantics syms arg4
| SEXTUPLE(tok,arg1,arg2,arg3,arg4,arg5) -> printf "%s " (Ord.getstr(tok)) ; iter_ semantics syms arg1; iter_ semantics syms arg2; iter_ semantics syms arg3; iter_ semantics syms arg4; iter_ semantics syms(arg5)
| SEPTUPLE(tok,arg1,arg2,arg3,arg4,arg5,arg6) -> printf "%s " (Ord.getstr(tok)) ; iter_ semantics syms arg1; iter_ semantics syms arg2; iter_ semantics syms arg3; iter_ semantics syms arg4; iter_ semantics syms(arg5); iter_ semantics syms(arg6)
| RANGE(arg1,arg2) -> iter_ semantics syms arg1; iter_ semantics syms arg2
| ID id -> enter_sym syms id EMPTY
| _ -> printf "Unhandled %s\n" (Ord.getstr exp);;

let moditer k (x:Globals.modtree) = semantics x;;
