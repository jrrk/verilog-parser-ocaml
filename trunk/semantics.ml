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

let enter_a_sym symbols id attr w = 
if Hashtbl.mem symbols id then begin
(*  printf "Update %s: %s\n" id (Ord.getstr attr); *)
  let newset = (Hashtbl.find symbols id).symattr and oldw = (Hashtbl.find symbols id).width in
  Hashtbl.replace symbols id ({Setup.symattr = (TokSet.add attr newset); width = (if oldw==EMPTY then w else oldw)}); end
else begin
(*  printf "Enter %s: %s\n" id (Ord.getstr attr); *)
  Hashtbl.add symbols id ({Setup.symattr = (TokSet.singleton attr); width = w;})
  end
;;

let iter_ semantics out_chan gsyms (stem:string) syms list =
  List.iter (fun x -> semantics out_chan gsyms stem ({Globals.tree=x; symbols=syms})) list
;;

let unhand_list = ref [EMPTY];;

let unhandled arg = unhand_list := arg :: !unhand_list; hd([])

let not_found syms w = printf "wire/port %s not found\n" w; enter_a_sym syms w IMPLICIT EMPTY;;

let find_ident gsyms dir stem syms tok = match tok with ID id -> begin
if Hashtbl.mem syms id == false then begin
  printf "Creating implicit wire %s\n" id;
  Hashtbl.add syms id ({Setup.symattr = TokSet.singleton IMPLICIT; width = EMPTY;})
  end;
enter_a_sym gsyms (stem^id) dir EMPTY;
Hashtbl.find syms id
end
| BINNUM lev -> ({Setup.symattr = TokSet.singleton tok; width = EMPTY;})
| _ -> unhandled tok; ({Setup.symattr = TokSet.singleton tok; width = EMPTY;})
;;

let enter_sym_attrs gsyms dir stem symbols (tok:token) list width = match tok with
| ID id -> enter_a_sym gsyms (stem^id) dir width;
  iter (fun x -> enter_a_sym symbols id x width) list
| _ -> unhandled tok;
;;

let subexp gsyms stem syms exp = match exp with
| ID id -> find_ident gsyms DRIVER stem syms exp
| TRIPLE (BITSEL, ID id, INTNUM n) -> find_ident gsyms DRIVER stem syms (ID id)
| _ -> unhandled exp; {symattr=TokSet.singleton exp; width=EMPTY;};;

let subexp2 gsyms stem syms exp = {entry=exp; symbol=(subexp gsyms stem syms exp)};;

let expr_dyadic gsyms stem syms op left right = DYADIC(op, subexp2 gsyms stem syms left, subexp2 gsyms stem syms right);;

let expression gsyms stem syms (tree:token) = match tree with
| TRIPLE (PLUS as op, left, right) -> expr_dyadic gsyms stem syms op left right
| _ -> UNHANDLED tree;;

let statement gsyms stem syms tok var expr = (
let x = subexp gsyms stem syms var in
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

let inner_chk gsyms stem syms sym subcct inner wireport wid = begin
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
  else if (TokSet.mem INPUT sym.symattr) then ( enter_a_sym gsyms hier DRIVER wid; enter_a_sym gsyms hier2 RECEIVER wid )
  else if (TokSet.mem OUTPUT sym.symattr) then ( enter_a_sym gsyms hier RECEIVER wid; enter_a_sym gsyms hier2 DRIVER wid )
  else if (TokSet.mem INOUT sym.symattr) then ( enter_a_sym gsyms hier BIDIR wid; enter_a_sym gsyms hier2 BIDIR wid )
  end
end

let iwidth wid =  match wid with 
| RANGE(INTNUM ihi, INTNUM ilo) -> (ihi,ilo)
| EMPTY -> (0,0)
| _ -> unhandled wid; (-1,-1)

let rec connect gsyms stem syms kind subcct (innert:token) tok = 
let innersym = (Hashtbl.find Globals.modprims kind).symbols in match innert with ID inner -> begin
if (Hashtbl.mem innersym inner) then
let isym=Hashtbl.find innersym inner in match tok with
| ID wireport -> if (Hashtbl.mem syms wireport) then inner_chk gsyms stem syms isym subcct inner wireport (Hashtbl.find syms wireport).width else not_found syms wireport
| TRIPLE(BITSEL, ID wireport, INTNUM sel) -> if (Hashtbl.mem syms wireport) then inner_chk gsyms stem syms isym subcct inner wireport (RANGE (INTNUM sel, INTNUM sel)) else not_found syms wireport
| QUADRUPLE(PARTSEL, ID wireport, INTNUM hi, INTNUM lo) -> if (Hashtbl.mem syms wireport) then inner_chk gsyms stem syms isym subcct inner wireport (RANGE(INTNUM hi, INTNUM lo)) else not_found syms wireport
| INTNUM lev -> inner_chk gsyms stem syms isym subcct inner (string_of_int lev) (RANGE(INTNUM 31, INTNUM 0))
| BINNUM lev -> inner_chk gsyms stem syms isym subcct inner lev (RANGE(INTNUM (fst(widthnum 2 lev)-1), INTNUM 0))
| TLIST concat -> let idx = ref (fst(iwidth isym.width)) in iter (fun (item:token) -> 
(match item with
| ID id -> let wid = (Hashtbl.find syms id).width in begin inner_chk gsyms stem syms {symattr=isym.symattr; width=RANGE(INTNUM !idx, INTNUM !idx)} subcct inner id wid; idx := !idx + snd(iwidth wid) - fst(iwidth wid); end
| TRIPLE (BITSEL, ID id, INTNUM sel) -> inner_chk gsyms stem syms {symattr=isym.symattr; width=RANGE(INTNUM !idx, INTNUM !idx)} subcct inner id (RANGE(INTNUM sel, INTNUM sel)); idx := !idx-1
| QUADRUPLE (PARTSEL, ID id, INTNUM hi, INTNUM lo) -> inner_chk gsyms stem syms {symattr=isym.symattr; width=RANGE(INTNUM !idx, INTNUM (!idx+lo-hi))} subcct inner id (RANGE(INTNUM hi, INTNUM lo)); idx := !idx+lo-hi-1
| _ -> unhandled item)
) concat
| _ -> unhandled tok
else printf "Instance port %s not found\n" inner
end
| _ -> unhandled innert
;;

let vbuf gsyms stem syms (x:token) a =
ignore(find_ident gsyms RECEIVER stem syms x);
ignore(find_ident gsyms DRIVER stem syms a);;

let vbufif gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | BINNUM lev -> () | _ -> unhandled t) inlist;;

let vnot gsyms stem syms (x:token) a =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun w -> ignore(find_ident gsyms DRIVER stem syms w)) [x;a];;

let vand gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | _ -> unhandled t) inlist;;

let vor gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | _ -> unhandled t) inlist;;

let vxor gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | _ -> unhandled t) inlist;;

let vnand gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | _ -> unhandled t) inlist;;

let vnor gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | _ -> unhandled t) inlist;;

let vxnor gsyms stem syms (x:token) (inlist:token list) =
ignore(find_ident gsyms RECEIVER stem syms x);
iter (fun t -> match t with ID w -> ( ignore(find_ident gsyms DRIVER stem syms t)
	  ) | _ -> unhandled t) inlist;;

let f2 inner t = show_token(inner);show_token(t);print_char '\n';;

let fiter gsyms (stem:string) syms (kind:string) (subcct:string) (inner:token) (term:token) = match term with
          (* connect by position syntax - deprecated *)
          | TRIPLE (DOT, myinner, tok) -> connect gsyms stem syms kind subcct myinner tok
          | ID id -> connect gsyms stem syms kind subcct inner term
	  | TLIST concat -> connect gsyms stem syms kind subcct inner term
          | QUADRUPLE (PARTSEL, ID net, INTNUM hi, INTNUM lo) -> connect gsyms stem syms kind subcct inner term
	  | _ -> unhandled term
;;

let rec semantics out_chan gsyms (stem:string) (tree:Globals.modtree) =
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
| DOUBLE(SPECIFY, TLIST speclist) -> iter (fun item -> match item with ID id -> enter_a_sym gsyms (stem^id) SPECIFY EMPTY| _ -> ()) speclist
| TRIPLE(ASSIGN, EMPTY, TLIST assignlist)
-> iter (fun a -> match a with TRIPLE (EQUALS, var1, expr) -> statement gsyms stem syms ASSIGN var1 (expression gsyms stem syms expr) | _ -> unhandled a) assignlist
| TRIPLE(EQUALS, TLIST arg1, TLIST arg2) -> iter_ semantics out_chan gsyms stem syms arg1; iter_ semantics out_chan gsyms stem syms arg2
| TRIPLE(IF, TLIST arg1, TLIST arg2) -> iter_ semantics out_chan gsyms stem syms arg1; iter_ semantics out_chan gsyms stem syms arg2
| TRIPLE(PLUS, TLIST arg1, TLIST arg2) -> iter_ semantics out_chan gsyms stem syms arg1; iter_ semantics out_chan gsyms stem syms arg2
| TRIPLE(BUF,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, a) -> vbuf gsyms stem syms x a
      | _ -> unhandled inst) instances
| TRIPLE(NOT,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, a) -> vnot gsyms stem syms x a
      | _ -> unhandled inst) instances
| TRIPLE(AND,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vand gsyms stem syms x inlist
      | _ -> unhandled inst) instances
| TRIPLE(OR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vor gsyms stem syms x inlist
      | _ -> unhandled inst) instances
| TRIPLE(XOR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vxor gsyms stem syms x inlist
      | _ -> unhandled inst) instances
| TRIPLE(NAND,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vand gsyms stem syms x inlist
      | _ -> unhandled inst) instances
| TRIPLE(NOR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vor gsyms stem syms x inlist
      | _ -> unhandled inst) instances
| TRIPLE(XNOR,EMPTY, TLIST instances) ->
    iter (fun inst -> match inst with
      | QUADRUPLE (EMPTY, EMPTY, x, TLIST inlist) -> vxor gsyms stem syms x inlist
      | _ -> unhandled inst) instances
| TRIPLE(BUFIF lev, TLIST [WEAK "weak0"; WEAK "weak1"], TLIST instances) ->
    iter (fun inst -> match inst with
      | DOUBLE (x, TLIST inlist) -> vbufif gsyms stem syms x inlist
      | _ -> unhandled inst) instances
(* Parse primitive instance *)
| TRIPLE(PRIMINST, ID prim, TLIST inlist) ->
    if (Hashtbl.mem Globals.modprims prim) then
      semantics out_chan gsyms (stem^prim^".") (Hashtbl.find Globals.modprims prim) (* scan the inner primitive *)
    else printf "Primitive %s not found\n" prim;
    enter_a_sym syms prim PRIMITIVE EMPTY;
    let fc inner t = connect gsyms stem syms prim prim inner t in 
    ( match (Hashtbl.find Globals.modprims prim).Globals.tree with QUINTUPLE(PRIMITIVE,ID arg1, EMPTY, TLIST primargs, TLIST arg4) ->
iter2 fc primargs inlist | _ -> ())
(* Parse module instance *)
| TRIPLE(ID kind,EMPTY, TLIST instances) ->
      if (Hashtbl.mem Globals.modprims kind == false) then printf "sub-module %s not found\n" kind else
(*    printf "Scanning sub-module %s\n" kind;  *)
    begin
    enter_a_sym syms kind SUBMODULE EMPTY;
    let kindhash = Hashtbl.find Globals.modprims kind in iter (fun inst -> match inst with
      | TRIPLE (ID subcct, EMPTY, TLIST termlist) -> semantics out_chan gsyms (stem^subcct^".") kindhash;
        enter_a_sym syms subcct SUBCCT EMPTY;
        ( match kindhash.Globals.tree with QUINTUPLE(MODULE,ID arg1, EMPTY, TLIST primargs, TLIST arg4) ->
        (try iter2 (fun (inner:token) (term:token) -> fiter gsyms stem syms kind subcct inner term) primargs termlist; with Invalid_argument "List.iter2" -> fprintf out_chan "sub-module %s insufficient args\n" kind)
        | _ -> unhandled kindhash.Globals.tree)
      | _ -> unhandled inst) instances
    end
| QUADRUPLE(EQUALS, TLIST arg1, TLIST arg2, TLIST arg3) -> iter_ semantics out_chan gsyms stem syms arg1; iter_ semantics out_chan gsyms stem syms arg2; iter_ semantics out_chan gsyms stem syms arg3
| QUADRUPLE(IF, TLIST arg1, TLIST arg2, TLIST arg3) -> iter_ semantics out_chan gsyms stem syms arg1; iter_ semantics out_chan gsyms stem syms arg2; iter_ semantics out_chan gsyms stem syms arg3
(* Parse wire/reg declarations *)
| QUADRUPLE((WIRE|REG) as kind, arg1, arg2, TLIST arg3) ->
    let width = ref EMPTY in begin
    semantics out_chan gsyms stem {Globals.tree=arg1; symbols=syms};
    (match arg2 with
      | RANGE(INTNUM hi, INTNUM lo) as rangehilo -> width := rangehilo
      | TRIPLE(EMPTY,(RANGE(INTNUM hi, INTNUM lo) as rangehilo),EMPTY) -> width := rangehilo
      | TLIST arg7 ->  List.iter (fun arg -> unhandled arg) arg7
      | EMPTY -> ()
      | TRIPLE(EMPTY,EMPTY,EMPTY) -> ()
      | _ ->  unhandled arg2);
    ( List.iter (fun x -> match x with
      | TRIPLE(id, arg5, arg6) -> enter_sym_attrs gsyms kind stem syms id [kind] !width
      | DOUBLE(id, EMPTY) -> enter_sym_attrs gsyms kind stem syms id [kind] !width
      | _ -> unhandled x) arg3); end
(* Parse module declarations *)
| QUINTUPLE(MODULE,ID arg1, arg2, TLIST arg3, TLIST arg4) ->
    enter_a_sym syms arg1 MODULE EMPTY; (* print_endline (stem^arg1); *)
    semantics out_chan gsyms stem {Globals.tree=arg2; symbols=syms};
    iter (fun arg -> match arg with ID id -> enter_a_sym syms id IOPORT EMPTY| _ -> semantics out_chan gsyms stem {Globals.tree=arg; symbols=syms}) arg3;
    iter_ semantics out_chan gsyms stem syms arg4
(* Parse primitive declarations *)
| QUINTUPLE(PRIMITIVE,ID arg1, EMPTY, TLIST arg3, TLIST arg4) ->
    enter_a_sym syms arg1 (PRIMARGS arg3) EMPTY;
    iter (fun arg -> match arg with ID id -> enter_a_sym syms id IOPORT EMPTY| _ -> semantics out_chan gsyms stem {Globals.tree=arg; symbols=syms}) arg3;
    iter_ semantics out_chan gsyms stem syms arg4
(* Parse IO declarations *)
| QUINTUPLE((INPUT|OUTPUT|INOUT) as dir, arg1, arg2, arg3, arg4) ->
    let width = ref EMPTY in begin
    semantics out_chan gsyms stem {Globals.tree=arg1; symbols=syms};
    semantics out_chan gsyms stem {Globals.tree=arg2; symbols=syms};
    (match arg3 with
      | RANGE(INTNUM hi,INTNUM lo) as rangehilo -> width := rangehilo
      | TLIST arg9 ->  List.iter (fun arg -> unhandled arg) arg9
      | EMPTY -> ()
      | _ -> unhandled arg3);
    ( match arg4 with
      | DOUBLE(id, arg5) -> enter_sym_attrs gsyms dir stem syms id [IOPORT;dir] !width
      | TRIPLE(id, TLIST arg5, TLIST arg6) -> enter_sym_attrs gsyms dir stem syms id [IOPORT;dir] !width
      | TLIST arg9 ->  List.iter (fun x -> match x with TRIPLE(id, arg5, arg6) -> enter_sym_attrs gsyms dir stem syms id [IOPORT;dir] !width | _ -> unhandled x) arg9
      | EMPTY -> ()
      | _ -> unhandled arg4); end
| QUINTUPLE(MODULE,ID arg1, EMPTY, EMPTY, EMPTY) -> enter_a_sym syms arg1 MODULE EMPTY
| RANGE(arg1, arg2) -> semantics out_chan gsyms stem {Globals.tree=arg1; symbols=syms}; semantics out_chan gsyms stem {Globals.tree=arg2; symbols=syms}
| ID id -> enter_a_sym syms id EMPTY EMPTY
| DOUBLE(SPECIFY,EMPTY) -> ()
| PREPROC txt -> ()
| TABLE -> ()
| EMPTY -> ()
| _ -> unhandled exp;;

(* let moditer k (x:Globals.modtree) = semantics out_chan gsyms k x;; *)

let find_glob gsyms s = Setup.show_sym s ( Hashtbl.find gsyms s);;

let find_glob_substr gsyms s = let reg = Str.regexp s in Hashtbl.iter (fun k x -> try Printf.printf "%s %d\n" k (Str.search_forward reg k 0); with Not_found -> ()) gsyms;;

let dotted s = try String.index s '.' > 0 ; with Not_found -> false;;

let erc_chk out_chan nam s = let sym = s.symattr in
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
	end
  end
;;

let check_glob out_chan gsyms = Hashtbl.iter (fun nam s -> erc_chk out_chan nam s) gsyms;;
