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
| ASSIGNS of (exprtree * exprt)
| UNHANDLED of token
;;

type uptr = UPTR of (out_channel -> int -> Vparser.token -> unit) | UNIL;;

type dmode = Pundef | PATH;;

let stk = Stack.create();;

let unhand_list = ref [(0,EMPTY)];;

let unhandled_dflt out_chan ln argt = let arg = (ln,argt) in if (List.mem arg !unhand_list == false) then begin
unhand_list := arg :: !unhand_list;
fprintf out_chan "\n\n**** Unhandled %d ****\n" (List.length !unhand_list);
Dump.dump out_chan argt 0
end

let unhandled_ptr = ref (UPTR unhandled_dflt);;

let unhandled out_chan ln arg = match !unhandled_ptr with UPTR fn -> fn out_chan ln arg | UNIL -> ();;

let last_mod = ref "";;
let timescale = ref "";;
let delay_mode = ref Pundef;;
let mod_empty = ref true;;

let celldefine = ref false and portfaults = ref false and suppress_faults = ref false and protect = ref false;;

(* these functions are for debugging symbol hash related issues *)

let shash_add syms (key:string) (sym:symtab) = Hashtbl.add syms key sym;;
let shash_create (siz:int) = Hashtbl.create siz;;
let shash_find syms (key:string) = Hashtbl.find syms key;;
let shash_iter (f:string -> Setup.symtab -> unit) syms = Hashtbl.iter f syms;;
let shash_mem syms (key:string) = Hashtbl.mem syms key;;
let shash_remove syms (key:string) = Hashtbl.remove syms key;;
let shash_replace syms (key:string) (sym:symtab) = Hashtbl.replace syms key sym;;

let find_param out_chan syms pth = begin
if shash_mem syms pth == false then begin
(*  fprintf out_chan "Creating implicit param %s\n" (stem^id);  *)
  shash_add syms pth {Setup.symattr = TokSet.singleton PARAMETER;
                       width = SCALAR;
		       sigattr = Sigparam (INT 1);
		       path=pth}
  end;
shash_find syms pth
end
;;

let rec exprBoolean out_chan stem syms op expr1 expr2 =
op (exprConst out_chan stem syms expr1) (exprConst out_chan stem syms expr2)

and exprConst out_chan stem syms expr = Stack.push (stem, 67, expr) stk; let rslt = ( match expr with
| INT n -> n
| TRIPLE(TIMES, expr1, expr2) -> (exprConst out_chan stem syms expr1) * (exprConst out_chan stem syms expr2)
| TRIPLE(PLUS, expr1, expr2) -> (exprConst out_chan stem syms expr1) + (exprConst out_chan stem syms expr2)
| TRIPLE(MINUS, expr1, expr2) -> (exprConst out_chan stem syms expr1) - (exprConst out_chan stem syms expr2)
| TRIPLE(P_EQUAL, expr1, expr2) -> if (exprBoolean out_chan stem syms (=)) expr1 expr2 then 1 else 0
| TRIPLE(P_NOTEQUAL, expr1, expr2) -> if (exprBoolean out_chan stem syms (<>)) expr1 expr2 then 1 else 0
| TRIPLE(LESS, expr1, expr2) -> if (exprBoolean out_chan stem syms (<)) expr1 expr2 then 1 else 0
| TRIPLE(GREATER, expr1, expr2) -> if (exprBoolean out_chan stem syms (>)) expr1 expr2 then 1 else 0
| TRIPLE(P_LTE, expr1, expr2) -> if (exprBoolean out_chan stem syms (<=)) expr1 expr2 then 1 else 0
| TRIPLE(P_GTE, expr1, expr2) -> if (exprBoolean out_chan stem syms (>=)) expr1 expr2 then 1 else 0
| ID id -> let pth = stem^id in begin
if shash_mem syms pth == false then begin
  if shash_mem syms id == false then begin
    unhandled out_chan 81 expr;
    fprintf out_chan "constant %s not declared, value 1 assumed\n" pth;
    1
    end
  else
    match (shash_find syms id).sigattr with
    | Sigparam pexpr -> exprConst out_chan stem syms pexpr
    | Sigarray x -> fprintf out_chan "%s not a constant or for variable, value 1 assumed\n" id; 1
    | _ -> unhandled out_chan 89 expr; 1
  end
else
  match (shash_find syms pth).sigattr with
  | Sigparam pexpr -> exprConst out_chan stem syms pexpr
  | Sigarray x -> fprintf out_chan "%s not a constant or for variable, value 1 assumed\n" pth; 1
  | _ -> unhandled out_chan 95 expr; 1
end
| TRIPLE(FUNCREF, ID id, TLIST args) -> fprintf out_chan "%s is a function, value 1 assumed\n" id; 1
| QUADRUPLE(PARTSEL, arg, INT hi, INT lo) -> (exprConst out_chan stem syms arg) lsr lo
| _ -> unhandled out_chan 97 expr; 1 ) in
ignore(Stack.pop stk);
rslt

let iwidth out_chan stem syms wid =  match wid with 
| RANGE(expr1, expr2) -> (exprConst out_chan stem syms expr1,exprConst out_chan stem syms expr2)
| UNKNOWN -> (0,0)
| SCALAR -> (0,0)
| EMPTY -> (0,0)
| _ -> unhandled out_chan 56 wid; (-1,-1)

let maxwidth out_chan stem syms neww = let w = iwidth out_chan stem syms neww in
1 + (max (fst w) (snd w))
;;

let create_attr out_chan stem syms neww = 
 Sigarray (Array.make (maxwidth out_chan stem syms neww) TokSet.empty)

let enter_a_sym out_chan stem symbols id attr w = let pth = stem^id in match attr with
(IOPORT|INPUT|OUTPUT|INOUT|REG|WIRE|INTEGER|REAL|MEMORY|EVENT
 |MODULE|PRIMITIVE|SUBMODULE|SUBCCT|SPECIFY|SPECIAL|PARAMUSED
 |PARAMETER|TASK|FUNCTION) ->
if shash_mem symbols pth then begin
(*  printf "Update %s: %s\n" pth (Ord.getstr attr); *)
  let newset = (shash_find symbols pth).symattr
  and oldw = (shash_find symbols pth).width
  and oldsattr = (shash_find symbols pth).sigattr in
  if (oldw<>UNKNOWN)&&(oldw<>w)&&(w<>UNKNOWN) then
    Printf.fprintf out_chan "Addition of attribute %s to signal %s changed width from %s to %s\n"
      (str_token attr) pth (str_token oldw) (str_token w);
  if (w<>UNKNOWN) then
  shash_replace symbols pth
    {Setup.symattr = (TokSet.add attr newset);
    width = w;
    sigattr = create_attr out_chan stem symbols w;
    path=pth}
  else shash_replace symbols pth
    {Setup.symattr = (TokSet.add attr newset);
    width = oldw;
    sigattr = oldsattr;
    path=pth};
    end
else begin
(*  printf "Enter %s: %s\n" pth (Ord.getstr attr); *)
  shash_add symbols pth {Setup.symattr = (TokSet.singleton attr);
     width = w;
     sigattr = create_attr out_chan stem symbols w;
     path=pth}
  end
| _ -> unhandled out_chan 86 attr
;;

let iter_ semantics out_chan (stem:string) syms list =
  List.iter (fun x -> semantics out_chan stem ({Globals.unresolved=[]; tree=x; symbols=syms})) list
;;

let not_found out_chan stem syms w = printf "wire/port %s not found\n" w; enter_a_sym out_chan stem syms w IMPLICIT SCALAR;;

let find_ident out_chan dir stem syms tok = match tok with ID id -> let pth = stem^id in begin
if shash_mem syms pth == false then begin
(*  fprintf out_chan "Creating implicit wire %s\n" (stem^id);  *)
  shash_add syms pth {Setup.symattr = TokSet.singleton IMPLICIT;
                       width = SCALAR;
		       sigattr = create_attr out_chan stem syms SCALAR;
		       path=pth}
  end;
shash_find syms pth
end
| _ -> unhandled out_chan 118 tok; ({Setup.symattr = TokSet.singleton tok; width = EMPTY; sigattr = create_attr out_chan stem syms SCALAR; path=""})
;;

let enter_sym_attrs out_chan stem symbols (tok:token) list width = match tok with
| ID id -> iter (fun x -> enter_a_sym out_chan stem symbols id x width) list;
  let newset = (find_ident out_chan WIRE stem symbols tok).symattr in
    begin
     if (TokSet.mem INPUT newset) && (TokSet.mem REG newset) then 
       Printf.fprintf out_chan "Signal %s cannot be input and reg\n" id;
    end
| _ -> unhandled out_chan 128 tok;
;;

let enter_parameter out_chan stem syms id arg5 arg6 w = let pth = stem^id in
(*
Dump.dump out_chan arg5 0;
Dump.dump out_chan arg6 0;
*)
  shash_add syms pth {Setup.symattr = (TokSet.singleton PARAMETER);
     width = w;
     sigattr = Sigparam arg6;
     path=pth}

let enter_a_sig_attr out_chan (stem:string) symbols (tok:token) attr w = match tok with 
| ID id -> let sym = find_ident out_chan WIRE stem symbols tok in (match sym.sigattr with
| Sigarray attrs -> (
match w with
| RANGE range -> let (hi,lo) = iwidth out_chan stem symbols w in
  if not ((TokSet.mem IMPLICIT sym.symattr)||(TokSet.mem MEMORY sym.symattr)) then
  ( try for i = hi downto lo do
    attrs.(i) <- TokSet.add attr attrs.(i);
    done;
  with Invalid_argument("index out of bounds") -> fprintf out_chan "Trying to access %s with index [%d:%d]\n" id hi lo)
| SCALAR ->
    attrs.(0) <- TokSet.add attr attrs.(0);
| _ -> unhandled out_chan 98 w)
| Sigparam x -> enter_sym_attrs out_chan stem symbols tok [PARAMUSED] UNKNOWN
(*
| Sigundef -> printf "Internal error - Signal %s has no width\n" id
| Sigtask x -> printf "Internal error - Signal %s is already declared as a task\n" id
*)
| _ -> unhandled out_chan 173 tok)
| _ -> unhandled out_chan 175 tok
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
  let hier = ID (stem^wireport) and compat=ref false in 
  begin
  if (sym.width <> wid) then
    begin
    match wid with
    | RANGE(INT x, INT y) -> if ((x==y) && (sym.width == EMPTY)) then compat := true;
    | _ -> ();
    match sym.width with
    | RANGE(INT x, INT y) -> if ((x==y) && (wid == EMPTY)) then compat := true;
    | _ -> ();
    if (!compat == false) then begin
      fprintf out_chan "Width mismatch stem=%s subcct=%s inner=%s %s wireport=%s %s\n"
          stem subcct inner (Setup.str_token sym.width) wireport (str_token(wid)); 
      end
    end;
  if (TokSet.mem IOPORT sym.symattr == false) then printf "Instance port %s not an ioport\n" inner
  else if (TokSet.mem INPUT sym.symattr) then ( enter_a_sig_attr out_chan stem syms hier DRIVER wid)
  else if (TokSet.mem OUTPUT sym.symattr) then ( enter_a_sig_attr out_chan stem syms hier RECEIVER wid)
  else if (TokSet.mem INOUT sym.symattr) then ( enter_a_sig_attr out_chan stem syms hier BIDIR wid)
  end
end

let inner_chk_const out_chan stem syms sym subcct inner (tok:token) wid = begin
  let compat=ref false in 
  begin
  if (sym.width <> wid) then
    begin
    match wid with
    | RANGE(INT x, INT y) -> if ((x==y) && (sym.width == EMPTY)) then compat := true;
    | _ -> ();
    match sym.width with
    | RANGE(INT x, INT y) -> if ((x==y) && (wid == EMPTY)) then compat := true;
    | _ -> ();
    if (!compat == false) then begin
      fprintf out_chan "Width mismatch stem=%s subcct=%s inner=%s %s const=%s %s\n"
          stem subcct inner (Setup.str_token sym.width) (str_token tok) (str_token(wid)); 
      end
    end;
  if (TokSet.mem IOPORT sym.symattr == false) then printf "Instance port %s not an ioport\n" inner
  else if (TokSet.mem INPUT sym.symattr) then ()
  else if (TokSet.mem OUTPUT sym.symattr) then fprintf out_chan "Output port %s cannot connect to constant\n" inner
  else if (TokSet.mem INOUT sym.symattr) then fprintf out_chan "Output port %s cannot connect to constant\n" inner
  end
end

let rec connect out_chan stem syms kind subcct (innert:token) tok = 
let innersym = (shash_find Globals.modprims kind).symbols in match innert with ID inner -> begin
if (shash_mem innersym inner) then
let isym=shash_find innersym inner in match tok with
| ID wireport -> inner_chk out_chan stem syms isym subcct inner wireport (find_ident out_chan WIRE stem syms tok).width
| TRIPLE(BITSEL, ID wireport, INT sel) -> if (shash_mem syms wireport) then inner_chk out_chan stem syms isym subcct inner wireport (RANGE (INT sel, INT sel)) else not_found out_chan stem syms wireport
| QUADRUPLE(PARTSEL, ID wireport, INT hi, INT lo) -> if (shash_mem syms wireport) then inner_chk out_chan stem syms isym subcct inner wireport (RANGE(INT hi, INT lo)) else not_found out_chan stem syms wireport
| INT lev -> inner_chk_const out_chan stem syms isym subcct inner tok (RANGE(INT 31, INT 0))
| BINNUM lev -> inner_chk_const out_chan stem syms isym subcct inner tok (RANGE(INT (fst(widthnum 2 lev)-1), INT 0))
| DOUBLE (CONCAT, TLIST concat) -> let idx = ref (fst(iwidth out_chan stem syms isym.width)) in iter (fun (item:token) -> 
(match item with
| ID id -> let wid = (find_ident out_chan WIRE stem syms item).width in begin inner_chk out_chan stem syms {symattr=isym.symattr; width=RANGE(INT !idx, INT !idx); sigattr = create_attr out_chan stem syms SCALAR; path=id} subcct inner id wid; idx := !idx + snd(iwidth out_chan stem syms wid) - fst(iwidth out_chan stem syms wid); end
| TRIPLE (BITSEL, ID id, INT sel) -> inner_chk out_chan stem syms {symattr=isym.symattr; width=RANGE(INT !idx, INT !idx); sigattr = create_attr out_chan stem syms SCALAR; path=id} subcct inner id (RANGE(INT sel, INT sel)); idx := !idx-1
| QUADRUPLE (PARTSEL, ID id, INT hi, INT lo) -> inner_chk out_chan stem syms {symattr=isym.symattr; width=RANGE(INT !idx, INT (!idx+lo-hi)); sigattr = create_attr out_chan stem syms SCALAR; path=id} subcct inner id (RANGE(INT hi, INT lo)); idx := !idx+lo-hi-1
| _ -> unhandled out_chan 224 item)
) concat
| _ -> unhandled out_chan 226 tok
else printf "Instance port %s not found\n" inner
end
| _ -> unhandled out_chan 229 innert
;;

let f2 inner t = show_token(inner);show_token(t);print_char '\n';;

let fiter out_chan (stem:string) syms (kind:string) (subcct:string) (inner:token) (term:token) = match term with
          | DOUBLE (CELLPIN, myinner) -> ()
          | TRIPLE (CELLPIN, myinner, tok) -> connect out_chan stem syms kind subcct myinner tok
          (* connect by position syntax - deprecated *)
          | ID id -> connect out_chan stem syms kind subcct inner term
	  | DOUBLE (CONCAT, TLIST concat) -> connect out_chan stem syms kind subcct inner term
          | QUADRUPLE (PARTSEL, ID net, INT hi, INT lo) -> connect out_chan stem syms kind subcct inner term
	  | _ -> unhandled out_chan 241 term
;;

let rec exprGeneric out_chan stem syms expr = Stack.push (stem, 288, expr) stk; ( match expr with
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
| TRIPLE (CONCAT, arg2, TLIST arg4) -> iter (fun arg -> exprGeneric out_chan stem syms arg) (arg2::arg4)
| DOUBLE (CONCAT, TLIST concat) -> iter (fun arg -> exprGeneric out_chan stem syms arg) concat
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
| INT left -> ()
| BINNUM left -> ()
| DECNUM left -> ()
| HEXNUM left -> ()
| ID arg1 -> enter_a_sig_attr out_chan stem syms expr DRIVER (find_ident out_chan WIRE stem syms expr).width
| TRIPLE(BITSEL, arg1, arg3) -> enter_a_sig_attr out_chan stem syms arg1 DRIVER (RANGE(arg3,arg3))
| QUADRUPLE(PARTSEL, arg1 , arg3 , arg5 ) -> ()
| QUADRUPLE(P_PLUSCOLON, arg1 , arg3 , arg5 ) -> ()
| QUADRUPLE(P_MINUSCOLON, arg1, arg3, arg5 ) -> ()
| ASCNUM arg1 -> ()
| FLOATNUM arg1 -> ()
| DOTTED path -> () (*TBD*)
| _ -> unhandled out_chan 321 expr );
ignore(Stack.pop stk);;

let rec caseitems out_chan stem syms expr = Stack.push (stem, 369, expr) stk; ( match expr with
(* Parse case statement *)
| TRIPLE (CASECOND, TLIST thecases, stmt) ->
iter (fun pattern -> exprGeneric out_chan stem syms pattern) thecases;
stmtBlock out_chan stem syms stmt
| DOUBLE (DEFAULT, stmt) ->
stmtBlock out_chan stem syms stmt
| QUADRUPLE (P_LTE, dest, dly, exp) ->
exprGeneric out_chan stem syms exp;
ignore(subexp out_chan RECEIVER stem syms dest)
| ID id -> enter_a_sym out_chan stem syms id EMPTY EMPTY
| PREPROC txt -> ()
| EMPTY -> ()
| _ -> unhandled out_chan 417 expr );
ignore(Stack.pop stk)

and for_stmt out_chan stem syms id start test inc clause = let pth = stem^id and wid = (find_ident out_chan WIRE stem syms (ID id)).width and crnt = ref (INT (exprConst out_chan stem syms start)) in begin
  shash_add syms pth {Setup.symattr = (TokSet.singleton PARAMETER);
     width = wid;
     sigattr = Sigparam !crnt;
     path=pth};
let loops = ref 0 and unrolling = ref true in while (!unrolling) && (0 <> exprConst out_chan stem syms test) do
    stmtBlock out_chan stem syms clause;
    crnt := INT (exprConst out_chan stem syms inc);
    shash_replace syms pth
      {Setup.symattr = (TokSet.singleton PARAMETER);
      width = wid;
      sigattr = Sigparam !crnt;
      path=pth};
    loops := 1 + !loops;
    if (!loops > 1000) then (unrolling := false; fprintf out_chan "Loop %s unrolling stopped after 1000 iterations\n" id)
done;
shash_remove syms pth ;
end 

(*
| TRIPLE(EQUALS, TLIST arg1, TLIST arg2) -> iter_ semantics out_chan stem syms arg1; iter_ semantics out_chan stem syms arg2
| TRIPLE(PLUS, TLIST arg1, TLIST arg2) -> iter_ semantics out_chan stem syms arg1; iter_ semantics out_chan stem syms arg2
| QUADRUPLE(ASSIGN, var1, EMPTY, expr)
-> ignore(subexp out_chan RECEIVER stem syms var1);
   ignore(exprGeneric out_chan stem syms expr)
| QUADRUPLE(EQUALS, TLIST arg1, TLIST arg2, TLIST arg3) ->
  iter_ semantics out_chan stem syms arg1;
  iter_ semantics out_chan stem syms arg2;
  iter_ semantics out_chan stem syms arg3
| RANGE(arg1, arg2) -> semantics out_chan stem {Globals.unresolved=[]; tree=arg1; symbols=syms}; semantics out_chan stem {Globals.unresolved=[]; tree=arg2; symbols=syms}
*)

and stmtBlock out_chan stem syms block = Stack.push (stem, 465, block) stk; ( match block with
| EMPTY -> ()
| DOUBLE (DISABLE, nam) -> ()
| DOUBLE (P_MINUSGT, ev) -> ()
| DOUBLE (DOUBLE (HASH, FLOATNUM dly), stmt) -> stmtBlock out_chan stem syms stmt
| QUINTUPLE(NAMED, ID blk_named, TLIST [], TLIST stmts, EMPTY) ->
 iter (fun item -> stmtBlock out_chan stem syms item) stmts
| TLIST stmtList -> iter (fun item ->
    stmtBlock out_chan stem syms item) stmtList
| TRIPLE(BEGIN, TLIST stmtList, endLabelE) -> iter (fun item -> stmtBlock out_chan stem syms item) stmtList
|  DOUBLE
    (DOUBLE (AT, TLIST sens_list), stmt)
-> iter (fun item -> senitem out_chan stem syms item) sens_list; ( match stmt with
  | TRIPLE (BEGIN, TLIST stmts, EMPTY)
    -> stmtBlock out_chan stem syms stmt
  | TLIST stmts
    -> stmtBlock out_chan stem syms stmt
  | _ -> stmtBlock out_chan stem syms stmt )
| QUADRUPLE((ASSIGNMENT|DLYASSIGNMENT), var1, dly, expr)
-> ignore(subexp out_chan RECEIVER stem syms var1);
   ignore(exprGeneric out_chan stem syms expr);
(match dly with
  | EMPTY -> ()
  | DOUBLE (HASH, dlytok) -> enter_sym_attrs out_chan stem syms dlytok [PARAMUSED] UNKNOWN
  | _ -> unhandled out_chan 493 dly)
| DOUBLE(FOREVER, stmt) ->
   stmtBlock out_chan stem syms stmt
| TRIPLE(REPEAT, iter, stmt) ->
   stmtBlock out_chan stem syms stmt
| TRIPLE(WHILE, expr, stmt) ->
   ignore(exprGeneric out_chan stem syms expr);
   stmtBlock out_chan stem syms stmt
| TRIPLE(IF, expr, then_clause) ->
exprGeneric out_chan stem syms expr;
stmtBlock out_chan stem syms then_clause
| QUADRUPLE(IF, expr, then_clause, else_clause) ->
exprGeneric out_chan stem syms expr;
stmtBlock out_chan stem syms then_clause;
stmtBlock out_chan stem syms else_clause
| QUINTUPLE(FOR, TRIPLE(ASSIGNMENT,ID idstart, start), test, TRIPLE(ASSIGNMENT,ID idinc,inc), clause) ->
if idstart <> idinc then fprintf out_chan "For variable not consistent %s vs. %s\n" idstart idinc
else for_stmt out_chan stem syms idstart start test inc clause
| QUADRUPLE ((CASE|CASEX|CASEZ), expr, caseAttr, TLIST caseList) ->
exprGeneric out_chan stem syms expr;
iter (fun caseitem -> caseitems out_chan stem syms caseitem) caseList
(* Parse task reference *)
| TRIPLE (TASKREF, task, args) -> ( match task with
  | ID taskname ->
  let stem2 = stem^taskname^"." in begin
    if (shash_mem syms taskname) then match (shash_find syms taskname).sigattr with
      | Sigtask tsk -> dispatch out_chan stem2 {Globals.unresolved=[]; tree=tsk; symbols=syms} true (* scan the task *)
      | _ -> fprintf out_chan "Trying to call non task %s\n" taskname
    else printf "Task %s not found\n" taskname;
end
  | DOTTED path -> iter (fun name -> match name with ID id -> Printf.fprintf out_chan "%s." id | _ -> ()) path;
    Printf.fprintf out_chan " - hierarchical task etc. not (yet) supported\n"
  | _ -> ()
 )
| TRIPLE((D_READMEMB|D_READMEMH), (ASCNUM file|ID file), args) -> ()
| TRIPLE (D_FOPEN, dest, nam ) -> ignore(subexp out_chan RECEIVER stem syms dest);
    exprGeneric out_chan stem syms nam
| TRIPLE(D_WRITE, ASCNUM msg, args) -> ()
| TRIPLE(D_FWRITE, fd, TLIST args) -> iter (fun arg -> exprGeneric out_chan stem syms arg) args
| DOUBLE(D_FCLOSE, fd) -> exprGeneric out_chan stem syms fd
| TRIPLE(D_DISPLAY, ASCNUM msg, args) -> ()
| DOUBLE(D_DISPLAY, EMPTY) -> ()
| DOUBLE(D_MONITOR, TLIST args) -> ()
| DOUBLE(D_FINISH, EMPTY) -> ()
| _ -> unhandled out_chan 468 block );
ignore(Stack.pop stk)

and subexp out_chan dir stem syms exp = Stack.push (stem, 475, exp) stk; match exp with
| ID id -> enter_a_sig_attr out_chan stem syms exp dir SCALAR
| TRIPLE (BITSEL, ID id, sel) -> enter_a_sig_attr out_chan stem syms (ID id) dir (RANGE (sel, sel))
| _ -> exprGeneric out_chan stem syms exp;
ignore(Stack.pop stk)
(*
and expr_dyadic out_chan dir stem syms op left right = DYADIC(op, subexp2 out_chan dir stem syms left, subexp2 out_chan dir stem syms right)
*)
and vtran out_chan stem syms x y =
iter(fun x -> ignore(subexp out_chan RECEIVER stem syms x)) [x;y]

and vtranif out_chan stem syms x y z =
iter(fun x -> ignore(subexp out_chan RECEIVER stem syms x)) [x;y;z]

and vnmos out_chan stem syms x y z =
ignore(subexp out_chan RECEIVER stem syms x);
iter(fun x -> ignore(subexp out_chan DRIVER stem syms x)) [y;z]

and vpmos out_chan stem syms x y z =
ignore(subexp out_chan RECEIVER stem syms x);
iter(fun x -> ignore(subexp out_chan DRIVER stem syms x)) [y;z]

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
| _ -> unhandled out_chan 490 item

and misc_syntax out_chan stem syms expr = Stack.push (stem, 539, expr) stk; ( match expr with
| EMPTY -> ()
| _ -> unhandled out_chan 597 expr);
ignore(Stack.pop stk)

and decls out_chan stem tree =
   let expr = tree.Globals.tree and syms = tree.Globals.symbols in Stack.push (stem, 539, expr) stk; ( match expr with
(* Parse parameter declarations *)
| QUADRUPLE(PARAMETER, EMPTY, EMPTY, decls) ->
    let width = ref EMPTY in begin
    ( match decls with
      | TLIST arg9 ->  List.iter (fun x -> match x with TRIPLE(ID id, arg5, arg6) -> enter_parameter out_chan stem syms id arg5 arg6 !width | _ -> unhandled out_chan 498 x) arg9
      | EMPTY -> ()
      | _ -> unhandled out_chan 500 decls); end
(* Parse IO declarations *)
| QUINTUPLE((INPUT|OUTPUT|INOUT) as dir, arg1, arg2, arg3, arg4) ->
    let width = ref SCALAR and attr = ref [IOPORT;dir] in begin
    (match arg1 with
      | EMPTY -> ()
      | REG -> attr := REG::!attr
      | _ -> unhandled out_chan 558 arg1);
    misc_syntax out_chan stem syms arg2;
    (match arg3 with
      | RANGE(hi,lo) as rangehilo -> width := rangehilo
      | TLIST arg9 ->  List.iter (fun arg -> unhandled out_chan 508 arg) arg9
      | EMPTY -> ()
      | _ -> unhandled out_chan 510 arg3);
    ( match arg4 with
      | DOUBLE(id, arg5) -> enter_sym_attrs out_chan stem syms id !attr !width
      | TRIPLE(id, TLIST arg5, TLIST arg6) -> enter_sym_attrs out_chan stem syms id !attr !width
      | TLIST arg9 ->  List.iter (fun x -> match x with TRIPLE(id, arg5, arg6) -> enter_sym_attrs out_chan stem syms id !attr !width | _ -> unhandled out_chan 514 x) arg9
      | EMPTY -> ()
      | _ -> unhandled out_chan 516 arg4); end
(* Parse wire/reg declarations *)
| QUADRUPLE((WIRE|REG) as kind, arg1, arg2, TLIST arg3) ->
    let width = ref SCALAR in begin
    misc_syntax out_chan stem syms arg1;
    (match arg2 with
      | RANGE(hi, lo) as rangehilo -> width := rangehilo
      | TRIPLE(EMPTY,(RANGE(hi, lo) as rangehilo),EMPTY) -> width := rangehilo
      | TLIST arg7 ->  List.iter (fun arg -> unhandled out_chan 524 arg) arg7
      | EMPTY -> ()
      | TRIPLE(EMPTY,EMPTY,EMPTY) -> ()
      | _ ->  unhandled out_chan 527 arg2);
    ( List.iter (fun x -> match x with
      | TRIPLE(ID id, arg5, arg6) -> (match arg5 with
          | EMPTY ->
              enter_sym_attrs out_chan stem syms (ID id) [kind] !width;
              enter_a_sig_attr out_chan stem syms (ID id) RECEIVER !width
          | TLIST [RANGE (expr1, expr2)] ->
              enter_sym_attrs out_chan stem syms (ID id) [MEMORY] !width;
          | _ -> unhandled out_chan 582 arg5);
          if (arg6 <> EMPTY) then exprGeneric out_chan stem syms arg6;
      | DOUBLE(id, EMPTY) -> enter_sym_attrs out_chan stem syms id [kind] !width
      | _ -> unhandled out_chan 534 x) arg3); end
(* Parse real/integer/event decls *)
| QUADRUPLE((REAL|INTEGER|EVENT) as kind, arg1, arg2, TLIST arg3) ->
    misc_syntax out_chan stem syms arg1;
    (match arg2 with
      | EMPTY -> ()
      | TRIPLE(EMPTY,EMPTY,EMPTY) -> ()
      | _ ->  unhandled out_chan 541 arg2);
    ( List.iter (fun x -> match x with
      | TRIPLE(id, arg5, arg6) -> enter_sym_attrs out_chan stem syms id [kind] SCALAR
      | _ -> unhandled out_chan 544 x) arg3)
| _ -> unhandled out_chan 545 expr );
ignore(Stack.pop stk)

and toplevelitems out_chan stem tree =
   let expr = tree.Globals.tree and syms = tree.Globals.symbols in Stack.push (stem, 595, expr) stk; ( match expr with
| DOUBLE((INITIAL|FINAL|ALWAYS), stmt) -> stmtBlock out_chan stem syms stmt
| TRIPLE(ASSIGN, EMPTY, TLIST assignlist)
-> iter (fun a -> match a with TRIPLE (ASSIGNMENT, var1, expr) ->
    ignore(subexp out_chan RECEIVER stem syms var1);
    ignore(exprGeneric out_chan stem syms expr) | _ -> unhandled out_chan 560 a) assignlist
| TRIPLE(BUF, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, SCALAR, x, a) -> vbuf out_chan stem syms x a
      | _ -> unhandled out_chan 564 inst) instances
| TRIPLE(NOT,dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, SCALAR, x, a) -> vnot out_chan stem syms x a
      | _ -> unhandled out_chan 568 inst) instances
| TRIPLE(AND, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, SCALAR, x, TLIST inlist) -> vand out_chan stem syms x inlist
      | _ -> unhandled out_chan 572 inst) instances
| TRIPLE(OR, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, SCALAR, x, TLIST inlist) -> vor out_chan stem syms x inlist
      | _ -> unhandled out_chan 576 inst) instances
| TRIPLE(XOR, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, SCALAR, x, TLIST inlist) -> vxor out_chan stem syms x inlist
      | _ -> unhandled out_chan 580 inst) instances
| TRIPLE(NAND, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, SCALAR, x, TLIST inlist) -> vand out_chan stem syms x inlist
      | _ -> unhandled out_chan 584 inst) instances
| TRIPLE(NOR, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, SCALAR, x, TLIST inlist) -> vor out_chan stem syms x inlist
      | _ -> unhandled out_chan 588 inst) instances
| TRIPLE(XNOR, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (nam, SCALAR, x, TLIST inlist) -> vxor out_chan stem syms x inlist
      | _ -> unhandled out_chan 592 inst) instances
| TRIPLE(BUFIF lev, weaklist, TLIST instances) ->
    iter (fun inst -> match inst with
      | DOUBLE (x, TLIST inlist) -> vbufif out_chan stem syms x inlist
      | _ -> unhandled out_chan 596 inst) instances
| TRIPLE(PULLUP, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | TRIPLE(EMPTY, EMPTY, x) -> vpullup out_chan stem syms x
      | _ -> unhandled out_chan 600 inst) instances
| TRIPLE(NMOS, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | TRIPLE(pin1, pin2, pin3) -> vnmos out_chan stem syms pin1 pin2 pin3
      | _ -> unhandled out_chan 604 inst) instances
| TRIPLE(PMOS, dly, TLIST instances) ->
    iter (fun inst -> match inst with
      | TRIPLE(pin1, pin2, pin3) -> vpmos out_chan stem syms pin1 pin2 pin3
      | _ -> unhandled out_chan 608 inst) instances
| TRIPLE(TRANIF lev, weaklist, TLIST instances) ->
    iter (fun inst -> match inst with
      | TRIPLE(pin1, pin2, pin3) -> vtranif out_chan stem syms pin1 pin2 pin3
      | _ -> unhandled out_chan 612 inst) instances
| TRIPLE(TRAN, weaklist, TLIST instances) ->
    iter (fun inst -> match inst with
      | DOUBLE(pin1, pin2) -> vtran out_chan stem syms pin1 pin2
      | _ -> unhandled out_chan 616 inst) instances
(* Parse table declarations *)
| DOUBLE(TABLE, TLIST trows) -> iter (fun row -> match row with
  | DOUBLE(TLIST tin,TLIST tout) -> ()
  | TRIPLE(TLIST tin,TLIST treg,TLIST tout) -> ()
  | _ -> unhandled out_chan 621 row) trows
(* Parse truncated specify blocks *)
| DOUBLE(SPECIFY, TLIST speclist) -> iter (fun item -> match item with ID id -> enter_a_sym out_chan stem syms (stem^id) SPECIFY UNKNOWN| _ -> ()) speclist
(* Parse primitive instance *)
| QUADRUPLE(PRIMINST, ID prim, EMPTY, TLIST inlist) ->
(*
    if (shash_mem Globals.modprims prim) then
      moditemlist out_chan (stem^prim^".") (shash_find Globals.modprims prim) (* scan the inner primitive *)
    else printf "Primitive %s not found\n" prim;
*)
    enter_a_sym out_chan stem syms prim PRIMITIVE EMPTY;
    let fc inner t = connect out_chan stem syms prim prim inner t in 
    ( match (shash_find Globals.modprims prim).Globals.tree with QUINTUPLE(PRIMITIVE,ID arg1, EMPTY, TLIST primargs, TLIST arg4) ->
iter2 fc primargs inlist | _ -> ())
(* Parse module instance *)
| QUADRUPLE(MODINST, ID kind,params, TLIST instances) ->
    begin
    enter_a_sym out_chan stem syms kind SUBMODULE EMPTY;
    let kindhash = shash_find Globals.modprims kind in
    iter (fun inst -> match inst with
      | TRIPLE (ID subcct, SCALAR, TLIST termlist) -> (* semantics out_chan (stem^subcct^".") kindhash; *)
        enter_a_sym out_chan stem syms subcct SUBCCT EMPTY;
        ( match kindhash.Globals.tree with QUINTUPLE((MODULE|PRIMITIVE),ID arg1, EMPTY, TLIST primargs, TLIST arg4) ->
        (try iter2 (fun (inner:token) (term:token) -> fiter out_chan stem syms kind subcct inner term) primargs termlist; with Invalid_argument "List.iter2" -> let ids = ref [] and partlist = ref ([],[])and byposn = ref false in begin
iter (fun (inner:token) -> (match inner with
| ID id -> ids := (!ids @ [id])
| QUINTUPLE ((INPUT|OUTPUT|INOUT), EMPTY, EMPTY, range, DOUBLE (ID id, EMPTY)) -> ids := (!ids @ [id])
| _ -> unhandled out_chan 648 inner)) primargs;
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
(shash_mem kindhash.symbols inner) && (TokSet.mem INPUT (shash_find kindhash.symbols inner).symattr)
) !ids;
if (length (fst(!partlist)) > 0) then begin
fprintf out_chan "sub-module %s of kind %s insufficient args - %d unconnected inputs(s): " subcct kind (length (fst(!partlist)));
iter (fun id -> fprintf out_chan "%s " id) (fst(!partlist));
output_char out_chan '\n';
end
end)
        | _ -> unhandled out_chan 669 kindhash.Globals.tree)
      | _ -> unhandled out_chan 670 inst) instances;
    match params with
    | EMPTY -> ()
    | TLIST parmlist -> iter (fun param -> match param with ID id -> () | _ -> unhandled out_chan 673 param) parmlist
    | _ -> unhandled out_chan 674 params
    end
| _ -> unhandled out_chan 676 expr );
ignore(Stack.pop stk);
mod_empty := false

and dispatch out_chan stem tree pass2 =
   let expr = tree.Globals.tree and syms = tree.Globals.symbols in Stack.push (stem, 726, expr) stk; ( match expr with
(* handled by decls *)
| QUADRUPLE(PARAMETER, EMPTY, EMPTY, params) -> if (pass2==false) then decls out_chan stem tree
| QUINTUPLE((INPUT|OUTPUT|INOUT), arg1, arg2, arg3, arg4) -> if (pass2==true) then decls out_chan stem tree
| QUADRUPLE((WIRE|REG|REAL|INTEGER|EVENT), arg1, arg2, TLIST arg3) -> if (pass2==true) then decls out_chan stem tree
(* handled by toplevelitems *)
| DOUBLE((INITIAL|FINAL|ALWAYS|TABLE|SPECIFY), items) -> if (pass2) then toplevelitems out_chan stem tree
| TRIPLE(ASSIGN, EMPTY, TLIST assignlist) ->  if (pass2) then toplevelitems out_chan stem tree
| TRIPLE((BUF|NOT|AND|OR|XOR|NAND|NOR|XNOR|PULLUP|NMOS|PMOS|TRAN), dly, TLIST instances) ->  if (pass2) then toplevelitems out_chan stem tree
| TRIPLE((BUFIF lev|TRANIF lev), weaklist, TLIST instances) ->  if (pass2) then toplevelitems out_chan stem tree
| QUADRUPLE((MODINST|PRIMINST), ID prim, params, TLIST inlist) ->  if (pass2) then toplevelitems out_chan stem tree
(* Parse function declarations *)
| OCTUPLE(FUNCTION, EMPTY, range, ID funcname, EMPTY, TLIST args, stmts, EMPTY) -> (
enter_a_sym out_chan stem syms funcname FUNCTION range;
iter (fun arg -> decls out_chan stem {Globals.unresolved=[]; tree=arg; symbols=syms}) args;
if (pass2==false) then stmtBlock out_chan stem syms stmts)
(* Parse task declarations *)
| SEPTUPLE(TASK, EMPTY, ID taskname, EMPTY, TLIST args, stmts, EMPTY) -> (
let stem = taskname^"." in (
shash_add syms taskname {Setup.symattr = TokSet.singleton TASK;
                       width = VOID;
		       sigattr = Sigtask expr;
		       path=taskname};
iter (fun arg -> decls out_chan stem {Globals.unresolved=[]; tree=arg; symbols=syms}) args;
if (pass2==true) then stmtBlock out_chan stem syms stmts))
| _ -> unhandled out_chan 702 expr );
ignore(Stack.pop stk)

and moditemlist out_chan stem tree =
   let expr = tree.Globals.tree and syms = tree.Globals.symbols in Stack.push (stem, 752, expr) stk; ( match expr with
(* Parse module declarations *)
| QUINTUPLE(MODULE,ID arg1, arg2, TLIST arg3, TLIST arg4) ->
    enter_a_sym out_chan stem syms arg1 MODULE SCALAR; (* print_endline (stem^arg1); *)
    misc_syntax out_chan "" syms arg2;
    iter (fun arg -> match arg with
| ID id -> enter_a_sym out_chan stem syms id IOPORT UNKNOWN
| _ -> decls out_chan "" {Globals.unresolved=[]; tree=arg; symbols=syms}) arg3;
    iter (fun item -> dispatch out_chan "" {Globals.unresolved=[]; tree=item; symbols=syms} false) arg4;
    iter (fun item -> dispatch out_chan "" {Globals.unresolved=[]; tree=item; symbols=syms} true) arg4;
(* Parse primitive declarations *)
| QUINTUPLE(PRIMITIVE,ID arg1, EMPTY, TLIST primargs, TLIST arg4) ->
    enter_a_sym out_chan stem syms arg1 PRIMITIVE EMPTY;
    iter (fun arg -> match arg with
      | ID id -> iter (fun x -> enter_a_sym out_chan stem syms id x UNKNOWN) [IOPORT;SPECIAL]; 
      | _ -> misc_syntax out_chan "" syms arg) primargs;
    iter (fun item -> dispatch out_chan "" {Globals.unresolved=[]; tree=item; symbols=syms} true) arg4;
| _ -> unhandled out_chan 723 expr );
ignore(Stack.pop stk)

let dotted s = try String.index s '.' > 0 ; with Not_found -> false;;

let erc_chk_sig out_chan nam syma siga =
  begin
	begin
	  if (TokSet.mem INPUT syma) && not ((TokSet.mem DRIVER siga) || (TokSet.mem SPECIAL syma)) then
	    Printf.fprintf out_chan "%s is an unloaded input\n" nam
	  else if (TokSet.mem OUTPUT syma) && not ((TokSet.mem RECEIVER siga) || (TokSet.mem SPECIAL syma)) then
	    Printf.fprintf out_chan "%s is an undriven output\n" nam
	  else if (TokSet.mem INOUT syma) then
	    Printf.fprintf out_chan "Note: %s is an inout\n" nam
	  else if (TokSet.mem WIRE syma) && not ((TokSet.mem RECEIVER siga) || (TokSet.mem SPECIFY syma)) then
	    Printf.fprintf out_chan "%s is an unused wire\n" nam
	end
  end
;;

let erc_chk out_chan syms id s = match s.sigattr with
| Sigarray attrs -> (
match s.width with
| RANGE range -> let (hi,lo) = iwidth out_chan "" syms s.width in
  if not ((TokSet.mem IMPLICIT s.symattr)||(TokSet.mem MEMORY s.symattr)) then
  ( try for i = hi downto lo do
    erc_chk_sig out_chan (id^"["^(string_of_int i)^"]") s.symattr attrs.(i)
    done
  with Invalid_argument("index out of bounds") -> fprintf out_chan "Trying to access %s with index [%d:%d]\n" id hi lo)
| SCALAR | EMPTY | UNKNOWN->
    erc_chk_sig out_chan id s.symattr attrs.(0)
| _ -> unhandled out_chan 791 s.width)
| Sigparam x ->
  if not (TokSet.mem PARAMUSED s.symattr) then Printf.fprintf out_chan "Parameter %s is not used\n" id
| Sigtask x ->
  if not (TokSet.mem TASKUSED s.symattr) then Printf.fprintf out_chan "Task %s is not used\n" id
| _ -> unhandled out_chan 804 s.width
;;

let check_syms out_chan syms = shash_iter (fun nam s -> erc_chk out_chan syms nam s) syms;;

exception Error

type logt = Closed | Open of out_channel;;

let pending = Hashtbl.create 256;;
let black_box = Hashtbl.create 256;;
let logfile = ref Closed;;

let tmpnam = "report."^(string_of_int(Unix.getpid()))^"."^Unix.gethostname()^".report";;

let scan out_chan key contents = begin
last_mod := key;
Hashtbl.add Globals.modprims key contents;
Printf.fprintf out_chan "scanning ..\n";
mod_empty := true;
moditemlist out_chan "" contents;
if !mod_empty then
    Printf.fprintf out_chan "%s check skipped due to black boxing\n" key
else
    check_syms out_chan contents.Globals.symbols;
end

let rec remove_from_pending out_chan mykey =  let reslist = ref [] in begin
		Hashtbl.iter (fun key contents ->
contents.Globals.unresolved <- List.filter(fun item -> item <> mykey) contents.Globals.unresolved;
if contents.Globals.unresolved == [] then match contents.Globals.tree with
| QUINTUPLE(kind, ID mykey, _, _, _) -> (
			Printf.fprintf out_chan "%s %s: resumed " (str_token kind) key;
			scan out_chan key contents; reslist := key :: !reslist)
| _ -> unhandled out_chan 899 contents.Globals.tree) pending;
			List.iter (fun key -> shash_remove pending key; remove_from_pending out_chan key) !reslist;
			end

let read_pragma nam1 nam2 kind =
if (nam1 = nam2) then begin
(*Printf.fprintf out_chan "Pragma %s is black-boxed\n" nam1;*)
if (Hashtbl.mem black_box nam1 == false) then Hashtbl.add black_box nam1 kind
end

let prescan decl = let expt = { Globals.tree=decl; symbols=Hashtbl.create 256; unresolved=(!unresolved_list); } in
	if (!logfile == Closed) then logfile := Open (open_out tmpnam);
	match !logfile with Open out_chan -> begin match decl with
| QUINTUPLE(kind, ID mykey, _, _, _) ->
	Printf.fprintf out_chan "%s %s: parsed " (str_token kind) mykey;
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
	flush out_chan
| PREPROC str -> Printf.fprintf out_chan "Encountered %s\n" str
| PRAGMATIC str ->
( try Scanf.sscanf str "//Verilog HDL for \"%s@\", \"%s@\" \"%s@\"" read_pragma;
with Scanf.Scan_failure msg -> Printf.fprintf out_chan "Comment %s not understood\n" str)
| P_RESETALL        			-> begin
    celldefine := false;
    portfaults := false;
    suppress_faults := false;
    protect := false;
    timescale := ""
    end
| P_CELLDEFINE			        -> celldefine := true
| P_ENDCELLDEFINE        		-> celldefine := false
| P_ENABLE_PORTFAULTS        		-> portfaults := true
| P_DISABLE_PORTFAULTS        		-> portfaults := false
| P_SUPPRESS_FAULTS        		-> suppress_faults := true
| P_NOSUPPRESS_FAULTS        		-> suppress_faults := false
| P_PROTECT        			-> protect := true;
| P_ENDPROTECT        			-> protect := false;
| P_TIMESCALE scale    			-> timescale := scale
| P_DELAY_MODE_PATH                     -> delay_mode := PATH
| _ -> unhandled out_chan 919 decl
	end
	| Closed -> raise Error
;;

let rec endscan2 indent mykey =
	match !logfile with Open out_chan -> begin
        for i = 1 to indent do output_char out_chan ' '; done;
	Printf.fprintf out_chan "Checking %s: " mykey;
	if (shash_mem pending mykey) then
          begin
	  Printf.fprintf out_chan "Module %s still postponed\n" mykey;
	  List.iter (fun key -> if (shash_mem pending key) then endscan2 (indent+2) key
          else Printf.fprintf out_chan "%s " key) ((shash_find pending mykey).Globals.unresolved);
 	  output_char out_chan '\n';
          end
	end
	| Closed -> raise Error
;;

let endscan () = let repfile = (!last_mod)^".report" in begin Hashtbl.iter (fun key item -> endscan2 0 key) pending;
match !logfile with
| Open out_chan -> close_out out_chan; logfile := Closed;
Printf.printf "Module %s report %s\n" !last_mod repfile;
Sys.rename tmpnam repfile
| Closed -> ()
end

(*
let nullsym = {Setup.symattr = TokSet.empty; width = EMPTY; path = ""};;

let moditer k (x:Globals.modtree) = semantics out_chan k x

let find_glob s = Setup.show_sym s ( shash_find s);;

let find_glob_substr s = let reg = Str.regexp s in shash_iter (fun k x -> try Printf.printf "%s posn %d\n" k (Str.search_forward reg k 0); with not_found out_chan stem -> ()) gsyms;;

let find_referrer s = Setup.show_sym s (match (shash_find s).referrer with Referrer lk -> lk | Nil -> nullsym);;
*)
