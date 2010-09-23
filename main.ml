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

(* let _ = Printexc.print Parse.parse Sys.argv.( Array.length Sys.argv - 1 );; -- Pass the last command line module *)

(* let m k x = Printf.printf "%s\n" k in Hashtbl.iter m Globals.modprims;;  -- Print all modules *)

(* Hashtbl.find Globals.modprims "test";; -- Find module "test" (displays result) *)

(* Dump.dump ((Hashtbl.find Globals.modprims "test").tree, 0);; -- dump module as text*)

(* Hashtbl.iter (fun k x -> Printf.printf "%s\n" k) Globals.modprims;; *)

(* List.iter (fun x -> Dump.dump (x, 0)) arg;; *)

(* Hashtbl.iter (fun k x -> Printf.printf "%s\n" k) (Hashtbl.find Globals.modprims "test").symbols;; -- dump symbol names *)

let my_syms m = Hashtbl.iter Setup.show_sym (Hashtbl.find Globals.modprims m).Globals.symbols;;

let dump_sym m s = Setup.TokSet.iter Setup.show_token ( Hashtbl.find (Hashtbl.find Globals.modprims m).Globals.symbols s);;

let dump_gsyms gsyms = Hashtbl.iter Setup.show_sym gsyms;;

let dump_gsym gsyms s = Setup.TokSet.iter Setup.show_token ( Hashtbl.find gsyms s);;

let vparser gsyms args = begin for i = 1 to ( Array.length args - 2 ) do
    Printexc.print Parse.parse args.( i )
  done;
  if ( Array.length args > 2 ) then
    begin
    if (Hashtbl.mem Globals.modprims (args.( Array.length args - 1 ))) then
      begin
      Semantics.semantics gsyms "" (Hashtbl.find Globals.modprims (args.( Array.length args - 1 )));
      Semantics.check_glob gsyms
      end
    else Printf.printf "Toplevel %s is not found\n" args.( Array.length args - 1 );
    end
  end

let _ = Printexc.record_backtrace true; vparser (Hashtbl.create 256) Sys.argv;;
