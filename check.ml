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
open Const
open Printf
open Vparser
open Globals
open Setup

let dotted s = try String.index s '.' > 0 ; with Not_found -> false;;

let erc_chk_sig out_chan (syma:tset) siga =
  begin
	begin
	  if ((TokSet.mem INPUT syma) && (TokSet.mem SENSUSED siga)) && not (TokSet.mem DRIVER siga) then
	    "is an input mentioned in sensitivity list but not referenced"
	  else if (TokSet.mem INPUT syma) && not ((TokSet.mem DRIVER siga) || (TokSet.mem SPECIAL syma)) then
	    "is an unloaded input"
	  else if (TokSet.mem OUTPUT syma) && not ((TokSet.mem RECEIVER siga) || (TokSet.mem SPECIAL syma)) then
	    "is an undriven output"
	  else if (TokSet.mem INOUT syma) then
	    ": is an inout"
	  else if (TokSet.mem WIRE syma) && (TokSet.mem DRIVER siga) && not ((TokSet.mem RECEIVER siga) || (TokSet.mem SPECIFY syma)) then
	    "is a wire which drives but is not driven"
	  else if (TokSet.mem WIRE syma) && not ((TokSet.mem RECEIVER siga) || (TokSet.mem SPECIFY syma)) then
	    "is an unused wire"
          else ""
	end
  end
;;

let erc_chk out_chan key (gsyms:sentries) id s = let h = ref false
and erch h = if not !h then Printf.fprintf (fst out_chan) "In %s:\n" key; h := true in match s.sigattr with
| Sigarray attrs -> (
match s.width with
| RANGE range -> let (hi,lo) = iwidth out_chan (Shash {nxt=EndShash; syms=gsyms}) s.width in
  if not ((TokSet.mem IMPLICIT s.symattr)||(TokSet.mem MEMORY s.symattr)) then
  ( let msg0 = ref "" and i0 = ref hi and i1 = ref hi in try for i = hi downto lo do
    let msg = erc_chk_sig out_chan s.symattr attrs.(i) in
(*    if (String.length msg > 0) then
        Printf.fprintf (fst out_chan) "DBG: %s %s\n" (id^"["^(string_of_int i)^"]") msg;  *)
    if (msg <> !msg0) then (
      if (String.length !msg0 > 0) then
	 (erch h; Printf.fprintf (fst out_chan) "%s %s\n" (id^"["^(string_of_int !i0)^":"^(string_of_int !i1)^"]") !msg0;);
      i0 := i;
      i1 := i;
      msg0 := msg; )
    else if (i == lo) then (
      if (String.length msg > 0) then
	 (erch h; Printf.fprintf (fst out_chan) "%s %s\n" (id^"["^(string_of_int !i0)^":"^(string_of_int i)^"]") !msg0 ))
    else
      i1 := i;
    done
  with Invalid_argument("index out of bounds") -> (erch h; Printf.fprintf (fst out_chan) "Trying to access %s with index [%d:%d]\n" id hi lo))
| SCALAR | EMPTY | UNKNOWN->
    let msg = erc_chk_sig out_chan s.symattr attrs.(0) in
    if (String.length msg > 0) then (erch h; Printf.fprintf (fst out_chan) "%s %s\n" id msg)
| _ -> unhandled out_chan 791 s.width)
| Sigparam x ->
  if not (TokSet.mem PARAMUSED s.symattr) then (erch h; Printf.fprintf (fst out_chan) "Parameter %s is not used\n" id)
| Sigtask x ->
  if not (TokSet.mem TASKUSED s.symattr) then (erch h; Printf.fprintf (fst out_chan) "Task %s is not used\n" id)
| Sigfunc x ->
  if not (TokSet.mem FUNCUSED s.symattr) then (erch h; Printf.fprintf (fst out_chan) "Function %s is not used\n" id)
| _ -> unhandled out_chan 804 s.width
;;
