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

open Nethtml
open Netchannels
open Nethtml_scanner
open Other

let multiple x = match x with
| 0 -> " "
| 1 -> ""
| 2 -> "DOUBLE"
| 3 -> "TRIPLE"
| 4 -> "QUADRUPLE"
| 5 -> "QUINTUPLE"
| 6 -> "SEXTUPLE"
| 7 -> "SEPTUPLE"
| 8 -> "OCTUPLE"
| 9 -> "NONUPLE"
| 10 -> "DECUPLE"
| 11 -> "UNDECUPLE"
| 12 -> "DUODECUPLE"
| 13 -> "TREDECUPLE"
| 14 -> "QUATTUORDECUPLE"
| 15 -> "QUINDECUPLE"
| 16 -> "SEXDECUPLE"
| 17 -> "SEPTENDECUPLE"
| 18 -> "OCTODECUPLE"
| 19 -> "NOVEMDECUPLE"
| 20 -> "VIGENUPLE"
| 21 -> "UNVIGENUPLE"
| 22 -> "DUOVIGENUPLE"
| 23 -> "TREVIGENUPLE"
| 24 -> "QUATTUORVIGENUPLE"
| 25 -> "QUINVIGENUPLE"
| 26 -> "SEXVIGENUPLE"
| 27 -> "SEPTENVIGENUPLE"
| 28 -> "OCTOVIGENUPLE"
| 29 -> "NOVEMVIGENUPLE"
| 30 -> "TRIGENUPLE" 
| _ -> "UNKNOWN"^(string_of_int x)^""

let isalpha = function 'A'..'Z'|'a'..'z' -> true | _ -> false

let write_os_not str = ()

let rules = Hashtbl.create 256
let hsh2 = Hashtbl.create 256
let cnt = ref 0
let tc = open_out "tokens.log"

let ksymbols = Hashtbl.create 256
let reverse = Hashtbl.create 256

let valid1 = ref false and valid2 = ref false and com = ref false and mask = ref false and fst = ref []
and superscript = ref false and optional = ref false and zlist = ref false and annotated = ref false
and begin_clause = ref false and to_wr = ref [] and myname = ref "" and comment = ref "" and pending = ref []

let rec mygetstr tok = match tok with
| ID id -> id
| ALTERNATIVE -> "|"
| LEFT_BRACKET -> "["
| RIGHT_BRACKET -> "]"
| LEFT_CURLY -> "{"
| RIGHT_CURLY -> "}"
| SUBTRACTION -> "-"
| RANGE(left,right) -> Format.sprintf "\"%s\" .. \"%s\"" (mygetstr left) (mygetstr right)
| TOKEN_BEGIN_COMMENT -> "'/' '*' "
| TOKEN_END_COMMENT -> "'*' '/' "
| TLIST lst | DOTTED lst -> let concat = ref "" in List.iter (fun item -> concat := !concat ^ " " ^ mygetstr item) lst; !concat
| _ -> if (Hashtbl.mem reverse tok) then (Hashtbl.find reverse tok) else (Ord.getstr tok)

let rec mygetstr2 tok = match tok with
| ID id -> id
| TLIST lst | DOTTED lst -> let concat = ref "" in List.iter (fun item -> concat := !concat ^ " " ^ mygetstr2 item) lst; !concat
| ALTERNATIVE -> "VBAR"
| LEFT_BRACKET -> "LBRACK"
| RIGHT_BRACKET -> "RBRACK"
| LEFT_CURLY -> "LCURLY"
| RIGHT_CURLY -> "RCURLY"
| SUBTRACTION -> "MINUS"
| RANGE(left,right) -> Format.sprintf "\"%s\" .. \"%s\"" (mygetstr2 left) (mygetstr2 right)
| _ -> Ord.getstr tok

let write_os_pending (tok0:token) = 
let tok = if !valid2 then match tok0 with 
| VBAR -> ALTERNATIVE
| LBRACK -> LEFT_BRACKET
| RBRACK -> RIGHT_BRACKET
| LCURLY -> LEFT_CURLY
| RCURLY -> RIGHT_CURLY
| MINUS -> SUBTRACTION
| _ -> tok0 else tok0 in
if tok = MINUS then begin fst := [List.hd !to_wr]; to_wr := List.tl !to_wr; end
else if (!fst <> []) then (let rng = RANGE(List.hd(!fst), tok) in fst := [];
    match List.hd !to_wr with RANGE(_,_) -> to_wr := rng :: VBAR :: !to_wr | _ -> to_wr := rng :: !to_wr)
else to_wr := tok :: !to_wr

let rec write_os_flush name write_os tow = 
let cnt = ref 0 and nam = ref name in
let fetch () = begin let tok = List.hd(!tow) in ( tow := List.tl(!tow); cnt := !cnt+1; tok ) end in
let looping = ref true and sub_def = ref [] in
while !looping && (!tow <> []) do
let tok = fetch() in (match tok with
| ID s -> sub_def := !sub_def @ [tok]
| IS_DEFINED_AS -> sub_def := !sub_def @ [tok]
| VBAR -> sub_def := !sub_def @ [tok]
| LBRACK -> sub_def := !sub_def @ [TLIST (write_os_flush (!nam^"_"^(string_of_int !cnt)) (write_os) tow)]
| LCURLY -> sub_def := !sub_def @ [DOTTED (write_os_flush (!nam^"_"^(string_of_int !cnt)) (write_os) tow)]
| RBRACK | RCURLY -> looping := false
| _ -> sub_def := !sub_def @ [tok]);
output_string tc (Printf.sprintf "%.2d %s\n" (!cnt) (mygetstr2 tok));
done;
!sub_def

let thresh = 1

let rec mygetstr3 tok cnt len = (if (cnt = 1) then "(" else "")^(match tok with
| ID id -> (if String.length id > thresh then ("$"^(string_of_int cnt)) else "CHAR '"^id^"'")
| _ -> (mygetstr2 tok))^(if cnt == len then ");" else ", ")

let rec unpack write_os tok = match tok with
    | VBAR -> write_os "| "
    | IS_DEFINED_AS -> write_os "::= "
    | ID id -> write_os (id^" ")
    | TLIST lst -> let concat = ref "[" in List.iter (
        fun item -> unpack (fun s -> concat := !concat ^ " " ^ s ^ " ") item) lst; write_os (!concat^" ] ")
    | DOTTED lst -> let concat = ref "{" in List.iter (
        fun item -> unpack (fun s -> concat := !concat ^ " " ^ s ^ " ") item) lst; write_os (!concat^" } ")
    | _ -> write_os ((mygetstr tok)^" ")

let dumpargs2 write args = 
    let len = List.length !args in write ("{ "^(multiple len)); 
        let cnt = ref 0 in List.iter (fun item -> write (cnt := !cnt + 1; mygetstr3 item !cnt len)) !args; write " }"; args := []

let leprechaun s = let esc = ref "" in for i = 0 to (String.length s)-1 do
if s.[i] = '$' then esc := !esc ^ (if i = 0 then "d_" else "_dollar_") else esc := !esc ^ (String.make 1 s.[i])
done;
!esc

let rec unpack2 write cnt key tok args = match tok with
    | VBAR -> dumpargs2 write args; write"\n\t| "; true
    | IS_DEFINED_AS -> write ": "; args := []; true
    | ID id -> write (if String.length id > thresh then leprechaun(id)^" " else Printf.sprintf "'%s' " id); args := !args @ [tok]; String.length id > thresh
    | TLIST lst -> pending := !pending @ [dump2 key (ID key :: IS_DEFINED_AS :: lst)]; write (key^" "); args := !args @ [ID key]; true
    | DOTTED lst -> pending := !pending @ [dump2 key (ID key :: IS_DEFINED_AS :: lst)]; write (key^" "); args := !args @ [ID key]; true
    | RANGE(left,right) -> false
    | _ -> write ((mygetstr2 tok)^" "); args := !args @ [tok]; true

and dump2 key0 lst =
let key = leprechaun key0 and buffer = ref "" and cnt = ref 0 and args = ref [] and retval = ref true in
List.iter (fun item -> let key2 = key^"_"^(string_of_int !cnt) in retval := !retval && unpack2 (fun s -> buffer := !buffer^s) !cnt key2 item args; cnt := !cnt + 1) lst;
if !args <> [] then dumpargs2(fun s -> buffer := !buffer^s) args;
if (!retval) then !buffer^"\n\t;\n\n" else "/* "^(!buffer)^"\n\t; */\n\n"

let enter_keyword id keyword prim = 
if Hashtbl.mem ksymbols id then
  Printf.printf "Error: repeated keyword %s\n" id
else begin
(*  Printf.printf "Enter %s\n" id; *)
  Hashtbl.add ksymbols id (keyword,prim)
  end

let _ = List.iter (fun (str,key,prim) -> enter_keyword str key prim)
[
(*
("$hold_timing_check", HOLD_TIMING_CHECK, false);
("$width_timing_check", WIDTH_TIMING_CHECK, false);
("$recovery_timing_check", RECOVERY_TIMING_CHECK, false);
("$setuphold_timing_check", SETUPHOLD_TIMING_CHECK, false);
("$fullskew_timing_check", FULLSKEW_TIMING_CHECK, false);
("$timeskew_timing_check", TIMESKEW_TIMING_CHECK, false);
("$setup_timing_check", SETUP_TIMING_CHECK, false);
("$skew_timing_check", SKEW_TIMING_CHECK, false);
("$nochange_timing_check", NOCHANGE_TIMING_CHECK, false);
("$recrem_timing_check", RECREM_TIMING_CHECK, false);
("$removal_timing_check", REMOVAL_TIMING_CHECK, false);
("$period_timing_check", PERIOD_TIMING_CHECK, false);
(  "zA", ZA, false);
*)
( "empty", EMPTY, false);
( "c_identifier_2", C_IDENTIFIER_2 "", true);
( "c_identifier_3_2", C_IDENTIFIER_3_2 "", true);
( "simple_identifier_2", SIMPLE_IDENTIFIER_2 "", true); 
( "simple_identifier_3_2", SIMPLE_IDENTIFIER_3_2 "", true);
( "system_task_identifier_3", SYSTEM_TASK_IDENTIFIER_3 "", true);
( "system_function_identifier_3", SYSTEM_FUNCTION_IDENTIFIER_3 "", true);
(  "file_path", FILE_PATH, false);
(  "space", SPACE, false);
(  "tab", TAB, false);
(  "newline", NEWLINE, false);
(  "eof", EOF, false);
(  "Any_ASCII_Characters", ANY_ASCII_CHARS, false);
(  "Any_ASCII_character", ANY_ASCII_CHAR, false);
(  "within", WITHIN, false);
(  "this", THIS, false);
("$nochange", NOCHANGE, false);
("$fullskew", FULLSKEW, false);
(  "always_comb",	ALWAYS_COMB, false);
(  "always_ff",		ALWAYS_FF, false);
(  "always_latch",	ALWAYS_LATCH, false);
(  "always",		ALWAYS, false);
(  "and",		AND, false);
(  "assert",		ASSERT, false);
(  "assign",		ASSIGN, false);
(  "$attribute",	D_ATTRIBUTE, false);
(  "automatic",		AUTOMATIC, false);
(  "begin",		BEGIN, false);
(  "$bits",		D_BITS, false);
(  "buf",		BUF, false);
(  "casex",		CASEX, false);
(  "case",		CASE, false);
(  "casez",		CASEZ, false);
(  "clocking",		CLOCKING, false);
(  "$clog2",		D_CLOG2, false);
(  "$countdrivers",	D_COUNTDRIVERS, false);
(  "$countones",	D_COUNTONES, false);
(  "countones",		COUNTONES, false);
(  "cover",		COVER, false);
(  "deassign",		DEASSIGN, false);
(  "default",		DEFAULT, false);
(  "defparam",		DEFPARAM, false);
(  "disable",		DISABLE, false);
(  "$display",		D_DISPLAY, false);
(  "do",		DO, false);
(  "edge",		EDGE, false);
(  "else",		ELSE, false);
(  "endcase",		ENDCASE, false);
(  "endfunction",	ENDFUNCTION, false);
(  "endgenerate",	ENDGENERATE, false);
(  "endmodule",		ENDMODULE, false);
(  "endprimitive",	ENDPRIMITIVE, false);
(  "endspecify",	ENDSPECIFY, false);
(  "endtable",		ENDTABLE, false);
(  "endtask",		ENDTASK, false);
(  "end",		END, false);
(  "event",		EVENT, false);
(  "$error",		D_ERROR, false);
(  "$fatal",		D_FATAL, false);
(  "$fclose",		D_FCLOSE, false);
(  "$fdisplay",		D_FDISPLAY, false);
(  "$feof",		D_FEOF, false);
(  "$fflush",		D_FFLUSH, false);
(  "$fgetc",		D_FGETC, false);
(  "$fgets",		D_FGETS, false);
(  "final",		FINAL, false);
(  "$finish",		D_FINISH, false);
(  "$fopen",		D_FOPEN, false);
(  "for",		FOR, false);
(  "$fscanf",		D_FSCANF, false);
(  "function",		FUNCTION, false);
(  "forever",		FOREVER, false);
(  "$fwrite",		D_FWRITE, false);
(  "$fwriteh",		D_FWRITEH, false);
(  "generate",		GENERATE, false);
(  "genvar",		GENVAR, false);
(  "$hold",		D_HOLD, false);
(  "iff",		IFF, false);
(  "ifnone",		IF_NONE, false);
(  "if",		IF, false);
(  "$info",		D_INFO, false);
(  "initial",		INITIAL, false);
(  "inout",		INOUT, false);
(  "input",		INPUT, false);
(  "integer",		INTEGER, false);
(  "$isunknown",	D_ISUNKNOWN, false);
(  "isunknown",		ISUNKNOWN, false);
(  "localparam",	LOCALPARAM, false);
(  "module",		MODULE, false);
(  "$monitor",		D_MONITOR, false);
(  "nand",		NAND, false);
(  "negedge",		NEGEDGE, false);
(  "nmos",		NMOS, false);
(  "nor",		NOR, false);
(  "not",		NOT, false);
(  "$onehot0",		D_ONEHOT0, false);
(  "$onehot",		D_ONEHOT, false);
(*
(  "onehot0",		D_ONEHOT0, false);
(  "onehot",		D_ONEHOT, false);
*)
(  "or",		OR, false);
(  "output",		OUTPUT, false);
(  "parameter",		PARAMETER, false);
(  "pmos",		PMOS, false);
(  "pullup",		PULLUP, false);
(  "$period",		D_PERIOD, false);
(  "posedge",		POSEDGE, false);
(  "property",		PROPERTY, false);
(  "primitive",		PRIMITIVE, false);
(  "$readmemb",		D_READMEMB, false);
(  "$readmemh",		D_READMEMH, false);
(  "$realtime",		D_REALTIME, false);
(  "$recovery",		D_RECOVERY, false);
(  "$recrem",		D_RECREM, false);
(  "real",		REAL, false);
(  "reg",		REG, false);
(  "repeat",		REPEAT, false);
(  "$removal",		D_REMOVAL, false);
(  "$setuphold",	D_SETUPHOLD, false);
(  "$setup",		D_SETUP, false);
(  "$signed",		D_SIGNED, false);
(  "signed",		SIGNED, false);
(  "$skew",		D_SKEW, false);
(  "specify",		SPECIFY, false);
(  "specparam",		SPECPARAM, false);
(  "static",            STATIC, false);
(  "$sscanf",		D_SSCANF, false);
(  "$stop",		D_STOP, false);
(  "supply0",		SUPPLY0, false);
(  "supply1",		SUPPLY1, false);
(  "table",		TABLE, false);
(  "task",		TASK, false);
(  "$test$plusargs",	D_TEST_PLUSARGS, false);
(  "$timeskew",		D_TIMESKEW, false);
(  "$time",		D_TIME, false);
(  "tran",		TRAN, false);
(  "tri0",		TRI0, false);
(  "tri1",		TRI1, false);
(  "$unsigned",		D_UNSIGNED, false);
(  "unsigned",		UNSIGNED, false);
(  "uwire",		U_WIRE, false);
(  "vectored",		VECTORED, false);
(  "$warning",		D_WARNING, false);
(  "while",		WHILE, false);
(  "$width",		D_WIDTH, false);
(  "wire",		WIRE, false);
(  "$write",		D_WRITE, false);
(  "xnor",		XNOR, false);
(  "xor",		XOR, false);
(  "bufif0", BUFIF0, false);
(  "notif0", NOTIF0, false);
(  "tranif0", TRANIF0, false);
(  "weak0", WEAK0, false);
(  "bufif1", BUFIF1, false);
(  "notif1", NOTIF1, false);
(  "tranif1", TRANIF1, false);
(  "weak1", WEAK1, false);
(  "alias", ALIAS, false);
(  "before", BEFORE, false);
(  "bind", BIND, false);
(  "bit", BIT, false);
(  "bold", BOLD, false);
(  "break", BREAK, false);
(  "byte", BYTE, false);
(  "cell", CELL, false);
(  "chandle", CHANDLE, false);
(  "class", CLASS, false);
(  "cmos", CMOS, false);
(  "config", CONFIG, false);
(  "const", CONST, false);
(  "constraint", CONSTRAINT, false);
(  "context", CONTEXT, false);
(  "continue", CONTINUE, false);
(  "design", DESIGN, false);
(  "dist", DIST, false);
(  "endclass", ENDCLASS, false);
(  "endclocking", ENDCLOCKING, false);
(  "endconfig", ENDCONFIG, false);
(  "endinterface", ENDINTERFACE, false);
(  "endprogram", ENDPROGRAM, false);
(  "endproperty", ENDPROPERTY, false);
(  "endsequence", ENDSEQUENCE, false);
(  "enum", ENUM, false);
(  "export", EXPORT, false);
(  "extends", EXTENDS, false);
(  "extern", EXTERN, false);
(  "first_match", FIRST_MATCH, false);
(  "force", FORCE, false);
(  "fork", FORK, false);
(  "forkjoin", FORKJOIN, false);
(  "highz0", HIGHZ0, false);
(  "highz1", HIGHZ1, false);
(  "import", IMPORT, false);
(  "include", INCLUDE, false);
(  "inside", INSIDE, false);
(  "instance", INSTANCE, false);
(  "interface", INTERFACE, false);
(  "intersect", INTERSECT, false);
(  "int", SVINT, false);
(  "join_any", JOIN_ANY, false);
(  "join", JOIN, false);
(  "join_none", JOIN_NONE, false);
(  "large", LARGE, false);
(  "liblist", LIBLIST, false);
(  "library", LIBRARY, false);
(  "local", LOCAL, false);
(  "logic", LOGIC, false);
(  "longint", LONGINT, false);
(  "macromodule", MACROMODULE, false);
(  "medium", MEDIUM, false);
(  "modport", MODPORT, false);
(  "new", NEW, false);
(  "noshowcancelled", NOSHOWCANCELLED, false);
(  "null", NULL, false);
(  "packed", PACKED, false);
(  "PATHPULSE$", PATHPULSE, false);
(  "priority", PRIORITY, false);
(  "program", PROGRAM, false);
(  "protected", PROTECTED, false);
(  "pull0", PULL0, false);
(  "pull1", PULL1, false);
(  "pulldown", PULLDOWN, false);
(  "pulsestyle_ondetect", PULSESTYLE_ONDETECT, false);
(  "pulsestyle_onevent", PULSESTYLE_ONEVENT, false);
(  "pure", PURE, false);
(  "randc", RANDC, false);
(  "randomize", RANDOMIZE, false);
(  "rand", RAND, false);
(  "rcmos", RCMOS, false);
(  "realtime", REALTIME, false);
(  "ref", REF, false);
(  "release", RELEASE, false);
(  "return", RETURN, false);
(  "rnmos", RNMOS, false);
(  "rpmos", RPMOS, false);
(  "rtranif0", RTRANIF0, false);
(  "rtranif1", RTRANIF1, false);
(  "rtran", RTRAN, false);
(  "scalared", SCALARED, false);
(  "sequence", SEQUENCE, false);
(  "shortint", SHORTINT, false);
(  "shortreal", SHORTREAL, false);
(  "showcancelled", SHOWCANCELLED, false);
(  "small", SMALL, false);
(  "solve", SOLVE, false);
(  "step", STEP, false);
(  "string", STRING, false);
(  "strong0", STRONG0, false);
(  "strong1", STRONG1, false);
(  "struct", STRUCT, false);
(  "super", SUPER, false);
(  "throughout", THROUGHOUT, false);
(  "timeprecision", TIMEPRECISION, false);
(  "time", TIME, false);
(  "timeunit", TIMEUNIT, false);
(  "triand", TRIAND, false);
(  "trior", TRIOR, false);
(  "trireg", TRIREG, false);
(  "tri", TRI, false);
(  "typedef", TYPEDEF, false);
(  "type", TYPE, false);
(  "union", UNION, false);
(  "unique", UNIQUE, false);
(  "use", USE, false);
(  "virtual", VIRTUAL, false);
(  "void", VOID, false);
(  "wait_order", WAIT_ORDER, false);
(  "wait", WAIT, false);
(  "wand", WAND, false);
(  "with", WITH, false);
(  "wor", WOR, false);
(  "&&"			, (P_ANDAND), false);
(  "&&&"		, (P_ANDANDAND), false);
(  "&="			, (P_ANDEQ), false);
(  "*>"                 , (P_ASTGT), false);
(  "@@"			, (P_ATAT), false);
(  "==="		, (P_CASEEQUAL), false);
(  "!=="		, (P_CASENOTEQUAL), false);
(  "::"			, (P_COLONCOLON), false);
(  ":/"			, (P_COLONDIV), false);
(  ":="			, (P_COLONEQ), false);
(  "/="			, (P_DIVEQ), false);
(  ".*"			, (P_DOTSTAR), false);
(  "=>"                 , (P_EQGT), false);
(  "=="			, (P_EQUAL), false);
(  ">="			, (P_GTE), false);
(  "<="			, (P_LTE), false);
(  "-:"			, (P_MINUSCOLON), false);
(  "-="			, (P_MINUSEQ), false);
(  "->"			, (P_MINUSGT), false);
(  "%="			, (P_MODEQ), false);
(  "~&"			, (P_NAND), false);
(  "~("			, (P_NOR), false);
(  "!="			, (P_NOTEQUAL), false);
(  "(="			, (P_OREQ), false);
(  "(=>"		, (P_OREQGT), false);
(  "(,"		        , (P_ORMINUSGT), false);
(  "(("			, (P_OROR), false);
(  "+:"			, (P_PLUSCOLON), false);
(  "+="			, (P_PLUSEQ), false);
(  "##"			, (P_POUNDPOUND), false);
(  "**"			, (P_POW), false);
(  "<<<"		, (P_SLEFT3), false);
(  "<<"			, (P_SLEFT), false);
(  "<<<="		, (P_SLEFT3EQ), false);
(  "<<="		, (P_SLEFTEQ), false);
(  ">>"			, (P_SRIGHT), false);
(  ">>="		, (P_SRIGHTEQ), false);
(  ">>>"		, (P_SSRIGHT3), false);
(  ">>>="		, (P_SSRIGHT3EQ), false);
(  "*="			, (P_TIMESEQ), false);
(  "==?"		, (P_WILDEQUAL), false);
(  "!=?"		, (P_WILDNOTEQUAL), false);
(  "^~"			, (P_XNOR), false);
(  "~^"			, (P_NXOR), false);
(  "^="			, (P_XOREQ), false);
("[*->", TOKEN_349, false);
("|->", TOKEN_327, false);
("\"", TOKEN_695, false);
("::=", IS_DEFINED_AS, false);
("->>", TOKEN_504, false);
("0", TOKEN_436, false);
("1", TOKEN_435, false);
("2", TOKEN_687, false);
("3", TOKEN_688, false);
("4", TOKEN_689, false);
("5", TOKEN_690, false);
("6", TOKEN_691, false);
("7", TOKEN_639, false);
("8", TOKEN_272, false);
("9", TOKEN_266, false);
("1'B0", TOKEN_431, false);
("1'B1", TOKEN_432, false);
("'b0", TOKEN_595, false);
("'b1", TOKEN_596, false);
("\\", TOKEN_718, false);
("_", TOKEN_661, false);
("1'BX", TOKEN_434, false);
("1'Bx", TOKEN_433, false);
("9_", TOKEN_713, false);
("1'b0", TOKEN_427, false);
("1'b1", TOKEN_428, false);
("=?=", TOKEN_649, false);
("1'bX", TOKEN_430, false);
("[*", TOKEN_346, false);
("@*", TOKEN_500, false);
("1'bx", TOKEN_429, false);
("\"DPI\"", TOKEN_287, false);
("'0", TOKEN_631, false);
("'1", TOKEN_632, false);
("(*", TOKEN_697, false);
("1364-2001", TOKEN_46, false);
("'X", TOKEN_636, false);
("'Z", TOKEN_634, false);
("\n", TOKEN_706, false);
("*)", TOKEN_699, false);
("|=>", TOKEN_328, false);
("*/", TOKEN_END_COMMENT, false);
("!?=", TOKEN_650, false);
("++", TOKEN_652, false);
("'x", TOKEN_635, false);
("'z", TOKEN_633, false);
("]{", TOKEN_724, false);
("9_$", TOKEN_723, false);
("[*=", TOKEN_348, false);
("|=", TOKEN_471, false);
("--", TOKEN_653, false);
("(*)", TOKEN_501, false);
("-incdir", INCDIR, false);
("/*", TOKEN_BEGIN_COMMENT, false);
("//", TOKEN_704, false);
("||", TOKEN_651, false);
("01", TOKEN_587, false);
("{any_ASCII_character_except_white_space}", TOKEN_719, false);
("~|", TOKEN_648, false);
("10", TOKEN_588, false);
("11", TOKEN_176, false);
("'B0", TOKEN_597, false);
("'B1", TOKEN_598, false);
( "&" , (AMPERSAND), false);
( "@" , (AT), false);
( "^" , (CARET), false);
( ":" , (COLON), false);
( "," , (COMMA), false);
( "/" , (DIVIDE), false);
( "=" , (EQUALS), false);
( ">" , (GREATER), false);
( "#" , (HASH), false);
( "[" , (LBRACK), false);
( "{" , (LCURLY), false);
( "<" , (LESS), false);
( "(" , (LPAREN), false);
( "-" , (MINUS), false);
( "%" , (MODULO), false);
( "." , (DOT), false);
( "!" , (PLING), false);
( "+" , (PLUS), false);
( "?" , (QUERY), false);
( "]" , (RBRACK), false);
( "}" , (RCURLY), false);
( ")" , (RPAREN), false);
( ";" , (SEMICOLON), false);
( "~" , (TILDE), false);
( "*" , (TIMES), false);
( "|" , (VBAR), false);
( "$" , (DOLLAR), false);
( "'" , (SQUOTE), false);
( "\\n", TOKEN_601, false)]


let subst1 sub1 obuf outix = begin match sub1 with
| "&LT;" -> String.set obuf !outix '<'; outix := !outix+1
| "&GT;" -> String.set obuf !outix '>'; outix := !outix+1
| "&AMP;" -> String.set obuf !outix '&'; outix := !outix+1
| "&QUOT;" -> String.set obuf !outix '\"'; outix := !outix+1
| _ -> print_endline sub1  end

let rec split2 write_os sub2 = if (!valid1 || !valid2) then begin
if String.contains sub2 '\n' then let ix = String.index sub2 '\n' in
    ( split2 (write_os) (String.sub sub2 0 (if (ix > 0) && (sub2.[ix-1]) = '\r' then ix-1 else ix));
      write_os (String.sub sub2 ix 1);
      split2 (write_os) (String.sub sub2 (ix+1) (String.length(sub2)-ix-1)) );
else if String.contains sub2 ' ' then let ix = String.index sub2 ' ' in
    ( split2 (write_os) (String.sub sub2 0 ix);
      write_os (String.sub sub2 ix 1);
      split2 (write_os) (String.sub sub2 (ix+1) (String.length(sub2)-ix-1)) );
else if String.contains sub2 '\t' then let ix = String.index sub2 '\t' in
    ( split2 (write_os) (String.sub sub2 0 ix);
      write_os (String.sub sub2 ix 1);
      split2 (write_os) (String.sub sub2 (ix+1) (String.length(sub2)-ix-1)) );
else if (String.length sub2 > 0) then
    ( if not ((Hashtbl.mem ksymbols sub2)||(Hashtbl.mem hsh2 sub2)) then
        ( write_os_pending (ID (if !valid2 then String.uppercase sub2 else sub2));
          if !valid2 && (isalpha sub2.[0]) && (String.length sub2 > 2) then
            Printf.fprintf tc "(  \"%s\", %s);\n" sub2 (String.uppercase sub2) else
            ( cnt := !cnt+1; Hashtbl.add hsh2 sub2 !cnt )) else 
          write_os_pending (if (Hashtbl.mem ksymbols sub2) then 
          (match (Hashtbl.find ksymbols sub2) with (x,y) -> x) else
          ID sub2))
end

let amp write_os s = 
let len = String.length s in let ix = ref 0 and outix = ref 0 and copy = ref true
and starts = ref 0 and obuf = String.create len in while (!ix < len) do
if s.[!ix] = '&' then ( starts := !ix; copy := false; )
else if ( s.[!ix] = ';' ) && not !copy then
  ( subst1 (String.uppercase (String.sub s (!starts) ((!ix)-(!starts)+1))) obuf outix;
  copy := true)
else if !copy then ( String.set obuf !outix s.[!ix]; outix := !outix+1 ); ix := !ix+1 done;
split2 write_os (String.sub obuf 0 !outix);;

let mywrite_ ~dtd ~xhtml write_os doc =
  let rec trav doc =
    match doc with
	Element(name,atts,subdocs) ->
	  ( match name with
		"!" ->
		  write_os_not "<!";
		  write_os_not (List.assoc "contents" atts);
		  write_os_not ">";
	      | "?" ->
		  write_os_not "<?";
		  write_os_not (List.assoc "contents" atts);
		  write_os_not ">";
	      | "--" ->
		  write_os_not "<!--";
		  write_os_not (List.assoc "contents" atts);
		  write_os_not "-->";
	      | _ ->
		  let is_empty =
		    try 
		      let _, constr = List.assoc name dtd in
		      constr = `Empty
		    with
			Not_found -> false
		  in
		  List.iter
		    (fun (aname,aval) ->
		       write_os_not " ";
		       write_os_not aname;
		       write_os_not "=";
		       write_os_not aval;
                       match aname with
                       | "class" ->
                       if (name="li") && (aval="DashedList") then mask := true;
                       if (name="p") && (aval="BNF_SyntaxItem") && not (!mask) then valid1 := true;
                       if (name="span") && (aval="BNFkeyword") && not (!mask) then valid2 := true;
                       if (name="p") && (aval="Body.Indented.1") && not (!mask) then valid1 := true;
                       if (name="span") && (aval="Superscript") then superscript := true;
                       | "name" -> myname := aval
                       | _ -> ()
		    )
		    atts;
		  if is_empty then
		    (* Ignore subdocs (even if <> []) because they should
		       not be there. *)
		    write_os_not (if xhtml then "/>" else ">")
                  else begin
		    write_os_not ">";
		    List.iter trav subdocs;
		    write_os_not "</";
		    write_os_not name;
		    write_os_not ">";
                    match name with
                    | "span" -> if (!superscript) then superscript := false else
		        (valid1 := !valid2; valid2 := false)
                    | "li" -> mask := false
                    | "p" ->  let l = write_os_flush "" (write_os) (ref (List.rev !to_wr)) in 
		              if l <> [] then Hashtbl.add rules (List.hd l) l;
			      (* if !to_wr <> [] then List.iter (fun item -> output_string tc ((mygetstr2 item)^"********\n")) !to_wr; *)
			      to_wr := [];
		              write_os "/* "; List.iter (fun item -> unpack write_os item) l; write_os "*/\n";
		              valid1 := false; valid2 := false; begin_clause := false;
                    | _ -> ()
		  end
	  )
      | Data s -> match s with
          | "\r\n" -> write_os s
	  | _ -> if (!valid1) || (!valid2) then
	      begin if !com then begin let meaningful = ref ((String.length !comment) > 10) in
				  com := false;
				      for i = 0 to (String.length !comment)-1 do if (isalpha !comment.[i]) then meaningful := true; done;
				  if (!meaningful) then write_os (Printf.sprintf "/* %s */\n"
				 !comment); end;
				       if not (!superscript) then amp (write_os) s end
	      else begin if not !com then ( com := true; comment := ""; ); comment := !comment ^ s end
  in
  try
    List.iter trav doc;
    write_os "\n";
    Hashtbl.iter (fun key lst -> match key with ID id -> write_os (dump2 id lst) | _ -> ()) rules;
    List.iter (fun item -> write_os item) !pending;
    write_os "// END_OF_FILE\n"
  with
      Not_found -> failwith "write"

let mywrite ?(dtd = html40_dtd) ?(xhtml = true) ch doc =
  mywrite_ ~dtd ~xhtml (ch # output_string) doc

let html_document chan =
  with_in_obj_channel
    (new input_channel chan)
    Nethtml.parse

let _ = 
  let chan1 = open_in Sys.argv.(1) in
  let html1 = html_document chan1 in
  let chan2 = open_in Sys.argv.(2) in
  let html2 = html_document chan2 in
  let ochan1 = open_out Sys.argv.(3) in
  let ochan2 = open_out Sys.argv.(4) in

  Hashtbl.iter (fun key (item,prim) -> Hashtbl.add reverse item ("'"^key^"'");
    Printf.fprintf ochan1 "%%token%s %s // %s\n" (if prim then "<string>" else "") (Ord.getstr item) key) ksymbols;
(*
  Printf.fprintf ochan1 "%%token <string> X\n";
  Printf.fprintf ochan1 "%%token <string> x\n";
  Printf.fprintf ochan1 "%%token <string> R\n";
  Printf.fprintf ochan1 "%%token <string> r\n";
  Printf.fprintf ochan1 "%%token <string> f\n";
  Printf.fprintf ochan1 "%%token <string> P\n";
  Printf.fprintf ochan1 "%%token <string> p\n";
  Printf.fprintf ochan1 "%%token <string> N\n";
  Printf.fprintf ochan1 "%%token <string> n\n";
  Printf.fprintf ochan1 "%%token <string> Z\n";
  Printf.fprintf ochan1 "%%token <string> z\n";
  Printf.fprintf ochan1 "%%token <string> S\n";
  Printf.fprintf ochan1 "%%token <string> s\n";
  Printf.fprintf ochan1 "%%token <string> a b c d e f A B C D E F\n";
  Printf.fprintf ochan1 "%%token <string> H O d e a\n";
  Printf.fprintf ochan1 "%%token <string> FILE_PATH\n";
  Printf.fprintf ochan1 "%%token <string> SPACE TAB NEWLINE EOF\n";
  Printf.fprintf ochan1 "%%token <string> ZA Z_ Z0\n";
*)
  Printf.fprintf ochan1 "%%token <token> MS\n";
  Printf.fprintf ochan1 "%%token <token> US\n";
  Printf.fprintf ochan1 "%%token <token> NS\n";
  Printf.fprintf ochan1 "%%token <token> PS\n";
  Printf.fprintf ochan1 "%%token <token> FS\n";
  Printf.fprintf ochan1 "%%token <token> AS\n";
  Printf.fprintf ochan1 "%%token <string> ASCNUM\n";
  Printf.fprintf ochan1 "%%token <char> CHAR\n";
  Printf.fprintf ochan1 "%%token <string> ID\n";
  Printf.fprintf ochan1 "%%token <token * token > RANGE\n";
  Printf.fprintf ochan1 "%%token <int> INT\n";
  for i = 2 to 25 do
    let rec kind n = (if n > 1 then (kind (n-1)^" * ") else "")^"token" in
    Printf.fprintf ochan1 "%%token <%s> %s\n" (kind i) (multiple i);
  done;
  Printf.fprintf ochan1 "%%token ALTERNATIVE\n";
  Printf.fprintf ochan1 "%%token  ASSIGNMENT\n";
  Printf.fprintf ochan1 "%%token  BIDIR\n";
  Printf.fprintf ochan1 "%%token <string> BINNUM\n";
  Printf.fprintf ochan1 "%%token  BITSEL\n";
  Printf.fprintf ochan1 "%%token  CASECOND\n";
  Printf.fprintf ochan1 "%%token  CELLPIN\n";
  Printf.fprintf ochan1 "%%token  CONCAT\n";
  Printf.fprintf ochan1 "%%token  D_C\n";
  Printf.fprintf ochan1 "%%token <string> DECNUM\n";
  Printf.fprintf ochan1 "%%token  DLYASSIGNMENT\n";
  Printf.fprintf ochan1 "%%token <token list> DOTTED\n";
  Printf.fprintf ochan1 "%%token  D_RANDOM\n";
  Printf.fprintf ochan1 "%%token  DRIVER\n";
  Printf.fprintf ochan1 "%%token  D_STIME\n";
  Printf.fprintf ochan1 "%%token  ENDLABEL\n";
  Printf.fprintf ochan1 "%%token  ENDOFFILE\n";
  Printf.fprintf ochan1 "%%token <float> FLOATNUM\n";
  Printf.fprintf ochan1 "%%token FULLSKEW_TIMING_CHECK\n";
  Printf.fprintf ochan1 "%%token  FUNCREF\n";
  Printf.fprintf ochan1 "%%token  FUNCUSED\n";
  Printf.fprintf ochan1 "%%token  GENCASE\n";
  Printf.fprintf ochan1 "%%token  GENCASECOND\n";
  Printf.fprintf ochan1 "%%token <string> HEXNUM\n";
  Printf.fprintf ochan1 "%%token HOLD_TIMING_CHECK\n";
  Printf.fprintf ochan1 "%%token  IMPLICIT\n";
  Printf.fprintf ochan1 "%%token <string> INTNUM\n";
  Printf.fprintf ochan1 "%%token  IOPORT\n";
  Printf.fprintf ochan1 "%%token LEFT_BRACKET\n";
  Printf.fprintf ochan1 "%%token LEFT_CURLY\n";
  Printf.fprintf ochan1 "%%token  MEMORY\n";
  Printf.fprintf ochan1 "%%token  MINTYPMAX\n";
  Printf.fprintf ochan1 "%%token  MODINST\n";
  Printf.fprintf ochan1 "%%token  NAMED\n";
  Printf.fprintf ochan1 "%%token NOCHANGE_TIMING_CHECK\n";
  Printf.fprintf ochan1 "%%token <string> OCTNUM\n";
  Printf.fprintf ochan1 "%%token  PARAMUSED\n";
  Printf.fprintf ochan1 "%%token  PARTSEL\n";
  Printf.fprintf ochan1 "%%token  P_CELLDEFINE\n";
  Printf.fprintf ochan1 "%%token  P_DEFINE\n";
  Printf.fprintf ochan1 "%%token  P_DELAY_MODE_PATH\n";
  Printf.fprintf ochan1 "%%token  P_DISABLE_PORTFAULTS\n";
  Printf.fprintf ochan1 "%%token  P_ELSE\n";
  Printf.fprintf ochan1 "%%token  P_ENABLE_PORTFAULTS\n";
  Printf.fprintf ochan1 "%%token  P_ENDCELLDEFINE\n";
  Printf.fprintf ochan1 "%%token  P_ENDIF\n";
  Printf.fprintf ochan1 "%%token  P_ENDPROTECT\n";
  Printf.fprintf ochan1 "%%token PERIOD_TIMING_CHECK\n";
  Printf.fprintf ochan1 "%%token  P_IFDEF\n";
  Printf.fprintf ochan1 "%%token <string> P_INCLUDE\n";
  Printf.fprintf ochan1 "%%token  P_NOSUPPRESS_FAULTS\n";
  Printf.fprintf ochan1 "%%token  P_PROTECT\n";
  Printf.fprintf ochan1 "%%token <string> PRAGMATIC\n";
  Printf.fprintf ochan1 "%%token <string> PREPROC\n";
  Printf.fprintf ochan1 "%%token  P_RESETALL\n";
  Printf.fprintf ochan1 "%%token  PRIMINST\n";
  Printf.fprintf ochan1 "%%token  P_SUPPRESS_FAULTS\n";
  Printf.fprintf ochan1 "%%token <string> P_TIMESCALE\n";
  Printf.fprintf ochan1 "%%token  RECEIVER\n";
  Printf.fprintf ochan1 "%%token RECOVERY_TIMING_CHECK\n";
  Printf.fprintf ochan1 "%%token RECREM_TIMING_CHECK\n";
  Printf.fprintf ochan1 "%%token REMOVAL_TIMING_CHECK\n";
  Printf.fprintf ochan1 "%%token RIGHT_BRACKET\n";
  Printf.fprintf ochan1 "%%token RIGHT_CURLY\n";
  Printf.fprintf ochan1 "%%token  SCALAR\n";
  Printf.fprintf ochan1 "%%token  SENSUSED\n";
  Printf.fprintf ochan1 "%%token SETUPHOLD_TIMING_CHECK\n";
  Printf.fprintf ochan1 "%%token SETUP_TIMING_CHECK\n";
  Printf.fprintf ochan1 "%%token SKEW_TIMING_CHECK\n";
  Printf.fprintf ochan1 "%%token  SPECIAL\n";
  Printf.fprintf ochan1 "%%token  SUBCCT\n";
  Printf.fprintf ochan1 "%%token  SUBMODULE\n";
  Printf.fprintf ochan1 "%%token SUBTRACTION\n";
(*
  Printf.fprintf ochan1 "%%token SYSTEM_FUNCTION_IDENTIFIER_3 \n";
  Printf.fprintf ochan1 "%%token SYSTEM_TASK_IDENTIFIER_3 \n";
*)
  Printf.fprintf ochan1 "%%token  TASKREF\n";
  Printf.fprintf ochan1 "%%token  TASKUSED\n";
  Printf.fprintf ochan1 "%%token TIMESKEW_TIMING_CHECK\n";
  Printf.fprintf ochan1 "%%token  TIMINGSPEC\n";
  Printf.fprintf ochan1 "%%token <token list> TLIST\n";
  Printf.fprintf ochan1 "%%token TOKEN_707\n";
  Printf.fprintf ochan1 "%%token TOKEN_708\n";
  Printf.fprintf ochan1 "%%token  UNKNOWN\n";
  Printf.fprintf ochan1 "%%token WIDTH_TIMING_CHECK\n";
  Printf.fprintf ochan1 "\n";
  Printf.fprintf ochan1 "%%start start\n";
  Printf.fprintf ochan1 "%%type <token> start\n";
  Printf.fprintf ochan1 "\n%%%%\n\n";
  Printf.fprintf ochan1 "start: source_text { $1 };\n\n";
  Hashtbl.iter (fun key (item,prim) -> if prim then let x = Ord.getstr item in Printf.fprintf ochan1 "%s: %s { %s $1 };\n" key x x) ksymbols;
  with_out_obj_channel (new output_channel ochan1) (fun ch -> mywrite ch html1);
  close_in chan1;
  close_out ochan1; (* I think this happened already *)
  with_out_obj_channel (new output_channel ochan2) (fun ch -> write ch html2);
  close_in chan2;
  close_out ochan2; (* I think this happened already *)
  Hashtbl.iter (fun key item -> if not (isalpha key.[0]) then
		    begin let tok = if key.[0]='$' then String.uppercase (String.sub key 1 ((String.length key)-1)) else 
		    ("TOKEN_"^(string_of_int item)) in Printf.fprintf tc "(\"%s\", %s);\n" key tok; end) hsh2;
  close_out tc


