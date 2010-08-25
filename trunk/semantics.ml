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

let enter_sym id attr = 
if Hashtbl.mem symbols id then begin
  printf "Update %s: %s\n" id (Ord.getstr attr);
  let newset = (Hashtbl.find symbols id) in
  Hashtbl.replace symbols id (TokSet.add attr newset); end
else begin
  printf "Enter %s: %s\n" id (Ord.getstr attr);
  Hashtbl.add symbols id (TokSet.singleton (ID id))
  end
;;

let rec semantics exp =
   match exp with
| DOUBLE(tok,arg) -> semantics (tok) ; iter semantics arg
| TRIPLE(EQUALS,arg1,arg2) -> iter semantics arg1; iter semantics arg2
| TRIPLE(IF,arg1,arg2) -> iter semantics arg1; iter semantics arg2
| TRIPLE(PLUS,arg1,arg2) -> iter semantics arg1; iter semantics arg2
| TRIPLE(tok,arg1,arg2) -> semantics (tok) ; iter semantics arg1; iter semantics arg2
| QUADRUPLE(EQUALS,arg1,arg2,arg3) -> iter semantics arg1; iter semantics arg2; iter semantics arg3
| QUADRUPLE(IF,arg1,arg2,arg3) -> iter semantics arg1; iter semantics arg2; iter semantics arg3
| QUADRUPLE(tok,arg1,arg2,arg3) -> semantics (tok) ; iter semantics arg1; iter semantics arg2; iter semantics arg3
| QUINTUPLE(MODULE,[ID arg1],arg2,arg3,arg4) ->
    enter_sym arg1 MODULE;
    iter semantics arg2;
    iter (fun arg -> match arg with ID id -> enter_sym id IOPORT | _ -> semantics arg) arg3;
    iter semantics arg4
| QUINTUPLE((INPUT|OUTPUT|INOUT) as dir,arg1,arg2,arg3,arg4) ->
    iter semantics arg1;
    iter semantics arg2;
    (match arg3 with [RANGE([INTNUM hi],[INTNUM lo])] -> range hi lo
      | _ ->  List.iter (fun x -> printf "unmatched arg3 %s" (Ord.getstr x)) arg3);
    ( match arg4 with [DOUBLE(ID id,arg5)] ->
      enter_sym id dir
      | [TRIPLE(ID id,arg5,arg6)] -> enter_sym id dir
      | _ ->  List.iter (fun x -> match x with TRIPLE(ID id,arg5,arg6) -> enter_sym id dir | _ -> printf "unmatched arg4 %s\n" (Ord.getstr x)) arg4);
| QUINTUPLE(tok,arg1,arg2,arg3,arg4) -> semantics (tok) ; iter semantics arg1; iter semantics arg2; iter semantics arg3; iter semantics arg4
| SEXTUPLE(tok,arg1,arg2,arg3,arg4,arg5) -> semantics (tok) ; iter semantics arg1; iter semantics arg2; iter semantics arg3; iter semantics arg4; iter semantics(arg5)
| SEPTUPLE(tok,arg1,arg2,arg3,arg4,arg5,arg6) -> semantics (tok) ; iter semantics arg1; iter semantics arg2; iter semantics arg3; iter semantics arg4; iter semantics(arg5); iter semantics(arg6)
| RANGE(arg1,arg2) -> iter semantics arg1; iter semantics arg2
| ID id -> enter_sym id EMPTY
| _ -> printf "Unhandled %s\n" (Ord.getstr exp)

let moditer k x = semantics x;;
