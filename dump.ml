(******************************************************************************
*
*    DESCRIPTION: Verilog parser dump parser tree file
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

open Printf
open Vparser
open List

let rec dump (exp, indent) =
   match exp with
| DOUBLE(tok,arg) -> printf "\n"; for i = 1 to indent do printf " " done; dump (tok, indent) ; myiter indent dump arg
| TRIPLE(EQUALS,arg1,arg2) -> printf "\n"; for i = 1 to indent do printf " " done; myiter indent dump arg1; printf "= "; myiter indent dump arg2;
| TRIPLE(IF,arg1,arg2) -> printf "\n"; for i = 1 to indent do printf " " done; printf "if ( "; myiter indent dump arg1; printf ") "; myiter indent dump arg2;
| TRIPLE(PLUS,arg1,arg2) -> printf "\n"; for i = 1 to indent do printf " " done; myiter indent dump arg1; printf "+ "; myiter indent dump arg2;
| TRIPLE(tok,arg1,arg2) -> printf "\n"; for i = 1 to indent do printf " " done; dump (tok, indent) ; myiter indent dump arg1; myiter indent dump arg2;
| QUADRUPLE(EQUALS,arg1,arg2,arg3) -> printf "\n"; for i = 1 to indent do printf " " done; myiter indent dump arg1; printf "= "; myiter indent dump arg2; myiter indent dump arg3;
| QUADRUPLE(IF,arg1,arg2,arg3) -> printf "\n"; for i = 1 to indent do printf " " done; printf "if ( "; myiter indent dump arg1; printf ") "; myiter indent dump arg2; printf "else "; myiter indent dump arg3;
| QUADRUPLE(tok,arg1,arg2,arg3) -> printf "\n"; for i = 1 to indent do printf " " done; dump (tok, indent) ; myiter indent dump arg1; myiter indent dump arg2; myiter indent dump arg3;
| QUINTUPLE(MODULE,arg1,arg2,arg3,arg4) -> printf "module "; myiter indent dump arg1; printf " "; myiter indent dump arg2; printf "\n"; myiter indent dump arg3; printf "\n"; myiter indent dump arg4; printf "\nendmodule\n"
| QUINTUPLE(tok,arg1,arg2,arg3,arg4) -> printf "\n"; for i = 1 to indent do printf " " done; dump (tok, indent) ; myiter indent dump arg1; myiter indent dump arg2; myiter indent dump arg3; myiter indent dump arg4;
| SEXTUPLE(tok,arg1,arg2,arg3,arg4,arg5) -> printf "\n"; for i = 1 to indent do printf " " done; dump (tok, indent) ; myiter indent dump arg1; myiter indent dump arg2; myiter indent dump arg3; myiter indent dump arg4; myiter indent dump(arg5);
| SEPTUPLE(tok,arg1,arg2,arg3,arg4,arg5,arg6) -> printf "\n"; for i = 1 to indent do printf " " done; dump (tok, indent) ; myiter indent dump arg1; myiter indent dump arg2; myiter indent dump arg3; myiter indent dump arg4; myiter indent dump(arg5); myiter indent dump(arg6);
| RANGE(arg1,arg2) -> printf "[ "; myiter indent dump arg1; printf ": "; myiter indent dump arg2; printf "] "
| ALWAYS -> printf "always "
| ASCNUM c -> printf "ASCNUM(%s) " c
| ASSIGN -> printf "assign "
| AT -> printf "@ "
| BINNUM c -> printf "BINNUM(%s) " c
| BITSEL -> printf "BitSelect "
| COMMENT_BEGIN cmnt -> printf "COMMENT_BEGIN %s " cmnt
| D_ATTRIBUTE -> printf "$attribute "
| DECNUM c -> printf "DECNUM(%s) " c
| DOT -> printf " ."
| EMPTY -> printf " "
| FLOATNUM flt -> printf "FLOATNUM(%f) " flt
| HASH -> printf "# "
| HEXNUM c -> printf "HEXNUM(%s) " c
| ID str -> printf "%s " str
| ILLEGAL c -> printf "ILLEGAL character %c " c
| INOUT -> printf "inout "
| INPUT -> printf "input "
| INTNUM c -> printf "%d " (Nativeint.to_int c)
| NEGEDGE -> printf "negedge "
| OUTPUT -> printf "output "
| PARTSEL -> printf "PartSelect "
| PREPROC str -> printf "`%s\n" str
| REG -> printf "reg "
| TRI strength -> printf "TRI%s " strength
| WEAK strength -> printf "weak%s" strength
| _ -> printf "%s " (Ord.getstr exp)

and myiter indent dump list =
  let f x = dump (x, indent + 2) in List.iter f list
;;

let moditer k x = printf "Module %s : " k; dump (x, 0);;

