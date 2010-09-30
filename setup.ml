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

type refer = Nil | Referrer of symtab

and symtab = {
  symattr : tset;
  width : token;
  referrer : refer;
  path : string;
}

module TokSet = Set.Make (OrdTok)

let one_elm = TokSet.add EMPTY TokSet.empty;;

let rec str_token (e:token) = match e with
| ID id -> id
| RANGE (INTNUM hi,INTNUM lo) -> "[" ^ (string_of_int hi) ^ ":" ^ (string_of_int lo) ^ "] "
| TRIPLE (DOT, inner, tok) -> "."^(str_token inner)^"("^(str_token tok)^")"
| _ -> (Ord.getstr e);;

let show_token (e:token) = Printf.printf "%s " (str_token e)

let show_set s = TokSet.iter (fun e -> Printf.printf "%s " (str_token e)) s;;

let show_sym _ (x:symtab) = Printf.printf "%s: " x.path; TokSet.iter show_token x.symattr; print_char '\n';;
