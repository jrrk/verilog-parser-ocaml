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
}

let digit = ['0'-'9']
let ident = ['a'-'z' 'A'-'Z' '_']
let ident_num = ['a'-'z' 'A'-'Z' '_' '0'-'9' '$']
let anything_but_blank = [ '^'  '~'  '<'  '='  '>'  '|'  '_'  '-'  ','  ';'  ':'  '!'  '?'  '/'  '.'  '`'  '\''  '\"'  '('  ')'  '['  ']'  '{'  '}'  '@'  '$'  '*'  '\\'  '&'  '#'  '%'  '+'  '0'-'9'  'a'-'z'  'A'-'Z' ]
let anything_but_star = [ '\r' '\n'  ' '  '^'  '~'  '<'  '='  '>'  '|'  '_'  '-'  ','  ';'  ':'  '!'  '?'  '.'  '`'  '\''  '\"'  '('  ')'  '['  ']'  '{'  '}'  '@'  '$'  '/'  '\\'  '&'  '#'  '%'  '+'  '0'-'9'  'a'-'z'  'A'-'Z' ]
let anything_but_newline = [ '\r' '\t' ' '  '^'  '~'  '<'  '='  '>'  '|'  '_'  '-'  ','  ';'  ':'  '!'  '?'  '/'  '.'  '`'  '\''  '\"'  '('  ')'  '['  ']'  '{'  '}'  '@'  '$'  '*'  '\\'  '&'  '#'  '%'  '+'  '0'-'9'  'a'-'z'  'A'-'Z' ]
let anything_but_quote = [ ' '  '^'  '~'  '<'  '='  '>'  '|'  '_'  '-'  ','  ';'  ':'  '!'  '?'  '/'  '.'  '`'  '\''  '('  ')'  '['  ']'  '{'  '}'  '@'  '$'  '*'  '\\'  '&'  '#'  '%'  '+'  '0'-'9'  'a'-'z'  'A'-'Z' ]
rule token = parse
|  '\\'anything_but_blank+' ' as word {ID word }
|  '/''/'anything_but_newline*'\n' {token lexbuf}
|  "(*"anything_but_star*"*)" {token lexbuf}
|  "/*"anything_but_star*"*/" {token lexbuf}
|  "/*"anything_but_star+ as comment {COMMENT_BEGIN comment }
|  "(*"anything_but_star+ as comment {COMMENT_BEGIN comment }
|  "*/" {COMMENT_END}
|  "*)" {COMMENT_END}
|  "always_comb"		{ALWAYS}
|  "always_ff"		{ALWAYS}
|  "always_latch"	{ALWAYS}
|  "always"		{ALWAYS}
|  "and"		{AND}
|  "assert"		{ASSERT}
|  "assign"		{ASSIGN}
|  "$attribute"		{D_ATTRIBUTE}
|  "automatic"		{AUTOMATIC}
|  "begin"		{BEGIN}
|  "$bits"		{D_BITS}
|  "buf"		{BUF}
|  "bufif"digit+ as def	{BUFIF def }
|  "casex"		{CASEX}
|  "case"		{CASE}
|  "casez"		{CASEZ}
|  "clocking"		{CLOCKING}
|  "$clog2"		{D_CLOG2}
|  "$countones"		{D_COUNTONES}
|  "countones"		{D_COUNTONES}
|  "cover"		{COVER}
|  "default"		{DEFAULT}
|  "defparam"		{DEFPARAM}
|  "disable"		{DISABLE}
|  "$display"		{D_DISPLAY}
|  "do"			{DO}
|  "edge"		{TIMINGSPEC}
|  "else"		{ELSE}
|  "endcase"		{ENDCASE}
(*
|  "endclocking"	{ENDCLOCKING}
*)
|  "endfunction"	{ENDFUNCTION}
|  "endgenerate"	{ENDGENERATE}
|  "endmodule"		{ENDMODULE}
|  "endprimitive"	{ENDPRIMITIVE}
|  "endspecify"		{ENDSPECIFY}
|  "endtable"		{ENDTABLE}
|  "endtask"		{ENDTASK}
|  "end"		{END}
|  "$error"		{D_ERROR}
|  "$fatal"		{D_FATAL}
|  "$fclose"		{D_FCLOSE}
|  "$fdisplay"		{D_FDISPLAY}
|  "$feof"		{D_FEOF}
|  "$fflush"		{D_FFLUSH}
|  "$fgetc"		{D_FGETC}
|  "$fgets"		{D_FGETS}
|  "final"		{FINAL}
|  "$finish"		{D_FINISH}
|  "$fopen"		{D_FOPEN}
|  "for"		{FOR}
|  "$fscanf"		{D_FSCANF}
(*
|  "$fullskew"		{TIMINGSPEC}
*)
|  "function"		{FUNCTION}
|  "$fwrite"		{D_FWRITE}
|  "generate"		{GENERATE}
|  "genvar"		{GENVAR}
|  "$hold"		{TIMINGSPEC}
|  "iff"		{IFF}
|  "ifnone"		{TIMINGSPEC}
|  "if"			{IF}
|  "$info"		{D_INFO}
|  "initial"		{INITIAL}
|  "inout"		{INOUT}
|  "input"		{INPUT}
|  "integer"		{INTEGER}
|  "$isunknown"		{D_ISUNKNOWN}
|  "isunknown"		{D_ISUNKNOWN}
|  "localparam"		{LOCALPARAM}
(*|  "macromodule"	{MODULE}*)
|  "module"		{MODULE}
|  "nand"		{NAND}
|  "negedge"		{NEGEDGE}
(*|  "$nochange"		{TIMINGSPEC}*)
|  "nor"		{NOR}
(*|  "noshowcancelled"	{TIMINGSPEC}*)
|  "not"		{NOT}
|  "$onehot0"		{D_ONEHOT0}
|  "onehot0"		{D_ONEHOT0}
|  "$onehot"		{D_ONEHOT}
|  "onehot"		{D_ONEHOT}
|  "or"			{OR}
|  "output"		{OUTPUT}
|  "parameter"		{PARAMETER}
|  "$period"		{TIMINGSPEC}
|  "posedge"		{POSEDGE}
|  "property"		{PROPERTY}
|  "primitive"		{PRIMITIVE}
(*
|  "pulsestyle_ondetect"	{TIMINGSPEC}
|  "pulsestyle_onevent"	{TIMINGSPEC}
|  "$random"		{D_RANDOM}
*)
|  "$readmemb"		{D_READMEMB}
|  "$readmemh"		{D_READMEMH}
|  "$realtime"		{D_TIME}
|  "$recovery"		{TIMINGSPEC}
|  "$recrem"		{TIMINGSPEC}
|  "reg"		{REG}
|  "$removal"		{TIMINGSPEC}
(*
|  "scalared"		{SCALARED}
*)
|  "$setuphold"		{TIMINGSPEC}
|  "$setup"		{TIMINGSPEC}
(*|  "showcancelled"	{TIMINGSPEC}*)
|  "$signed"		{D_SIGNED}
|  "signed"		{SIGNED}
|  "$skew"		{TIMINGSPEC}
|  "specify"		{SPECIFY}
|  "specparam"		{TIMINGSPEC}
|  "$sscanf"		{D_SSCANF}
(*
|  "static"		{STATIC}
|  "$stime"		{D_STIME}
*)
|  "$stop"		{D_STOP}
|  "supply0"		{SUPPLY0}
|  "supply1"		{SUPPLY1}
|  "table"		{TABLE}
|  "task"		{TASK}
|  "$timeskew"		{TIMINGSPEC}
|  "$time"		{D_TIME}
|  "tri"digit+ as strength		{TRI strength}
|  "$unsigned"		{D_UNSIGNED}
|  "unsigned"		{UNSIGNED}
|  "uwire"		{WIRE}
|  "vectored"		{VECTORED}
|  "$warning"		{D_WARNING}
|  "weak"digit+ as strength	{WEAK strength }
|  "while"		{WHILE}
|  "$width"		{TIMINGSPEC}
|  "wire"		{WIRE}
|  "$write"		{D_WRITE}
|  "xnor"		{XNOR}
|  "xor"		{XOR}
|  "&&"			{P_ANDAND}
|  "&&&"		{P_ANDANDAND}
|  "&="			{P_ANDEQ}
|  "*>"                 {P_ASTGT}
|  "@@"			{P_ATAT}
|  "==="		{P_CASEEQUAL}
|  "!=="		{P_CASENOTEQUAL}
|  "::"			{P_COLONCOLON}
|  ":/"			{P_COLONDIV}
|  ":="			{P_COLONEQ}
|  "/="			{P_DIVEQ}
|  ".*"			{P_DOTSTAR}
|  "=>"                 {P_EQGT}
|  "=="			{P_EQUAL}
|  ">="			{P_GTE}
|  "<="			{P_LTE}
|  "-:"			{P_MINUSCOLON}
|  "-="			{P_MINUSEQ}
|  "%="			{P_MODEQ}
|  "~&"			{P_NAND}
|  "~|"			{P_NOR}
|  "!="			{P_NOTEQUAL}
|  "|="			{P_OREQ}
|  "|=>"		{P_OREQGT}
|  "|->"		{P_ORMINUSGT}
|  "||"			{P_OROR}
|  "+:"			{P_PLUSCOLON}
|  "+="			{P_PLUSEQ}
|  "##"			{P_POUNDPOUND}
|  "**"			{P_POW}
|  "<<<"		{P_SLEFT}
|  "<<"			{P_SLEFT}
|  "<<<="		{P_SLEFTEQ}
|  "<<="		{P_SLEFTEQ}
|  ">>"			{P_SRIGHT}
|  ">>="		{P_SRIGHTEQ}
|  ">>>"		{P_SSRIGHT}
|  ">>>="		{P_SSRIGHTEQ}
|  "*="			{P_TIMESEQ}
|  "==?"		{P_WILDEQUAL}
|  "!=?"		{P_WILDNOTEQUAL}
|  "^~"			{P_XNOR}
|  "~^"			{P_XNOR}
|  "^="			{P_XOREQ}
| "&" {AMPERSAND}
| "@" {AT}
| "^" {CARET}
| ":" {COLON}
| "," {COMMA}
| "/" {DIVIDE}
| "=" {EQUALS}
| ">" {GREATER}
| "#" {HASH}
| "[" {LBRACK}
| "{" {LCURLY}
| "<" {LESS}
| "(" {LPAREN}
| "-" {MINUS}
| "%" {MODULO}
| "." {DOT}
| "!" {PLING}
| "+" {PLUS}
| "?" {QUERY}
| "]" {RBRACK}
| "}" {RCURLY}
| ")" {RPAREN}
| ";" {SEMICOLON}
| "~" {TILDE}
| "*" {TIMES}
| "|" {VBAR}
| "$" {DOLLAR}
| digit+'.'digit* as floatnum { FLOATNUM ( float_of_string floatnum ) }
| digit*'\'''b'['0' '1' 'x' 'X' 'z' 'Z' '?' '_']+ as bnum {BINNUM bnum }
| digit*'\'''d'digit+ as dnum {DECNUM dnum }
| digit*'\'''h'['0'-'9' 'A'-'F' 'a'-'f' 'x' 'X' 'z' 'Z' '?' '_']+ as hnum {HEXNUM hnum }
| digit+ as inum {INTNUM ( int_of_string inum ) }
| '\"'anything_but_quote+'\"' as asciinum {ASCNUM asciinum }
(*
| "`timescale"anything_but_newline+ as timescale {TIMESCALE timescale }
| "`inline"anything_but_newline+ as inline {INLINE inline }
| "`portcoerce"anything_but_newline+ as portcoerce {PORTCOERCE portcoerce }
*)
| '`' anything_but_newline+ as preproc {PREPROC preproc }
| ident ident_num* as word {ID word }
  | [' ' '\t' '\r' '\n' ]	{token lexbuf }
  | _		{ILLEGAL ( lexeme_char lexbuf 0 ) }
  | eof		{ENDOFFILE}
