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
open Mytoploop (* for unhandled syntax *)

type exprtree = { entry: token; symbol: symtab };;

type exprt =
| DYADIC of (token * exprtree * exprtree)
| ASSIGNS of (exprtree * exprt)
| UNHANDLED of token
;;

type uptr = UPTR of (out_channel -> Vparser.token -> unit) | UNIL;;

let stk = Stack.create();;

let unhand_list = ref [Vparser.EMPTY];;

let unhandled_dflt out_chan arg = if (List.mem arg !unhand_list == false) then begin
unhand_list := arg :: !unhand_list;
Dump.dump out_chan arg 0
end

let unhandled_ptr = ref (UPTR unhandled_dflt);;

let unhandled out_chan arg = match !unhandled_ptr with UPTR fn -> fn out_chan arg | UNIL -> ();;

let nullsym = {Setup.symattr = TokSet.empty; width = EMPTY; path = ""};;

let enter_a_sym out_chan symbols id attr w = 
if Hashtbl.mem symbols id then begin
(*  printf "Update %s: %s\n" id (Ord.getstr attr); *)
  let newset = (Hashtbl.find symbols id).symattr and oldw = (Hashtbl.find symbols id).width in
  if (oldw<>UNKNOWN)&&(oldw<>w)&&(w<>UNKNOWN) then
    Printf.fprintf out_chan "Addition of attribute %s to signal %s changed width from %s to %s\n"
      (str_token attr) id (str_token oldw) (str_token w);
  Hashtbl.replace symbols id
    {Setup.symattr = (TokSet.add attr newset);
    width = if (w<>UNKNOWN) then w else oldw;
    path=id};
    end
else begin
(*  printf "Enter %s: %s\n" id (Ord.getstr attr); *)
  Hashtbl.add symbols id {Setup.symattr = (TokSet.singleton attr); width = w; path=id}
  end
;;

let iter_ semantics out_chan (stem:string) syms list =
  List.iter (fun x -> semantics out_chan stem ({Globals.unresolved=[]; tree=x; symbols=syms})) list
;;

let not_found out_chan syms w = printf "wire/port %s not found\n" w; enter_a_sym out_chan syms w IMPLICIT EMPTY;;

let find_ident out_chan dir stem syms tok = match tok with ID id -> begin
if Hashtbl.mem syms id == false then begin
(*  fprintf out_chan "Creating implicit wire %s\n" id;  *)
  Hashtbl.add syms id {Setup.symattr = TokSet.singleton IMPLICIT; width = SCALAR; path=id}
  end;
Hashtbl.find syms id
end
| _ -> unhandled out_chan tok; ({Setup.symattr = TokSet.singleton tok; width = EMPTY; path=""})
;;

let enter_sym_attrs out_chan stem symbols (tok:token) list width = match tok with
| ID id -> iter (fun x -> enter_a_sym out_chan symbols id x width) list;
  let newset = (Hashtbl.find symbols id).symattr in
    begin
     if (TokSet.mem INPUT newset) && (TokSet.mem REG newset) then 
       Printf.fprintf out_chan "Signal %s cannot be input and reg\n" id;
    end
| _ -> unhandled out_chan tok;
;;

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

let inner_chk out_chan stem syms sym subcct inner wireport wid = begin
  let hier = (stem^wireport) and compat=ref false in 
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
      fprintf out_chan "Width mismatch stem=%s subcct=%s inner=%s %s wireport=%s %s\n"
          stem subcct inner (Setup.str_token sym.width) wireport (str_token(wid)); 
      end
    end;
  if (TokSet.mem IOPORT sym.symattr == false) then printf "Instance port %s not an ioport\n" inner
  else if (TokSet.mem INPUT sym.symattr) then ( enter_a_sym out_chan syms hier DRIVER wid)
  else if (TokSet.mem OUTPUT sym.symattr) then ( enter_a_sym out_chan syms hier RECEIVER wid)
  else if (TokSet.mem INOUT sym.symattr) then ( enter_a_sym out_chan syms hier BIDIR wid)
  end
end

let iwidth out_chan wid =  match wid with 
| RANGE(INTNUM ihi, INTNUM ilo) -> (ihi,ilo)
| EMPTY -> (0,0)
| _ -> unhandled out_chan wid; (-1,-1)

let rec connect out_chan stem syms kind subcct (innert:token) tok = 
let innersym = (Hashtbl.find Globals.modprims kind).symbols in match innert with ID inner -> begin
if (Hashtbl.mem innersym inner) then
let isym=Hashtbl.find innersym inner in match tok with
| ID wireport -> inner_chk out_chan stem syms isym subcct inner wireport (find_ident out_chan WIRE stem syms tok).width
| TRIPLE(BITSEL, ID wireport, INTNUM sel) -> if (Hashtbl.mem syms wireport) then inner_chk out_chan stem syms isym subcct inner wireport (RANGE (INTNUM sel, INTNUM sel)) else not_found out_chan syms wireport
| QUADRUPLE(PARTSEL, ID wireport, INTNUM hi, INTNUM lo) -> if (Hashtbl.mem syms wireport) then inner_chk out_chan stem syms isym subcct inner wireport (RANGE(INTNUM hi, INTNUM lo)) else not_found out_chan syms wireport
| INTNUM lev -> inner_chk out_chan stem syms isym subcct inner (string_of_int lev) (RANGE(INTNUM 31, INTNUM 0))
| BINNUM lev -> inner_chk out_chan stem syms isym subcct inner lev (RANGE(INTNUM (fst(widthnum 2 lev)-1), INTNUM 0))
| DOUBLE (CONCAT, TLIST concat) -> let idx = ref (fst(iwidth out_chan isym.width)) in iter (fun (item:token) -> 
(match item with
| ID id -> let wid = (find_ident out_chan WIRE stem syms item).width in begin inner_chk out_chan stem syms {symattr=isym.symattr; width=RANGE(INTNUM !idx, INTNUM !idx); path=id} subcct inner id wid; idx := !idx + snd(iwidth out_chan wid) - fst(iwidth out_chan wid); end
| TRIPLE (BITSEL, ID id, INTNUM sel) -> inner_chk out_chan stem syms {symattr=isym.symattr; width=RANGE(INTNUM !idx, INTNUM !idx); path=id} subcct inner id (RANGE(INTNUM sel, INTNUM sel)); idx := !idx-1
| QUADRUPLE (PARTSEL, ID id, INTNUM hi, INTNUM lo) -> inner_chk out_chan stem syms {symattr=isym.symattr; width=RANGE(INTNUM !idx, INTNUM (!idx+lo-hi)); path=id} subcct inner id (RANGE(INTNUM hi, INTNUM lo)); idx := !idx+lo-hi-1
| _ -> unhandled out_chan item)
) concat
| _ -> unhandled out_chan tok
else printf "Instance port %s not found\n" inner
end
| _ -> unhandled out_chan innert
;;

let f2 inner t = show_token(inner);show_token(t);print_char '\n';;

let fiter out_chan (stem:string) syms (kind:string) (subcct:string) (inner:token) (term:token) = match term with
          | DOUBLE (CELLPIN, myinner) -> ()
          | TRIPLE (CELLPIN, myinner, tok) -> connect out_chan stem syms kind subcct myinner tok
          (* connect by position syntax - deprecated *)
          | ID id -> connect out_chan stem syms kind subcct inner term
	  | DOUBLE (CONCAT, TLIST concat) -> connect out_chan stem syms kind subcct inner term
          | QUADRUPLE (PARTSEL, ID net, INTNUM hi, INTNUM lo) -> connect out_chan stem syms kind subcct inner term
	  | _ -> unhandled out_chan term
;;

let rec exprGeneric out_chan stem syms expr = match expr with
| TRIPLE( P_OROR, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_ANDAND, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( AMPERSAND, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( VBAR, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_NAND, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_NOR, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( CARET, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_XNOR, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_EQUAL, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_NOTEQUAL, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_CASEEQUAL, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_CASENOTEQUAL, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_WILDEQUAL, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_WILDNOTEQUAL, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( GREATER, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( LESS, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_GTE, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_LTE, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_SLEFT, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_SRIGHT, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_SSRIGHT, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( PLUS, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( MINUS, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( TIMES, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( DIVIDE, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( MODULO, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| TRIPLE( P_POW, left, right ) -> exprGeneric out_chan stem syms left; exprGeneric out_chan stem syms right
| DOUBLE (MINUS, arg2) -> exprGeneric out_chan stem syms arg2
| DOUBLE (PLUS, arg2) -> exprGeneric out_chan stem syms arg2
| DOUBLE (AMPERSAND, arg2) -> exprGeneric out_chan stem syms arg2
| DOUBLE (VBAR, arg2) -> exprGeneric out_chan stem syms arg2
| DOUBLE (CARET, arg2) -> exprGeneric out_chan stem syms arg2
| DOUBLE (P_XNOR, arg2) -> exprGeneric out_chan stem syms arg2
| DOUBLE (P_NAND, arg2) -> exprGeneric out_chan stem syms arg2
| DOUBLE (P_NOR, arg2) -> exprGeneric out_chan stem syms arg2
| DOUBLE (PLING, arg2) -> exprGeneric out_chan stem syms arg2
| DOUBLE (TILDE, arg2) -> exprGeneric out_chan stem syms arg2
| QUADRUPLE (QUERY, expr, then_clause, else_clause ) ->
    exprGeneric out_chan stem syms expr;
    exprGeneric out_chan stem syms then_clause;
    exprGeneric out_chan stem syms else_clause
| DOUBLE (CONCAT, TLIST concat) -> iter (fun arg -> exprGeneric out_chan stem syms arg) concat
| TRIPLE (LCURLY, arg2, TLIST arg4) -> iter (fun arg -> exprGeneric out_chan stem syms arg) arg4
| DOUBLE (D_BITS, right ) -> exprGeneric out_chan stem syms right
| DOUBLE (D_C, TLIST right ) -> iter(fun arg -> exprGeneric out_chan stem syms arg) right
| DOUBLE (D_CLOG2, right ) -> exprGeneric out_chan stem syms right
| DOUBLE (D_COUNTDRIVERS, right ) -> exprGeneric out_chan stem syms right
| DOUBLE (D_COUNTONES, right ) -> exprGeneric out_chan stem syms right
| DOUBLE (D_FEOF, right ) -> exprGeneric out_chan stem syms right
| DOUBLE (D_FGETC, right ) -> exprGeneric out_chan stem syms right
| TRIPLE (D_FGETS, right, arg5) -> exprGeneric out_chan stem syms right
| TRIPLE (D_FSCANF, right, arg6) -> exprGeneric out_chan stem syms right
| TRIPLE (D_SSCANF, right, arg6) -> exprGeneric out_chan stem syms right
| DOUBLE (D_ISUNKNOWN, right ) -> exprGeneric out_chan stem syms right
| DOUBLE (D_ONEHOT, right ) -> exprGeneric out_chan stem syms right
| DOUBLE (D_ONEHOT0, right ) -> exprGeneric out_chan stem syms right
| DOUBLE (D_RANDOM, right ) -> exprGeneric out_chan stem syms right
| D_RANDOM -> ()
| DOUBLE (D_SIGNED, right ) -> exprGeneric out_chan stem syms right
| D_STIME -> ()
| D_TIME -> ()
| DOUBLE (D_TEST_PLUSARGS, right ) -> exprGeneric out_chan stem syms right
| DOUBLE (D_UNSIGNED, right ) -> exprGeneric out_chan stem syms right
| TRIPLE (FUNCREF, arg1, TLIST arg3) -> ()
| INTNUM left -> ()
| BINNUM left -> ()
| DECNUM left -> ()
| HEXNUM left -> ()
| ID arg1 -> enter_sym_attrs out_chan stem syms expr [DRIVER] UNKNOWN
| TRIPLE(BITSEL, arg1, arg3) -> ()
| QUADRUPLE(PARTSEL, arg1 , arg3 , arg5 ) -> ()
| QUADRUPLE(P_PLUSCOLON, arg1 , arg3 , arg5 ) -> ()
| QUADRUPLE(P_MINUSCOLON, arg1, arg3, arg5 ) -> ()
| ASCNUM arg1 -> ()
| FLOATNUM arg1 -> ()
| _ -> ignore(unhandled out_chan expr);
ignore(Stack.pop stk);;

let rec semantics out_chan (stem:string) (tree:Globals.modtree) =
   let exp = tree.Globals.tree and syms = tree.Globals.symbols in Stack.push exp stk; match exp with
(* These patterns are temporary till we decide on the proper general form *)
|  DOUBLE
    (DOUBLE (AT, TLIST sens_list), stmt)
-> iter (fun item -> senitem out_chan stem syms item) sens_list; ( match stmt with
  | TRIPLE (BEGIN, TLIST stmts, EMPTY)
    -> iter_ semantics out_chan stem syms stmts
  | TLIST stmts
    -> iter_ semantics out_chan stem syms stmts
  | _ -> stmtBlock out_chan stem syms stmt )
| DOUBLE((INITIAL|FINAL|ALWAYS), stmt)
-> ( match stmt with
  | TRIPLE (BEGIN, TLIST stmts, EMPTY)
    -> iter_ semantics out_chan stem syms stmts
  | TLIST stmts
    -> iter_ semantics out_chan stem syms stmts
  | _ -> stmtBlock out_chan stem syms stmt )
| DOUBLE(FOREVER, stmt)
-> ( match stmt with
  | TRIPLE (BEGIN, TLIST stmts, EMPTY)
    -> iter_ semantics out_chan stem syms stmts
  | TLIST stmts
    -> iter_ semantics out_chan stem syms stmts
  | _ -> stmtBlock out_chan stem syms stmt )
| TRIPLE(REPEAT, INTNUM iter, stmt)
-> ( match stmt with
  | TRIPLE (BEGIN, TLIST stmts, EMPTY)
    -> iter_ semantics out_chan stem syms stmts
  | TLIST stmts
    -> iter_ semantics out_chan stem syms stmts
  | _ -> stmtBlock out_chan stem syms stmt )
| TRIPLE(WHILE, expr, stmt)
-> ignore(exprGeneric out_chan stem syms expr); ( match stmt with
  | TRIPLE (BEGIN, TLIST stmts, EMPTY)
    -> iter_ semantics out_chan stem syms stmts
  | TLIST stmts
    -> iter_ semantics out_chan stem syms stmts
  | _ -> stmtBlock out_chan stem syms stmt )
| DOUBLE(SPECIFY, TLIST speclist) -> iter (fun item -> match item with ID id -> enter_a_sym out_chan syms (stem^id) SPECIFY EMPTY| _ -> ()) speclist
| TRIPLE(ASSIGN, EMPTY, TLIST assignlist)
-> iter (fun a -> match a with TRIPLE (EQUALS, var1, expr) ->
    ignore(subexp out_chan RECEIVER stem syms var1);
    ignore(exprGeneric out_chan stem syms expr) | _ -> unhandled out_chan a) assignlist
| TRIPLE(EQUALS, TLIST arg1, TLIST arg2) -> iter_ semantics out_chan stem syms arg1; iter_ semantics out_chan stem syms arg2
| TRIPLE(IF, expr, then_clause) ->
exprGeneric out_chan stem syms expr;
stmtBlock out_chan stem syms then_clause
| TRIPLE(PLUS, TLIST arg1, TLIST arg2) -> iter_ semantics out_chan stem syms arg1; iter_ semantics out_chan stem syms arg2
| TRIPLE(BUF, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, EMPTY, x, a) -> vbuf out_chan stem syms x a
      | _ -> unhandled out_chan inst) instances
| TRIPLE(NOT,dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, EMPTY, x, a) -> vnot out_chan stem syms x a
      | _ -> unhandled out_chan inst) instances
| TRIPLE(AND, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, EMPTY, x, TLIST inlist) -> vand out_chan stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(OR, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, EMPTY, x, TLIST inlist) -> vor out_chan stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(XOR, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, EMPTY, x, TLIST inlist) -> vxor out_chan stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(NAND, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, EMPTY, x, TLIST inlist) -> vand out_chan stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(NOR, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, EMPTY, x, TLIST inlist) -> vor out_chan stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(XNOR, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, EMPTY, x, TLIST inlist) -> vxor out_chan stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(BUFIF lev, weaklist, TLIST instances) ->
    iter (fun inst -> match inst with
      | DOUBLE (x, TLIST inlist) -> vbufif out_chan stem syms x inlist
      | _ -> unhandled out_chan inst) instances
| TRIPLE(PULLUP, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | TRIPLE(EMPTY, EMPTY, x) -> vpullup out_chan stem syms x
      | _ -> unhandled out_chan inst) instances
| TRIPLE(NMOS, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | TRIPLE(pin1, pin2, pin3) -> vnmos out_chan stem syms pin1 pin2 pin3
      | _ -> unhandled out_chan inst) instances
| TRIPLE(PMOS, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | TRIPLE(pin1, pin2, pin3) -> vpmos out_chan stem syms pin1 pin2 pin3
      | _ -> unhandled out_chan inst) instances
| TRIPLE(TRANIF lev, weaklist, TLIST instances) ->
    iter (fun inst -> match inst with
      | TRIPLE(pin1, pin2, pin3) -> vtranif out_chan stem syms pin1 pin2 pin3
      | _ -> unhandled out_chan inst) instances
| TRIPLE(TRAN, weaklist, TLIST instances) ->
    iter (fun inst -> match inst with
      | DOUBLE(pin1, pin2) -> vtran out_chan stem syms pin1 pin2
      | _ -> unhandled out_chan inst) instances
(* Parse primitive instance *)
| QUADRUPLE(PRIMINST, ID prim, EMPTY, TLIST inlist) ->
(*
    if (Hashtbl.mem Globals.modprims prim) then
      semantics out_chan (stem^prim^".") (Hashtbl.find Globals.modprims prim) (* scan the inner primitive *)
    else printf "Primitive %s not found\n" prim;
*)
    enter_a_sym out_chan syms prim PRIMITIVE EMPTY;
    let fc inner t = connect out_chan stem syms prim prim inner t in 
    ( match (Hashtbl.find Globals.modprims prim).Globals.tree with QUINTUPLE(PRIMITIVE,ID arg1, EMPTY, TLIST primargs, TLIST arg4) ->
iter2 fc primargs inlist | _ -> ())
(* Parse module instance *)
| QUADRUPLE(MODINST, ID kind,params, TLIST instances) ->
    begin
    enter_a_sym out_chan syms kind SUBMODULE EMPTY;
    let kindhash = Hashtbl.find Globals.modprims kind in
    iter (fun inst -> match inst with
      | TRIPLE (ID subcct, SCALAR, TLIST termlist) -> (* semantics out_chan (stem^subcct^".") kindhash; *)
        enter_a_sym out_chan syms subcct SUBCCT EMPTY;
        ( match kindhash.Globals.tree with QUINTUPLE((MODULE|PRIMITIVE),ID arg1, EMPTY, TLIST primargs, TLIST arg4) ->
        (try iter2 (fun (inner:token) (term:token) -> fiter out_chan stem syms kind subcct inner term) primargs termlist; with Invalid_argument "List.iter2" -> let ids = ref [] and partlist = ref ([],[])and byposn = ref false in begin
iter (fun (inner:token) -> (match inner with
| ID id -> ids := (!ids @ [id])
| QUINTUPLE ((INPUT|OUTPUT|INOUT), EMPTY, EMPTY, range, DOUBLE (ID id, EMPTY)) -> ids := (!ids @ [id])
| _ -> unhandled out_chan inner)) primargs;
let primstr = !ids in try iter2 (fun (innert:string) (term:token) -> (match term with
| DOUBLE (CELLPIN, ID innern) -> () (*Explicitly unconnected pin*)
| TRIPLE (CELLPIN, ID innern, tok) -> ids := filter (fun item -> item<>innern) !ids
| _ -> byposn := true; ids := filter (fun item -> item<>innert) !ids)) primstr termlist;
with Invalid_argument "List.iter2" -> ();
if (!byposn) then begin
  fprintf out_chan "sub-module %s of kind %s deprecated connect by position - %d unconnected pins(s) - might be " subcct kind (length (!ids));
  iter (fun id -> fprintf out_chan "%s " id) (!ids);
  output_char out_chan '\n';
end;
(* Find which of the unconnected pins are inputs *)
partlist := partition (fun inner -> 
(Hashtbl.mem kindhash.symbols inner) && (TokSet.mem INPUT (Hashtbl.find kindhash.symbols inner).symattr)
) !ids;
if (length (fst(!partlist)) > 0) then begin
fprintf out_chan "sub-module %s of kind %s insufficient args - %d unconnected inputs(s): " subcct kind (length (fst(!partlist)));
iter (fun id -> fprintf out_chan "%s " id) (fst(!partlist));
output_char out_chan '\n';
end
end)
        | _ -> unhandled out_chan kindhash.Globals.tree)
      | _ -> unhandled out_chan inst) instances;
    match params with
    | EMPTY -> ()
    | TLIST parmlist -> iter (fun param -> match param with ID id -> () | _ -> unhandled out_chan param) parmlist
    | _ -> unhandled out_chan params
    end
| QUADRUPLE(ASSIGN, var1, EMPTY, expr)
-> ignore(subexp out_chan RECEIVER stem syms var1);
   ignore(exprGeneric out_chan stem syms expr)
| QUADRUPLE(ASSIGNMENT, var1, EMPTY, expr)
-> ignore(subexp out_chan RECEIVER stem syms var1);
   ignore(exprGeneric out_chan stem syms expr)
| QUADRUPLE(EQUALS, TLIST arg1, TLIST arg2, TLIST arg3) ->
  iter_ semantics out_chan stem syms arg1;
  iter_ semantics out_chan stem syms arg2;
  iter_ semantics out_chan stem syms arg3
| QUADRUPLE(IF, expr, then_clause, else_clause) ->
exprGeneric out_chan stem syms expr;
stmtBlock out_chan stem syms then_clause;
stmtBlock out_chan stem syms else_clause
| QUINTUPLE(FOR, TRIPLE(ASSIGNMENT,ID idstart, start), test, TRIPLE(ASSIGNMENT,ID idinc,inc), clause) ->
if idstart <> idinc then fprintf out_chan "For variable not consistent %s vs. %s\n" idstart idinc;
exprGeneric out_chan stem syms start;
exprGeneric out_chan stem syms test;
exprGeneric out_chan stem syms inc;
stmtBlock out_chan stem syms clause
(* Parse wire/reg declarations *)
| QUADRUPLE((WIRE|REG) as kind, arg1, arg2, TLIST arg3) ->
    let width = ref SCALAR in begin
    semantics out_chan stem {Globals.unresolved=[]; tree=arg1; symbols=syms};
    (match arg2 with
      | RANGE(hi, lo) as rangehilo -> width := rangehilo
      | TRIPLE(EMPTY,(RANGE(hi, lo) as rangehilo),EMPTY) -> width := rangehilo
      | TLIST arg7 ->  List.iter (fun arg -> unhandled out_chan arg) arg7
      | EMPTY -> ()
      | TRIPLE(EMPTY,EMPTY,EMPTY) -> ()
      | _ ->  unhandled out_chan arg2);
    ( List.iter (fun x -> match x with
      | TRIPLE(id, arg5, arg6) -> enter_sym_attrs out_chan stem syms id [kind;RECEIVER] !width;
          exprGeneric out_chan stem syms arg6;
      | DOUBLE(id, EMPTY) -> enter_sym_attrs out_chan stem syms id [kind] !width
      | _ -> unhandled out_chan x) arg3); end
| QUADRUPLE((REAL|INTEGER|EVENT) as kind, arg1, arg2, TLIST arg3) ->
    semantics out_chan stem {Globals.unresolved=[]; tree=arg1; symbols=syms};
    (match arg2 with
      | EMPTY -> ()
      | TRIPLE(EMPTY,EMPTY,EMPTY) -> ()
      | _ ->  unhandled out_chan arg2);
    ( List.iter (fun x -> match x with
      | TRIPLE(id, arg5, arg6) -> enter_sym_attrs out_chan stem syms id [kind] EMPTY
      | _ -> unhandled out_chan x) arg3)
| QUINTUPLE(NAMED, ID blk_named, TLIST [], TLIST stmts, EMPTY) ->
 iter (fun item -> semantics out_chan stem {Globals.unresolved=[]; tree=item; symbols=syms}) stmts
(* Parse module declarations *)
| QUINTUPLE(MODULE,ID arg1, arg2, TLIST arg3, TLIST arg4) ->
    enter_a_sym out_chan syms arg1 MODULE SCALAR; (* print_endline (stem^arg1); *)
    semantics out_chan stem {Globals.unresolved=[]; tree=arg2; symbols=syms};
    iter (fun arg -> match arg with
| ID id -> enter_a_sym out_chan syms id IOPORT UNKNOWN
| _ -> semantics out_chan stem {Globals.unresolved=[]; tree=arg; symbols=syms}) arg3;
    iter_ semantics out_chan stem syms arg4
(* Parse primitive declarations *)
| QUINTUPLE(PRIMITIVE,ID arg1, EMPTY, TLIST primargs, TLIST arg4) ->
    enter_a_sym out_chan syms arg1 PRIMITIVE EMPTY;
    iter (fun arg -> match arg with
| ID id -> enter_a_sym out_chan syms id IOPORT UNKNOWN
| _ -> semantics out_chan stem {Globals.unresolved=[]; tree=arg; symbols=syms}) primargs;
    iter_ semantics out_chan stem syms arg4
(* Parse IO declarations *)
| QUINTUPLE((INPUT|OUTPUT|INOUT) as dir, arg1, arg2, arg3, arg4) ->
    let width = ref SCALAR in begin
    semantics out_chan stem {Globals.unresolved=[]; tree=arg1; symbols=syms};
    semantics out_chan stem {Globals.unresolved=[]; tree=arg2; symbols=syms};
    (match arg3 with
      | RANGE(hi,lo) as rangehilo -> width := rangehilo
      | TLIST arg9 ->  List.iter (fun arg -> unhandled out_chan arg) arg9
      | EMPTY -> ()
      | _ -> unhandled out_chan arg3);
    ( match arg4 with
      | DOUBLE(id, arg5) -> enter_sym_attrs out_chan stem syms id [IOPORT;dir] !width
      | TRIPLE(id, TLIST arg5, TLIST arg6) -> enter_sym_attrs out_chan stem syms id [IOPORT;dir] !width
      | TLIST arg9 ->  List.iter (fun x -> match x with TRIPLE(id, arg5, arg6) -> enter_sym_attrs out_chan stem syms id [IOPORT;dir] !width | _ -> unhandled out_chan x) arg9
      | EMPTY -> ()
      | _ -> unhandled out_chan arg4); end
(* Parse parameter declarations *)
| QUADRUPLE(PARAMETER, EMPTY, EMPTY, decls) ->
    let width = ref EMPTY in begin
    ( match decls with
      | TLIST arg9 ->  List.iter (fun x -> match x with TRIPLE(id, arg5, arg6) -> enter_sym_attrs out_chan stem syms id [PARAMETER] !width | _ -> unhandled out_chan x) arg9
      | EMPTY -> ()
      | _ -> unhandled out_chan decls); end
(* Parse function declarations *)
| OCTUPLE(FUNCTION, EMPTY, EMPTY, ID funcname, EMPTY, TLIST args, TLIST stmts, EMPTY) ->
enter_a_sym out_chan syms funcname FUNCTION EMPTY;
iter (fun arg -> semantics out_chan stem {Globals.unresolved=[]; tree=arg; symbols=syms}) args;
iter_ semantics out_chan stem syms stmts
(* Parse task declarations *)
| SEPTUPLE(TASK, EMPTY, ID taskname, EMPTY, TLIST args, TLIST stmts, EMPTY) ->
let stem2 = stem^taskname^"." in (
enter_a_sym out_chan syms taskname TASK exp;
iter (fun arg -> semantics out_chan stem2 {Globals.unresolved=[]; tree=arg; symbols=syms}) args;
iter_ semantics out_chan stem2 syms stmts )
(* Parse task reference *)
| TRIPLE (TASKREF, task, args) -> ( match task with
  | ID taskname ->
  let stem2 = stem^taskname^"." in begin
    if (Hashtbl.mem syms taskname) then
      semantics out_chan stem2 {Globals.unresolved=[]; tree=(Hashtbl.find syms taskname).width; symbols=syms} (* scan the task *)
    else printf "Task %s not found\n" taskname;
end
  | DOTTED path -> iter (fun name -> match name with ID id -> Printf.printf "%s." id | _ -> ()) path;
    Printf.printf "\n"
  | _ -> ()
 )
(* Parse case statement *)
| TRIPLE (CASECOND, TLIST thecases, stmt) ->
iter (fun pattern -> exprGeneric out_chan stem syms pattern) thecases;
stmtBlock out_chan stem syms stmt
| QUADRUPLE (CASE, expr, caseAttr, TLIST caseList) ->
exprGeneric out_chan stem syms expr;
iter (fun caseitem -> semantics out_chan stem {Globals.unresolved=[]; tree=caseitem; symbols=syms}) caseList
| QUADRUPLE (P_LTE, dest, dly, exp) ->
exprGeneric out_chan stem syms exp;
ignore(subexp out_chan RECEIVER stem syms dest)
| QUINTUPLE(MODULE,ID arg1, EMPTY, EMPTY, EMPTY) -> enter_a_sym out_chan syms arg1 MODULE EMPTY
| RANGE(arg1, arg2) -> semantics out_chan stem {Globals.unresolved=[]; tree=arg1; symbols=syms}; semantics out_chan stem {Globals.unresolved=[]; tree=arg2; symbols=syms}
| ID id -> enter_a_sym out_chan syms id EMPTY EMPTY
| DOUBLE(SPECIFY,EMPTY) -> ()
| TRIPLE(D_DISPLAY, ASCNUM msg, args) -> ()
| DOUBLE(D_MONITOR, TLIST args) -> ()
| DOUBLE(D_FINISH, EMPTY) -> ()
| DOUBLE (P_MINUSGT, ev) -> ()
| DOUBLE (DOUBLE (HASH, FLOATNUM dly), stmt) -> semantics out_chan stem {Globals.unresolved=[]; tree=stmt; symbols=syms}
| PREPROC txt -> ()
| DOUBLE(TABLE, TLIST trows) ->
iter (fun row -> match row with
| DOUBLE(TLIST tin,TLIST tout) -> ()
| TRIPLE(TLIST tin,TLIST treg,TLIST tout) -> ()
| _ -> unhandled out_chan row
) trows;
| EMPTY -> ()
| _ -> unhandled out_chan exp

and stmtBlock out_chan stem syms block = match block with
| EMPTY -> ()
| TLIST stmtList -> iter (fun item -> semantics out_chan stem {Globals.unresolved=[]; tree=item; symbols=syms}) stmtList
| TRIPLE(BEGIN, TLIST stmtList, endLabelE) -> iter (fun item -> semantics out_chan stem {Globals.unresolved=[]; tree=item; symbols=syms}) stmtList
| _ -> semantics out_chan stem {Globals.unresolved=[]; tree=block; symbols=syms};

and subexp out_chan dir stem syms exp = match exp with
| ID id -> enter_sym_attrs out_chan stem syms exp [dir] UNKNOWN
| TRIPLE (BITSEL, ID id, sel) -> enter_sym_attrs out_chan stem syms (ID id) [dir] UNKNOWN
| _ -> exprGeneric out_chan stem syms exp

(*and subexp2 out_chan dir stem syms exp = {entry=exp; symbol=(subexp out_chan dir stem syms exp)}

and expr_dyadic out_chan dir stem syms op left right = DYADIC(op, subexp2 out_chan dir stem syms left, subexp2 out_chan dir stem syms right)
*)
and vtran out_chan stem syms x y =
iter(fun x -> ignore(subexp out_chan RECEIVER stem syms x)) [x;y]

and vtranif out_chan stem syms x y z =
iter(fun x -> ignore(subexp out_chan RECEIVER stem syms x)) [x;y;z]

and vnmos out_chan stem syms x y z =
iter(fun x -> ignore(subexp out_chan RECEIVER stem syms x)) [x;y;z]

and vpmos out_chan stem syms x y z =
iter(fun x -> ignore(subexp out_chan RECEIVER stem syms x)) [x;y;z]

and vpullup out_chan stem syms (x:token) =
ignore(subexp out_chan RECEIVER stem syms x)

and vbuf out_chan stem syms (x:token) a =
ignore(subexp out_chan RECEIVER stem syms x);
ignore(subexp out_chan DRIVER stem syms a)

and vbufif out_chan stem syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER stem syms x);
iter (fun t -> ignore(subexp out_chan DRIVER stem syms t)) inlist

and vnot out_chan stem syms (x:token) a =
ignore(subexp out_chan RECEIVER stem syms x);
iter (fun w -> ignore(subexp out_chan DRIVER stem syms w)) [x;a]

and vand out_chan stem syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER stem syms x);
iter (fun t -> ignore(subexp out_chan DRIVER stem syms t)) inlist

and vor out_chan stem syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER stem syms x);
iter (fun t -> ignore(subexp out_chan DRIVER stem syms t)) inlist

and vxor out_chan stem syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER stem syms x);
iter (fun t -> ignore(subexp out_chan DRIVER stem syms t)) inlist

and vnand out_chan stem syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER stem syms x);
iter (fun t -> ignore(subexp out_chan DRIVER stem syms t)) inlist

and vnor out_chan stem syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER stem syms x);
iter (fun t -> ignore(subexp out_chan DRIVER stem syms t)) inlist

and vxnor out_chan stem syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER stem syms x);
iter (fun t -> ignore(subexp out_chan DRIVER stem syms t)) inlist

and senitem out_chan stem syms item = match item with
| DOUBLE(POSEDGE, clk) -> ignore(subexp out_chan DRIVER stem syms clk)
| DOUBLE(NEGEDGE, clk) -> ignore(subexp out_chan DRIVER stem syms clk)
| ID signal -> ignore(subexp out_chan DRIVER stem syms item)
| _ -> unhandled out_chan item

let dotted s = try String.index s '.' > 0 ; with Not_found -> false;;

let erc_chk out_chan nam s = let sym = s.symattr in
  begin
	begin
	  if (TokSet.mem INPUT sym) && not (TokSet.mem DRIVER sym) then
	    Printf.fprintf out_chan "%s is a dangling input\n" nam
	  else if (TokSet.mem OUTPUT sym) && not (TokSet.mem RECEIVER sym) then
	    Printf.fprintf out_chan "%s is a dangling output\n" nam
	  else if (TokSet.mem INOUT sym) then
	    Printf.fprintf out_chan "%s is a inout\n" nam
	  else if (TokSet.mem WIRE sym) && not ((TokSet.mem RECEIVER sym) || (TokSet.mem SPECIFY sym)) then
	    Printf.fprintf out_chan "%s is a dangling wire\n" nam
	end
  end
;;

let check_syms out_chan syms = Hashtbl.iter (fun nam s -> erc_chk out_chan nam s) syms;;

exception Error

type logt = Closed | Open of out_channel;;

let pending = Hashtbl.create 256;;

let logfile = ref Closed;;

let scan out_chan key contents = begin
Hashtbl.add Globals.modprims key contents;
Printf.fprintf out_chan "scanning ..\n";
semantics out_chan "" contents;
check_syms out_chan contents.Globals.symbols;
end

let rec remove_from_pending out_chan mykey =  let reslist = ref [] in begin
		Hashtbl.iter (fun key contents ->
contents.Globals.unresolved <- List.filter(fun item -> item <> mykey) contents.Globals.unresolved;
if contents.Globals.unresolved == [] then (
			Printf.fprintf out_chan "module %s: resumed " key;
			scan out_chan key contents; reslist := key :: !reslist)) pending;
			List.iter (fun key -> Hashtbl.remove pending key; remove_from_pending out_chan key) !reslist;
			end

let prescan kind mykey expt =
	if (!logfile == Closed) then logfile := Open (open_out "report.report");
	match !logfile with Open out_chan -> begin
	Printf.fprintf out_chan "%s %s: parsed " kind mykey;
	if (List.length(!unresolved_list)==0) then begin
		scan out_chan mykey expt;
		remove_from_pending out_chan mykey;
		end
	else begin
		Printf.fprintf out_chan "pending: not yet encountered: ";
		List.iter (fun key -> Printf.fprintf out_chan "%s " key) !unresolved_list;
		output_char out_chan '\n';
		Hashtbl.add pending mykey expt;
		unresolved_list := [];
	end;
	flush out_chan;
	end
	| Closed -> raise Error
;;

let rec endscan indent (mykey:string) =
	match !logfile with Open out_chan -> begin
        for i = 1 to indent do output_char out_chan ' '; done;
	Printf.fprintf out_chan "Checking %s: " mykey;
	if (Hashtbl.mem pending mykey) then
          begin
	  Printf.fprintf out_chan "Module %s still postponed\n" mykey;
	  List.iter (fun key -> if (Hashtbl.mem pending key) then endscan (indent+2) key
          else Printf.fprintf out_chan "%s " key) ((Hashtbl.find pending mykey).Globals.unresolved);
 	  output_char out_chan '\n';
          end
	end
	| Closed -> raise Error
;;

(*
let moditer k (x:Globals.modtree) = semantics out_chan k x

let find_glob s = Setup.show_sym s ( Hashtbl.find s);;

let find_glob_substr s = let reg = Str.regexp s in Hashtbl.iter (fun k x -> try Printf.printf "%s posn %d\n" k (Str.search_forward reg k 0); with not_found out_chan -> ()) gsyms;;

let find_referrer s = Setup.show_sym s (match (Hashtbl.find s).referrer with Referrer lk -> lk | Nil -> nullsym);;
*)
