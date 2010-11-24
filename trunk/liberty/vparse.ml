(******************************************************************************
*
*    DESCRIPTION: Verilog parser program
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

exception Error

open Setup
open Globals
open Liberty_parser

type dmode = Pundef | PATH;;

let timescale = ref "";;
let delay_mode = ref Pundef;;
let (includes:(string*in_channel) Stack.t) = Stack.create();;
let (ifdef_stk:bool Stack.t) = Stack.create();;
let celldefine = ref false and portfaults = ref false and suppress_faults = ref false and protect = ref false;;

let _ = List.iter (fun (str,key) -> Hashtbl.add tsymbols str key)
[
("`include", INCLUDE);
];;

let myflush strm =  match !strm with Open chan -> flush (fst chan) | Closed -> ();;

let from_special1 out_chan macro_raw =
(* first convert any tabs to spaces *)
for i = 0 to (String.length macro_raw)-1 do if macro_raw.[i]=='\t' then macro_raw.[i] <- ' '; done;
let blank1 = String.index macro_raw ' ' in begin
let substr = String.sub macro_raw 0 blank1 in if (Hashtbl.mem tsymbols substr) then
  begin
  let right = String.sub macro_raw (blank1+1) ((String.length macro_raw)-blank1-1) in
  match Hashtbl.find tsymbols substr with
  | INCLUDE -> ( try Scanf.sscanf right " \"%s@\"" (fun nam ->
						     Printf.fprintf (fst out_chan) "Open %s\n" nam;
						     Stack.push (nam,open_in nam) includes)
						     with End_of_file -> () | Scanf.Scan_failure msg -> ()); ""
  | _ -> substr
  end
else
  ""
end 

let from_special2 out_chan macro_raw =
let retval = ref "" in begin
  begin
  (* Printf.fprintf trace_file "%s is not `defined\n" macro_raw; *)
  end;
!retval;
end

let rec paste out_chan src (dst:string) dstlen = let tick1 = String.index src '`' and looping = ref true in (
      let tend = ref (tick1+1) in while !looping && (!tend < String.length src) do match src.[!tend] with
      | 'A'..'Z' -> tend := !tend+1
      | 'a'..'z' -> tend := !tend+1
      | '0'..'9' -> tend := !tend+1
      | '_' -> tend := !tend+1
      | _ -> looping := false
      done;
      let subst = from_special2 out_chan (String.sub src tick1 (!tend-tick1)) in
      let combined = (String.sub src 0 tick1)^subst^(String.sub src (!tend) ((String.length src)-(!tend)))^"\n" in
      let totlen = String.length combined in
      (* Printf.fprintf trace_file "Source %s subst=%s combined=%s len=%d\n" src subst combined totlen; *)
      if (String.contains combined '`')&&(String.index combined '`'>tick1) then paste out_chan combined dst dstlen else
      (String.blit combined 0 dst 0 totlen;
      totlen))

let from_blit out_chan src dst dstlen =
      let looping = ref true and preproc = ref false in
              let tstart = ref 0 in while !looping && (!tstart < String.length src) do match src.[!tstart] with
              | ' ' -> tstart := !tstart+1
              | '\t' -> tstart := !tstart+1
              | '`' -> preproc := true; looping := false
              | _ -> looping := false
              done;
      preproc := !preproc && ((String.contains_from src !tstart ' ')||(String.contains_from src !tstart '\t'));
      (* Printf.fprintf trace_file "Source %s preproc=%s\n" src (yesno !preproc); *)
      if (!preproc) then begin
        let subst = from_special1 out_chan (String.sub src !tstart ((String.length src)- !tstart)) in
        let len = String.length subst in
	String.blit subst 0 dst 0 len;
	dst.[len] <- '\n';
	len+1 end
      else if (String.contains src '`') then paste out_chan src dst dstlen
      else (
      String.blit src 0 dst 0 dstlen;
      dst.[dstlen] <- '\n';
      dstlen+1)

let my_input_line chan cnt = 
let idx = ref 0 and looping = ref true and str = String.create cnt in
while (!looping) && (!idx < cnt-2) do
str.[!idx] <- input_char chan;
if str.[!idx] == '\n' then looping := false;
if (!idx > cnt/2) && ((str.[!idx] == ' ') || (str.[!idx] == '\t')) then looping := false;
idx := !idx + 1;
done;
String.sub str 0 !idx

let from_func out_chan dst cnt =
    try let retval = ref 0 and looping = ref true in while !looping do
      let src = my_input_line (snd(Stack.top includes)) cnt in
      retval := from_blit out_chan src dst (String.length src);
      looping := Stack.top ifdef_stk == false;
      ( match !Globals.trace_file with Open chan -> 
          let b = (if !looping then "false" else "true") and
          p = pos_in (snd(Stack.top includes)) and
          s = (String.sub dst 0 !retval) in Printf.fprintf (fst chan) "If=%s Offset %d %s" b p s | Closed -> ());
      done;
      !retval
  with End_of_file ->
    Printf.fprintf (fst out_chan) "Close %s\n" (fst (Stack.top includes));
    close_in_noerr (snd(Stack.pop includes));
    Printf.fprintf (fst out_chan) "Open %s\n" (fst (Stack.top includes));
    myflush Globals.trace_file;
    dst.[0] <- '\n';
    1
;;

let parse str = begin
  (   let trc_file = Globals.mygetenv "VCHK_TRACE_FILE" in
    if (!Globals.trace_file == Closed) && (trc_file <> "") then
      let fd = open_out trc_file in
          Globals.trace_file := Open (fd,Format.formatter_of_out_channel fd); );
  ( if (!Globals.logfile == Closed) then
      let fd = open_out Globals.tmpnam in
          Globals.logfile := Open (fd,Format.formatter_of_out_channel fd); );
  match !Globals.logfile with Open out_chan -> begin
  Printf.fprintf (fst out_chan) "Open %s\n" str;
  Stack.push (str, open_in str) includes;
  Stack.push true ifdef_stk; (* toplevel ifdef default *)
  try
    let lexbuf = Lexing.from_function (fun dst cnt -> from_func out_chan dst cnt) in
    let looping = ref true in while !looping do
      let rslt = Liberty_parser.file Vlexer.token lexbuf in match rslt with
      | TRIPLE(GROUP,TRIPLE(HEAD, ID LIBERTY_GROUPENUM_library, TLIST [ID (STRING key)]), TLIST lst) -> Hashtbl.add libraries key lst
      | ENDOFFILE -> looping := false
      | _ -> Globals.unhandled (stdout,Format.std_formatter) 191 rslt
    done
  with Stack.Empty -> ()
    | Parsing.Parse_error
    | Error ->
    begin
    psuccess := false;
    Printf.fprintf stdout "Parse Error in %s\n" (fst(Stack.top includes));
    Printf.fprintf (fst out_chan) "Parse Error in %s\n" (fst(Stack.top includes));
    for i = 1 to hsiz do let idx = (hsiz-i+(!histcnt))mod hsiz in let item = !(history.(idx)) in
        Printf.fprintf (fst out_chan) "Backtrace %d : %s (%d-%d)\n"  i (str_token (item.tok)) item.strt item.stop;
    done;
    end;
  end
| Closed -> failwith (Printf.sprintf "Failed to open logfile %s" Globals.tmpnam)
end
;;
