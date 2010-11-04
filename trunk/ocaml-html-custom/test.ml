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
open Vparser

let multiple x = match x with
| 0 -> " "
| 1 -> "("
| 2 -> "DOUBLE("
| 3 -> "TRIPLE("
| 4 -> "QUADRUPLE("
| 5 -> "QUINTUPLE("
| 6 -> "SEXTUPLE("
| 7 -> "SEPTUPLE("
| 8 -> "OCTUPLE("
| _ -> "UNKNOWN"^(string_of_int x)^"("

let isalpha = function 'A'..'Z'|'a'..'z' -> true | _ -> false

let valid1 = ref false and valid2 = ref false and com = ref false and mask = ref false
and superscript = ref false and optional = ref false and zlist = ref false and annotated = ref false
and begin_clause = ref false and to_write = ref [] and myname = ref "" and comment = ref "" and pending = ref []

let write_os_pending (tok:token) = 
to_write := !to_write @ [tok]

let rec write_os_flush_old kind name write_os = 
let cnt = ref 0 and nam = ref name in
let fetch () = begin let tok = List.hd(!to_write) in ( to_write := List.tl(!to_write); cnt := !cnt+1; tok ) end in
let fmt = ref "" and looping = ref true and cnt0 = ref 0 and syn = ref "" in
let dump_alt () = begin fmt := !fmt^" { }"; cnt0 := !cnt; syn := "" end in
match kind with
| LBRACK -> fmt := name^":\t/*empty*/ {EMPTY} | "
| LCURLY -> fmt := name^":\t/*empty*/ {EMPTY} | "^name^" "; syn := name; cnt0 := 1
| _ -> fmt := "";
while !looping && (!to_write <> []) do
let tok = fetch() in match tok with
| ID s -> fmt := !fmt ^ s ^ " "; if !nam = "" then nam := s; syn := !syn ^" $"^(string_of_int (!cnt - !cnt0))
| IS_DEFINED_AS -> fmt := !fmt^":\t"; cnt0 := !cnt; syn := ""
| VBAR -> dump_alt(); fmt := !fmt^"\n|\t"
| LBRACK -> let nam = !nam^"_"^(string_of_int !cnt) in begin syn := !syn ^" $"^(string_of_int (!cnt - !cnt0)); write_os_flush_old LBRACK nam (write_os); fmt := !fmt^nam^" " end
| RBRACK -> looping := false
| LCURLY -> let nam = !nam^"_"^(string_of_int !cnt) in begin syn := !syn ^" $"^(string_of_int (!cnt - !cnt0)); write_os_flush_old LCURLY nam (write_os); fmt := !fmt^nam^" " end
| RCURLY -> looping := false
| _ -> fmt := !fmt ^ (Ord.getstr tok) ^ " "; syn := !syn ^ " " ^ (Ord.getstr tok)
done;
if (!cnt > 0) then dump_alt();
write_os (!fmt^"\n;\n\n")

let rec write_os_flush name write_os = 
let cnt = ref 0 and nam = ref name in
let fetch () = begin let tok = List.hd(!to_write) in ( to_write := List.tl(!to_write); cnt := !cnt+1; tok ) end in
let looping = ref true and sub_def = ref [] in
while !looping && (!to_write <> []) do
let tok = fetch() in match tok with
| ID s -> sub_def := !sub_def @ [tok]
| IS_DEFINED_AS -> sub_def := !sub_def @ [tok]
| VBAR -> sub_def := !sub_def @ [tok]
| LBRACK -> sub_def := !sub_def @ [TLIST (write_os_flush (!nam^"_"^(string_of_int !cnt)) (write_os))]
| LCURLY -> sub_def := !sub_def @ [DOTTED (write_os_flush (!nam^"_"^(string_of_int !cnt)) (write_os))]
| RBRACK | RCURLY -> looping := false
| _ -> sub_def := !sub_def @ [tok]
done;
!sub_def

let write_os_not str = ()

let rules = Hashtbl.create 256
let hsh2 = Hashtbl.create 256
let cnt = ref 0
let tc = open_out "tokens.ml"

let ksymbols = Hashtbl.create 256
let reverse = Hashtbl.create 256

let rec mygetstr tok = match tok with
| ID id -> id
| TOKEN_BEGIN_COMMENT -> "'/' '*' "
| TOKEN_END_COMMENT -> "'*' '/' "
| TLIST lst | DOTTED lst -> let concat = ref "" in List.iter (fun item -> concat := !concat ^ " " ^ mygetstr item) lst; !concat
| _ -> if (Hashtbl.mem reverse tok) then (Hashtbl.find reverse tok) else (Ord.getstr tok)

let rec mygetstr2 tok = match tok with
| ID id -> id
| TLIST lst | DOTTED lst -> let concat = ref "" in List.iter (fun item -> concat := !concat ^ " " ^ mygetstr2 item) lst; !concat
| _ -> Ord.getstr tok

let rec mygetstr3 tok cnt len = match tok with
| ID id -> (if String.length id > 1 then ("$"^(string_of_int cnt)) else "CHAR '"^id^"'")^(if cnt == len then ");" else ", ")
| _ -> (Ord.getstr tok)^(if cnt == len then ");" else ", ")

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
        let cnt = ref 0 in List.iter (fun item -> write (cnt := !cnt + 1; mygetstr3 item !cnt len)) !args; write " }\n\t| "; args := []

let rec unpack2 write cnt key tok args = match tok with
    | VBAR -> dumpargs2 write args
    | IS_DEFINED_AS -> write ": "; args := []
    | ID id -> write (if String.length id > 1 then id^" " else Printf.sprintf "'%s' " id); args := !args @ [tok]
    | TLIST lst -> pending := !pending @ [dump2 key (ID key :: IS_DEFINED_AS :: lst)]; write (key^" "); args := !args @ [ID key]
    | DOTTED lst -> pending := !pending @ [dump2 key (ID key :: IS_DEFINED_AS :: lst)]; write (key^" "); args := !args @ [ID key]
    | _ -> write ((mygetstr2 tok)^" "); args := !args @ [tok]

and dump2 (key:string) lst =
let buffer = ref "" and cnt = ref 0 and args = ref [] in
List.iter (fun item -> let key2 = key^"_"^(string_of_int !cnt) in unpack2 (fun s -> buffer := !buffer^s) !cnt key2 item args; cnt := !cnt + 1) lst;
dumpargs2(fun s -> buffer := !buffer^s) args;
!buffer^" { };\n\n"

let enter_keyword id keyword = 
if Hashtbl.mem ksymbols id then
  Printf.printf "Error: repeated keyword %s\n" id
else begin
(*  Printf.printf "Enter %s\n" id; *)
  Hashtbl.add ksymbols id keyword
  end

let _ = List.iter (fun (str,key) -> enter_keyword str key)
[
(*
("$hold_timing_check", HOLD_TIMING_CHECK);
("$width_timing_check", WIDTH_TIMING_CHECK);
("$recovery_timing_check", RECOVERY_TIMING_CHECK);
("$setuphold_timing_check", SETUPHOLD_TIMING_CHECK);
("$fullskew_timing_check", FULLSKEW_TIMING_CHECK);
("$timeskew_timing_check", TIMESKEW_TIMING_CHECK);
("$setup_timing_check", SETUP_TIMING_CHECK);
("$skew_timing_check", SKEW_TIMING_CHECK);
("$nochange_timing_check", NOCHANGE_TIMING_CHECK);
("$recrem_timing_check", RECREM_TIMING_CHECK);
("$removal_timing_check", REMOVAL_TIMING_CHECK);
("$period_timing_check", PERIOD_TIMING_CHECK);
*)
(  "Any_ASCII_Characters", ANY_ASCII_CHARS);
(  "Any_ASCII_character", ANY_ASCII_CHAR);
(  "within", WITHIN);
(  "this", THIS);
("$nochange", NOCHANGE);
("$fullskew", FULLSKEW);
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
(  "xor",		XOR ) ;
(  "bufif0", BUFIF0) ;
(  "notif0", NOTIF0) ;
(  "tranif0", TRANIF0) ;
(  "weak0", WEAK0);
(  "bufif1", BUFIF1) ;
(  "notif1", NOTIF1) ;
(  "tranif1", TRANIF1) ;
(  "weak1", WEAK1);
(  "alias", ALIAS);
(  "before", BEFORE);
(  "bind", BIND);
(  "bit", BIT);
(  "bold", BOLD);
(  "break", BREAK);
(  "byte", BYTE);
(  "cell", CELL);
(  "chandle", CHANDLE);
(  "class", CLASS);
(  "cmos", CMOS);
(  "config", CONFIG);
(  "const", CONST);
(  "constraint", CONSTRAINT);
(  "context", CONTEXT);
(  "continue", CONTINUE);
(  "design", DESIGN);
(  "dist", DIST);
(  "endclass", ENDCLASS);
(  "endclocking", ENDCLOCKING);
(  "endconfig", ENDCONFIG);
(  "endinterface", ENDINTERFACE);
(  "endprogram", ENDPROGRAM);
(  "endproperty", ENDPROPERTY);
(  "endsequence", ENDSEQUENCE);
(  "enum", ENUM);
(  "export", EXPORT);
(  "extends", EXTENDS);
(  "extern", EXTERN);
(  "first_match", FIRST_MATCH);
(  "force", FORCE);
(  "fork", FORK);
(  "forkjoin", FORKJOIN);
(  "highz0", HIGHZ0);
(  "highz1", HIGHZ1);
(  "import", IMPORT);
(  "include", INCLUDE);
(  "inside", INSIDE);
(  "instance", INSTANCE);
(  "interface", INTERFACE);
(  "intersect", INTERSECT);
(  "int", INT 0);
(  "join_any", JOIN_ANY);
(  "join", JOIN);
(  "join_none", JOIN_NONE);
(  "large", LARGE);
(  "liblist", LIBLIST);
(  "library", LIBRARY);
(  "local", LOCAL);
(  "logic", LOGIC);
(  "longint", LONGINT);
(  "macromodule", MACROMODULE);
(  "medium", MEDIUM);
(  "modport", MODPORT);
(  "new", NEW);
(  "noshowcancelled", NOSHOWCANCELLED);
(  "null", NULL);
(  "packed", PACKED);
(  "PATHPULSE$", PATHPULSE);
(  "priority", PRIORITY);
(  "program", PROGRAM);
(  "protected", PROTECTED);
(  "pull0", PULL0);
(  "pull1", PULL1);
(  "pulldown", PULLDOWN);
(  "pulsestyle_ondetect", PULSESTYLE_ONDETECT);
(  "pulsestyle_onevent", PULSESTYLE_ONEVENT);
(  "pure", PURE);
(  "randc", RANDC);
(  "randomize", RANDOMIZE);
(  "rand", RAND);
(  "rcmos", RCMOS);
(  "realtime", REALTIME);
(  "ref", REF);
(  "release", RELEASE);
(  "return", RETURN);
(  "rnmos", RNMOS);
(  "rpmos", RPMOS);
(  "rtranif0", RTRANIF0);
(  "rtranif1", RTRANIF1);
(  "rtran", RTRAN);
(  "scalared", SCALARED);
(  "sequence", SEQUENCE);
(  "shortint", SHORTINT);
(  "shortreal", SHORTREAL);
(  "showcancelled", SHOWCANCELLED);
(  "small", SMALL);
(  "solve", SOLVE);
(  "step", STEP);
(  "string", STRING);
(  "strong0", STRONG0);
(  "strong1", STRONG1);
(  "struct", STRUCT);
(  "super", SUPER);
(  "throughout", THROUGHOUT);
(  "timeprecision", TIMEPRECISION);
(  "time", TIME);
(  "timeunit", TIMEUNIT);
(  "triand", TRIAND);
(  "trior", TRIOR);
(  "trireg", TRIREG);
(  "tri", TRI);
(  "typedef", TYPEDEF);
(  "type", TYPE);
(  "union", UNION);
(  "unique", UNIQUE);
(  "use", USE);
(  "virtual", VIRTUAL);
(  "void", VOID);
(  "wait_order", WAIT_ORDER);
(  "wait", WAIT);
(  "wand", WAND);
(  "with", WITH);
(  "wor", WOR);
(  "&&"			, (P_ANDAND));
(  "&&&"		, (P_ANDANDAND));
(  "&="			, (P_ANDEQ));
(  "*>"                 , (P_ASTGT));
(  "@@"			, (P_ATAT));
(  "==="		, (P_CASEEQUAL));
(  "!=="		, (P_CASENOTEQUAL));
(  "::"			, (P_COLONCOLON));
(  ":/"			, (P_COLONDIV));
(  ":="			, (P_COLONEQ));
(  "/="			, (P_DIVEQ));
(  ".*"			, (P_DOTSTAR));
(  "=>"                 , (P_EQGT));
(  "=="			, (P_EQUAL));
(  ">="			, (P_GTE));
(  "<="			, (P_LTE));
(  "-:"			, (P_MINUSCOLON));
(  "-="			, (P_MINUSEQ));
(  "->"			, (P_MINUSGT));
(  "%="			, (P_MODEQ));
(  "~&"			, (P_NAND));
(  "~("			, (P_NOR));
(  "!="			, (P_NOTEQUAL));
(  "(="			, (P_OREQ));
(  "(=>"		, (P_OREQGT));
(  "(,"		        , (P_ORMINUSGT));
(  "(("			, (P_OROR));
(  "+:"			, (P_PLUSCOLON));
(  "+="			, (P_PLUSEQ));
(  "##"			, (P_POUNDPOUND));
(  "**"			, (P_POW));
(  "<<<"		, (P_SLEFT));
(  "<<"			, (P_SLEFT));
(  "<<<="		, (P_SLEFTEQ));
(  "<<="		, (P_SLEFTEQ));
(  ">>"			, (P_SRIGHT));
(  ">>="		, (P_SRIGHTEQ));
(  ">>>"		, (P_SSRIGHT));
(  ">>>="		, (P_SSRIGHTEQ));
(  "*="			, (P_TIMESEQ));
(  "==?"		, (P_WILDEQUAL));
(  "!=?"		, (P_WILDNOTEQUAL));
(  "^~"			, (P_XNOR));
(  "~^"			, (P_XNOR));
(  "^="			, (P_XOREQ));
("[*->", TOKEN_349);
("|->", TOKEN_327);
("\"", TOKEN_695);
("::=", IS_DEFINED_AS);
("->>", TOKEN_504);
("0", TOKEN_436);
("1", TOKEN_435);
("2", TOKEN_687);
("3", TOKEN_688);
("4", TOKEN_689);
("5", TOKEN_690);
("6", TOKEN_691);
("7", TOKEN_639);
("8", TOKEN_272);
("9", TOKEN_266);
("1'B0", TOKEN_431);
("1'B1", TOKEN_432);
("'b0", TOKEN_595);
("'b1", TOKEN_596);
("\\", TOKEN_718);
("_", TOKEN_661);
("1'BX", TOKEN_434);
("1'Bx", TOKEN_433);
("9_", TOKEN_713);
("1'b0", TOKEN_427);
("1'b1", TOKEN_428);
("=?=", TOKEN_649);
("1'bX", TOKEN_430);
("[*", TOKEN_346);
("@*", TOKEN_500);
("1'bx", TOKEN_429);
("\"DPI\"", TOKEN_287);
("'0", TOKEN_631);
("'1", TOKEN_632);
("(*", TOKEN_697);
("1364-2001", TOKEN_46);
("'X", TOKEN_636);
("'Z", TOKEN_634);
("\n", TOKEN_706);
("*)", TOKEN_699);
("|=>", TOKEN_328);
("*/", TOKEN_END_COMMENT);
("!?=", TOKEN_650);
("++", TOKEN_652);
("'x", TOKEN_635);
("'z", TOKEN_633);
("]{", TOKEN_724);
("9_$", TOKEN_723);
("[*=", TOKEN_348);
("|=", TOKEN_471);
("--", TOKEN_653);
("(*)", TOKEN_501);
("-incdir", INCDIR);
("/*", TOKEN_BEGIN_COMMENT);
("//", TOKEN_704);
("||", TOKEN_651);
("01", TOKEN_587);
("{any_ASCII_character_except_white_space}", TOKEN_719);
("~|", TOKEN_648);
("10", TOKEN_588);
("11", TOKEN_176);
("'B0", TOKEN_597);
("'B1", TOKEN_598);
( "&" , (AMPERSAND));
( "@" , (AT));
( "^" , (CARET));
( ":" , (COLON));
( "," , (COMMA));
( "/" , (DIVIDE));
( "=" , (EQUALS));
( ">" , (GREATER));
( "#" , (HASH));
( "[" , (LBRACK));
( "{" , (LCURLY));
( "<" , (LESS));
( "(" , (LPAREN));
( "-" , (MINUS));
( "%" , (MODULO));
( "." , (DOT));
( "!" , (PLING));
( "+" , (PLUS));
( "?" , (QUERY));
( "]" , (RBRACK));
( "}" , (RCURLY));
( ")" , (RPAREN));
( ";" , (SEMICOLON));
( "~" , (TILDE));
( "*" , (TIMES));
( "|" , (VBAR));
( "$" , (DOLLAR));
( "'" , (SQUOTE));
( "\\n", TOKEN_601)]


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
          (Hashtbl.find ksymbols sub2) else
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
		  write_os_not (Printf.sprintf "\n<%s,%s %s"
				 (if !valid1 then "true" else "false")
				 (if !valid2 then "true" else "false")
				 name);
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
                    | "p" ->  let l = write_os_flush "" (write_os) in if l <> [] then Hashtbl.add rules (List.hd l) l;
		              write_os "/* "; List.iter (fun item -> unpack write_os item) l; write_os "*/\n";
		              valid1 := false; valid2 := false; begin_clause := false;
                    | _ -> ()
		  end
	  )
      | Data s -> match s with
          | "\r\n" -> write_os s
	  | _ -> if (!valid1) || (!valid2) then
	      begin if !com then begin let meaningful = ref false in
				  com := false;
				      for i = 0 to (String.length !comment)-1 do if (isalpha !comment.[i]) then meaningful := true; done;
				  if (!meaningful) then write_os (Printf.sprintf "/* %s */\n" !comment); end;
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

  Hashtbl.iter (fun key item -> Hashtbl.add reverse item ("'"^key^"'"); Printf.fprintf ochan1 "%%token %s // %s\n" (Ord.getstr item) key) ksymbols;
  Printf.fprintf ochan1 "%%token <string> file_path\n";
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
*)
  Printf.fprintf ochan1 "%%token <string> ZA Z_ zA Z0\n";
  Printf.fprintf ochan1 "%%token <string> MS\n";
  Printf.fprintf ochan1 "%%token <string> US\n";
  Printf.fprintf ochan1 "%%token <string> NS\n";
  Printf.fprintf ochan1 "%%token <string> PS\n";
  Printf.fprintf ochan1 "%%token <string> FS\n";
  Printf.fprintf ochan1 "%%token <string> AS\n";
  Printf.fprintf ochan1 "%%token <string> space tab newline eof\n";
  Printf.fprintf ochan1 "%%token <string> ASCNUM\n";
  Printf.fprintf ochan1 "\n";
  Printf.fprintf ochan1 "%%start library_text\n";
  Printf.fprintf ochan1 "%%type <unit> library_text\n";
  Printf.fprintf ochan1 "\n";
  Printf.fprintf ochan1 "\n%%%%\n\n";
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


