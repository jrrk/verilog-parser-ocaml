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

open Liberty_parser

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
        Sigparam of Liberty_parser.token |
        Sigtask of Liberty_parser.token |
        Sigfunc of Liberty_parser.token |
	Signamed of Liberty_parser.token

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
| STRING id -> "STRING "^id
| ID id -> "ID "^(str_token id)
| NUM num -> string_of_float num
| DOUBLE(arg1, arg2) -> (str_token arg1)^" "^(str_token arg2)
| TRIPLE(arg1,arg2,arg3) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)
| QUADRUPLE(arg1,arg2,arg3,arg4) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)
| QUINTUPLE(arg1,arg2,arg3,arg4,arg5) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)^" "^(str_token arg5)
| SEXTUPLE(arg1,arg2,arg3,arg4,arg5,arg6) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)^" "^(str_token arg5)^" "^(str_token arg6)
| SEPTUPLE(arg1,arg2,arg3,arg4,arg5,arg6,arg7) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)^" "^(str_token arg5)^" "^(str_token arg6)^" "^(str_token arg7)
| OCTUPLE(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8) -> (str_token arg1)^" "^(str_token arg2)^" "^(str_token arg3)^" "^(str_token arg4)^" "^(str_token arg5)^" "^(str_token arg6)^" "^(str_token arg7)^" "^(str_token arg8)
| _ -> (Liberty.getstr e)
