(******************************************************************************
*
*    DESCRIPTION: Verilog parser constant expression manipulation program
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

open Vparser
open Globals
open Setup
open Ord

let rec exprBoolean out_chan (syms:shash) op expr1 expr2 =
op (exprConst out_chan syms expr1) (exprConst out_chan syms expr2)

and widthnum out_chan expbase (str:string) =
let base = ref 10
and width = ref 0
and value = ref 0
and basing = ref 0
and converting = ref true in
for idx = 0 to String.length(str)-1 do let ch = Char.lowercase(str.[idx]) in begin
if (Globals.verbose >= 2) then Printf.fprintf (fst out_chan) "%c %d %d\n" ch !base !value;
    match ch with
| '\'' -> converting := false; basing := idx+1;
| '0'..'9' -> if (!converting) then
    width := (!width * !base) + int_of_char(ch) - int_of_char('0')
else
    value := (!value * !base) + int_of_char(ch) - int_of_char('0')
| 'a'..'z' ->  if (!converting) then
    width := (!width * !base) + int_of_char(ch) - int_of_char('a') + 10
else if (!basing==idx) then begin match ch with
  | 'b' -> base := 2
  | 'd' -> base := 10
  | 'h' -> base := 16
  | _ -> value := int_of_char(ch) - int_of_char('a') + 10
end else
    value := (!value * !base) + int_of_char(ch) - int_of_char('a') + 10;
| _ -> converting := false; width := 0
end
done;
if (!basing == 0) then begin
  value := !width;
  width := 32;
end;
if (!base <> expbase) then Printf.printf "Expected base %d, actual base %d\n" expbase !base;
(!width, !value)

and shash_chain_mem (syms:shash) nam = match syms with
| Shash symr -> if Hashtbl.mem symr.syms nam then true else shash_chain_mem symr.nxt nam
| EndShash -> false

and shash_chain_find (syms:shash) nam = match syms with
| Shash symr -> if Hashtbl.mem symr.syms nam then Hashtbl.find symr.syms nam else shash_chain_find symr.nxt nam
| EndShash -> failwith "Not found"

and shash_chain_replace (syms:shash) (nam:string) (sym:symtab) = match syms with
| Shash symr -> if Hashtbl.mem symr.syms nam then Hashtbl.replace symr.syms nam sym else shash_chain_replace symr.nxt nam sym
| EndShash -> failwith "Not found"

and exprConst out_chan (syms:shash) expr = Stack.push (67, expr) stk; let rslt = ( match expr with
| INT n -> n
| HEXNUM str -> snd(widthnum out_chan 16 str)
| TRIPLE(TIMES, expr1, expr2) -> (exprConst out_chan syms expr1) * (exprConst out_chan syms expr2)
| TRIPLE(PLUS, expr1, expr2) -> (exprConst out_chan syms expr1) + (exprConst out_chan syms expr2)
| TRIPLE(MINUS, expr1, expr2) -> (exprConst out_chan syms expr1) - (exprConst out_chan syms expr2)
| TRIPLE(P_EQUAL, expr1, expr2) -> if (exprBoolean out_chan syms (=)) expr1 expr2 then 1 else 0
| TRIPLE(P_NOTEQUAL, expr1, expr2) -> if (exprBoolean out_chan syms (<>)) expr1 expr2 then 1 else 0
| TRIPLE(LESS, expr1, expr2) -> if (exprBoolean out_chan syms (<)) expr1 expr2 then 1 else 0
| TRIPLE(GREATER, expr1, expr2) -> if (exprBoolean out_chan syms (>)) expr1 expr2 then 1 else 0
| TRIPLE(P_LTE, expr1, expr2) -> if (exprBoolean out_chan syms (<=)) expr1 expr2 then 1 else 0
| TRIPLE(P_GTE, expr1, expr2) -> if (exprBoolean out_chan syms (>=)) expr1 expr2 then 1 else 0
| DOUBLE(CONCAT, TLIST [left; right]) -> Printf.fprintf (fst out_chan) "Concat expr not yet implemented, value 1 assumed\n"; 1

| ID id -> begin
if shash_chain_mem syms id == false then begin
    Printf.fprintf (fst out_chan) "constant %s not declared, value 1 assumed\n" id;
    1
    end
else
    let found = shash_chain_find syms id in match found.sigattr with
    | Sigparam pexpr -> shash_chain_replace syms id
    {Setup.symattr = (TokSet.add PARAMUSED found.symattr); width = found.width; sigattr = found.sigattr; localsyms = EndShash; path=id};
    exprConst out_chan syms pexpr
    | Sigarray x -> Printf.fprintf (fst out_chan) "%s not a constant or for variable, value 1 assumed\n" id; 1
    | _ -> unhandled out_chan 89 expr; 1
  end
| TRIPLE(FUNCREF, ID id, TLIST args) -> Printf.fprintf (fst out_chan) "%s is a function, value 1 assumed\n" id; 1
| QUADRUPLE(PARTSEL, arg, INT hi, INT lo) -> (exprConst out_chan syms arg) lsr lo
| TRIPLE(P_SLEFT, INT 1, ID id) -> Printf.fprintf (fst out_chan) "Const expression 1<<%s is too complicated, value 1 assumed\n" id; 1
| _ -> unhandled out_chan 97 expr; 1 ) in
ignore(Stack.pop stk);
rslt

let iwidth out_chan syms wid =  match wid with 
| RANGE(expr1, expr2) -> (exprConst out_chan syms expr1,exprConst out_chan syms expr2)
| UNKNOWN -> (0,0)
| SCALAR -> (0,0)
| EMPTY -> (0,0)
| _ -> unhandled out_chan 56 wid; (-1,-1)

let maxwidth out_chan syms neww = let w = iwidth out_chan syms neww in
1 + (max (fst w) (snd w))

let show_set s = TokSet.iter (fun e -> Printf.printf "%s " (str_token e)) s;;

let show_chk_sig nam syma siga =
  begin
  Printf.printf "%s: " nam;
  show_set siga;
  Printf.printf "\n"
  end

let show_sig_attr syms id s = match s.sigattr with
| Sigarray attrs -> (
match s.width with
| RANGE range -> let (hi,lo) = iwidth (stderr,Format.err_formatter) syms s.width in
  if not ((TokSet.mem IMPLICIT s.symattr)||(TokSet.mem MEMORY s.symattr)) then
  ( try for i = hi downto lo do
    show_chk_sig (id^"["^(string_of_int i)^"]") s.symattr attrs.(i)
    done
  with Invalid_argument("index out of bounds") -> Printf.printf "Trying to access %s with index [%d:%d]\n" id hi lo)
| SCALAR | EMPTY | UNKNOWN->
    show_chk_sig id s.symattr attrs.(0)
| _ -> unhandled (stderr,Format.err_formatter) 791 s.width)
| Sigparam x ->
  if not (TokSet.mem PARAMUSED s.symattr) then Printf.printf "Parameter %s is not used\n" id
| Sigtask x ->
  if not (TokSet.mem TASKUSED s.symattr) then Printf.printf "Task %s is not used\n" id
| Sigfunc x ->
  if not (TokSet.mem FUNCUSED s.symattr) then Printf.printf "Function %s is not used\n" id
| _ -> unhandled (stderr,Format.err_formatter) 804 s.width

let show_token (e:token) = Printf.printf "%s " (str_token e)

let show_sym _ (x:symtab) = Printf.printf "%s: " x.path; TokSet.iter show_token x.symattr; print_char '\n';;

let dump_sym m s = let gsyms = (Hashtbl.find Globals.modprims m).Globals.symbols in match gsyms with
| Shash symr -> let sym = Hashtbl.find symr.syms s in (
Setup.TokSet.iter show_token sym.Setup.symattr;
Printf.printf "\n";
show_sig_attr gsyms s sym
)
| EndShash -> ()

let my_syms m = match (Hashtbl.find Globals.modprims m).Globals.symbols with
| Shash symr -> Hashtbl.iter show_sym symr.syms
| EndShash -> ()

let dump_syms m = match (Hashtbl.find Globals.modprims m).Globals.symbols with
| Shash symr -> Hashtbl.iter show_sym symr.syms
| EndShash -> ()

