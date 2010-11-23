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
open Const
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

type declmode = Create | SizeOnly | AttrOnly

let showmode mode = match mode with
| Create -> "Create"
| SizeOnly -> "SizeOnly"
| AttrOnly -> "AttrOnly"

let mod_empty = ref true;;
let anon = {Setup.symattr = (TokSet.empty); width=UNKNOWN; sigattr=Sigundef; localsyms=EndShash; path="*unknown*"};;

(* these functions are for debugging symbol hash related issues *)

let shash_add (syms:shash) (key:string) (sym:symtab) = match syms with
| Shash symr -> Hashtbl.add symr.syms key sym
| EndShash -> failwith "No symbol table passed to shash_add"

let shash_create prev (siz:int) = Shash {nxt=EndShash; syms=Hashtbl.create siz}

let shash_iter (f:string -> Setup.symtab -> unit) syms = match syms with
| Shash symr -> Hashtbl.iter f symr.syms
| EndShash -> failwith "No symbol table passed to shash_iter"

let shash_remove (syms:shash) (key:string) = match syms with
| Shash symr -> Hashtbl.remove symr.syms key
| EndShash -> failwith "No symbol table passed to shash_remove"

let find_param out_chan syms id = begin
if Const.shash_chain_mem syms id == false then begin
  ( if List.mem id !implicit_params == false then implicit_params := id :: !implicit_params );
  shash_add syms id {Setup.symattr = TokSet.singleton PARAMETER;
                       width = SCALAR;
		       sigattr = Sigparam (INT 1);
		       localsyms = syms;
		       path=id}
  end;
Const.shash_chain_find syms id
end
;;

let create_attr out_chan syms neww = 
 Sigarray (Array.make (maxwidth out_chan syms neww) TokSet.empty)

let enter_a_sym out_chan (symbols:shash) id attr w mode = match attr with
(IOPORT|INPUT|OUTPUT|INOUT|REG|WIRE|TRI0|TRI1|SUPPLY0|SUPPLY1|INTEGER|REAL|MEMORY|EVENT
 |MODULE|PRIMITIVE|SUBMODULE|SUBCCT|SPECIFY|SPECIAL|PARAMUSED
 |PARAMETER|TASK|FUNCTION) ->
if Const.shash_chain_mem symbols id then let found = Const.shash_chain_find symbols id in begin
if (Globals.verbose > 0) then ( Printf.fprintf (fst out_chan) "Update %s %s: %s %s\n" id (str_token w) (Ord.getstr attr) (showmode mode));
  let newset = found.symattr
  and oldw = found.width
  and oldsattr = found.sigattr in
  if (oldw<>UNKNOWN)&&(oldw<>w)&&(w<>UNKNOWN) then
    Printf.fprintf (fst out_chan) "Addition of attribute %s to signal %s changed width from %s to %s\n"
      (str_token attr) id (str_token oldw) (str_token w);
  if (w<>UNKNOWN) && (mode<>AttrOnly) then
  shash_chain_replace symbols id
    {Setup.symattr = (TokSet.add attr newset);
    width = w;
    sigattr = create_attr out_chan symbols w;
    localsyms = EndShash;
    path=id}
  else shash_chain_replace symbols id
    {Setup.symattr = (TokSet.add attr newset);
    width = oldw;
    sigattr = oldsattr;
    localsyms = EndShash;
    path=id};
    end
else begin
if (Globals.verbose > 0) then (Printf.fprintf (fst out_chan) "Enter %s %s: %s %s\n" id (str_token w) (Ord.getstr attr) (showmode mode));
  shash_add symbols id {Setup.symattr = (TokSet.singleton attr);
     width = w;
     sigattr = create_attr out_chan symbols w;
     localsyms = EndShash;
     path=id}
  end
| _ -> unhandled out_chan 86 attr
;;

let iter_ semantics out_chan syms list =
  List.iter (fun x -> semantics out_chan ({Globals.unresolved=[]; tree=x; symbols=syms})) list
;;

let find_ident out_chan syms tok = match tok with ID id -> begin
if Const.shash_chain_mem syms id then Const.shash_chain_find syms id else (
  ( if List.mem id !implicit_wires == false then implicit_wires := id :: !implicit_wires );
  shash_add syms id {Setup.symattr = TokSet.singleton IMPLICIT;
                       width = SCALAR;
		       sigattr = create_attr out_chan syms SCALAR;
		       localsyms = syms;
		       path=id};
   Const.shash_chain_find syms id
      )
end
| _ -> unhandled out_chan 118 tok; ({Setup.symattr = TokSet.singleton tok; width = EMPTY; sigattr = create_attr out_chan syms SCALAR; localsyms = EndShash; path=""})
;;

let not_found out_chan syms w = Printf.fprintf (fst out_chan) "wire/port %s not found\n" w; ignore(find_ident out_chan syms (ID w))

let enter_sym_attrs out_chan syms (tok:token) list width mode = match tok with
| ID id -> if (Const.shash_chain_mem syms id == false)&&(mode <> Create) then (
          Printf.fprintf (fst out_chan) "Signal %s cannot be declared here\n" id )
  else begin
     iter (fun x -> enter_a_sym out_chan syms id x width mode) list;
     let newset = (find_ident out_chan syms tok).symattr in
     if (TokSet.mem INPUT newset) && (TokSet.mem REG newset) then 
       Printf.fprintf (fst out_chan) "Error: signal %s cannot be input and reg\n" id
     else if (TokSet.mem INPUT newset) && (TokSet.mem WIRE newset) then 
       Printf.fprintf (fst out_chan) "Note: input signal %s redundantly declared as wire\n" id;
    end
| _ -> unhandled out_chan 128 tok;
;;

let enter_parameter out_chan syms id arg6 w =
  shash_add syms id {Setup.symattr = (TokSet.singleton PARAMETER);
     width = w;
     sigattr = Sigparam arg6;
		       localsyms = syms;
     path=id}

let sig_attr_extract out_chan isyms inner = let rslt0 = (0,0,0,Array.make 1 TokSet.empty) in
let rslt = ref rslt0 in ( match inner.sigattr with
| Sigarray attrs -> (
match inner.width with
| RANGE range -> let (left,right,inc) = iwidth out_chan isyms inner.width in rslt := (left,right,inc,attrs)
| SCALAR ->
    rslt := (0,0,0,attrs);
| UNKNOWN -> (*TBD*)
    rslt := rslt0;
| EMPTY -> (*TBD*)
    rslt := rslt0;
| _ -> unhandled out_chan 98 inner.width)
| Sigparam x -> rslt := rslt0
| Sigundef -> rslt := rslt0
| Sigtask x -> rslt := rslt0
| Sigfunc x -> rslt := rslt0
| Signamed x -> rslt := rslt0); !rslt

let chk_inner_attr out_chan inner inner_attr attr idx =
let retval = (inner.sigattr == Sigundef) || (idx < 0) || (TokSet.mem SPECIAL inner.symattr) || (match attr with
      | DRIVER -> TokSet.mem DRIVER (inner_attr.(idx))
      | RECEIVER -> TokSet.mem RECEIVER (inner_attr.(idx))
      | BIDIR -> TokSet.mem BIDIR (inner_attr.(idx))
      | _ -> false) in
if (inner.sigattr <> Sigundef) && (Globals.verbose >= 2) then
    Printf.fprintf (fst out_chan) "Accessing %s with index [%d] -> result %s\n" inner.path idx (yesno retval);
retval
;;

let enter_range out_chan syms id sym attr wid inner high inci inner_attr attrs = let (left,right,inc) = iwidth out_chan syms wid in
  if not ((TokSet.mem IMPLICIT sym.symattr)||(TokSet.mem MEMORY sym.symattr)||(left < 0)||(right < 0)) then
    let i = ref left and j = ref high in while (if inc > 0 then !i <= right else !i >= right) do
    if chk_inner_attr out_chan inner inner_attr attr !j then attrs.(!i) <- TokSet.add attr attrs.(!i);
    (*with Invalid_argument("index out of bounds") -> Printf.fprintf (fst out_chan) "Trying to access %s with index [%d]\n" id i*)
    i := !i + inc;
    j := !j + inci
    done

let enter_a_sig_attr out_chan syms (tok:token) attr w isyms isym = ( match tok with 
| ID id -> let sym = find_ident out_chan syms tok and (left,right,inc,inner_attr) = sig_attr_extract out_chan isyms isym
 in (match sym.sigattr with
| Sigarray attrs -> enter_range out_chan syms id sym attr w isym left inc inner_attr attrs
| Sigparam x -> enter_sym_attrs out_chan syms tok [PARAMUSED] UNKNOWN AttrOnly
| Sigundef -> Printf.fprintf (fst out_chan) "Internal error - Signal %s has no width\n" id
| Sigtask x -> Printf.fprintf (fst out_chan) "Entity %s is already declared as a task\n" id
| Sigfunc x -> Printf.fprintf (fst out_chan) "Entity %s is already declared as a function\n" id
| Signamed x -> Printf.fprintf (fst out_chan) "Entity %s is already declared as a named block\n" id)
| _ -> unhandled out_chan 175 tok);
 if (Globals.verbose >= 2) then Printf.fprintf (fst out_chan) "enter_a_sig_attr out_chan syms tok:%s attr:%s width:%s\n"
  (str_token tok) (str_token attr) (str_token w)
;;

let inner_chk out_chan syms isyms isym subcct outer wid = begin
 if (Globals.verbose >= 2) then Printf.fprintf (fst out_chan) "inner_chk out_chan syms isym {path:%s width:%s} subcct:%s outer:%s width:%s\n"
  isym.path (str_token isym.width) subcct outer (str_token wid);
  let hier = ID (outer) and compat=ref false in 
  begin
  if (isym.width <> wid) then
    begin
    match wid with
    | RANGE(INT x, INT y) -> if ((x==y) && (isym.width == EMPTY)) then compat := true;
    | _ -> ();
    match isym.width with
    | RANGE(INT x, INT y) -> if ((x==y) && (wid == EMPTY)) then compat := true;
    | _ -> ();
    if (!compat == false) then begin
      Printf.fprintf (fst out_chan) "Width mismatch subcct=%s inner=%s %s outer=%s %s\n"
          subcct isym.path (Setup.str_token isym.width) outer (str_token(wid)); 
      end
    end;
  if (TokSet.mem IOPORT isym.symattr == false) then Printf.fprintf (fst out_chan) "Instance port %s not an ioport\n" isym.path
  else if (TokSet.mem INPUT isym.symattr) then ( enter_a_sig_attr out_chan syms hier DRIVER wid isyms isym)
  else if (TokSet.mem OUTPUT isym.symattr) then ( enter_a_sig_attr out_chan syms hier RECEIVER wid isyms isym)
  else if (TokSet.mem INOUT isym.symattr) then ( enter_a_sig_attr out_chan syms hier BIDIR wid isyms isym)
  end
end

let inner_chk_const out_chan syms isyms isym subcct (tok:token) wid = begin
  let compat=ref false in 
  begin
  if (isym.width <> wid) then
    begin
    match wid with
    | RANGE(INT x, INT y) -> if ((x==y) && (isym.width == EMPTY)) then compat := true;
    | _ -> ();
    match isym.width with
    | RANGE(INT x, INT y) -> if ((x==y) && (wid == EMPTY)) then compat := true;
    | _ -> ();
    if (!compat == false) then begin
      Printf.fprintf (fst out_chan) "Width mismatch subcct=%s inner=%s %s const=%s %s\n"
          subcct isym.path (Setup.str_token isym.width) (str_token tok) (str_token(wid)); 
      end
    end;
  if (TokSet.mem IOPORT isym.symattr == false) then Printf.fprintf (fst out_chan) "Instance port %s not an ioport\n" isym.path
  else if (TokSet.mem INPUT isym.symattr) then ()
  else if (TokSet.mem OUTPUT isym.symattr) then Printf.fprintf (fst out_chan) "Output port %s cannot connect to constant\n" isym.path
  else if (TokSet.mem INOUT isym.symattr) then Printf.fprintf (fst out_chan) "Output port %s cannot connect to constant\n" isym.path
  end
end

let rec inner_chk_expr out_chan syms isyms isym subcct (tok:token) = begin
 let wid = ( match tok with
(* These patterns are temporary placeholders *)
| TRIPLE(CARET, ID left, ID right) -> exprGeneric out_chan syms tok
| TRIPLE(P_OROR, arg1, arg2) -> exprGeneric out_chan syms tok
| TRIPLE(P_ANDAND, ID arg1, ID arg2) -> exprGeneric out_chan syms tok
| TRIPLE(VBAR, ID left, ID right) -> exprGeneric out_chan syms tok
| TRIPLE(AMPERSAND, arg1, arg2) -> exprGeneric out_chan syms tok
| DOUBLE(VBAR, ID left) -> exprGeneric out_chan syms tok
| DOUBLE(TILDE, left) -> exprGeneric out_chan syms tok
| _ -> unhandled out_chan 226 tok; UNKNOWN ) in
  let compat=ref false in 
  begin
  if (isym.width <> wid) then
    begin
    match wid with
    | RANGE(INT x, INT y) -> if ((x==y) && (isym.width == EMPTY)) then compat := true;
    | _ -> ();
    match isym.width with
    | RANGE(INT x, INT y) -> if ((x==y) && (wid == EMPTY)) then compat := true;
    | _ -> ();
    if (!compat == false) then begin
      Printf.fprintf (fst out_chan) "Width mismatch subcct=%s inner=%s %s const=%s %s\n"
          subcct isym.path (Setup.str_token isym.width) (str_token tok) (str_token(wid)); 
      end
    end;
  if (TokSet.mem IOPORT isym.symattr == false) then Printf.fprintf (fst out_chan) "Instance port %s not an ioport\n" isym.path
  else if (TokSet.mem INPUT isym.symattr) then ()
  else if (TokSet.mem OUTPUT isym.symattr) then Printf.fprintf (fst out_chan) "Output port %s cannot connect to expression\n" isym.path
  else if (TokSet.mem INOUT isym.symattr) then Printf.fprintf (fst out_chan) "Output port %s cannot connect to expression\n" isym.path
  end
end

and connect out_chan syms kind subcct (innert:token) tok = 
let isyms = (Hashtbl.find Globals.modprims kind).symbols in ( Stack.push (255, innert) stk; match innert with ID innerid -> begin
if (Const.shash_chain_mem isyms innerid) then
let isym=Const.shash_chain_find isyms innerid in let (fst_irange,snd_irange,inc_irange) = iwidth out_chan isyms isym.width in match tok with
| ID outer -> inner_chk out_chan syms isyms isym subcct outer (find_ident out_chan syms tok).width
| TRIPLE(BITSEL, ID outer, sel) -> if (Const.shash_chain_mem syms outer) then inner_chk out_chan syms isyms isym subcct outer (RANGE (sel, sel)) else not_found out_chan syms outer
| QUADRUPLE(PARTSEL, ID outer, INT hi, INT lo) -> if (Const.shash_chain_mem syms outer) then inner_chk out_chan syms isyms isym subcct outer (RANGE(INT hi, INT lo)) else not_found out_chan syms outer
| INT lev -> inner_chk_const out_chan syms isyms isym subcct tok (RANGE(INT 31, INT 0))
| BINNUM lev -> inner_chk_const out_chan syms isyms isym subcct tok (RANGE(INT (fst(widthnum out_chan 2 lev)-1), INT 0))
| DOUBLE(CONCAT, TLIST concat) -> let idx = ref fst_irange in iter (fun (item:token) -> 
( if (Globals.verbose >= 3) then Printf.fprintf (fst out_chan) "Concat idx %d\n" !idx; match item with
  | ID id -> let wid = (find_ident out_chan syms item).width in
      let (left,right,inc) = iwidth out_chan syms wid in let last = !idx + (right-left)*inc*inc_irange in
      begin inner_chk out_chan syms isyms {symattr=isym.symattr; width=RANGE(INT !idx, INT last); sigattr = isym.sigattr; localsyms = EndShash; path=isym.path} subcct id wid; idx := last+inc_irange; end
  | TRIPLE(BITSEL, ID id, INT sel) -> inner_chk out_chan syms isyms {symattr=isym.symattr; width=RANGE(INT !idx, INT !idx); sigattr = isym.sigattr; localsyms = EndShash; path=isym.path} subcct id (RANGE(INT sel, INT sel)); idx := !idx+inc_irange
  | QUADRUPLE(PARTSEL, ID id, INT left, INT right) -> let inc = idirection left right in let last = !idx + (right-left)*inc*inc_irange in inner_chk out_chan syms isyms {symattr=isym.symattr; width=RANGE(INT !idx, INT last); sigattr = isym.sigattr; localsyms = EndShash; path=isym.path} subcct id (RANGE(INT left, INT right)); idx := last + inc_irange
  | BINNUM lev -> let w = fst(widthnum out_chan 2 lev) in inner_chk_const out_chan syms isyms {symattr=isym.symattr; width=RANGE(INT !idx, INT (!idx+1-w)); sigattr = isym.sigattr; localsyms = EndShash; path=isym.path} subcct tok (RANGE(INT (w-1), INT 0)); idx := !idx+inc_irange*w
  | _ -> unhandled out_chan 224 item)
) concat;
if (!idx <> snd_irange+inc_irange) then
  Printf.fprintf (fst out_chan) "Concatenation width %d does not match port width %s[%d:%d] in %s\n"
    ((!idx - fst_irange)*inc_irange) innerid fst_irange snd_irange subcct;
| _ -> inner_chk_expr out_chan syms isyms isym subcct tok
else Printf.fprintf (fst out_chan) "Instance port %s of %s (type %s) not found\n" innerid subcct kind
end
| _ -> unhandled out_chan 229 innert);
ignore(Stack.pop stk)

and fiter out_chan syms (kind:string) (subcct:string) (inner:token) (term:token) = match term with
          | DOUBLE(CELLPIN, myinner) -> ()
          | TRIPLE(CELLPIN, myinner, tok) -> connect out_chan syms kind subcct myinner tok
          (* connect by position syntax - deprecated *)
          | ID id -> connect out_chan syms kind subcct inner term
	  | DOUBLE(CONCAT, TLIST concat) -> connect out_chan syms kind subcct inner term
          | QUADRUPLE(PARTSEL, ID net, INT hi, INT lo) -> connect out_chan syms kind subcct inner term
	  | _ -> unhandled out_chan 241 term

and exprGeneric out_chan syms expr = Stack.push (288, expr) stk; let retval = ref SCALAR in ( match expr with
| TRIPLE( P_OROR, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right;
| TRIPLE( P_ANDAND, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( AMPERSAND, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( VBAR, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_NAND, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_NOR, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( CARET, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_XNOR, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_EQUAL, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right;
| TRIPLE( P_NOTEQUAL, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_CASEEQUAL, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_CASENOTEQUAL, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_WILDEQUAL, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_WILDNOTEQUAL, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( GREATER, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( LESS, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_GTE, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_LTE, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_SLEFT, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_SRIGHT, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_SSRIGHT, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( PLUS, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( MINUS, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( TIMES, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( DIVIDE, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( MODULO, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE( P_POW, left, right ) -> retval := exprGeneric out_chan syms left; retval := exprGeneric out_chan syms right
| TRIPLE(CONCAT, arg2, TLIST arg4) -> iter (fun arg -> retval := exprGeneric out_chan syms arg) (arg2::arg4)
| DOUBLE(CONCAT, TLIST concat) -> iter (fun arg -> retval := exprGeneric out_chan syms arg) concat
| DOUBLE(MINUS, arg2) -> retval := exprGeneric out_chan syms arg2
| DOUBLE(PLUS, arg2) -> retval := exprGeneric out_chan syms arg2
| DOUBLE(AMPERSAND, arg2) -> retval := exprGeneric out_chan syms arg2
| DOUBLE(VBAR, arg2) -> retval := exprGeneric out_chan syms arg2
| DOUBLE(CARET, arg2) -> retval := exprGeneric out_chan syms arg2
| DOUBLE(P_XNOR, arg2) -> retval := exprGeneric out_chan syms arg2
| DOUBLE(P_NAND, arg2) -> retval := exprGeneric out_chan syms arg2
| DOUBLE(P_NOR, arg2) -> retval := exprGeneric out_chan syms arg2
| DOUBLE(PLING, arg2) -> retval := exprGeneric out_chan syms arg2
| DOUBLE(TILDE, arg2) -> retval := exprGeneric out_chan syms arg2
| QUADRUPLE(QUERY, expr, then_clause, else_clause ) ->
    ( ignore(exprGeneric out_chan syms expr);
    let retval1 = exprGeneric out_chan syms then_clause in
    let retval2 = exprGeneric out_chan syms else_clause in
    let (left1,right1,inc1) = iwidth out_chan syms retval1 and (left2,right2,inc2) = iwidth out_chan syms retval2 in
      retval := if ((right1-left1)*inc1 > (right2-left2)*inc2) then retval1 else retval2; )
| DOUBLE(D_BITS, right ) -> retval := exprGeneric out_chan syms right
| DOUBLE(D_C, TLIST right ) -> iter(fun arg -> retval := exprGeneric out_chan syms arg) right
| DOUBLE(D_CLOG2, right ) -> retval := exprGeneric out_chan syms right
| DOUBLE(D_COUNTDRIVERS, right ) -> retval := exprGeneric out_chan syms right
| DOUBLE(D_COUNTONES, right ) -> retval := exprGeneric out_chan syms right
| DOUBLE(D_FEOF, right ) -> retval := exprGeneric out_chan syms right
| DOUBLE(D_FGETC, right ) -> retval := exprGeneric out_chan syms right
| TRIPLE(D_FGETS, right, arg5) -> retval := exprGeneric out_chan syms right
| TRIPLE(D_FSCANF, right, arg6) -> retval := exprGeneric out_chan syms right
| TRIPLE(D_SSCANF, right, arg6) -> retval := exprGeneric out_chan syms right
| DOUBLE(D_ISUNKNOWN, right ) -> retval := exprGeneric out_chan syms right
| DOUBLE(D_ONEHOT, right ) -> retval := exprGeneric out_chan syms right
| DOUBLE(D_ONEHOT0, right ) -> retval := exprGeneric out_chan syms right
| DOUBLE(D_RANDOM, right ) -> retval := exprGeneric out_chan syms right
| D_RANDOM -> retval := RANGE(INT 31, INT 0)
| DOUBLE(D_SIGNED, right ) -> retval := exprGeneric out_chan syms right
| D_STIME -> retval := RANGE(INT 31, INT 0)
| D_TIME -> retval := RANGE(INT 31, INT 0)
| DOUBLE(D_TEST_PLUSARGS, right ) -> retval := exprGeneric out_chan syms right
| DOUBLE(D_UNSIGNED, right ) -> retval := exprGeneric out_chan syms right
| TRIPLE(FUNCREF, func, TLIST arg3) -> ( match func with
  | ID funcname ->
  begin
    if (Const.shash_chain_mem syms funcname) then let h = Const.shash_chain_find syms funcname in match h.sigattr with
      | Sigfunc fnc -> dispatch out_chan {Globals.unresolved=[]; tree=fnc; symbols=h.localsyms} true
      | _ -> Printf.fprintf (fst out_chan) "Trying to evaluate non function %s\n" funcname
    else Printf.fprintf (fst out_chan) "Function %s not found\n" funcname;
  end
  | DOTTED path -> iter (fun name -> match name with ID id -> Printf.fprintf (fst out_chan) "%s." id | _ -> ()) path;
    Printf.fprintf (fst out_chan) " - hierarchical function etc. not (yet) supported\n"
  | _ -> ()
 )
| INT left -> ()
| BINNUM left -> ()
| DECNUM left -> ()
| HEXNUM left -> ()
| ID arg1 -> retval := (find_ident out_chan syms expr).width; enter_a_sig_attr out_chan syms expr DRIVER !retval syms anon
| TRIPLE(BITSEL, arg1, arg3) -> retval := RANGE(arg3,arg3); enter_a_sig_attr out_chan syms arg1 DRIVER !retval syms anon
| QUADRUPLE(PARTSEL, arg1 , arg3 , arg5 ) -> retval := RANGE(arg3,arg5); enter_a_sig_attr out_chan syms arg1 DRIVER !retval syms anon
| QUADRUPLE(P_PLUSCOLON, arg1 , arg3 , arg5 ) -> ()
| QUADRUPLE(P_MINUSCOLON, arg1, arg3, arg5 ) -> ()
| ASCNUM arg1 -> ()
| FLOATNUM arg1 -> ()
| DOTTED path -> (*TBD*) retval := UNKNOWN
| _ -> unhandled out_chan 321 expr; retval := UNKNOWN );
ignore(Stack.pop stk);
!retval

and caseitems out_chan syms expr = Stack.push (369, expr) stk; ( match expr with
(* Parse case statement *)
| TRIPLE(CASECOND, TLIST thecases, stmt) ->
iter (fun pattern -> ignore(exprGeneric out_chan syms pattern)) thecases;
stmtBlock out_chan syms stmt
| DOUBLE(DEFAULT, stmt) ->
stmtBlock out_chan syms stmt
| QUADRUPLE(P_LTE, dest, dly, exp) ->
ignore(exprGeneric out_chan syms exp);
ignore(subexp out_chan RECEIVER syms dest)
| ID id -> enter_a_sym out_chan syms id EMPTY EMPTY AttrOnly
| PREPROC txt -> ()
| EMPTY -> ()
| _ -> unhandled out_chan 417 expr );
ignore(Stack.pop stk)

and for_stmt out_chan syms id start test inc clause = let wid = (find_ident out_chan syms (ID id)).width and crnt = ref (INT (exprConst out_chan syms start)) in begin
  shash_add syms id {Setup.symattr = (TokSet.singleton PARAMETER);
     width = wid;
     sigattr = Sigparam !crnt;
		       localsyms = syms;
     path=id};
let loops = ref 0 and unrolling = ref true in while (!unrolling) && (0 <> exprConst out_chan syms test) do
    stmtBlock out_chan syms clause;
    crnt := INT (exprConst out_chan syms inc);
    shash_chain_replace syms id
      {Setup.symattr = (TokSet.singleton PARAMETER);
      width = wid;
      sigattr = Sigparam !crnt;
		       localsyms = syms;
      path=id};
    loops := 1 + !loops;
    if (!loops > 1000) then (unrolling := false; Printf.fprintf (fst out_chan) "Loop %s unrolling stopped after 1000 iterations\n" id)
done;
shash_remove syms id;
end 

and hash_dly out_chan syms dly = match dly with
  | EMPTY -> ()
  | DOUBLE(HASH, ID dlytok) -> enter_sym_attrs out_chan syms (ID dlytok) [PARAMUSED] UNKNOWN AttrOnly
  | DOUBLE(HASH, TLIST dlylist) -> iter (fun item -> match item with 
        | ID _ -> enter_sym_attrs out_chan syms item [PARAMUSED] UNKNOWN AttrOnly
        | _ -> unhandled out_chan 408 item) dlylist
  | DOUBLE(HASH, FLOATNUM num) -> ()
  | TLIST [WEAK weak0; WEAK weak1] -> ()
  | _ -> unhandled out_chan 493 dly

and stmtBlock out_chan syms block = Stack.push (465, block) stk; ( match block with
| EMPTY -> ()
| DOUBLE(DISABLE, nam) -> ()
| DOUBLE(P_MINUSGT, ev) -> ()
| DOUBLE(DOUBLE(HASH, _) as dly, stmt) -> hash_dly out_chan syms dly; stmtBlock out_chan syms stmt
| QUINTUPLE(NAMED, ID blk_named, TLIST loc_decls, TLIST stmts, EMPTY) -> let syms2 = shash_create syms 256 in
 shash_add syms blk_named {Setup.symattr = TokSet.singleton FUNCTION;
                       width = VOID;
		       sigattr = Signamed block;
		       localsyms = syms2;
		       path=blk_named};
 iter (fun item -> decls out_chan {Globals.unresolved=[]; tree=item; symbols=syms2} Create) loc_decls;
 iter (fun item -> stmtBlock out_chan syms2 item) stmts
| TLIST stmtList -> iter (fun item ->
    stmtBlock out_chan syms item) stmtList
| TRIPLE(BEGIN, TLIST stmtList, endLabelE) -> iter (fun item -> stmtBlock out_chan syms item) stmtList
|  DOUBLE
    (DOUBLE(AT, TLIST sens_list), stmt)
-> iter (fun item -> senitem out_chan syms item) sens_list; ( match stmt with
  | TRIPLE(BEGIN, TLIST stmts, EMPTY)
    -> stmtBlock out_chan syms stmt
  | TLIST stmts
    -> stmtBlock out_chan syms stmt
  | _ -> stmtBlock out_chan syms stmt )
| QUADRUPLE((ASSIGNMENT|DLYASSIGNMENT), var1, dly, expr)
-> ignore(subexp out_chan RECEIVER syms var1);
   ignore(exprGeneric out_chan syms expr);
   hash_dly out_chan syms dly
| QUADRUPLE(ASSIGN, ID id, EMPTY, expr) ->
   ignore(subexp out_chan RECEIVER syms (ID id));
   ignore(exprGeneric out_chan syms expr)
| DOUBLE(DEASSIGN, ID id) ->
   ignore(subexp out_chan RECEIVER syms (ID id))
| DOUBLE(FOREVER, stmt) ->
   stmtBlock out_chan syms stmt
| TRIPLE(REPEAT, iter, stmt) ->
   stmtBlock out_chan syms stmt
| TRIPLE(WHILE, expr, stmt) ->
   ignore(exprGeneric out_chan syms expr);
   stmtBlock out_chan syms stmt
| TRIPLE(IF, expr, then_clause) ->
ignore(exprGeneric out_chan syms expr);
stmtBlock out_chan syms then_clause
| QUADRUPLE(IF, expr, then_clause, else_clause) ->
ignore(exprGeneric out_chan syms expr);
stmtBlock out_chan syms then_clause;
stmtBlock out_chan syms else_clause
| QUINTUPLE(FOR, TRIPLE(ASSIGNMENT,ID idstart, start), test, TRIPLE(ASSIGNMENT,ID idinc,inc), clause) ->
if idstart <> idinc then Printf.fprintf (fst out_chan) "For variable not consistent %s vs. %s\n" idstart idinc
else for_stmt out_chan syms idstart start test inc clause
| QUADRUPLE((CASE|CASEX|CASEZ), expr, caseAttr, TLIST caseList) ->
ignore(exprGeneric out_chan syms expr);
iter (fun caseitem -> caseitems out_chan syms caseitem) caseList
(* Parse task reference *)
| TRIPLE(TASKREF, task, args) -> ( match task with
  | ID taskname ->
  begin
    if (Const.shash_chain_mem syms taskname) then let h = Const.shash_chain_find syms taskname in match h.sigattr with
      | Sigtask tsk -> dispatch out_chan {Globals.unresolved=[]; tree=tsk; symbols=h.localsyms} true (* scan the task *)
      | _ -> Printf.fprintf (fst out_chan) "Trying to call non task %s\n" taskname
    else Printf.fprintf (fst out_chan) "Task %s not found\n" taskname;
end
  | DOTTED path -> iter (fun name -> match name with ID id -> Printf.fprintf (fst out_chan) "%s." id | _ -> ()) path;
    Printf.fprintf (fst out_chan) " - hierarchical task etc. not (yet) supported\n"
  | _ -> ()
 )
| TRIPLE((D_READMEMB|D_READMEMH), (ASCNUM file|ID file), args) -> ()
| TRIPLE(D_FOPEN, dest, nam ) -> ignore(subexp out_chan RECEIVER syms dest);
    ignore(exprGeneric out_chan syms nam)
| TRIPLE(D_WRITE, ASCNUM msg, args) -> ()
| TRIPLE((D_FWRITE|D_FWRITEH), fd, TLIST args) -> iter (fun arg -> ignore(exprGeneric out_chan syms arg)) args
| DOUBLE(D_FCLOSE, fd) -> ignore(exprGeneric out_chan syms fd)
| QUADRUPLE(D_FDISPLAY, fd, ASCNUM msg, args) -> ()
| TRIPLE(D_FDISPLAY, fd, EMPTY) -> ()
| TRIPLE(D_DISPLAY, ASCNUM msg, args) -> ()
| DOUBLE(D_DISPLAY, EMPTY) -> ()
| DOUBLE(D_MONITOR, TLIST args) -> ()
| DOUBLE(D_FINISH, EMPTY) -> ()
| _ -> unhandled out_chan 468 block );
ignore(Stack.pop stk)

and subexp out_chan dir syms exp = Stack.push (475, exp) stk; match exp with
| ID id -> enter_a_sig_attr out_chan syms exp dir (find_ident out_chan syms exp).width syms anon
| TRIPLE(BITSEL, ID id, sel) -> enter_a_sig_attr out_chan syms (ID id) dir (RANGE (sel, sel)) syms anon
| _ -> ignore(exprGeneric out_chan syms exp);
ignore(Stack.pop stk)
(*
and expr_dyadic out_chan dir syms op left right = DYADIC(op, subexp2 out_chan dir syms left, subexp2 out_chan dir syms right)
*)
and vtran out_chan syms x y =
iter(fun x -> ignore(subexp out_chan RECEIVER syms x)) [x;y]

and vtranif out_chan syms x y z =
iter(fun x -> ignore(subexp out_chan RECEIVER syms x)) [x;y;z]

and vnmos out_chan syms x y z =
ignore(subexp out_chan RECEIVER syms x);
iter(fun x -> ignore(subexp out_chan DRIVER syms x)) [y;z]

and vpmos out_chan syms x y z =
ignore(subexp out_chan RECEIVER syms x);
iter(fun x -> ignore(subexp out_chan DRIVER syms x)) [y;z]

and vpullup out_chan syms (x:token) =
ignore(subexp out_chan RECEIVER syms x)

and vbuf out_chan syms (x:token) a =
ignore(subexp out_chan RECEIVER syms x);
ignore(subexp out_chan DRIVER syms a)

and vbufif out_chan syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER syms x);
iter (fun t -> ignore(subexp out_chan DRIVER syms t)) inlist

and vnotif out_chan syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER syms x);
iter (fun t -> ignore(subexp out_chan DRIVER syms t)) inlist

and vnot out_chan syms (x:token) a =
ignore(subexp out_chan RECEIVER syms x);
iter (fun w -> ignore(subexp out_chan DRIVER syms w)) [x;a]

and vand out_chan syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER syms x);
iter (fun t -> ignore(subexp out_chan DRIVER syms t)) inlist

and vor out_chan syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER syms x);
iter (fun t -> ignore(subexp out_chan DRIVER syms t)) inlist

and vxor out_chan syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER syms x);
iter (fun t -> ignore(subexp out_chan DRIVER syms t)) inlist

and vnand out_chan syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER syms x);
iter (fun t -> ignore(subexp out_chan DRIVER syms t)) inlist

and vnor out_chan syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER syms x);
iter (fun t -> ignore(subexp out_chan DRIVER syms t)) inlist

and vxnor out_chan syms (x:token) (inlist:token list) =
ignore(subexp out_chan RECEIVER syms x);
iter (fun t -> ignore(subexp out_chan DRIVER syms t)) inlist

and senitem out_chan syms item = match item with
| DOUBLE(POSEDGE, clk) -> ignore(subexp out_chan DRIVER syms clk)
| DOUBLE(NEGEDGE, clk) -> ignore(subexp out_chan DRIVER syms clk)
| ID signal -> ignore(subexp out_chan SENSUSED syms item)
| _ -> unhandled out_chan 490 item

and misc_syntax out_chan syms expr = Stack.push (539, expr) stk; ( match expr with
| EMPTY -> ()
| _ -> unhandled out_chan 597 expr);
ignore(Stack.pop stk)

and decls out_chan tree mode =
   let expr = tree.Globals.tree and syms = tree.Globals.symbols in Stack.push (539, expr) stk; ( match expr with
(* Parse parameter declarations *)
| QUADRUPLE(PARAMETER, EMPTY, EMPTY, decls) ->
    let width = ref EMPTY in begin
    ( match decls with
      | TLIST arg9 ->  List.iter (fun x -> match x with TRIPLE(ID id, arg5, arg6) -> enter_parameter out_chan syms id arg6 !width | _ -> unhandled out_chan 498 x) arg9
      | EMPTY -> ()
      | _ -> unhandled out_chan 500 decls); end
(* Parse IO declarations *)
| QUINTUPLE((INPUT|OUTPUT|INOUT) as dir, arg1, arg2, arg3, arg4) ->
    let width = ref SCALAR and attr = ref [IOPORT;dir] in begin
    (match arg1 with
      | EMPTY -> ()
      | REG -> attr := REG::!attr
      | _ -> unhandled out_chan 558 arg1);
    misc_syntax out_chan syms arg2;
    (match arg3 with
      | RANGE(left,right) as rangehilo -> width := rangehilo
      | TLIST arg9 ->  List.iter (fun arg -> unhandled out_chan 508 arg) arg9
      | EMPTY -> ()
      | _ -> unhandled out_chan 510 arg3);
    ( match arg4 with
      | DOUBLE(id, arg5) -> enter_sym_attrs out_chan syms id !attr !width mode
      | TRIPLE(id, TLIST arg5, TLIST arg6) -> enter_sym_attrs out_chan syms id !attr !width mode
      | TLIST arg9 ->  List.iter (fun x -> match x with
        | TRIPLE(id, arg5, arg6) -> enter_sym_attrs out_chan syms id !attr !width mode
        | _ -> unhandled out_chan 514 x) arg9
      | EMPTY -> ()
      | _ -> unhandled out_chan 516 arg4); end
(* Parse wire/reg declarations *)
| QUADRUPLE((WIRE|REG|TRI0|TRI1|SUPPLY0|SUPPLY1) as kind, arg1, arg2, TLIST arg3) ->
    let width = ref SCALAR in begin
    misc_syntax out_chan syms arg1;
    (match arg2 with
      | RANGE(left, right) as rangehilo -> width := rangehilo
      | TRIPLE(EMPTY,(RANGE(left, right) as rangehilo),EMPTY) -> width := rangehilo
      | TLIST arg7 ->  List.iter (fun arg -> unhandled out_chan 524 arg) arg7
      | EMPTY -> ()
      | TRIPLE(EMPTY,EMPTY,EMPTY) -> ()
      | _ ->  unhandled out_chan 527 arg2);
    ( List.iter (fun x -> match x with
      | TRIPLE(ID id, arg5, arg6) -> (match arg5 with
          | EMPTY ->
              enter_sym_attrs out_chan syms (ID id) [kind] !width Create;
              enter_a_sig_attr out_chan syms (ID id) RECEIVER !width syms anon
          | TLIST [RANGE (expr1, expr2)] ->
              enter_sym_attrs out_chan syms (ID id) [MEMORY] !width Create;
          | _ -> unhandled out_chan 582 arg5);
          if (arg6 <> EMPTY) then ignore(exprGeneric out_chan syms arg6);
      | DOUBLE(id, EMPTY) -> enter_sym_attrs out_chan syms id [kind] !width Create
      | _ -> unhandled out_chan 534 x) arg3); end
(* Parse real/integer/event decls *)
| QUADRUPLE((REAL|INTEGER|EVENT) as kind, arg1, arg2, TLIST arg3) ->
    misc_syntax out_chan syms arg1;
    (match arg2 with
      | EMPTY -> ()
      | TRIPLE(EMPTY,EMPTY,EMPTY) -> ()
      | _ ->  unhandled out_chan 541 arg2);
    ( List.iter (fun x -> match x with
      | TRIPLE(id, arg5, arg6) -> enter_sym_attrs out_chan syms id [kind] SCALAR Create
      | _ -> unhandled out_chan 544 x) arg3)
| _ -> unhandled out_chan 545 expr );
ignore(Stack.pop stk)

and specifyitems out_chan syms expr = Stack.push (688, expr) stk; ( match expr with
  | ID id -> enter_a_sym out_chan syms id SPECIFY UNKNOWN AttrOnly
  | DOUBLE(DOUBLE(IF_NONE,
     TRIPLE
      (DECUPLE
        (LPAREN, (NEGEDGE|POSEDGE), DOUBLE (ID id1, EMPTY), P_EQGT, LPAREN,
         DOUBLE (ID id2, EMPTY), P_PLUSCOLON, BINNUM "1'b1", RPAREN,
         RPAREN),
       EQUALS, expr1)),
   SEMICOLON) -> ()
  | DOUBLE (ID id1, EMPTY) -> ()
  | DOUBLE (PLING, d) -> ()
  | DOUBLE (P_ANDANDAND, expr1) -> ()
  | TRIPLE (DOUBLE (PLING, DOUBLE (ID id1, EMPTY)), AMPERSAND, d) -> ()
  | TRIPLE (ID id, EQUALS, num) -> enter_parameter out_chan syms id num SCALAR
  | QUADRUPLE(SPECPARAM, EMPTY, TLIST slst, SEMICOLON) -> iter (fun expr -> specifyitems out_chan syms expr) slst
  | OCTUPLE(D_PERIOD, LPAREN, TRIPLE
    ((NEGEDGE|POSEDGE), DOUBLE (ID id1, EMPTY),
     DOUBLE (P_ANDANDAND, ID id2)),
   COMMA, ID id3, DOUBLE (COMMA, ID id4), RPAREN, SEMICOLON) -> ()
  | DECUPLE (LPAREN, POSEDGE, DOUBLE (ID id1, EMPTY), P_EQGT, LPAREN,
         DOUBLE (ID id2, TRIPLE (LBRACK, INT idx, RBRACK)), COLON,
         BINNUM "1'bx", RPAREN, RPAREN) -> ()
  | DECUPLE(D_RECOVERY, LPAREN, TRIPLE ((NEGEDGE|POSEDGE), DOUBLE (ID id1, EMPTY), EMPTY),
   COMMA,
   TRIPLE
    (POSEDGE, DOUBLE (ID id2, EMPTY),
     DOUBLE (P_ANDANDAND, ID id3)),
   COMMA, ID id4, DOUBLE (COMMA, ID id5), RPAREN,
   SEMICOLON) -> ()
  | DECUPLE(D_WIDTH, LPAREN,
   TRIPLE
    ((POSEDGE|NEGEDGE), DOUBLE (ID id1, EMPTY), DOUBLE (P_ANDANDAND, expr1)),
   COMMA, expr2, COMMA, expr3, DOUBLE (COMMA, ID id4), RPAREN, SEMICOLON) -> ()
  | UNDECUPLE
        (ID "Tcq", COMMA, ID "Tcq", COMMA, ID "Tcqx", COMMA, ID "Tcq", COMMA,
         ID "Tcqx", COMMA, ID "Tcq") -> ()
  | UNDECUPLE
      (ID "Tsdq", COMMA, ID "Tsdq", COMMA, ID "Tsdqx", COMMA, ID "Tsdq",
       COMMA, ID "Tsdqx", COMMA, ID "Tsdq") -> ()
  | DUODECUPLE
  (D_SETUPHOLD, LPAREN,
   TRIPLE
    ((NEGEDGE|POSEDGE), DOUBLE (ID id1, EMPTY), expr1),
   COMMA,
   TRIPLE ((NEGEDGE|POSEDGE), DOUBLE (ID id3, idx), expr2),
   COMMA, expr3, COMMA, expr4,
   TRIPLE
    (COMMA, ID id6,
     TRIPLE
      (COMMA, EMPTY,
       TRIPLE
        (COMMA, EMPTY,
         TRIPLE
          (COMMA, ID id7,
           DOUBLE
            (COMMA, qid))))),
   RPAREN, SEMICOLON) -> ()
  | DUODECUPLE
  (D_RECREM, LPAREN,
   TRIPLE
    ((NEGEDGE|POSEDGE), DOUBLE (ID id1, EMPTY),
     DOUBLE (P_ANDANDAND, expr1)),
   COMMA,
   TRIPLE
    ((NEGEDGE|POSEDGE), DOUBLE (ID id2, EMPTY),
     DOUBLE (P_ANDANDAND, expr2)),
   COMMA, expr3, COMMA, expr4,
   TRIPLE
    (COMMA, ID id3,
     TRIPLE
      (COMMA, EMPTY,
       TRIPLE
        (COMMA, EMPTY,
         TRIPLE (COMMA, ID id4, DOUBLE (COMMA, ID id5))))),
   RPAREN, SEMICOLON) -> ()
  | DOUBLE(TILDE, ID "EN") -> ()
  | DOUBLE(QUINTUPLE(IF, LPAREN, cond, RPAREN, TRIPLE(dec, EQUALS, undec)), SEMICOLON) -> ()
  | DOUBLE(TRIPLE(dec, EQUALS, undec), SEMICOLON) -> ()
  | TRIPLE(LBRACK, INT 0, RBRACK) -> ()
  | QUADRUPLE(ID id, LBRACK, INT n, RBRACK) -> ()
  | _ -> unhandled out_chan 690 expr);
ignore(Stack.pop stk)

and toplevelitems out_chan tree =
   let expr = tree.Globals.tree and syms = tree.Globals.symbols in Stack.push (595, expr) stk; ( match expr with
| DOUBLE((INITIAL|FINAL|ALWAYS), stmt) -> stmtBlock out_chan syms stmt
| TRIPLE(ASSIGN, dly, TLIST assignlist) -> hash_dly out_chan syms dly;
    iter (fun a -> match a with TRIPLE(ASSIGNMENT, var1, expr) ->
    ignore(subexp out_chan RECEIVER syms var1);
    ignore(exprGeneric out_chan syms expr) | _ -> unhandled out_chan 560 a) assignlist
| TRIPLE(BUF, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUADRUPLE(nam, SCALAR, x, a) -> vbuf out_chan syms x a
      | _ -> unhandled out_chan 564 inst) instances
| TRIPLE(NOT,dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUADRUPLE(nam, SCALAR, x, a) -> vnot out_chan syms x a
      | _ -> unhandled out_chan 568 inst) instances
| TRIPLE(AND, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUADRUPLE(nam, SCALAR, x, TLIST inlist) -> vand out_chan syms x inlist
      | _ -> unhandled out_chan 572 inst) instances
| TRIPLE(OR, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUADRUPLE(nam, SCALAR, x, TLIST inlist) -> vor out_chan syms x inlist
      | _ -> unhandled out_chan 576 inst) instances
| TRIPLE(XOR, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUADRUPLE(nam, SCALAR, x, TLIST inlist) -> vxor out_chan syms x inlist
      | _ -> unhandled out_chan 580 inst) instances
| TRIPLE(NAND, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUADRUPLE(nam, SCALAR, x, TLIST inlist) -> vand out_chan syms x inlist
      | _ -> unhandled out_chan 584 inst) instances
| TRIPLE(NOR, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUADRUPLE(nam, SCALAR, x, TLIST inlist) -> vor out_chan syms x inlist
      | _ -> unhandled out_chan 588 inst) instances
| TRIPLE(XNOR, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUADRUPLE(nam, SCALAR, x, TLIST inlist) -> vxor out_chan syms x inlist
      | _ -> unhandled out_chan 592 inst) instances
| TRIPLE(BUFIF lev, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUADRUPLE(nam, SCALAR, x, TLIST inlist) -> vbufif out_chan syms x inlist
      | _ -> unhandled out_chan 596 inst) instances
| TRIPLE(NOTIF lev, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUADRUPLE(nam, SCALAR, x, TLIST inlist) -> vnotif out_chan syms x inlist
      | _ -> unhandled out_chan 596 inst) instances
| TRIPLE(PULLUP, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUADRUPLE(nam, EMPTY, EMPTY, x) -> vpullup out_chan syms x
      | _ -> unhandled out_chan 600 inst) instances
| TRIPLE(NMOS, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUINTUPLE(nam, SCALAR, pin1, pin2, pin3) -> vnmos out_chan syms pin1 pin2 pin3
      | _ -> unhandled out_chan 604 inst) instances
| TRIPLE(PMOS, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUINTUPLE(nam, SCALAR, pin1, pin2, pin3) -> vpmos out_chan syms pin1 pin2 pin3
      | _ -> unhandled out_chan 608 inst) instances
| TRIPLE(TRANIF lev, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | TRIPLE(pin1, pin2, pin3) -> vtranif out_chan syms pin1 pin2 pin3
      | _ -> unhandled out_chan 612 inst) instances
| TRIPLE(TRAN, dly, TLIST instances) -> hash_dly out_chan syms dly;
    iter (fun inst -> match inst with
      | QUADRUPLE(nam, SCALAR, pin1, pin2) -> vtran out_chan syms pin1 pin2
      | _ -> unhandled out_chan 616 inst) instances
(* Parse table declarations *)
| DOUBLE(TABLE, TLIST trows) -> iter (fun row -> match row with
  | DOUBLE(TLIST tin,TLIST tout) -> ()
  | TRIPLE(TLIST tin,TLIST treg,TLIST tout) -> ()
  | _ -> unhandled out_chan 621 row) trows
(* Parse specify blocks *)
| DOUBLE(SPECIFY, TLIST lst) -> iter (fun expr -> specifyitems out_chan syms expr) lst
(* Parse primitive instance *)
| QUADRUPLE(PRIMINST, ID prim, params, TLIST inlist) ->
(*
    if (Const.shash_chain_mem Globals.modprims prim) then
      moditemlist out_chan (stem^prim^".") (Const.shash_chain_find Globals.modprims prim) (* scan the inner primitive *)
    else Printf.fprintf (fst out_chan) "Primitive %s not found\n" prim;
*)
    enter_a_sym out_chan syms prim PRIMITIVE EMPTY Create;
    let fc inner t = connect out_chan syms prim prim inner t in 
    ( match (Hashtbl.find Globals.modprims prim).Globals.tree with QUINTUPLE(PRIMITIVE,ID arg1, EMPTY, TLIST primargs, TLIST arg4) ->
iter2 fc primargs inlist | _ -> ())
(* Parse module instance *)
| QUADRUPLE(MODINST, ID kind,params, TLIST instances) ->
    begin
    enter_a_sym out_chan syms kind SUBMODULE EMPTY Create;
    let kindhash = Hashtbl.find Globals.modprims kind in
    iter (fun inst -> match inst with
      | TRIPLE(ID subcct, SCALAR, TLIST termlist) -> (* semantics out_chan (stem^subcct^".") kindhash; *)
        enter_a_sym out_chan syms subcct SUBCCT EMPTY Create;
        ( match kindhash.Globals.tree with QUINTUPLE((MODULE|PRIMITIVE),ID arg1, EMPTY, TLIST primargs, TLIST arg4) ->
        (try iter2 (fun (inner:token) (term:token) -> fiter out_chan syms kind subcct inner term) primargs termlist; with Invalid_argument "List.iter2" -> let ids = ref [] and partlist = ref ([],[])and byposn = ref false in begin
iter (fun (inner:token) -> (match inner with
| ID id -> ids := (!ids @ [id])
| QUINTUPLE ((INPUT|OUTPUT|INOUT), EMPTY, EMPTY, range, DOUBLE(ID id, EMPTY)) -> ids := (!ids @ [id])
| _ -> unhandled out_chan 648 inner)) primargs;
let primstr = !ids in try iter2 (fun (innert:string) (term:token) -> (match term with
| DOUBLE(CELLPIN, ID innern) -> () (*Explicitly unconnected pin*)
| TRIPLE(CELLPIN, ID innern, tok) -> ids := filter (fun item -> item<>innern) !ids
| _ -> byposn := true; ids := filter (fun item -> item<>innert) !ids)) primstr termlist;
with Invalid_argument "List.iter2" -> ();
if (!byposn) then begin
  Printf.fprintf (fst out_chan) "sub-module %s of kind %s deprecated connect by position - %d unconnected pins(s) - might be " subcct kind (length (!ids));
  iter (fun id -> Printf.fprintf (fst out_chan) "%s " id) (!ids);
  output_char (fst out_chan) '\n';
end;
(* Find which of the unconnected pins are inputs *)
partlist := partition (fun inner -> 
(Const.shash_chain_mem kindhash.symbols inner) && (TokSet.mem INPUT (Const.shash_chain_find kindhash.symbols inner).symattr)
) !ids;
if (length (fst(!partlist)) > 0) then begin
Printf.fprintf (fst out_chan) "sub-module %s of kind %s insufficient args - %d unconnected inputs(s): " subcct kind (length (fst(!partlist)));
iter (fun id -> Printf.fprintf (fst out_chan) "%s " id) (fst(!partlist));
output_char (fst out_chan) '\n';
end
end)
        | _ -> unhandled out_chan 713 kindhash.Globals.tree)
      | _ -> unhandled out_chan 714 inst) instances;
    match params with
    | EMPTY -> ()
    | TLIST parmlist -> iter (fun param -> match param with ID id -> () | _ -> unhandled out_chan 717 param) parmlist
    | DOUBLE (HASH, TLIST dlylist) -> iter (fun param -> match param with ID id -> () | _ -> unhandled out_chan 718 param) dlylist
    | _ -> unhandled out_chan 719 params
    end
| _ -> unhandled out_chan 721 expr );
ignore(Stack.pop stk);
mod_empty := false

and dispatch out_chan tree pass2 =
   let expr = tree.Globals.tree and syms = tree.Globals.symbols in Stack.push (726, expr) stk; ( match expr with
(* handled by decls *)
| QUADRUPLE(PARAMETER, EMPTY, EMPTY, params) -> if (pass2==false) then decls out_chan tree Create
| QUINTUPLE((INPUT|OUTPUT|INOUT), arg1, arg2, arg3, arg4) -> if (pass2==true) then decls out_chan tree SizeOnly
| QUADRUPLE((WIRE|REG|TRI0|TRI1|SUPPLY0|SUPPLY1|REAL|INTEGER|EVENT), arg1, arg2, TLIST arg3) -> if (pass2==true) then
    decls out_chan tree Create
(* handled by toplevelitems *)
| DOUBLE((INITIAL|FINAL|ALWAYS|TABLE|SPECIFY), items) -> if (pass2) then toplevelitems out_chan tree
| TRIPLE(ASSIGN, dly, TLIST assignlist) ->  if (pass2) then toplevelitems out_chan tree
| TRIPLE((BUF|NOT|AND|OR|XOR|NAND|NOR|XNOR|PULLUP|NMOS|PMOS|TRAN), dly, TLIST instances) ->  if (pass2) then toplevelitems out_chan tree
| TRIPLE((BUFIF lev|NOTIF lev|TRANIF lev), weaklist, TLIST instances) ->
    if (pass2) then toplevelitems out_chan tree
| QUADRUPLE((MODINST|PRIMINST), ID prim, params, TLIST inlist) ->  if (pass2) then toplevelitems out_chan tree
(* Parse function declarations *)
| OCTUPLE(FUNCTION, EMPTY, range, ID funcname, EMPTY, TLIST args, stmts, EMPTY) -> let syms2 = shash_create syms 256 in (
shash_add syms funcname {Setup.symattr = TokSet.singleton FUNCTION;
                       width = range;
		       sigattr = Sigfunc expr;
		       localsyms = syms2;
		       path=funcname};
iter (fun arg -> decls out_chan {Globals.unresolved=[]; tree=arg; symbols=syms2} Create) args;
if (pass2==false) then stmtBlock out_chan syms2 stmts)
(* Parse task declarations *)
| SEPTUPLE(TASK, EMPTY, ID taskname, EMPTY, TLIST args, stmts, EMPTY) -> let syms2 = shash_create syms 256 in (
shash_add syms taskname {Setup.symattr = TokSet.singleton TASK;
                       width = VOID;
		       sigattr = Sigtask expr;
		       localsyms = syms2;
		       path=taskname};
iter (fun arg -> decls out_chan {Globals.unresolved=[]; tree=arg; symbols=syms2} Create) args;
if (pass2==true) then stmtBlock out_chan syms2 stmts)
| _ -> unhandled out_chan 702 expr );
ignore(Stack.pop stk)

and moditemlist out_chan tree =
   let expr = tree.Globals.tree and syms = tree.Globals.symbols in Stack.push (752, expr) stk; ( match expr with
(* Parse module declarations *)
| QUINTUPLE(MODULE,ID arg1, arg2, TLIST arg3, TLIST arg4) ->
    enter_a_sym out_chan syms arg1 MODULE SCALAR Create;
    misc_syntax out_chan syms arg2;
    iter (fun arg -> match arg with
| ID id -> enter_a_sym out_chan syms id IOPORT UNKNOWN Create
| _ -> decls out_chan {Globals.unresolved=[]; tree=arg; symbols=syms} Create) arg3;
    iter (fun item -> dispatch out_chan {Globals.unresolved=[]; tree=item; symbols=syms} false) arg4;
    iter (fun item -> dispatch out_chan {Globals.unresolved=[]; tree=item; symbols=syms} true) arg4;
(* Parse primitive declarations *)
| QUINTUPLE(PRIMITIVE,ID arg1, EMPTY, TLIST primargs, TLIST arg4) ->
    enter_a_sym out_chan syms arg1 PRIMITIVE EMPTY Create;
    iter (fun arg -> match arg with
      | ID id -> iter (fun x -> enter_a_sym out_chan syms id x UNKNOWN Create) [IOPORT;SPECIAL]; 
      | _ -> misc_syntax out_chan syms arg) primargs;
    iter (fun item -> dispatch out_chan {Globals.unresolved=[]; tree=item; symbols=syms} true) arg4;
| _ -> unhandled out_chan 723 expr );
ignore(Stack.pop stk)

exception Error

let check_syms out_chan key (gsyms:shash) = let h = ref false and msg_cache = Hashtbl.create 256 in match gsyms with
| Shash symr -> 
    let erch () = begin if not !h then Printf.fprintf (fst out_chan) "In %s:\n" key; h := true; end in
    if (List.length(!implicit_params) > 0) then
      ( erch();
        Printf.fprintf (fst out_chan) "Implicit params:";
        List.iter (fun s -> Printf.fprintf (fst out_chan) " %s" s) !implicit_params;
        Printf.fprintf (fst out_chan) "\n" );
    if (List.length(!implicit_wires) > 0) then
      ( erch();
        Printf.fprintf (fst out_chan) "Implicit wires:";
        List.iter (fun s -> Printf.fprintf (fst out_chan) " %s" s) !implicit_wires;
        Printf.fprintf (fst out_chan) "\n" );
    shash_iter (fun nam s -> Check.erc_chk out_chan msg_cache erch symr.syms nam s) gsyms;
    let oc = (fst out_chan) in Hashtbl.iter (fun key contents -> 
        erch(); if List.length contents > 1 then Printf.fprintf oc "%ss: " key else Printf.fprintf oc "%s: " key;
        let tab = ref (1 + String.length key) in List.iter (fun item ->
            Printf.fprintf oc "%s " item; tab := !tab+1+String.length item;
            if !tab > 72 then (output_char oc '\n'; tab := 0)) (qsort contents);
        Printf.fprintf oc "\n") msg_cache
| EndShash -> failwith "No symbol table passed to check_syms"

let scan out_chan key contents = begin
last_mod := key;
Hashtbl.add Globals.modprims key contents;
if (Globals.verbose > 0) then Printf.fprintf (fst out_chan) "scanning ..\n";
mod_empty := true;
implicit_wires := [];
implicit_params := [];
moditemlist out_chan contents;
if !mod_empty then
    Printf.fprintf (fst out_chan) "%s check skipped due to black boxing\n" key
else
    check_syms out_chan key contents.Globals.symbols;
end

let rec remove_from_pending out_chan mykey =  let reslist = ref [] in begin
		Hashtbl.iter (fun key contents ->
contents.Globals.unresolved <- List.filter(fun item -> item <> mykey) contents.Globals.unresolved;
if contents.Globals.unresolved == [] then match contents.Globals.tree with
| QUINTUPLE(kind, ID mykey, _, _, _) -> (
			if (Globals.verbose > 0) then Printf.fprintf (fst out_chan) "%s %s: resumed " (str_token kind) key;
			scan out_chan key contents; reslist := key :: !reslist)
| _ -> unhandled out_chan 899 contents.Globals.tree) pending;
			List.iter (fun key -> Hashtbl.remove pending key; remove_from_pending out_chan key) !reslist;
			end

let prescan out_chan decl =
    let expt = { Globals.tree=decl; symbols=shash_create EndShash 256; unresolved=(!unresolved_list); } in
        match decl with
| QUINTUPLE(kind, ID mykey, _, _, _) ->
	if (Globals.verbose > 0) then Printf.fprintf (fst out_chan) "%s %s: parsed " (str_token kind) mykey;
	if (List.length(!unresolved_list)==0) then begin
		scan out_chan mykey expt;
		remove_from_pending out_chan mykey;
		end
	else begin
		if (Globals.verbose > 0) then (
                    Printf.fprintf (fst out_chan) "pending: not yet encountered: ";
		    List.iter (fun key -> Printf.fprintf (fst out_chan) "%s " key) !unresolved_list;
		    output_char (fst out_chan) '\n';
                    );
		Hashtbl.add pending mykey expt;
		unresolved_list := [];
	end;
	flush (fst out_chan)
| PREPROC str -> Printf.fprintf (fst out_chan) "Encountered %s\n" str
| _ -> unhandled out_chan 919 decl
;;

let rec endscan2 indent mykey =
	match !logfile with Open out_chan -> begin
        if (Globals.verbose > 0) then ( for i = 1 to indent do output_char (fst out_chan) ' '; done;
	Printf.fprintf (fst out_chan) "Checking %s: " mykey );
	if (Hashtbl.mem pending mykey) then
          begin
	  if (Globals.verbose >= 0) then Printf.fprintf (fst out_chan) "Module %s still postponed\n" mykey;
	  List.iter (fun key -> if (Hashtbl.mem pending key) then endscan2 (indent+2) key
          else if (Globals.verbose >= 0) then Printf.fprintf (fst out_chan) "%s " key) ((Hashtbl.find pending mykey).Globals.unresolved);
 	  output_char (fst out_chan) '\n';
          end
	end
	| Closed -> raise Error
;;

let endscan () = let repfile = (!last_mod)^".report" in begin Hashtbl.iter (fun key item -> endscan2 0 key) pending;
match !logfile with
| Open out_chan -> close_out (fst out_chan); logfile := Closed;
Printf.printf "Module %s report %s\n" !last_mod repfile;
Sys.rename tmpnam repfile
| Closed -> ()
end

(*
let nullsym = {Setup.symattr = TokSet.empty; width = EMPTY; localsyms = EndShash; path = ""};;

let moditer k (x:Globals.modtree) = semantics out_chan k x

let find_glob s = Setup.show_sym s ( Const.shash_chain_find s);;

let find_glob_substr s = let reg = Str.regexp s in shash_iter (fun k x -> try Printf.printf "%s posn %d\n" k (Str.search_forward reg k 0); with not_found out_chan -> ()) gsyms;;

let find_referrer s = Setup.show_sym s (match (Const.shash_chain_find s).referrer with Referrer lk -> lk | Nil -> nullsym);;
*)
