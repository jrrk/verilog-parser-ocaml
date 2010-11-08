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

open Other
open Grammar_sysver

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
        Sigparam of Grammar_sysver.token |
        Sigtask of Grammar_sysver.token |
        Sigfunc of Grammar_sysver.token |
	Signamed of Grammar_sysver.token

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
| SIMPLE_IDENTIFIER_2 id -> id
| RANGE (INT hi,INT lo) -> "[" ^ (string_of_int hi) ^ ":" ^ (string_of_int lo) ^ "] "
| RANGE (hi, lo) -> "[" ^ (str_token hi) ^ ":" ^ (str_token lo) ^ "] "
| TRIPLE (DOT, inner, tok) -> "."^(str_token inner)^"("^(str_token tok)^")"
| DOUBLE(arg1, arg2) -> (str_token arg1)^" "^(str_token arg2)
| TRIPLE(arg1,arg2,arg3) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)
| QUADRUPLE(arg1,arg2,arg3,arg4) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)
| QUINTUPLE(arg1,arg2,arg3,arg4,arg5) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)^" "^(str_token arg5)
| SEXTUPLE(arg1,arg2,arg3,arg4,arg5,arg6) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)^" "^(str_token arg5)^" "^(str_token arg6)
| SEPTUPLE(arg1,arg2,arg3,arg4,arg5,arg6,arg7) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)^" "^(str_token arg5)^" "^(str_token arg6)^" "^(str_token arg7)
| OCTUPLE(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)^" "^(str_token arg5)^" "^(str_token arg6)^" "^(str_token arg7)^" "^(str_token arg8)
| NONUPLE(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)^" "^(str_token arg5)^" "^(str_token arg6)^" "^(str_token arg7)^" "^(str_token arg8)^" "^(str_token arg9)
| DECUPLE(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)^" "^(str_token arg5)^" "^(str_token arg6)^" "^(str_token arg7)^" "^(str_token arg8)^" "^(str_token arg9)^" "^(str_token arg10)
| UNDECUPLE(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)^" "^(str_token arg5)^" "^(str_token arg6)^" "^(str_token arg7)^" "^(str_token arg8)^" "^(str_token arg9)^" "^(str_token arg10)^" "^(str_token arg11)
| DUODECUPLE(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)^" "^(str_token arg5)^" "^(str_token arg6)^" "^(str_token arg7)^" "^(str_token arg8)^" "^(str_token arg9)^" "^(str_token arg10)^" "^(str_token arg11)^" "^(str_token arg12)
| _ -> (Grammar_sysver.getstr e)
