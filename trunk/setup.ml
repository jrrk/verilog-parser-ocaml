(******************************************************************************
*
*    DESCRIPTION: Verilog parser set manipulation program
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
open Ord;;

let compare_tok (a:token) (b:token) = if (a > b) then 1 else if (a < b) then -1 else 0;;

module type Ordered =
  sig
    type t 
    val compare : token -> token -> int
  end

module OrdTok : Ordered with type t = token =
  struct
    type t = token
    let compare a b = compare_tok a b;
  end

type tset = Set.Make(OrdTok).t

type tsigattr = Sigundef |
        Sigarray of tset array |
        Sigparam of Vparser.token |
        Sigtask of Vparser.token |
        Sigfunc of Vparser.token |
	Signamed of Vparser.token

and symtab = {
  symattr : tset;
  width : token;
  path : string;
  sigattr : tsigattr;
  localsyms : shash;
}

and sentries = (string, symtab) Hashtbl.t

and symrec = { nxt : shash; syms: sentries; }
 
and shash = EndShash | Shash of symrec

type fmt = (out_channel*Format.formatter)

type logt = Closed | Open of fmt;;

module TokSet = Set.Make (OrdTok)

  let hsiz = 64;;
  type hist = {tok:token;strt:int;stop:int;key:bool;};;
  let histcnt = ref 0;;
  let history = Array.init hsiz (fun i-> ref {tok=EMPTY;strt=0;stop=0;key=false});;
  let psuccess = ref false;;

let one_elm = TokSet.add EMPTY TokSet.empty;;

let rec str_token (e:token) = match e with
| ID id -> id
| RANGE (INT left,INT right) -> "[" ^ (string_of_int left) ^ ":" ^ (string_of_int right) ^ "] "
| RANGE (left, right) -> "[" ^ (str_token left) ^ ":" ^ (str_token right) ^ "] "
| TRIPLE (DOT, inner, tok) -> "."^(str_token inner)^"("^(str_token tok)^")"
| WEAK arg | PWEAK arg -> arg
| PREPROC arg -> arg
| INTNUM arg -> "INTNUM "^arg
| ILLEGAL arg -> "ILLEGAL "^(String.make 1 arg)
| HEXNUM arg -> "HEXNUM "^arg
| FLOATNUM arg -> "FLOATNUM "^(string_of_float arg)
| DECNUM arg -> "DECNUM "^arg
| BUFIF arg -> arg
| BINNUM arg -> "BINNUM "^arg
| ASCNUM arg -> "ASCNUM "^arg
| EDGE arg -> Printf.sprintf "EDGE %c%c" (fst arg) (snd arg)
| SCALAR -> "scalar"
| WIRE -> "wire"
| REG -> "reg"
| _ -> (Ord.getstr e)
