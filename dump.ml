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
| TLIST lst -> List.iter (fun x -> dump (x, indent + 2)) lst
| DOUBLE(tok,arg) -> printf "\n"; for i = 1 to indent do printf " " done; dump (tok, indent) ; dump (arg, indent+2)
| TRIPLE(EQUALS, arg1, arg2) -> printf "\n"; for i = 1 to indent do printf " " done; dump (arg1, indent+2); printf "= "; dump (arg2, indent+2);
| TRIPLE(IF, arg1, arg2) -> printf "\n"; for i = 1 to indent do printf " " done; printf "if ( "; dump (arg1, indent+2); printf ") "; dump (arg2, indent+2);
| TRIPLE(PLUS, arg1, arg2) -> printf "\n"; for i = 1 to indent do printf " " done; dump (arg1, indent+2); printf "+ "; dump (arg2, indent+2);
| TRIPLE(tok, arg1, arg2) -> printf "\n"; for i = 1 to indent do printf " " done; dump (tok, indent) ; dump (arg1, indent+2); dump (arg2, indent+2);
| QUADRUPLE(EQUALS, arg1, arg2, arg3) -> printf "\n"; for i = 1 to indent do printf " " done; dump (arg1, indent+2); printf "= "; dump (arg2, indent+2); dump (arg3, indent+2);
| QUADRUPLE(IF, arg1, arg2, arg3) -> printf "\n"; for i = 1 to indent do printf " " done; printf "if ( "; dump (arg1, indent+2); printf ") "; dump (arg2, indent+2); printf "else "; dump (arg3, indent+2);
| QUADRUPLE(tok, arg1, arg2, arg3) -> printf "\n"; for i = 1 to indent do printf " " done; dump (tok, indent) ; dump (arg1, indent+2); dump (arg2, indent+2); dump (arg3, indent+2);
| QUINTUPLE(MODULE, arg1, arg2, arg3, arg4) -> printf "module "; dump (arg1, indent); printf " "; dump (arg2, indent); printf "\n"; dump (arg3, indent+2); printf "\n"; dump (arg4, indent+2); printf "\nendmodule\n"
| QUINTUPLE(tok, arg1, arg2, arg3, arg4) -> printf "\n"; for i = 1 to indent do printf " " done; dump (tok, indent) ; dump (arg1, indent+2); dump (arg2, indent+2); dump (arg3, indent+2); dump (arg4, indent+2);
| SEXTUPLE(tok, arg1, arg2, arg3, arg4, arg5) -> printf "\n"; for i = 1 to indent do printf " " done; dump (tok, indent) ; dump (arg1, indent+2); dump (arg2, indent+2); dump (arg3, indent+2); dump (arg4, indent+2); dump(arg5, indent+2);
| SEPTUPLE(tok, arg1, arg2, arg3, arg4, arg5, arg6) -> printf "\n"; for i = 1 to indent do printf " " done; dump (tok, indent) ; dump (arg1, indent+2); dump (arg2, indent+2); dump (arg3, indent+2); dump (arg4, indent+2); dump(arg5, indent+2); dump(arg6, indent+2);
| RANGE(arg1,arg2) -> printf "[ "; dump (arg1, indent); printf ": "; dump (arg2, indent); printf "] "
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

let moditer k (x:Globals.modtree) = printf "Module %s : " k; dump (x.Globals.tree, 0);;
let dump_module m = dump ((Hashtbl.find Globals.modprims m).Globals.tree, 0);;

