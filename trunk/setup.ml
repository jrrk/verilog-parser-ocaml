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

let compare_tok (a:token) (b:token) = ord(a) - ord(b);;

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

module TokSet = Set.Make (OrdTok)

let one_elm = TokSet.add EMPTY TokSet.empty;;

let show_set s = TokSet.iter (fun e -> Printf.printf "%s\n" (Ord.getstr(e))) s;;

let show_token (e:token) = Printf.printf "%s\n" (match e with ID id -> id | RANGE ([INTNUM hi],[INTNUM lo]) -> "[" ^ (Nativeint.to_string hi) ^ ":" ^ (Nativeint.to_string lo) ^ "] " | _ -> (Ord.getstr e));;
let show_sym k (x:TokSet.t) = Printf.printf "%s: " k; TokSet.iter show_token x;;
