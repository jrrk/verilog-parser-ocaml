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

let rec dump out_chan exp indent =
   match exp with
| TLIST lst -> List.iter (fun x -> dump out_chan x (indent+2)) lst
| DOUBLE(tok,arg) -> fprintf out_chan "\n"; for i = 1 to indent do fprintf out_chan " " done; dump out_chan tok indent; dump out_chan arg (indent+2) 
| TRIPLE(EQUALS, arg1, arg2) -> fprintf out_chan "\n"; for i = 1 to indent do fprintf out_chan " " done; dump out_chan arg1 (indent+2); fprintf out_chan "= "; dump out_chan arg2 (indent+2);
| TRIPLE(IF, arg1, arg2) -> fprintf out_chan "\n"; for i = 1 to indent do fprintf out_chan " " done; fprintf out_chan "if ( "; dump out_chan arg1 (indent+2); fprintf out_chan ") "; dump out_chan arg2 (indent+2);
| TRIPLE(PLUS, arg1, arg2) -> fprintf out_chan "\n"; for i = 1 to indent do fprintf out_chan " " done; dump out_chan arg1 (indent+2); fprintf out_chan "+ "; dump out_chan arg2 (indent+2);
| TRIPLE(tok, arg1, arg2) -> fprintf out_chan "\n"; for i = 1 to indent do fprintf out_chan " " done; dump out_chan tok indent; dump out_chan arg1 (indent+2); dump out_chan arg2 (indent+2);
| QUADRUPLE(EQUALS, arg1, arg2, arg3) -> fprintf out_chan "\n"; for i = 1 to indent do fprintf out_chan " " done; dump out_chan arg1 (indent+2); fprintf out_chan "= "; dump out_chan arg2 (indent+2); dump out_chan arg3 (indent+2);
| QUADRUPLE(IF, arg1, arg2, arg3) -> fprintf out_chan "\n"; for i = 1 to indent do fprintf out_chan " " done; fprintf out_chan "if ( "; dump out_chan arg1 (indent+2); fprintf out_chan ") "; dump out_chan arg2 (indent+2); fprintf out_chan "else "; dump out_chan arg3 (indent+2);
| QUADRUPLE(tok, arg1, arg2, arg3) -> fprintf out_chan "\n"; for i = 1 to indent do fprintf out_chan " " done; dump out_chan tok indent; dump out_chan arg1 (indent+2); dump out_chan arg2 (indent+2); dump out_chan arg3 (indent+2);
| QUINTUPLE(MODULE, arg1, arg2, arg3, arg4) -> fprintf out_chan "module "; dump out_chan arg1 indent; fprintf out_chan " "; dump out_chan arg2 indent; fprintf out_chan "\n"; dump out_chan arg3 (indent+2); fprintf out_chan "\n"; dump out_chan arg4 (indent+2); fprintf out_chan "\nendmodule\n"
| QUINTUPLE(tok, arg1, arg2, arg3, arg4) -> fprintf out_chan "\n"; for i = 1 to indent do fprintf out_chan " " done; dump out_chan tok indent; dump out_chan arg1 (indent+2); dump out_chan arg2 (indent+2); dump out_chan arg3 (indent+2); dump out_chan arg4 (indent+2);
| SEXTUPLE(tok, arg1, arg2, arg3, arg4, arg5) -> fprintf out_chan "\n"; for i = 1 to indent do fprintf out_chan " " done; dump out_chan tok indent; dump out_chan arg1 (indent+2); dump out_chan arg2 (indent+2); dump out_chan arg3 (indent+2); dump out_chan arg4 (indent+2); dump out_chan arg5 (indent+2);
| SEPTUPLE(tok, arg1, arg2, arg3, arg4, arg5, arg6) -> fprintf out_chan "\n"; for i = 1 to indent do fprintf out_chan " " done; dump out_chan tok indent; dump out_chan arg1 (indent+2); dump out_chan arg2 (indent+2); dump out_chan arg3 (indent+2); dump out_chan arg4 (indent+2); dump out_chan arg5 (indent+2); dump out_chan arg6 (indent+2);
| RANGE(arg1,arg2) -> fprintf out_chan "[ "; dump out_chan arg1 indent; fprintf out_chan ": "; dump out_chan arg2 indent; fprintf out_chan "] "
| ALWAYS -> fprintf out_chan "always "
| ASCNUM c -> fprintf out_chan "ASCNUM(%s) " c
| ASSIGN -> fprintf out_chan "assign "
| AT -> fprintf out_chan "@ "
| BINNUM c -> fprintf out_chan "BINNUM(%s) " c
| BITSEL -> fprintf out_chan "BitSelect "
| BUFIF lev -> fprintf out_chan "%s " lev
| D_ATTRIBUTE -> fprintf out_chan "$attribute "
| DECNUM c -> fprintf out_chan "DECNUM(%s) " c
| DOT -> fprintf out_chan " ."
| EMPTY -> fprintf out_chan " "
| FLOATNUM flt -> fprintf out_chan "FLOATNUM(%f) " flt
| HASH -> fprintf out_chan "# "
| HEXNUM c -> fprintf out_chan "HEXNUM(%s) " c
| ID str -> fprintf out_chan "%s " str
| ILLEGAL c -> fprintf out_chan "ILLEGAL character %c " c
| INOUT -> fprintf out_chan "inout "
| INPUT -> fprintf out_chan "input "
| INTNUM c -> fprintf out_chan "%s " c
| NEGEDGE -> fprintf out_chan "negedge "
| OUTPUT -> fprintf out_chan "output "
| PARTSEL -> fprintf out_chan "PartSelect "
| PREPROC str -> fprintf out_chan "`%s\n" str
| REG -> fprintf out_chan "reg "
| TRI strength -> fprintf out_chan "TRI%s " strength
| WEAK strength -> fprintf out_chan "weak%s" strength
| _ -> fprintf out_chan "%s " (Ord.getstr exp)

let moditer out_chan k (x:Globals.modtree) = fprintf out_chan "Module %s : " k; dump out_chan x.Globals.tree 0;;
let dump_module out_chan m = dump out_chan (Hashtbl.find Globals.modprims m).Globals.tree 0;;

