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
open Printf
open Vparser
open Globals
open Setup

type exprtree = { entry: token; symbol: Set.Make(Setup.OrdTok).t };;

type exprt =
| DYADIC of (token * exprtree * exprtree)
| ASSIGNMENT of (exprtree * exprt)
| UNHANDLED of token
;;

let stmts = ref [];;

let enter_a_sym symbols id attr = 
if Hashtbl.mem symbols id then begin
(*  printf "Update %s: %s\n" id (Ord.getstr attr); *)
  let newset = (Hashtbl.find symbols id) in
  Hashtbl.replace symbols id (TokSet.add attr newset); end
else begin
(*  printf "Enter %s: %s\n" id (Ord.getstr attr); *)
  Hashtbl.add symbols id (TokSet.add attr (TokSet.singleton (ID id)))
  end
;;

let enter_syms symbols id list = let f x = enter_a_sym symbols id x in iter f list;;

let iter_ semantics (stem:string) syms list =
  List.iter (fun x -> semantics stem ({Globals.tree=x; symbols=syms})) list
;;

let unhand_str = "**unhandled**";;

let unhandled arg = Dump.dump(arg, 0); enter_a_sym Globals.gsyms unhand_str arg;;

let find_ident syms v = try (Hashtbl.find syms v; true); with Not_found -> printf "variable %s not found\n" v;false ;;

let subexp syms exp = match exp with
| ID id -> if (find_ident syms id) then Hashtbl.find syms id else Hashtbl.find Globals.gsyms unhand_str
| _ -> unhandled exp; Hashtbl.find Globals.gsyms unhand_str;;

let subexp2 syms exp = {entry=exp; symbol=(subexp syms exp)};;

let expr_dyadic syms op left right = DYADIC(op, subexp2 syms left, subexp2 syms right);;

let expression syms (tree:token) = match tree with
| TRIPLE (PLUS as op, left, right) -> expr_dyadic syms op left right
| _ -> UNHANDLED tree;;

let statement syms tok var expr = (
let x = subexp syms var in
let r = {entry=var; symbol=x} in
stmts := ASSIGNMENT(r, expr) :: !stmts );;

let not_found syms w = printf "wire/port %s not found\n" w; enter_a_sym syms w IMPLICIT;;

let connect syms kind inner wireport =
try ignore(Hashtbl.find syms wireport); with Not_found -> not_found syms wireport;
try (fun insym -> if (TokSet.mem IOPORT insym == false) then printf "Instance port %s not an ioport\n" inner)
(Hashtbl.find ((Hashtbl.find Globals.modprims kind).symbols) inner);
with Not_found -> printf "Instance port %s not found\n" wireport;;

let vconst stem syms (x:string) a =
try ignore(Hashtbl.find syms x); with Not_found -> not_found syms x;;

let vbuf stem syms (x:string) a =
iter (fun w -> printf "%s.%s\n" stem w; try ignore(Hashtbl.find syms w); with Not_found -> not_found syms w) [x;a];;

let vbufif stem syms (inlist:token list) =
iter (fun t -> match t with ID w -> ( printf "%s.%s\n" stem w; try ignore(Hashtbl.find syms w);
	  with Not_found -> not_found syms w) | BINNUM lev -> () | _ -> unhandled t) inlist;;

let vnot stem syms (x:string) a =
iter (fun w -> printf "%s.%s\n" stem w; try ignore(Hashtbl.find syms w); with Not_found -> not_found syms w) [x;a];;

let vand stem syms (inlist:token list) =
iter (fun t -> match t with ID w -> ( printf "%s.%s\n" stem w; try ignore(Hashtbl.find syms w);
	  with Not_found -> not_found syms w) | _ -> unhandled t) inlist;;

let vor stem syms (inlist:token list) =
iter (fun t -> match t with ID w -> ( printf "%s.%s\n" stem w; try ignore(Hashtbl.find syms w);
	  with Not_found -> not_found syms w) | _ -> unhandled t) inlist;;

let vxor stem syms (inlist:token list) =
iter (fun t -> match t with ID w -> ( printf "%s.%s\n" stem w; try ignore(Hashtbl.find syms w);
	  with Not_found -> not_found syms w) | _ -> unhandled t) inlist;;

let vnand stem syms (inlist:token list) =
iter (fun t -> match t with ID w -> ( printf "%s.%s\n" stem w; try ignore(Hashtbl.find syms w);
	  with Not_found -> not_found syms w) | _ -> unhandled t) inlist;;

let vnor stem syms (inlist:token list) =
iter (fun t -> match t with ID w -> ( printf "%s.%s\n" stem w; try ignore(Hashtbl.find syms w);
	  with Not_found -> not_found syms w) | _ -> unhandled t) inlist;;

let vxnor stem syms (inlist:token list) =
iter (fun t -> match t with ID w -> ( printf "%s.%s\n" stem w; try ignore(Hashtbl.find syms w);
	  with Not_found -> not_found syms w) | _ -> unhandled t) inlist;;

let rec semantics (stem:string) (tree:Globals.modtree) =
   let exp = tree.Globals.tree and syms = tree.Globals.symbols in match exp with
(* These patterns are temporary till we decide on the proper general form *)
DOUBLE
 (ALWAYS,
   DOUBLE
    (DOUBLE (AT, TLIST [DOUBLE (POSEDGE, ID clk)]),
   QUADRUPLE
    (IF, ID rst,
      QUADRUPLE
       (EQUALS, ID var1, EMPTY, INTNUM start),
      QUADRUPLE
       (EQUALS, ID var2, EMPTY,
        TRIPLE
          (PLUS, ID var3, INTNUM inc)))))
-> iter (fun v -> try ignore(Hashtbl.find syms v); with Not_found -> not_found syms v) [clk;rst;var1;var2;var3];
| TRIPLE(ASSIGN, EMPTY, TLIST assignlist)
-> iter (fun a -> match a with TRIPLE (EQUALS, var1, expr) -> statement syms ASSIGN var1 (expression syms expr) | _ -> unhandled a) assignlist
| TRIPLE(EQUALS, TLIST arg1, TLIST arg2) -> iter_ semantics stem syms arg1; iter_ semantics stem syms arg2
| TRIPLE(IF, TLIST arg1, TLIST arg2) -> iter_ semantics stem syms arg1; iter_ semantics stem syms arg2
| TRIPLE(PLUS, TLIST arg1, TLIST arg2) -> iter_ semantics stem syms arg1; iter_ semantics stem syms arg2
| TRIPLE(BUF,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, ID x, ID a) -> vbuf stem syms x a
      | QUADRUPLE (EMPTY, EMPTY, ID x, BINNUM a) -> vconst stem syms x a
      | _ -> unhandled inst) instances
| TRIPLE(NOT,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, ID x, ID a) -> vnot stem syms x a
      | _ -> unhandled inst) instances
| TRIPLE(AND,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vand stem syms (x::inlist)
      | _ -> unhandled inst) instances
| TRIPLE(OR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vor stem syms (x::inlist)
      | _ -> unhandled inst) instances
| TRIPLE(XOR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vxor stem syms (x::inlist)
      | _ -> unhandled inst) instances
| TRIPLE(NAND,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vand stem syms (x::inlist)
      | _ -> unhandled inst) instances
| TRIPLE(NOR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vor stem syms (x::inlist)
      | _ -> unhandled inst) instances
| TRIPLE(XNOR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vxor stem syms (x::inlist)
      | _ -> unhandled inst) instances
| TRIPLE(BUFIF lev, TLIST [WEAK "weak0"; WEAK "weak1"], TLIST instances) ->
    iter (fun inst -> match inst with
      | DOUBLE (x, TLIST inlist) -> vbufif stem syms (x::inlist)
      | _ -> unhandled inst) instances
| TRIPLE(ID prim,ID q, TLIST inlist) ->
    (try
      semantics (stem^"."^prim) (Hashtbl.find Globals.modprims prim); (* scan the inner primitive *)
    with Not_found -> printf "primitive %s not found\n" prim );
(*    printf "Scanned Primitive %s\n" prim;  *)
    enter_a_sym syms prim PRIMITIVE;
iter (fun t -> match t with ID w -> ( try ignore(Hashtbl.find syms w);
	  with Not_found -> not_found syms w) | _ -> unhandled t) inlist
| TRIPLE(ID kind,EMPTY, TLIST instances) ->
      if (Hashtbl.mem Globals.modprims kind == false) then printf "sub-module %s not found\n" kind;
(*    printf "Scanned sub-module %s\n" kind;  *)
    enter_a_sym syms kind SUBMODULE;
    iter (fun inst -> match inst with
      | TRIPLE (ID subcct, EMPTY, TLIST termlist) -> semantics (stem^"."^subcct) (Hashtbl.find Globals.modprims kind); enter_a_sym syms subcct SUBCCT; iter (fun term -> match term with
          | TRIPLE (DOT, ID inner, ID wireport) -> connect syms kind inner wireport
          | TRIPLE (DOT, ID inner, TRIPLE(BITSEL, ID wireport, INTNUM sel)) -> connect syms kind inner wireport
	  | _ -> unhandled term) termlist
      | _ -> unhandled inst) instances
| QUADRUPLE(EQUALS, TLIST arg1, TLIST arg2, TLIST arg3) -> iter_ semantics stem syms arg1; iter_ semantics stem syms arg2; iter_ semantics stem syms arg3
| QUADRUPLE(IF, TLIST arg1, TLIST arg2, TLIST arg3) -> iter_ semantics stem syms arg1; iter_ semantics stem syms arg2; iter_ semantics stem syms arg3
| QUADRUPLE((WIRE|REG) as kind, arg1, arg2, TLIST arg3) ->
    let width = ref [kind] in begin
    semantics stem {Globals.tree=arg1; symbols=syms};
    (match arg2 with
      | RANGE(INTNUM hi, INTNUM lo) as rangehilo -> width := rangehilo :: !width
      | TRIPLE(EMPTY,(RANGE(INTNUM hi, INTNUM lo) as rangehilo),EMPTY) -> width := rangehilo :: !width
      | TLIST arg7 ->  List.iter (fun arg -> unhandled arg) arg7
      | EMPTY -> ()
      | TRIPLE(EMPTY,EMPTY,EMPTY) -> ()
      | _ ->  unhandled arg2);
    ( List.iter (fun x -> match x with
      | TRIPLE(ID id, arg5, arg6) -> enter_syms syms id !width
      | DOUBLE(ID id, EMPTY) -> enter_syms syms id !width
      | _ -> unhandled x) arg3); end
| QUINTUPLE(MODULE,ID arg1, arg2, TLIST arg3, TLIST arg4) ->
    enter_a_sym syms arg1 MODULE;
    semantics stem {Globals.tree=arg2; symbols=syms};
    iter (fun arg -> match arg with ID id -> enter_a_sym syms id IOPORT | _ -> semantics stem {Globals.tree=arg; symbols=syms}) arg3;
    iter_ semantics stem syms arg4
| QUINTUPLE(PRIMITIVE,ID arg1, EMPTY, TLIST arg3, TLIST arg4) ->
    enter_a_sym syms arg1 PRIMITIVE;
    iter (fun arg -> match arg with ID id -> enter_a_sym syms id IOPORT | _ -> semantics stem {Globals.tree=arg; symbols=syms}) arg3;
    iter_ semantics stem syms arg4
| QUINTUPLE((INPUT|OUTPUT|INOUT) as dir, arg1, arg2, arg3, arg4) ->
    let width = ref [dir] in begin
    semantics stem {Globals.tree=arg1; symbols=syms};
    semantics stem {Globals.tree=arg2; symbols=syms};
    (match arg3 with RANGE(INTNUM hi,INTNUM lo) as rangehilo -> width := rangehilo :: !width
      | TLIST arg9 ->  List.iter (fun arg -> unhandled arg) arg9
      | EMPTY -> ()
      | _ -> unhandled arg3);
    ( match arg4 with DOUBLE(ID id, arg5) ->
      enter_syms syms id !width
      | TRIPLE(ID id, TLIST arg5, TLIST arg6) -> enter_syms syms id !width
      | TLIST arg9 ->  List.iter (fun x -> match x with TRIPLE(ID id, arg5, arg6) -> enter_syms syms id !width | _ -> unhandled x) arg9
      | EMPTY -> ()
      | _ -> unhandled arg4); end
| QUINTUPLE(MODULE,ID arg1, EMPTY, EMPTY, EMPTY) -> enter_a_sym syms arg1 MODULE
| RANGE(arg1, arg2) -> semantics stem {Globals.tree=arg1; symbols=syms}; semantics stem {Globals.tree=arg2; symbols=syms}
| ID id -> enter_a_sym syms id EMPTY
| SPECIFY -> ()
| PREPROC txt -> ()
| TABLE -> ()
| EMPTY -> ()
| _ -> unhandled exp;;

let moditer k (x:Globals.modtree) = semantics k x;;
