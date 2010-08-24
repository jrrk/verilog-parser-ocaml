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
| AMPERSAND -> printf "AMPERSAND "
| AND -> printf "AND "
| ARGS -> printf "ARGS "
| ASCNUM c -> printf "ASCNUM(%s) " c
| ASSERT -> printf "ASSERT "
| ASSIGN -> printf "assign "
| AT -> printf "@ "
| AUTOMATIC -> printf "AUTOMATIC "
| BEGIN -> printf "BEGIN "
| BINNUM c -> printf "BINNUM(%s) " c
| BITSEL -> printf "BitSelect "
| BODY -> printf "BODY "
| BUF -> printf "BUF "
| CARET -> printf "CARET "
| CASE -> printf "CASE "
| CASEX -> printf "CASEX "
| CASEZ -> printf "CASEZ "
| CLOCKING -> printf "CLOCKING "
| COLON -> printf "COLON "
| COMMA -> printf "COMMA "
| COMMENT_BEGIN cmnt -> printf "COMMENT_BEGIN %s " cmnt
| COMMENT_END -> printf "COMMENT_END "
| COVER -> printf "COVER "
| D_ATTRIBUTE -> printf "$attribute "
| D_BITS -> printf "D_BITS "
| D_CLOG2 -> printf "D_CLOG2 "
| D_COUNTONES -> printf "D_COUNTONES "
| D_C -> printf "D_C "
| D_DISPLAY -> printf "D_DISPLAY "
| DEFAULT -> printf "DEFAULT "
| DEFPARAM -> printf "DEFPARAM "
| DECNUM c -> printf "DECNUM(%s) " c
| D_ERROR -> printf "D_ERROR "
| D_FATAL -> printf "D_FATAL "
| D_FCLOSE -> printf "D_FCLOSE "
| D_FDISPLAY -> printf "D_FDISPLAY "
| D_FEOF -> printf "D_FEOF "
| D_FFLUSH -> printf "D_FFLUSH "
| D_FGETC -> printf "D_FGETC "
| D_FGETS -> printf "D_FGETS "
| D_FINISH -> printf "D_FINISH "
| D_FOPEN -> printf "D_FOPEN "
| D_FSCANF -> printf "D_FSCANF "
| D_FWRITE -> printf "D_FWRITE "
| D_INFO -> printf "D_INFO "
| DISABLE -> printf "DISABLE "
| D_ISUNKNOWN -> printf "D_ISUNKNOWN "
| DIVIDE -> printf "DIVIDE "
| DOLLAR -> printf "DOLLAR "
| D_ONEHOT0 -> printf "D_ONEHOT0 "
| D_ONEHOT -> printf "D_ONEHOT "
| DO -> printf "DO "
| D_RANDOM -> printf "D_RANDOM "
| D_READMEMB -> printf "D_READMEMB "
| D_READMEMH -> printf "D_READMEMH "
| D_SIGNED -> printf "D_SIGNED "
| D_SSCANF -> printf "D_SSCANF "
| D_STIME -> printf "D_STIME "
| D_STOP -> printf "D_STOP "
| D_TIME -> printf "D_TIME "
| D_UNSIGNED -> printf "D_UNSIGNED "
| D_WARNING -> printf "D_WARNING "
| D_WRITE -> printf "D_WRITE "
| DOT -> printf " ."
| ELSE -> printf "ELSE "
| EMPTY -> printf " "
| ENDCASE -> printf "ENDCASE "
| ENDCLOCKING -> printf "ENDCLOCKING "
| ENDFUNCTION -> printf "ENDFUNCTION "
| ENDGENERATE -> printf "ENDGENERATE "
| ENDMODULE -> printf "ENDMODULE\n"
| ENDOFFILE -> printf "ENDOFFILE\n"
| END -> printf "END "
| ENDPRIMITIVE -> printf "ENDPRIMITIVE "
| ENDSPECIFY -> printf "ENDSPECIFY "
| ENDTABLE -> printf "ENDTABLE "
| ENDTASK -> printf "ENDTASK "
| EOF -> printf "EOF "
| EQUALS -> printf "EQUALS "
| FINAL -> printf "FINAL "
| FLOATNUM flt -> printf "FLOATNUM(%f) " flt
| FOR -> printf "FOR "
| FUNCTION -> printf "FUNCTION "
| GENERATE -> printf "GENERATE "
| GENVAR -> printf "GENVAR "
| GREATER -> printf "GREATER "
| HASH -> printf "# "
| HEXNUM c -> printf "HEXNUM(%s) " c
| ID str -> printf "%s " str
| IFF -> printf "IFF "
| IF -> printf "IF "
| ILLEGAL c -> printf "ILLEGAL character %c " c
| INITIAL -> printf "INITIAL "
| INOUT -> printf "inout "
| INPUT -> printf "input "
| INTEGER -> printf "INTEGER "
| INTNUM c -> printf "%d " (Nativeint.to_int c)
| LBRACK -> printf "LBRACK "
| LCURLY -> printf "LCURLY "
| LESS -> printf "LESS "
| LOCALPARAM -> printf "LOCALPARAM "
| LPAREN -> printf "LPAREN "
| MINUS -> printf "MINUS "
| MODULE -> printf "MODULE "
| MODULO -> printf "MODULO "
| NAND -> printf "NAND "
| NEGEDGE -> printf "negedge "
| NOR -> printf "NOR "
| NOT -> printf "NOT "
| OR -> printf "OR "
| OUTPUT -> printf "output "
| P_ANDANDAND -> printf "P_ANDANDAND "
| P_ANDAND -> printf "P_ANDAND "
| P_ANDEQ -> printf "P_ANDEQ "
| PARAMETER -> printf "PARAMETER "
| P_ASTGT -> printf "P_ASTGT "
| P_ATAT -> printf "P_ATAT "
| P_CASEEQUAL -> printf "P_CASEEQUAL "
| P_CASENOTEQUAL -> printf "P_CASENOTEQUAL "
| P_COLONCOLON -> printf "P_COLONCOLON "
| P_COLONDIV -> printf "P_COLONDIV "
| P_COLONEQ -> printf "P_COLONEQ "
| P_DIVEQ -> printf "P_DIVEQ "
| P_DOTSTAR -> printf "P_DOTSTAR "
| P_EQGT -> printf "P_EQGT "
| P_EQUAL -> printf "P_EQUAL "
| P_GTE -> printf "P_GTE "
| PLING -> printf "PLING "
| P_LTE -> printf "P_LTE "
| PLUS -> printf "PLUS "
| P_MINUSCOLON -> printf "P_MINUSCOLON "
| P_MINUSEQ -> printf "P_MINUSEQ "
| P_MODEQ -> printf "P_MODEQ "
| P_NAND -> printf "P_NAND "
| P_NOR -> printf "P_NOR "
| P_NOTEQUAL -> printf "P_NOTEQUAL "
| P_OREQGT -> printf "P_OREQGT "
| P_OREQ -> printf "P_OREQ "
| P_ORMINUSGT -> printf "P_ORMINUSGT "
| P_OROR -> printf "P_OROR "
| POSEDGE -> printf "posedge "
| P_PLUSCOLON -> printf "P_PLUSCOLON "
| P_PLUSEQ -> printf "P_PLUSEQ "
| P_POUNDPOUND -> printf "P_POUNDPOUND "
| P_POW -> printf "P_POW "
| PROPERTY -> printf "PROPERTY "
| P_SLEFTEQ -> printf "P_SLEFTEQ "
| P_SLEFT -> printf "P_SLEFT "
| P_SRIGHTEQ -> printf "P_SRIGHTEQ "
| P_SRIGHT -> printf "P_SRIGHT "
| P_SSRIGHTEQ -> printf "P_SSRIGHTEQ "
| P_SSRIGHT -> printf "P_SSRIGHT "
| P_TIMESEQ -> printf "P_TIMESEQ "
| P_WILDEQUAL -> printf "P_WILDEQUAL "
| P_WILDNOTEQUAL -> printf "P_WILDNOTEQUAL "
| P_XNOR -> printf "P_XNOR "
| P_XOREQ -> printf "P_XOREQ "
| PARTSEL -> printf "PartSelect "
| PREPROC str -> printf "`%s\n" str
| PRIMITIVE -> printf "PRIMITIVE "
| QUERY -> printf "QUERY "
| RBRACK -> printf "RBRACK "
| RCURLY -> printf "RCURLY "
| REG -> printf "reg "
| RPAREN -> printf "RPAREN "
| SCALARED -> printf "SCALARED "
| SEMICOLON -> printf "SEMICOLON "
| SIGNED -> printf "SIGNED "
| SPECIFY -> printf "SPECIFY "
| STATIC -> printf "STATIC "
| SUPPLY0 -> printf "SUPPLY0 "
| SUPPLY1 -> printf "SUPPLY1 "
| TABLE -> printf "TABLE "
| TASK -> printf "TASK "
| TILDE -> printf "TILDE "
| TIMES -> printf "TIMES "
| TIMINGSPEC -> printf "TIMINGSPEC "
| TRI strength -> printf "TRI%s " strength
| UNSIGNED -> printf "UNSIGNED "
| VBAR -> printf "VBAR "
| VECTORED -> printf "VECTORED "
| WEAK strength -> printf "weak%s" strength
| WHILE -> printf "WHILE "
| WIRE -> printf "WIRE "
| XNOR -> printf "XNOR "
| XOR -> printf "XOR "

and myiter indent dump list =
  let f x = dump (x, indent + 2) in List.iter f list
;;

let moditer k x = printf "Module %s : " k; dump (x, 0);;

