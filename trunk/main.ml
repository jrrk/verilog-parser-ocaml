(******************************************************************************
*
*    DESCRIPTION: Verilog parser main program
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

(* let _ = Printexc.print Vparse.parse Sys.argv.( Array.length Sys.argv - 1 );; -- Pass the last command line module *)

(* let m k x = Printf.printf "%s\n" k in Hashtbl.iter m Globals.modprims;;  -- Print all modules *)

(* Hashtbl.find Globals.modprims "test";; -- Find module "test" (displays result) *)

let dump_text out_chan m = Dump.dump out_chan (Hashtbl.find Globals.modprims m).Globals.tree 0;; (* dump module as text*)

(* Hashtbl.iter (fun k x -> Printf.printf "%s\n" k) Globals.modprims;; *)

(* List.iter (fun x -> Dump.dump (x, 0)) arg;; *)

(* Hashtbl.iter (fun k x -> Printf.printf "%s\n" k) (Hashtbl.find Globals.modprims "test").symbols;; -- dump symbol names *)

let my_syms m = Hashtbl.iter Setup.show_sym (Hashtbl.find Globals.modprims m).Globals.symbols;;

let dump_sym m s = Setup.TokSet.iter Setup.show_token ( Hashtbl.find (Hashtbl.find Globals.modprims m).Globals.symbols s).Setup.symattr;;

let dump_gsyms gsyms = Hashtbl.iter Setup.show_sym gsyms;;

let dump_gsym gsyms s = Setup.TokSet.iter Setup.show_token ( Hashtbl.find gsyms s).Setup.symattr;;

let vparser gsyms args = begin
  Setup.psuccess := true;
  for i = 1 to ( Array.length args - 2 ) do
    Printexc.print Vparse.parse args.( i )
  done;
  if (!Setup.psuccess == false) then
    Printf.printf "Not continuing due to parse errors\n"
  else if ( Array.length args > 2 ) then
    begin
    if (Hashtbl.mem Globals.modprims (args.( Array.length args - 1 ))) then
      let out_chan = open_out (args.( Array.length args - 1 ) ^ ".report") in
	begin

	Semantics.semantics out_chan gsyms "" (Hashtbl.find Globals.modprims (args.( Array.length args - 1 )));
	Semantics.check_glob out_chan gsyms;
	close_out out_chan
	end
    else Printf.printf "Toplevel %s is not found\n" args.( Array.length args - 1 );
    end
  else
    Printf.printf "Usage %s verilog_files TOPLEVEL\n" args.(0);
  end

exception MyException of string * int (* exceptions can carry a value *);;

let _ = vparser (Hashtbl.create 256) Sys.argv
(*  try
    Printexc.record_backtrace true; vparser (Hashtbl.create 256) Sys.argv;
  with
  | MyException (s, i) -> 
      Printf.printf "MyException: %s, %d\n" s i
  | e ->  (* catch all exceptions *)
     Printf.eprintf "Unexpected exception : %s" (Printexc.to_string e);
     (*If using Ocaml >= 3.11, it is possible to also print a backtrace: *)
     Printexc.print_backtrace stderr;
*)
       (* Needs to beforehand enable backtrace recording with
           Printexc.record_backtrace true
         or by setting the environment variable OCAMLRUNPARAM="b1"*)
;;