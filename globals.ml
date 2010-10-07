(******************************************************************************
*
*    DESCRIPTION: Verilog parser ocamlyacc grammar file
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

open Vparser;;

type symtab = { symattr : Setup.tset; width : int; };;

type modtree = {
tree: token;
symbols: (string, Setup.symtab) Hashtbl.t;
mutable unresolved: string list;
(* gsyms : (string, Setup.symtab) Hashtbl.t; *)
 };;

let modprims = Hashtbl.create 256;;
let unresolved_list = ref [];;

let get_table (m:string) = Hashtbl.find modprims m;;
let get_syms (r:modtree) = r.symbols;;
