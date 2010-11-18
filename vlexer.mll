(******************************************************************************
*
*    DESCRIPTION: Verilog ocamlex lexer file
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
******************************************************************************)

{
open Lexing
open Vparser
open Setup

let ksymbols = Hashtbl.create 256;;

let enter_keyword id keyword = 
if Hashtbl.mem ksymbols id then
  Printf.printf "Error: repeated keyword %s\n" id
else begin
(*  Printf.printf "Enter %s\n" id; *)
  Hashtbl.add ksymbols id keyword
  end

let hlog lexbuf ktok:token = begin
history.(!histcnt) := {tok=ktok;strt=(Lexing.lexeme_start lexbuf);stop=(Lexing.lexeme_end lexbuf);key=true};
ignore(histcnt := (!histcnt+1)mod hsiz);
ktok
end

let _ = List.iter (fun (str,key) -> enter_keyword str key)
[
(  "always_comb",	ALWAYS ) ;
(  "always_ff",		ALWAYS ) ;
(  "always_latch",	ALWAYS ) ;
(  "always",		ALWAYS ) ;
(  "and",		AND ) ;
(  "assert",		ASSERT ) ;
(  "assign",		ASSIGN ) ;
(  "$attribute",	D_ATTRIBUTE ) ;
(  "automatic",		AUTOMATIC ) ;
(  "begin",		BEGIN ) ;
(  "$bits",		D_BITS ) ;
(  "buf",		BUF ) ;
(  "casex",		CASEX ) ;
(  "case",		CASE ) ;
(  "casez",		CASEZ ) ;
(  "clocking",		CLOCKING ) ;
(  "$clog2",		D_CLOG2 ) ;
(  "$countdrivers",	D_COUNTDRIVERS ) ;
(  "$countones",	D_COUNTONES ) ;
(  "countones",		D_COUNTONES ) ;
(  "cover",		COVER ) ;
(  "deassign",		DEASSIGN ) ;
(  "default",		DEFAULT ) ;
(  "defparam",		DEFPARAM ) ;
(  "disable",		DISABLE ) ;
(  "$display",		D_DISPLAY ) ;
(  "do",		DO ) ;
(  "edge",		EDGE ) ;
(  "else",		ELSE ) ;
(  "endcase",		ENDCASE ) ;
(  "endfunction",	ENDFUNCTION ) ;
(  "endgenerate",	ENDGENERATE ) ;
(  "endmodule",		ENDMODULE ) ;
(  "endprimitive",	ENDPRIMITIVE ) ;
(  "endspecify",	ENDSPECIFY ) ;
(  "endtable",		ENDTABLE ) ;
(  "endtask",		ENDTASK ) ;
(  "end",		END ) ;
(  "event",		EVENT ) ;
(  "$error",		D_ERROR ) ;
(  "$fatal",		D_FATAL ) ;
(  "$fclose",		D_FCLOSE ) ;
(  "$fdisplay",		D_FDISPLAY ) ;
(  "$feof",		D_FEOF ) ;
(  "$fflush",		D_FFLUSH ) ;
(  "$fgetc",		D_FGETC ) ;
(  "$fgets",		D_FGETS ) ;
(  "final",		FINAL ) ;
(  "$finish",		D_FINISH ) ;
(  "$fopen",		D_FOPEN ) ;
(  "for",		FOR ) ;
(  "$fscanf",		D_FSCANF ) ;
(  "function",		FUNCTION ) ;
(  "forever",		FOREVER ) ;
(  "$fwrite",		D_FWRITE ) ;
(  "$fwriteh",		D_FWRITEH ) ;
(  "generate",		GENERATE ) ;
(  "genvar",		GENVAR ) ;
(  "$hold",		D_HOLD ) ;
(  "iff",		IFF ) ;
(  "ifnone",		IF_NONE ) ;
(  "if",		IF ) ;
(  "$info",		D_INFO ) ;
(  "initial",		INITIAL ) ;
(  "inout",		INOUT ) ;
(  "input",		INPUT ) ;
(  "integer",		INTEGER ) ;
(  "$isunknown",	D_ISUNKNOWN ) ;
(  "isunknown",		D_ISUNKNOWN ) ;
(  "localparam",	LOCALPARAM ) ;
(  "module",		MODULE ) ;
(  "$monitor",		D_MONITOR ) ;
(  "nand",		NAND ) ;
(  "negedge",		NEGEDGE ) ;
(  "nmos",		NMOS ) ;
(  "nor",		NOR ) ;
(  "not",		NOT ) ;
(  "$onehot0",		D_ONEHOT0 ) ;
(  "$onehot",		D_ONEHOT ) ;
(*
(  "onehot0",		D_ONEHOT0 ) ;
(  "onehot",		D_ONEHOT ) ;
*)
(  "or",		OR ) ;
(  "output",		OUTPUT ) ;
(  "parameter",		PARAMETER ) ;
(  "pmos",		PMOS ) ;
(  "pullup",		PULLUP ) ;
(  "$period",		D_PERIOD ) ;
(  "posedge",		POSEDGE ) ;
(  "property",		PROPERTY ) ;
(  "primitive",		PRIMITIVE ) ;
(  "$readmemb",		D_READMEMB ) ;
(  "$readmemh",		D_READMEMH ) ;
(  "$realtime",		D_TIME ) ;
(  "$recovery",		D_RECOVERY ) ;
(  "$recrem",		D_RECREM ) ;
(  "real",		REAL ) ;
(  "reg",		REG ) ;
(  "repeat",		REPEAT ) ;
(  "$removal",		D_REMOVAL ) ;
(  "$setuphold",	D_SETUPHOLD ) ;
(  "$setup",		D_SETUP ) ;
(  "$signed",		D_SIGNED ) ;
(  "signed",		SIGNED ) ;
(  "$skew",		D_SKEW ) ;
(  "specify",		SPECIFY ) ;
(  "specparam",		SPECPARAM ) ;
(  "static",            STATIC ) ;
(  "$sscanf",		D_SSCANF ) ;
(  "$stop",		D_STOP ) ;
(  "supply0",		SUPPLY0 ) ;
(  "supply1",		SUPPLY1 ) ;
(  "table",		TABLE ) ;
(  "task",		TASK ) ;
(  "$test$plusargs",	D_TEST_PLUSARGS ) ;
(  "$timeskew",		D_TIMESKEW ) ;
(  "$time",		D_TIME ) ;
(  "tran",		TRAN ) ;
(  "tri0",		TRI0 ) ;
(  "tri1",		TRI1 ) ;
(  "$unsigned",		D_UNSIGNED ) ;
(  "unsigned",		UNSIGNED ) ;
(  "uwire",		WIRE ) ;
(  "vectored",		VECTORED ) ;
(  "$warning",		D_WARNING ) ;
(  "while",		WHILE ) ;
(  "$width",		D_WIDTH ) ;
(  "wire",		WIRE ) ;
(  "$write",		D_WRITE ) ;
(  "xnor",		XNOR ) ;
(  "xor",		XOR ) ];;
}

let digit = ['0'-'9']
let state4 = ['0'-'1' 'x' 'z' '?' 'X' 'Z' 'b' 'B']
let ident = ['a'-'z' 'A'-'Z' '_']
let ident_num = ['a'-'z' 'A'-'Z' '_' '0'-'9' '$']
let anything_but_blank = [ '^'  '~'  '<'  '='  '>'  '|'  '_'  '-'  ','  ';'  ':'  '!'  '?'  '/'  '.'  '`'  '\''  '\"'  '('  ')'  '['  ']'  '{'  '}'  '@'  '$'  '*'  '\\'  '&'  '#'  '%'  '+'  '0'-'9'  'a'-'z'  'A'-'Z' ]
let anything_but_newline = [ '\r' '\t' ' '  '^'  '~'  '<'  '='  '>'  '|'  '_'  '-'  ','  ';'  ':'  '!'  '?'  '/'  '.'  '`'  '\''  '\"'  '('  ')'  '['  ']'  '{'  '}'  '@'  '$'  '*'  '\\'  '&'  '#'  '%'  '+'  '0'-'9'  'a'-'z'  'A'-'Z' ]
let anything_but_quote = [ ' '  '^'  '~'  '<'  '='  '>'  '|'  '_'  '-'  ','  ';'  ':'  '!'  '?'  '/'  '.'  '`'  '\''  '('  ')'  '['  ']'  '{'  '}'  '@'  '$'  '*'  '\\'  '&'  '#'  '%'  '+'  '0'-'9'  'a'-'z'  'A'-'Z' ]

rule token = parse
|  '\\'anything_but_blank+' ' as word {ID word }
| "/*"
    { comment (Lexing.lexeme_start lexbuf) lexbuf; token lexbuf }
| "(*"
    { comment2 (Lexing.lexeme_start lexbuf) lexbuf; token lexbuf }
|  "//Verilog "anything_but_newline* as comment {hlog lexbuf (PRAGMATIC comment) }
|  "//"anything_but_newline* {token lexbuf}
|  "bufif"digit+ as def		{ hlog lexbuf (BUFIF def) }
|  "notif"digit+ as def		{ hlog lexbuf (NOTIF def) }
|  "tranif"digit+ as def	{ hlog lexbuf (TRANIF def) }
|  "(weak"digit+ as strength	{ hlog lexbuf (PWEAK strength ) }
|  "weak"digit+ as strength	{ hlog lexbuf (WEAK strength ) }
|  "&&"			{ hlog lexbuf (P_ANDAND) }
|  "&&&"		{ hlog lexbuf (P_ANDANDAND) }
|  "&="			{ hlog lexbuf (P_ANDEQ) }
|  "*>"                 { hlog lexbuf (P_ASTGT) }
|  "@@"			{ hlog lexbuf (P_ATAT) }
|  "==="		{ hlog lexbuf (P_CASEEQUAL) }
|  "!=="		{ hlog lexbuf (P_CASENOTEQUAL) }
|  "::"			{ hlog lexbuf (P_COLONCOLON) }
|  ":/"			{ hlog lexbuf (P_COLONDIV) }
|  ":="			{ hlog lexbuf (P_COLONEQ) }
|  "/="			{ hlog lexbuf (P_DIVEQ) }
|  ".*"			{ hlog lexbuf (P_DOTSTAR) }
|  "=>"                 { hlog lexbuf (P_EQGT) }
|  "=="			{ hlog lexbuf (P_EQUAL) }
|  ">="			{ hlog lexbuf (P_GTE) }
|  "<="			{ hlog lexbuf (P_LTE) }
|  "-:"			{ hlog lexbuf (P_MINUSCOLON) }
|  "-="			{ hlog lexbuf (P_MINUSEQ) }
|  "->"			{ hlog lexbuf (P_MINUSGT) }
|  "%="			{ hlog lexbuf (P_MODEQ) }
|  "~&"			{ hlog lexbuf (P_NAND) }
|  "~|"			{ hlog lexbuf (P_NOR) }
|  "!="			{ hlog lexbuf (P_NOTEQUAL) }
|  "|="			{ hlog lexbuf (P_OREQ) }
|  "|=>"		{ hlog lexbuf (P_OREQGT) }
|  "|->"		{ hlog lexbuf (P_ORMINUSGT) }
|  "||"			{ hlog lexbuf (P_OROR) }
|  "+:"			{ hlog lexbuf (P_PLUSCOLON) }
|  "+="			{ hlog lexbuf (P_PLUSEQ) }
|  "##"			{ hlog lexbuf (P_POUNDPOUND) }
|  "**"			{ hlog lexbuf (P_POW) }
|  "<<<"		{ hlog lexbuf (P_SLEFT) }
|  "<<"			{ hlog lexbuf (P_SLEFT) }
|  "<<<="		{ hlog lexbuf (P_SLEFTEQ) }
|  "<<="		{ hlog lexbuf (P_SLEFTEQ) }
|  ">>"			{ hlog lexbuf (P_SRIGHT) }
|  ">>="		{ hlog lexbuf (P_SRIGHTEQ) }
|  ">>>"		{ hlog lexbuf (P_SSRIGHT) }
|  ">>>="		{ hlog lexbuf (P_SSRIGHTEQ) }
|  "*="			{ hlog lexbuf (P_TIMESEQ) }
|  "==?"		{ hlog lexbuf (P_WILDEQUAL) }
|  "!=?"		{ hlog lexbuf (P_WILDNOTEQUAL) }
|  "^~"			{ hlog lexbuf (P_XNOR) }
|  "~^"			{ hlog lexbuf (P_XNOR) }
|  "^="			{ hlog lexbuf (P_XOREQ) }
| "&" { hlog lexbuf (AMPERSAND) }
| "@" { hlog lexbuf (AT) }
| "^" { hlog lexbuf (CARET) }
| ":" { hlog lexbuf (COLON) }
| "," { hlog lexbuf (COMMA) }
| "/" { hlog lexbuf (DIVIDE) }
| "=" { hlog lexbuf (EQUALS) }
| ">" { hlog lexbuf (GREATER) }
| "#" { hlog lexbuf (HASH) }
| "[" { hlog lexbuf (LBRACK) }
| "{" { hlog lexbuf (LCURLY) }
| "<" { hlog lexbuf (LESS) }
| "(" { hlog lexbuf (LPAREN) }
| "-" { hlog lexbuf (MINUS) }
| "%" { hlog lexbuf (MODULO) }
| "." { hlog lexbuf (DOT) }
| "!" { hlog lexbuf (PLING) }
| "+" { hlog lexbuf (PLUS) }
| "?" { hlog lexbuf (QUERY) }
| "]" { hlog lexbuf (RBRACK) }
| "}" { hlog lexbuf (RCURLY) }
| ")" { hlog lexbuf (RPAREN) }
| ";" { hlog lexbuf (SEMICOLON) }
| "~" { hlog lexbuf (TILDE) }
| "*" { hlog lexbuf (TIMES) }
| "|" { hlog lexbuf (VBAR) }
| "$" ident ident_num* as word {
if Hashtbl.mem ksymbols word then hlog lexbuf (Hashtbl.find ksymbols word) else hlog lexbuf (ID word)
}
| "$" { hlog lexbuf (DOLLAR) }
| digit+'.'digit* as floatnum { hlog lexbuf ( FLOATNUM ( float_of_string floatnum ) ) }
| digit*'\''['b' 'B']['0' '1' 'x' 'X' 'z' 'Z' '?' '_']+ as bnum { hlog lexbuf (BINNUM bnum ) }
| digit*'\''['o' 'O']['0'-'7' 'x' 'X' 'z' 'Z' '?' '_']+ as onum { hlog lexbuf (OCTNUM onum ) }
| digit*'\''['d' 'D']digit+ as dnum { hlog lexbuf (DECNUM dnum ) }
| digit*'\''['h' 'H']['0'-'9' 'A'-'F' 'a'-'f' 'x' 'X' 'z' 'Z' '?' '_']+ as hnum { hlog lexbuf (HEXNUM hnum ) }
| digit+ as inum { hlog lexbuf (INTNUM inum ) }
| '\"'anything_but_quote*'\"' as asciinum { hlog lexbuf (ASCNUM asciinum ) }
| "`timescale" anything_but_newline+ as preproc { hlog lexbuf (P_TIMESCALE preproc) }
| '`'ident ident_num* as presym {
  if Hashtbl.mem Globals.tsymbols presym then hlog lexbuf (Hashtbl.find Globals.tsymbols presym)
  else hlog lexbuf (PREPROC presym)
}
| ident ident_num* as word {
if Hashtbl.mem ksymbols word then hlog lexbuf (Hashtbl.find ksymbols word) else hlog lexbuf (ID word)
}
  | [' ' '\t' ]		{token lexbuf }
  | ['\r' '\n' ]	{token lexbuf }
  | _		{ hlog lexbuf (ILLEGAL ( lexeme_char lexbuf 0 ) ) }
  | eof		{ hlog lexbuf (ENDOFFILE) }

and comment start = parse
  "/*"
    { comment (Lexing.lexeme_start lexbuf) lexbuf; comment start lexbuf }
| "*/"
    { () }
| eof
    { failwith (Printf.sprintf "Unterminated /* comment */ at offset %d." start) }
| _
    { comment start lexbuf }

and comment2 start = parse
  "(*"
    { comment2 (Lexing.lexeme_start lexbuf) lexbuf; comment2 start lexbuf }
| "*)"
    { () }
| eof
    { failwith (Printf.sprintf "Unterminated (* comment *) at offset %d." start) }
| _
    { comment2 start lexbuf }
