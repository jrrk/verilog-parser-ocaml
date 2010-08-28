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

(* let m k x = Printf.printf "%s\n" k in Hashtbl.iter m Globals.modprims;; *)

(* Hashtbl.find Globals.modprims "test";; *)

(* Hashtbl.find Globals.modprims "test2";; *)

(* Hashtbl.iter (fun k x -> Printf.printf "%s\n" k) Globals.modprims;; *)

(* Hashtbl.iter (fun k x -> Semantics.semantics x) Globals.modprims;; *)

(* List.iter (fun x -> Dump.dump (x, 0)) arg;; *)

(* Semantics.semantics ( Hashtbl.find Globals.modprims "test" ) ;; *)

(* Semantics.semantics ( Hashtbl.find Globals.modprims "test2" ) ;; *)

(* Hashtbl.iter (fun k x -> Printf.printf "%s: " k; Setup.TokSet.iter (fun e -> Dump.dump(e,0); Printf.printf "\n") x) Globals.symbols;; *)

(* Setup.TokSet.iter (fun e -> Printf.printf "%s\n" (Ord.getstr(e))) one_elm;; *)

(* let xx=Array.make 100 Vparser.EMPTY;; *)
(* let l = ref 0 in Globals.show_unhandled_f (fun t -> xx.(!l) <- t; l := !l+1 ) "test";; *)
