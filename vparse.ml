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

open Setup
open Vparser

type dmode = Pundef | PATH;;

let timescale = ref "";;
let delay_mode = ref Pundef;;
let tsymbols = Hashtbl.create 256;;
let (includes:(string*in_channel) Stack.t) = Stack.create();;
let (ifdef_stk:bool Stack.t) = Stack.create();;
let trace_file = open_out "trace_file";;
let celldefine = ref false and portfaults = ref false and suppress_faults = ref false and protect = ref false;;

let _ = List.iter (fun (str,key) -> Hashtbl.add tsymbols str key)
[
("`celldefine", P_CELLDEFINE );
("`define", P_DEFINE );
("`delay_mode_path", P_DELAY_MODE_PATH );
("`disable_portfaults", P_DISABLE_PORTFAULTS );
("`enable_portfaults", P_ENABLE_PORTFAULTS );
("`endcelldefine", P_ENDCELLDEFINE );
("`endprotect", P_ENDPROTECT );
("`else", P_ELSE );
("`endif", P_ENDIF );
("`ifdef", P_IFDEF );
("`include", P_INCLUDE "");
("`nosuppress_faults", P_NOSUPPRESS_FAULTS );
("`protect", P_PROTECT );
("`resetall", P_RESETALL );
("`suppress_faults", P_SUPPRESS_FAULTS );
("`timescale", P_TIMESCALE "" );
];;

let from_special1 macro_raw =
(* first convert any tabs to spaces *)
for i = 0 to (String.length macro_raw)-1 do if macro_raw.[i]=='\t' then macro_raw.[i] <- ' '; done;
let blank1 = String.index macro_raw ' ' in begin
let substr = String.sub macro_raw 0 blank1 in if (Hashtbl.mem tsymbols substr) then
  begin
  let right = String.sub macro_raw (blank1+1) ((String.length macro_raw)-blank1-1) in
  match Hashtbl.find tsymbols substr with
  | PREPROC replace -> replace^" "^right
  | P_INCLUDE _ -> ( try Scanf.sscanf right " \"%s@\"" (fun nam ->
						     Printf.fprintf trace_file "Open %s\n" nam;
						     Stack.push (nam,open_in nam) includes)
						     with End_of_file -> () | Scanf.Scan_failure msg -> ()); ""
  | P_DEFINE -> 	(* check the replacement text is not null, if so define it to blank *)
	let macro = if (String.contains_from macro_raw (blank1+1) ' ') then macro_raw else macro_raw^"  " in
	let blank2 = String.index_from macro (blank1+1) ' ' in
	let name = "`" ^ (String.sub macro (blank1+1) (blank2-blank1-1)) in
	let defn = String.sub macro (blank2+1) (String.length(macro)-blank2-1) in
	let idx = ref 0 in
  	  while (!idx < String.length defn) && (defn.[!idx] == ' ') do idx := !idx+1; done;
          let repl = String.sub (defn) (!idx) (String.length(defn)-(!idx)) in Hashtbl.add tsymbols name (PREPROC repl);
          Printf.fprintf trace_file "Define %s %s\n" name repl;
        ""
  | P_TIMESCALE _    		-> timescale := right;
        Printf.fprintf trace_file "%s\n" macro_raw; ""
  | P_IFDEF -> Stack.push (Hashtbl.mem tsymbols right) ifdef_stk; ""
  | P_ELSE -> Stack.push (not (Stack.pop ifdef_stk)) ifdef_stk; ""
  | P_ENDIF -> ignore(Stack.pop ifdef_stk); ""
  | _ -> macro_raw
  end
else
  ""
end 

let from_special2 macro_raw =
let retval = ref "" in begin
if (Hashtbl.mem tsymbols macro_raw) then
  begin
  match Hashtbl.find tsymbols macro_raw with PREPROC replace -> retval := replace
  | P_RESETALL        			-> begin
    celldefine := false;
    portfaults := false;
    suppress_faults := false;
    protect := false;
    timescale := ""
    end
  | P_DEFINE -> Printf.fprintf trace_file "`define needs an argument (%s)\n" macro_raw;
  | P_CELLDEFINE			-> celldefine := true
  | P_ENDCELLDEFINE        		-> celldefine := false
  | P_ENABLE_PORTFAULTS        		-> portfaults := true
  | P_DISABLE_PORTFAULTS        	-> portfaults := false
  | P_SUPPRESS_FAULTS        		-> suppress_faults := true
  | P_NOSUPPRESS_FAULTS        		-> suppress_faults := false
  | P_PROTECT        			-> protect := true;
  | P_ENDPROTECT        		-> protect := false;
  | P_DELAY_MODE_PATH                   -> delay_mode := PATH
  | P_ELSE -> Stack.push (not (Stack.pop ifdef_stk)) ifdef_stk;
  | P_ENDIF -> ignore(Stack.pop ifdef_stk);
  | _ -> retval := macro_raw
  end
else
  Printf.fprintf trace_file "%s is not `defined\n" macro_raw;
!retval;
end

let rec paste src (dst:string) dstlen = let tick1 = String.index src '`' and looping = ref true in (
      let tend = ref (tick1+1) in while !looping && (!tend < String.length src) do match src.[!tend] with
      | 'A'..'Z' -> tend := !tend+1
      | 'a'..'z' -> tend := !tend+1
      | '0'..'9' -> tend := !tend+1
      | '_' -> tend := !tend+1
      | _ -> looping := false
      done;
      let subst = from_special2 (String.sub src tick1 (!tend-tick1)) in
      let combined = (String.sub src 0 tick1)^subst^(String.sub src (!tend) ((String.length src)-(!tend)))^"\n" in
      let totlen = String.length combined in
      Printf.fprintf trace_file "Source %s subst=%s combined=%s len=%d\n" src subst combined totlen;
      if (String.contains combined '`')&&(String.index combined '`'>tick1) then paste combined dst dstlen else
      (String.blit combined 0 dst 0 totlen;
      totlen))

let from_blit src dst dstlen =
      let looping = ref true and preproc = ref false in
              let tstart = ref 0 in while !looping && (!tstart < String.length src) do match src.[!tstart] with
              | ' ' -> tstart := !tstart+1
              | '\t' -> tstart := !tstart+1
              | '`' -> preproc := true; looping := false
              | _ -> looping := false
              done;
      preproc := !preproc && ((String.contains_from src !tstart ' ')||(String.contains_from src !tstart '\t'));
      Printf.fprintf trace_file "Source %s preproc=%s\n" src (if !preproc then "true" else "false");
      if (!preproc) then begin
        let subst = from_special1 (String.sub src !tstart ((String.length src)- !tstart)) in
        let len = String.length subst in
	String.blit subst 0 dst 0 len;
	dst.[len] <- '\n';
	len+1 end
      else if (String.contains src '`') then paste src dst dstlen
      else (
      String.blit src 0 dst 0 dstlen;
      dst.[dstlen] <- '\n';
      dstlen+1)

let from_func dst cnt =
    try let retval = ref 0 and looping = ref true in while !looping do
      let pos = pos_in (snd(Stack.top includes)) in
      let src = input_line (snd(Stack.top includes)) in
      retval := from_blit src dst (min (cnt-2) (String.length src));
      looping := Stack.top ifdef_stk == false;
      Printf.fprintf trace_file "If=%s Offset %d %s\n"
          (if !looping then "false" else "true")
           pos (String.sub dst 0 !retval);
      done;
      !retval
  with End_of_file ->
    Printf.fprintf trace_file "Close %s\n" (fst (Stack.top includes));
    close_in_noerr (snd(Stack.pop includes));
    flush trace_file;
    dst.[0] <- '\n';
    1
;;

let push str =
  Stack.push (str, open_in str) includes;
  Printf.fprintf trace_file "Open %s\n" str;;

let parse () = begin
  Stack.push true ifdef_stk; (* toplevel ifdef default *)
  try
    let lexbuf = Lexing.from_function from_func in
    let looping = ref true in while !looping do
      let rslt = Grammar.start Vlexer.token lexbuf in match rslt with
      | ENDOFFILE -> looping := false
      | _ -> Semantics.unhandled trace_file 171 rslt
    done
  with Stack.Empty -> ()
    | Parsing.Parse_error
    | Grammar.Error ->
    begin
    psuccess := false;
    Printf.fprintf stderr "Parse Error in %s\n" (fst(Stack.top includes));
    for i = 1 to hsiz do let idx = (hsiz-i+(!histcnt))mod hsiz in let item = !(history.(idx)) in
        Printf.fprintf stderr "Backtrace %d : %s (%d-%d)\n"  i (str_token (item.tok)) item.strt item.stop;
    done;
    exit 1;
    end;
  end
