(***********************************************************************)
(*                                                                     *)
(*                           Objective Caml                            *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1996 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* $Id: toploop.mli 8705 2007-12-04 13:38:58Z doligez $ *)

open Format

(* Accessors for the table of toplevel value bindings.  These functions
   must appear as first and second exported functions in this module.
   (See module Translmod.) *)
val getvalue : string -> Obj.t
val setvalue : string -> Obj.t -> unit

(* The interactive toplevel loop *)

val loop : formatter -> unit

(* variables to be debugged *)

