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

let erc_chk_sig out_chan (syma:tset) siga id =
  begin
	begin
	  if ((TokSet.mem INPUT syma) && (TokSet.mem SENSUSED siga)) && not (TokSet.mem DRIVER siga) then
	    "Input mentioned in sensitivity list but not referenced"
	  else if (TokSet.mem INPUT syma) && not ((TokSet.mem DRIVER siga) || (TokSet.mem SPECIAL syma)) then
	    "Unloaded input"
	  else if (TokSet.mem OUTPUT syma) && not ((TokSet.mem RECEIVER siga) || (TokSet.mem SPECIAL syma)) then
	    "Undriven output"
	  else if (TokSet.mem INOUT syma) then
	    "Note: Inout"
	  else if (TokSet.mem WIRE syma) && (TokSet.mem DRIVER siga) && not ((TokSet.mem RECEIVER siga) || (TokSet.mem SPECIFY syma)) then
	    "Undriven but driving wire"
	  else let skip="SYNOPSYS_UNCONNECTED__" in if ((String.length id < String.length skip) || (skip <> String.sub id 0 (String.length skip))) && (TokSet.mem WIRE syma) && not ((TokSet.mem RECEIVER siga) || (TokSet.mem SPECIFY syma)) then
	    "Unused wire"
          else ""
	end
  end

let cache_msgs msg_cache msg id = if (String.length msg > 0) then begin
if (Hashtbl.mem msg_cache msg) then begin
 let entry = Hashtbl.find msg_cache msg in
  Hashtbl.replace msg_cache msg (id :: entry)
 end
else
 Hashtbl.add msg_cache msg [id]
end;;

let erc_chk out_chan msg_cache erch (gsyms:sentries) id s = match s.sigattr with
| Sigarray attrs -> (
match s.width with
| RANGE range -> let (left, right, inc) = iwidth out_chan (Shash {nxt=EndShash; syms=gsyms}) s.width in
  if not ((TokSet.mem IMPLICIT s.symattr)||(TokSet.mem MEMORY s.symattr)) then
  ( let msg0 = ref "" and i0 = ref left and i1 = ref left and i = ref left in try while (if inc > 0 then !i <= right else !i >= right) do
    let msg = erc_chk_sig out_chan s.symattr attrs.(!i) id in
(*    if (String.length msg > 0) then
        Printf.fprintf (fst out_chan) "DBG: %s %s\n" (id^"["^(string_of_int i)^"]") msg;  *)
    if (msg <> !msg0) then (
      cache_msgs msg_cache !msg0 (id^"["^(string_of_int !i0)^":"^(string_of_int !i1)^"]");
      i0 := !i;
      i1 := !i;
      msg0 := msg; )
    else if (!i == right) then (
      if (String.length msg > 0) then
      cache_msgs msg_cache !msg0 (id^"["^(string_of_int !i0)^":"^(string_of_int !i)^"]"))
    else
      i1 := !i;
    i := !i + inc
    done
  with Invalid_argument("index out of bounds") -> (erch(); Printf.fprintf (fst out_chan) "Trying to access %s with index [%d:%d]\n" id left right))
| SCALAR | EMPTY | UNKNOWN->
    let msg = erc_chk_sig out_chan s.symattr attrs.(0) id in
    cache_msgs msg_cache msg id
| _ -> unhandled out_chan 791 s.width)
| Sigparam x ->
  if not (TokSet.mem PARAMUSED s.symattr) then cache_msgs msg_cache "Unused Parameter" id
| Sigtask x ->
  if not (TokSet.mem TASKUSED s.symattr) then cache_msgs msg_cache "Unused Task" id
| Sigfunc x ->
  if not (TokSet.mem FUNCUSED s.symattr) then cache_msgs msg_cache "Unused Function" id
| Signamed x -> ()
| Sigundef -> ()
;;
