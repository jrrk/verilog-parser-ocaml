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

type exprtree = { entry: token; symbol: symtab };;

type exprt =
| DYADIC of (token * exprtree * exprtree)
| ASSIGNMENT of (exprtree * exprt)
| UNHANDLED of token
;;

let stmts = ref [];;
let nullsym = {Setup.symattr = TokSet.empty; width = EMPTY; referrer=Nil; path = ""};;

let enter_a_sym symbols id attr w refer = 
let refsym = if (refer <> "") then
  begin
  if Hashtbl.mem symbols refer then Referrer (Hashtbl.find symbols refer) else Nil
  end
else Nil in
if Hashtbl.mem symbols id then begin
(*  printf "Update %s: %s\n" id (Ord.getstr attr); *)
  let newset = (Hashtbl.find symbols id).symattr and oldw = (Hashtbl.find symbols id).width and oldr = (Hashtbl.find symbols id).referrer in
  Hashtbl.replace symbols id
    {Setup.symattr = (TokSet.add attr newset);
    width = (if oldw==EMPTY then w else oldw);
    referrer=(if oldr==Nil then refsym else oldr);
    path=id};
    end
else begin
(*  printf "Enter %s: %s\n" id (Ord.getstr attr); *)
  Hashtbl.add symbols id {Setup.symattr = (TokSet.singleton attr); width = w; referrer=refsym; path=id}
  end
;;

let iter_ semantics out_chan gsyms (stem:string) syms list =
  List.iter (fun x -> semantics out_chan gsyms stem ({Globals.tree=x; symbols=syms})) list
;;

let unhand_list = ref [EMPTY];;

let unhandled out_chan arg = unhand_list := arg :: !unhand_list; Dump.dump out_chan arg 0

let not_found syms w = printf "wire/port %s not found\n" w; enter_a_sym syms w IMPLICIT EMPTY "";;

let find_ident out_chan gsyms dir stem syms tok = match tok with ID id -> begin
if Hashtbl.mem syms id == false then begin
  fprintf out_chan "Creating implicit wire %s\n" id;
  Hashtbl.add syms id {Setup.symattr = TokSet.singleton IMPLICIT; width = EMPTY; referrer=Nil; path=id}
  end;
enter_a_sym gsyms (stem^id) dir EMPTY "";
Hashtbl.find syms id
end
| BINNUM lev -> ({Setup.symattr = TokSet.singleton tok; width = EMPTY; referrer=Nil; path=lev})
| _ -> unhandled out_chan tok; ({Setup.symattr = TokSet.singleton tok; width = EMPTY; referrer=Nil; path=""})
;;

let enter_sym_attrs out_chan gsyms dir stem symbols (tok:token) list width = match tok with
| ID id -> enter_a_sym gsyms (stem^id) dir width "";
  iter (fun x -> enter_a_sym symbols id x width "") list
| _ -> unhandled out_chan tok;
;;

let subexp out_chan gsyms stem syms exp = match exp with
| ID id -> find_ident out_chan gsyms DRIVER stem syms exp
| TRIPLE (BITSEL, ID id, INTNUM n) -> find_ident out_chan gsyms DRIVER stem syms (ID id)
| _ -> unhandled out_chan exp; {symattr=TokSet.singleton exp; width=EMPTY; referrer=Nil; path=""};;

let subexp2 out_chan gsyms stem syms exp = {entry=exp; symbol=(subexp out_chan gsyms stem syms exp)};;

let expr_dyadic out_chan gsyms stem syms op left right = DYADIC(op, subexp2 out_chan gsyms stem syms left, subexp2 out_chan gsyms stem syms right);;

let expression out_chan gsyms stem syms (tree:token) = match tree with
| TRIPLE (PLUS as op, left, right) -> expr_dyadic out_chan gsyms stem syms op left right
| _ -> UNHANDLED tree;;

let statement out_chan gsyms stem syms tok var expr = (
let x = subexp out_chan gsyms stem syms var in
let r = {entry=var; symbol=x} in
stmts := ASSIGNMENT(r, expr) :: !stmts );;

let widthnum expbase (str:string) =
let base = ref 10
and width = ref 0
and value = ref 0
and basing = ref 0
and converting = ref true in
for idx = 0 to String.length(str)-1 do let ch = Char.lowercase(str.[idx]) in begin
(*    Printf.printf "%c" ch;  *)
    match ch with
| '\'' -> converting := false; basing := idx+1;
| '0'..'9' -> if (!converting) then
    width := (!width * !base) + int_of_char(str.[idx]) - int_of_char('0')
else
    value := (!value * !base) + int_of_char(str.[idx]) - int_of_char('0')
| 'a'..'z' ->  if (!converting) then
    width := (!width * !base) + int_of_char(str.[idx]) - int_of_char('a') + 10
else if (!basing==idx) then begin match ch with
  | 'b' -> base := 2
  | 'd' -> base := 10
  | 'h' -> base := 16
  | _ -> value := int_of_char(str.[idx]) - int_of_char('a') + 10
end else
    value := (!value * !base) + int_of_char(str.[idx]) - int_of_char('a') + 10;
| _ -> converting := false; width := 0
end
done;
if (!basing == 0) then begin
  value := !width;
  width := 32;
end;
if (!base <> expbase) then printf "Expected base %d, actual base %d\n" expbase !base;
(!width, !value);;

let inner_chk out_chan gsyms stem syms sym subcct inner wireport wid = begin
  let hier = (stem^wireport) and hier2 = (stem^subcct^"."^inner) and compat=ref false in 
  begin
  if (sym.width <> wid) then
    begin
    match wid with
    | RANGE(INTNUM x, INTNUM y) -> if ((x==y) && (sym.width == EMPTY)) then compat := true;
    | _ -> ();
    match sym.width with
    | RANGE(INTNUM x, INTNUM y) -> if ((x==y) && (wid == EMPTY)) then compat := true;
    | _ -> ();
    if (!compat == false) then begin
      printf "Width mismatch stem=%s subcct=%s inner=%s %s wireport=%s %s\n"
          stem subcct inner (Setup.str_token sym.width) wireport (str_token(wid)); 
      end
    end;
  if (TokSet.mem IOPORT sym.symattr == false) then printf "Instance port %s not an ioport\n" inner
  else if (TokSet.mem INPUT sym.symattr) then ( enter_a_sym gsyms hier DRIVER wid ""; enter_a_sym gsyms hier2 RECEIVER wid hier)
  else if (TokSet.mem OUTPUT sym.symattr) then ( enter_a_sym gsyms hier RECEIVER wid ""; enter_a_sym gsyms hier2 DRIVER wid hier)
  else if (TokSet.mem INOUT sym.symattr) then ( enter_a_sym gsyms hier BIDIR wid ""; enter_a_sym gsyms hier2 BIDIR wid hier)
  end
end

let iwidth out_chan wid =  match wid with 
| RANGE(INTNUM ihi, INTNUM ilo) -> (ihi,ilo)
| EMPTY -> (0,0)
| _ -> unhandled out_chan wid; (-1,-1)

let rec connect out_chan gsyms stem syms kind subcct (innert:token) tok = 
let innersym = (Hashtbl.find Globals.modprims kind).symbols in match innert with ID inner -> begin
if (Hashtbl.mem innersym inner) then
let isym=Hashtbl.find innersym inner in match tok with
| ID wireport -> inner_chk out_chan gsyms stem syms isym subcct inner wireport (find_ident out_chan gsyms WIRE stem syms tok).width
| TRIPLE(BITSEL, ID wireport, INTNUM sel) -> if (Hashtbl.mem syms wireport) then inner_chk out_chan gsyms stem syms isym subcct inner wireport (RANGE (INTNUM sel, INTNUM sel)) else not_found syms wireport
| QUADRUPLE(PARTSEL, ID wireport, INTNUM hi, INTNUM lo) -> if (Hashtbl.mem syms wireport) then inner_chk out_chan gsyms stem syms isym subcct inner wireport (RANGE(INTNUM hi, INTNUM lo)) else not_found syms wireport
| INTNUM lev -> inner_chk out_chan gsyms stem syms isym subcct inner (string_of_int lev) (RANGE(INTNUM 31, INTNUM 0))
| BINNUM lev -> inner_chk out_chan gsyms stem syms isym subcct inner lev (RANGE(INTNUM (fst(widthnum 2 lev)-1), INTNUM 0))
| TLIST concat -> let idx = ref (fst(iwidth out_chan isym.width)) in iter (fun (item:token) -> 
(match item with
| ID id -> let wid = (find_ident out_chan gsyms WIRE stem syms item).width in begin inner_chk out_chan gsyms stem syms {symattr=isym.symattr; width=RANGE(INTNUM !idx, INTNUM !idx); referrer=Nil; path=id} subcct inner id wid; idx := !idx + snd(iwidth out_chan wid) - fst(iwidth out_chan wid); end
| TRIPLE (BITSEL, ID id, INTNUM sel) -> inner_chk out_chan gsyms stem syms {symattr=isym.symattr; width=RANGE(INTNUM !idx, INTNUM !idx); referrer=Nil; path=id} subcct inner id (RANGE(INTNUM sel, INTNUM sel)); idx := !idx-1
| QUADRUPLE (PARTSEL, ID id, INTNUM hi, INTNUM lo) -> inner_chk out_chan gsyms stem syms {symattr=isym.symattr; width=RANGE(INTNUM !idx, INTNUM (!idx+lo-hi)); referrer=Nil; path=id} subcct inner id (RANGE(INTNUM hi, INTNUM lo)); idx := !idx+lo-hi-1
| _ -> unhandled out_chan item)
) concat
| _ -> unhandled out_chan tok
else printf "Instance port %s not found\n" inner
end
| _ -> unhandled out_chan innert
;;

let vpullup out_chan gsyms stem syms (x:token) =
ignore(find_ident out_chan gsyms RECEIVER stem syms x);;

let vbuf out_chan gsyms stem syms (x:token) a =
ignore(find_ident out_chan gsyms RECEIVER stem syms x);
ignore(find_ident out_chan gsyms DRIVER stem syms a);;

let vbufif out_chan gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident out_chan gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident out_chan gsyms DRIVER stem syms t)
	  ) | BINNUM lev -> () | _ -> unhandled out_chan t) inlist;;

let vnot out_chan gsyms stem syms (x:token) a =
ignore(find_ident out_chan gsyms RECEIVER stem syms x);
iter (fun w -> ignore(find_ident out_chan gsyms DRIVER stem syms w)) [x;a];;

let vand out_chan gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident out_chan gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident out_chan gsyms DRIVER stem syms t)
	  ) | _ -> unhandled out_chan t) inlist;;

let vor out_chan gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident out_chan gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident out_chan gsyms DRIVER stem syms t)
	  ) | _ -> unhandled out_chan t) inlist;;

let vxor out_chan gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident out_chan gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident out_chan gsyms DRIVER stem syms t)
	  ) | _ -> unhandled out_chan t) inlist;;

let vnand out_chan gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident out_chan gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident out_chan gsyms DRIVER stem syms t)
	  ) | _ -> unhandled out_chan t) inlist;;

let vnor out_chan gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident out_chan gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident out_chan gsyms DRIVER stem syms t)
	  ) | _ -> unhandled out_chan t) inlist;;

let vxnor out_chan gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident out_chan gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident out_chan gsyms DRIVER stem syms t)
	  ) | _ -> unhandled out_chan t) inlist;;

let f2 inner t = show_token(inner);show_token(t);print_char '\n';;

let fiter out_chan gsyms (stem:string) syms (kind:string) (subcct:string) (inner:token) (term:token) = match term with
          (* connect by position syntax - deprecated *)
          | TRIPLE (DOT, myinner, tok) -> connect out_chan gsyms stem syms kind subcct myinner tok
          | ID id -> connect out_chan gsyms stem syms kind subcct inner term
	  | TLIST concat -> connect out_chan gsyms stem syms kind subcct inner term
          | QUADRUPLE (PARTSEL, ID net, INTNUM hi, INTNUM lo) -> connect out_chan gsyms stem syms kind subcct inner term
	  | _ -> unhandled out_chan term
;;

let rec semantics out_chan gsyms (stem:string) (tree:Globals.modtree) =
   let exp = tree.Globals.tree and syms = tree.Globals.symbols in match exp with
(* These patterns are temporary till we decide on the proper general form *)
DOUBLE
 (ALWAYS,
   DOUBLE
    (DOUBLE (AT, TLIST sens_list),
   TLIST stmts))
-> iter_ semantics out_chan gsyms stem syms sens_list; iter_ semantics out_chan gsyms stem syms stmts
| DOUBLE(SPECIFY, TLIST speclist) -> iter (fun item -> match item with ID id -> enter_a_sym gsyms (stem^id) SPECIFY EMPTY ""| _ -> ()) speclist
| TRIPLE(ASSIGN, EMPTY, TLIST assignlist)
-> iter (fun a -> match a with TRIPLE (EQUALS, var1, expr) -> statement out_chan gsyms stem syms ASSIGN var1 (expression out_chan gsyms stem syms expr) | _ -> unhandled out_chan a) assignlist
| TRIPLE(EQUALS, TLIST arg1, TLIST arg2) -> iter_ semantics out_chan gsyms stem syms arg1; iter_ semantics out_chan gsyms stem syms arg2
| TRIPLE(IF, expr, then_clause) ->
exprGeneric out_chan gsyms stem syms expr;
stmtBlock out_chan gsyms stem syms then_clause
| TRIPLE(PLUS, TLIST arg1, TLIST arg2) -> iter_ semantics out_chan gsyms stem syms arg1; iter_ semantics out_chan gsyms stem syms arg2
| TRIPLE(BUF,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, a) -> vbuf out_chan gsyms stem syms x a
      | _ -> unhandled out_chan inst) instances
| TRIPLE(NOT,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, a) -> vnot out_chan gsyms stem syms x a
      | _ -> unhandled out_chan inst) instances
| TRIPLE(AND,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vand out_chan gsyms stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(OR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vor out_chan gsyms stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(XOR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vxor out_chan gsyms stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(NAND,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vand out_chan gsyms stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(NOR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vor out_chan gsyms stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(XNOR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vxor out_chan gsyms stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(BUFIF lev, (EMPTY | TLIST [WEAK "weak0"; WEAK "weak1"]), TLIST instances) ->
    iter (fun inst -> match inst with
      | DOUBLE (x, TLIST inlist) -> vbufif out_chan gsyms stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(PULLUP, EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | TRIPLE(EMPTY, EMPTY, x) -> vpullup out_chan gsyms stem syms x
      | _ -> unhandled out_chan inst) instances
(* Parse primitive instance *)
| TRIPLE(PRIMINST, ID prim, TLIST inlist) ->
    if (Hashtbl.mem Globals.modprims prim) then
      semantics out_chan gsyms (stem^prim^".") (Hashtbl.find Globals.modprims prim) (* scan the inner primitive *)
    else printf "Primitive %s not found\n" prim;
    enter_a_sym syms prim PRIMITIVE EMPTY "";
    let fc inner t = connect out_chan gsyms stem syms prim prim inner t in 
    ( match (Hashtbl.find Globals.modprims prim).Globals.tree with QUINTUPLE(PRIMITIVE,ID arg1, EMPTY, TLIST primargs, TLIST arg4) ->
iter2 fc primargs inlist | _ -> ())
(* Parse module instance *)
| TRIPLE(ID kind,EMPTY, TLIST instances) ->
      if (Hashtbl.mem Globals.modprims kind == false) then printf "sub-module %s not found\n" kind else
(*    printf "Scanning sub-module %s\n" kind;  *)
    begin
    enter_a_sym syms kind SUBMODULE EMPTY "";
    let kindhash = Hashtbl.find Globals.modprims kind in iter (fun inst -> match inst with
      | TRIPLE (ID subcct, EMPTY, TLIST termlist) -> semantics out_chan gsyms (stem^subcct^".") kindhash;
        enter_a_sym syms subcct SUBCCT EMPTY "";
        ( match kindhash.Globals.tree with QUINTUPLE(MODULE,ID arg1, EMPTY, TLIST primargs, TLIST arg4) ->
        (try iter2 (fun (inner:token) (term:token) -> fiter out_chan gsyms stem syms kind subcct inner term) primargs termlist; with Invalid_argument "List.iter2" -> let ids = ref [] in begin
(*
iter (fun (inner:token) -> (fprintf out_chan "%s " (str_token inner))) primargs;
output_char out_chan '\n';
iter (fun (term:token) -> (fprintf out_chan "%s " (str_token term))) termlist;
output_char out_chan '\n';
*)
iter (fun (inner:token) -> (match inner with ID id -> ids := (!ids @ [id]) | _ -> unhandled out_chan inner)) primargs;
iter (fun (term:token) -> (match term with TRIPLE (DOT, ID inner, tok) -> ids := filter (fun item -> item<>inner) !ids | _ -> unhandled out_chan term)) termlist;
fprintf out_chan "sub-module %s of kind %s insufficient args - %d unconnected pin(s): " subcct kind (length !ids);
iter (fun id -> fprintf out_chan "%s " id) !ids;
output_char out_chan '\n';
end)
        | _ -> unhandled out_chan kindhash.Globals.tree)
      | _ -> unhandled out_chan inst) instances
    end
| QUADRUPLE(EQUALS, TLIST arg1, TLIST arg2, TLIST arg3) -> iter_ semantics out_chan gsyms stem syms arg1; iter_ semantics out_chan gsyms stem syms arg2; iter_ semantics out_chan gsyms stem syms arg3
| QUADRUPLE(IF, expr, then_clause, else_clause) ->
exprGeneric out_chan gsyms stem syms expr;
stmtBlock out_chan gsyms stem syms then_clause;
stmtBlock out_chan gsyms stem syms else_clause
(* Parse wire/reg declarations *)
| QUADRUPLE((WIRE|REG) as kind, arg1, arg2, TLIST arg3) ->
    let width = ref EMPTY in begin
    semantics out_chan gsyms stem {Globals.tree=arg1; symbols=syms};
    (match arg2 with
      | RANGE(INTNUM hi, INTNUM lo) as rangehilo -> width := rangehilo
      | TRIPLE(EMPTY,(RANGE(INTNUM hi, INTNUM lo) as rangehilo),EMPTY) -> width := rangehilo
      | TLIST arg7 ->  List.iter (fun arg -> unhandled out_chan arg) arg7
      | EMPTY -> ()
      | TRIPLE(EMPTY,EMPTY,EMPTY) -> ()
      | _ ->  unhandled out_chan arg2);
    ( List.iter (fun x -> match x with
      | TRIPLE(id, arg5, arg6) -> enter_sym_attrs out_chan gsyms kind stem syms id [kind] !width
      | DOUBLE(id, EMPTY) -> enter_sym_attrs out_chan gsyms kind stem syms id [kind] !width
      | _ -> unhandled out_chan x) arg3); end
(* Parse module declarations *)
| QUINTUPLE(MODULE,ID arg1, arg2, TLIST arg3, TLIST arg4) ->
    enter_a_sym syms arg1 MODULE EMPTY ""; (* print_endline (stem^arg1); *)
    semantics out_chan gsyms stem {Globals.tree=arg2; symbols=syms};
    iter (fun arg -> match arg with ID id -> enter_a_sym syms id IOPORT EMPTY ""| _ -> semantics out_chan gsyms stem {Globals.tree=arg; symbols=syms}) arg3;
    iter_ semantics out_chan gsyms stem syms arg4
(* Parse primitive declarations *)
| QUINTUPLE(PRIMITIVE,ID arg1, EMPTY, TLIST arg3, TLIST arg4) ->
    enter_a_sym syms arg1 (PRIMARGS arg3) EMPTY "";
    iter (fun arg -> match arg with ID id -> enter_a_sym syms id IOPORT EMPTY ""| _ -> semantics out_chan gsyms stem {Globals.tree=arg; symbols=syms}) arg3;
    iter_ semantics out_chan gsyms stem syms arg4
(* Parse IO declarations *)
| QUINTUPLE((INPUT|OUTPUT|INOUT) as dir, arg1, arg2, arg3, arg4) ->
    let width = ref EMPTY in begin
    semantics out_chan gsyms stem {Globals.tree=arg1; symbols=syms};
    semantics out_chan gsyms stem {Globals.tree=arg2; symbols=syms};
    (match arg3 with
      | RANGE(INTNUM hi,INTNUM lo) as rangehilo -> width := rangehilo
      | TLIST arg9 ->  List.iter (fun arg -> unhandled out_chan arg) arg9
      | EMPTY -> ()
      | _ -> unhandled out_chan arg3);
    ( match arg4 with
      | DOUBLE(id, arg5) -> enter_sym_attrs out_chan gsyms dir stem syms id [IOPORT;dir] !width
      | TRIPLE(id, TLIST arg5, TLIST arg6) -> enter_sym_attrs out_chan gsyms dir stem syms id [IOPORT;dir] !width
      | TLIST arg9 ->  List.iter (fun x -> match x with TRIPLE(id, arg5, arg6) -> enter_sym_attrs out_chan gsyms dir stem syms id [IOPORT;dir] !width | _ -> unhandled out_chan x) arg9
      | EMPTY -> ()
      | _ -> unhandled out_chan arg4); end
| QUINTUPLE(MODULE,ID arg1, EMPTY, EMPTY, EMPTY) -> enter_a_sym syms arg1 MODULE EMPTY ""
| RANGE(arg1, arg2) -> semantics out_chan gsyms stem {Globals.tree=arg1; symbols=syms}; semantics out_chan gsyms stem {Globals.tree=arg2; symbols=syms}
| ID id -> enter_a_sym syms id EMPTY EMPTY ""
| DOUBLE(SPECIFY,EMPTY) -> ()
| PREPROC txt -> ()
| TABLE -> ()
| EMPTY -> ()
| _ -> unhandled out_chan exp

and stmtBlock out_chan gsyms stem syms block = match block with
| EMPTY -> ()
| TLIST stmtList -> iter (fun item -> semantics out_chan gsyms stem {Globals.tree=item; symbols=syms}) stmtList
| TRIPLE(BEGIN, TLIST stmtList, endLabelE) -> iter (fun item -> semantics out_chan gsyms stem {Globals.tree=item; symbols=syms}) stmtList
| _ -> semantics out_chan gsyms stem {Globals.tree=block; symbols=syms};

and exprGeneric out_chan gsyms stem syms expr = match expr with
| TRIPLE( P_OROR, left, right ) -> ()
| TRIPLE( P_ANDAND, left, right ) -> ()
| TRIPLE( AMPERSAND, left, right ) -> ()
| TRIPLE( VBAR, left, right ) -> ()
| TRIPLE( P_NAND, left, right ) -> ()
| TRIPLE( P_NOR, left, right ) -> ()
| TRIPLE( CARET, left, right ) -> ()
| TRIPLE( P_XNOR, left, right ) -> ()
| TRIPLE( P_EQUAL, left, right ) -> ()
| TRIPLE( P_NOTEQUAL, left, right ) -> ()
| TRIPLE( P_CASEEQUAL, left, right ) -> ()
| TRIPLE( P_CASENOTEQUAL, left, right ) -> ()
| TRIPLE( P_WILDEQUAL, left, right ) -> ()
| TRIPLE( P_WILDNOTEQUAL, left, right ) -> ()
| TRIPLE( GREATER, left, right ) -> ()
| TRIPLE( LESS, left, right ) -> ()
| TRIPLE( P_GTE, left, right ) -> ()
| TRIPLE( P_LTE, left, right ) -> ()
| TRIPLE( P_SLEFT, left, right ) -> ()
| TRIPLE( P_SRIGHT, left, right ) -> ()
| TRIPLE( P_SSRIGHT, left, right ) -> ()
| TRIPLE( PLUS, left, right ) -> ()
| TRIPLE( MINUS, left, right ) -> ()
| TRIPLE( TIMES, left, right ) -> ()
| TRIPLE( DIVIDE, left, right ) -> ()
| TRIPLE( MODULO, left, right ) -> ()
| TRIPLE( P_POW, left, right ) -> ()
| DOUBLE (MINUS, arg2) -> ()
| DOUBLE (PLUS, arg2) -> ()
| DOUBLE (AMPERSAND, arg2) -> ()
| DOUBLE (VBAR, arg2) -> ()
| DOUBLE (CARET, arg2) -> ()
| DOUBLE (P_XNOR, arg2) -> ()
| DOUBLE (P_NAND, arg2) -> ()
| DOUBLE (P_NOR, arg2) -> ()
| DOUBLE (PLING, arg2) -> ()
| DOUBLE (TILDE, arg2) -> ()
| QUADRUPLE (QUERY, expr, then_clause, else_clause ) -> ()
| TLIST concat -> ()
| TRIPLE (LCURLY, arg2, TLIST arg4) -> ()
| DOUBLE (D_BITS, right ) -> ()
| DOUBLE (D_C, TLIST right ) -> ()
| DOUBLE (D_CLOG2, right ) -> ()
| DOUBLE (D_COUNTDRIVERS, right ) -> ()
| DOUBLE (D_COUNTONES, right ) -> ()
| DOUBLE (D_FEOF, right ) -> ()
| DOUBLE (D_FGETC, right ) -> ()
| TRIPLE (D_FGETS, right, arg5) -> ()
| TRIPLE (D_FSCANF, right, arg6) -> ()
| TRIPLE (D_SSCANF, right, arg6) -> ()
| DOUBLE (D_ISUNKNOWN, right ) -> ()
| DOUBLE (D_ONEHOT, right ) -> ()
| DOUBLE (D_ONEHOT0, right ) -> ()
| DOUBLE (D_RANDOM, right ) -> ()
| D_RANDOM -> ()
| DOUBLE (D_SIGNED, right ) -> ()
| D_STIME -> ()
| D_TIME -> ()
| DOUBLE (D_TEST_PLUSARGS, right ) -> ()
| DOUBLE (D_UNSIGNED, right ) -> ()
| TRIPLE(DOT, arg1, arg3) -> ()
| TRIPLE (FUNCTION, arg1, TLIST arg3) -> ()
| INTNUM left -> ()
| BINNUM left -> ()
| DECNUM left -> ()
| HEXNUM left -> ()
| ID arg1 -> ()
| TRIPLE(BITSEL, arg1, arg3) -> ()
| QUADRUPLE(PARTSEL, arg1 , arg3 , arg5 ) -> ()
| QUADRUPLE(P_PLUSCOLON, arg1 , arg3 , arg5 ) -> ()
| QUADRUPLE(P_MINUSCOLON, arg1, arg3, arg5 ) -> ()
| ASCNUM arg1 -> ()
| FLOATNUM arg1 -> ()
| _ -> semantics out_chan gsyms stem {Globals.tree=expr; symbols=syms};
;;

(* let moditer k (x:Globals.modtree) = semantics out_chan gsyms k x;; *)

let find_glob gsyms s = Setup.show_sym s ( Hashtbl.find gsyms s);;

let find_glob_substr gsyms s = let reg = Str.regexp s in Hashtbl.iter (fun k x -> try Printf.printf "%s posn %d\n" k (Str.search_forward reg k 0); with Not_found -> ()) gsyms;;

let find_referrer gsyms s = Setup.show_sym s (match (Hashtbl.find gsyms s).referrer with Referrer lk -> lk | Nil -> nullsym);;

let dotted s = try String.index s '.' > 0 ; with Not_found -> false;;

let erc_chk out_chan nam s = let sym = s.symattr and link = (match s.referrer with Referrer lk -> lk | Nil -> nullsym) in
  begin
	begin
	  if (TokSet.mem WIRE sym) && not ((TokSet.mem RECEIVER sym) || (TokSet.mem SPECIFY sym)) then
	    Printf.fprintf out_chan "%s is a dangling wire\n" nam
	  else if (dotted nam) && (TokSet.mem INPUT sym) && not (TokSet.mem RECEIVER sym) then
	    Printf.fprintf out_chan "%s is a dangling input\n" nam
	  else if (dotted nam) && (TokSet.mem OUTPUT sym) && not (TokSet.mem DRIVER sym) then
	    Printf.fprintf out_chan "%s is a dangling output\n" nam
	  else if (dotted nam) && (TokSet.mem INOUT sym) then
	    Printf.fprintf out_chan "%s is a inout\n" nam
	  else if (dotted nam) && (TokSet.mem INPUT sym) && not (TokSet.mem RECEIVER link.symattr) then
	    Printf.fprintf out_chan "%s is an input unconnected at level %s\n" nam link.path
	end
  end
;;

let check_glob out_chan gsyms = Hashtbl.iter (fun nam s -> erc_chk out_chan nam s) gsyms;;
