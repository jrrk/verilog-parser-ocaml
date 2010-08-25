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

let _ = Printexc.print Parse.parse ()

(* let _ = Printexc.print Parse.parse ();; *)

(* let m k x = Printf.printf "%s\n" k in Hashtbl.iter m Globals.modules;; *)

(* Hashtbl.find Globals.modules "test";; *)

(* Hashtbl.find Globals.modules "test2";; *)

(* Hashtbl.iter (fun k x -> Printf.printf "%s\n" k) Globals.modules;; *)

(* Hashtbl.iter (fun k x -> Semantics.semantics x) Globals.modules;; *)

(* List.iter (fun x -> Dump.dump (x, 0)) arg;; *)

(* Semantics.semantics ( Hashtbl.find Globals.modules "test" ) ;; *)

(* Semantics.semantics ( Hashtbl.find Globals.modules "test2" ) ;; *)

(* Hashtbl.iter (fun k x -> Printf.printf "%s: " k; Setup.TokSet.iter (fun e -> Dump.dump(e,0); Printf.printf "\n") x) Globals.symbols;; *)

(* Setup.TokSet.iter (fun e -> Printf.printf "%s\n" (Ord.getstr(e))) one_elm;; *)

