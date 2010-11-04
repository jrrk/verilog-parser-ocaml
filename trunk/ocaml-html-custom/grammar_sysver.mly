%token P_ATAT // @@
%token MACROMODULE // macromodule
%token FILE_PATH // file_path
%token D_CLOG2 // $clog2
%token D_READMEMB // $readmemb
%token INSTANCE // instance
%token CONSTRAINT // constraint
%token TOKEN_46 // 1364-2001
%token PACKED // packed
%token D_READMEMH // $readmemh
%token IFF // iff
%token TOKEN_706 // 

%token PRIMITIVE // primitive
%token WIRE // uwire
%token D_FFLUSH // $fflush
%token P_ANDEQ // &=
%token EOF // eof
%token BEGIN // begin
%token ENDCLOCKING // endclocking
%token NEW // new
%token D_FOPEN // $fopen
%token<string> C_IDENTIFIER_3_2 // c_identifier_3_2
%token TOKEN_597 // 'B0
%token TOKEN_631 // '0
%token D_FWRITE // $fwrite
%token TOKEN_598 // 'B1
%token TOKEN_632 // '1
%token ENDSPECIFY // endspecify
%token TOKEN_434 // 1'BX
%token PRIORITY // priority
%token SOLVE // solve
%token REALTIME // realtime
%token PROPERTY // property
%token P_OROR // ((
%token BUFIF0 // bufif0
%token PLING // !
%token BUFIF1 // bufif1
%token D_PERIOD // $period
%token TOKEN_697 // (*
%token TOKEN_695 // "
%token HASH // #
%token PULLDOWN // pulldown
%token ALWAYS // always
%token DOLLAR // $
%token P_ORMINUSGT // (,
%token SHOWCANCELLED // showcancelled
%token ENDSEQUENCE // endsequence
%token PULLUP // pullup
%token MODULO // %
%token EDGE // edge
%token AMPERSAND // &
%token SQUOTE // '
%token LIBRARY // library
%token LPAREN // (
%token TRANIF0 // tranif0
%token RPAREN // )
%token TRANIF1 // tranif1
%token PARAMETER // parameter
%token TAB // tab
%token EMPTY // empty
%token TIMES // *
%token PLUS // +
%token COMMA // ,
%token MINUS // -
%token P_OREQGT // (=>
%token DOT // .
%token DIVIDE // /
%token TOKEN_436 // 0
%token TOKEN_435 // 1
%token RNMOS // rnmos
%token SUPPLY0 // supply0
%token IF // if
%token TOKEN_687 // 2
%token SUPPLY1 // supply1
%token D_MONITOR // $monitor
%token TOKEN_688 // 3
%token D_FSCANF // $fscanf
%token TOKEN_689 // 4
%token PROGRAM // program
%token TOKEN_690 // 5
%token P_OREQ // (=
%token PMOS // pmos
%token TOKEN_691 // 6
%token PROTECTED // protected
%token DESIGN // design
%token VECTORED // vectored
%token TOKEN_639 // 7
%token P_XOREQ // ^=
%token TOKEN_433 // 1'Bx
%token TOKEN_272 // 8
%token CASE // case
%token TOKEN_266 // 9
%token COLON // :
%token TABLE // table
%token D_BITS // $bits
%token SEMICOLON // ;
%token LESS // <
%token EQUALS // =
%token TOKEN_636 // 'X
%token TIMEUNIT // timeunit
%token GREATER // >
%token QUERY // ?
%token TOKEN_634 // 'Z
%token ENDFUNCTION // endfunction
%token AT // @
%token TOKEN_601 // \n
%token FOREVER // forever
%token P_SRIGHTEQ // >>=
%token D_TEST_PLUSARGS // $test$plusargs
%token P_SSRIGHT // >>>
%token INPUT // input
%token TOKEN_699 // *)
%token BUF // buf
%token P_POW // **
%token VOID // void
%token WIRE // wire
%token FORK // fork
%token SUPER // super
%token SMALL // small
%token RELEASE // release
%token FORCE // force
%token D_FGETC // $fgetc
%token P_SLEFT // <<<
%token TOKEN_END_COMMENT // */
%token TOKEN_504 // ->>
%token P_SLEFTEQ // <<=
%token P_CASENOTEQUAL // !==
%token P_WILDNOTEQUAL // !=?
%token INCDIR // -incdir
%token TOKEN_427 // 1'b0
%token D_FATAL // $fatal
%token TOKEN_428 // 1'b1
%token ENUM // enum
%token ELSE // else
%token<string> SIMPLE_IDENTIFIER_2 // simple_identifier_2
%token TYPE // type
%token EVENT // event
%token ALWAYS // always_latch
%token IS_DEFINED_AS // ::=
%token BIND // bind
%token D_FEOF // $feof
%token AND // and
%token BYTE // byte
%token NOCHANGE // $nochange
%token DIST // dist
%token LBRACK // [
%token P_TIMESEQ // *=
%token D_FGETS // $fgets
%token ASSIGN // assign
%token TOKEN_652 // ++
%token TOKEN_718 // \
%token P_ASTGT // *>
%token RBRACK // ]
%token TOKEN_635 // 'x
%token CARET // ^
%token CELL // cell
%token TOKEN_633 // 'z
%token TOKEN_661 // _
%token TRAN // tran
%token D_COUNTDRIVERS // $countdrivers
%token TOKEN_724 // ]{
%token ENDINTERFACE // endinterface
%token D_FCLOSE // $fclose
%token ENDTASK // endtask
%token WAIT // wait
%token RETURN // return
%token NEGEDGE // negedge
%token GENERATE // generate
%token RANDC // randc
%token P_PLUSCOLON // +:
%token VIRTUAL // virtual
%token LOCAL // local
%token CONTEXT // context
%token EXTENDS // extends
%token P_PLUSEQ // +=
%token D_SKEW // $skew
%token P_SSRIGHTEQ // >>>=
%token JOIN_ANY // join_any
%token REPEAT // repeat
%token TOKEN_471 // |=
%token TOKEN_327 // |->
%token BIT // bit
%token WITH // with
%token REAL // real
%token TOKEN_650 // !?=
%token TRI // tri
%token PULSESTYLE_ONEVENT // pulsestyle_onevent
%token TOKEN_595 // 'b0
%token TOKEN_596 // 'b1
%token D_DISPLAY // $display
%token TOKEN_430 // 1'bX
%token P_XNOR // ^~
%token RCMOS // rcmos
%token ENDPROPERTY // endproperty
%token D_COUNTONES // countones
%token STATIC // static
%token LCURLY // {
%token CONTINUE // continue
%token ANY_ASCII_CHARS // Any_ASCII_Characters
%token VBAR // |
%token RCURLY // }
%token P_COLONDIV // :/
%token SPECIFY // specify
%token TILDE // ~
%token WOR // wor
%token P_NAND // ~&
%token D_ISUNKNOWN // isunknown
%token P_NOR // ~(
%token AUTOMATIC // automatic
%token TOKEN_653 // --
%token FOR // for
%token SPECPARAM // specparam
%token P_COLONCOLON // ::
%token TRIAND // triand
%token TIME // time
%token JOIN_NONE // join_none
%token CONFIG // config
%token TOKEN_287 // "DPI"
%token P_COLONEQ // :=
%token<string> C_IDENTIFIER_2 // c_identifier_2
%token D_ONEHOT0 // $onehot0
%token P_ANDANDAND // &&&
%token ASSERT // assert
%token NOSHOWCANCELLED // noshowcancelled
%token INITIAL // initial
%token P_MINUSCOLON // -:
%token NAND // nand
%token IF_NONE // ifnone
%token TOKEN_723 // 9_$
%token P_MINUSEQ // -=
%token P_DOTSTAR // .*
%token P_MINUSGT // ->
%token TOKEN_429 // 1'bx
%token MODULE // module
%token NEWLINE // newline
%token D_UNSIGNED // $unsigned
%token TOKEN_713 // 9_
%token D_SSCANF // $sscanf
%token CHANDLE // chandle
%token TOKEN_719 // {any_ASCII_character_except_white_space}
%token UNIQUE // unique
%token PULSESTYLE_ONDETECT // pulsestyle_ondetect
%token LOGIC // logic
%token D_WIDTH // $width
%token BEFORE // before
%token NMOS // nmos
%token CASEX // casex
%token TOKEN_328 // |=>
%token INTERFACE // interface
%token CASEZ // casez
%token INTERSECT // intersect
%token DEASSIGN // deassign
%token D_COUNTONES // $countones
%token BOLD // bold
%token TOKEN_BEGIN_COMMENT // /*
%token REF // ref
%token NULL // null
%token PURE // pure
%token EXPORT // export
%token REG // reg
%token SCALARED // scalared
%token TOKEN_704 // //
%token D_ISUNKNOWN // $isunknown
%token ENDCONFIG // endconfig
%token ENDCLASS // endclass
%token TOKEN_348 // [*=
%token TOKEN_501 // (*)
%token SVINT // int
%token OR // or
%token TOKEN_651 // ||
%token P_SLEFT // <<
%token P_NOTEQUAL // !=
%token ALWAYS // always_ff
%token P_LTE // <=
%token SHORTINT // shortint
%token CONST // const
%token WAND // wand
%token STEP // step
%token EXTERN // extern
%token MEDIUM // medium
%token PULL0 // pull0
%token P_XNOR // ~^
%token PULL1 // pull1
%token FORKJOIN // forkjoin
%token DEFPARAM // defparam
%token CLOCKING // clocking
%token TRI0 // tri0
%token TASK // task
%token P_DIVEQ // /=
%token TRI1 // tri1
%token UNION // union
%token LIBLIST // liblist
%token ENDMODULE // endmodule
%token P_POUNDPOUND // ##
%token RAND // rand
%token SHORTREAL // shortreal
%token D_RECREM // $recrem
%token LOCALPARAM // localparam
%token D_TIME // $realtime
%token SIGNED // signed
%token D_ATTRIBUTE // $attribute
%token TOKEN_587 // 01
%token STRONG0 // strong0
%token STRONG1 // strong1
%token LONGINT // longint
%token P_EQUAL // ==
%token HIGHZ0 // highz0
%token D_SIGNED // $signed
%token ENDGENERATE // endgenerate
%token P_EQGT // =>
%token HIGHZ1 // highz1
%token POSEDGE // posedge
%token D_INFO // $info
%token FINAL // final
%token RPMOS // rpmos
%token D_TIMESKEW // $timeskew
%token<string> SYSTEM_FUNCTION_IDENTIFIER_3 // system_function_identifier_3
%token P_CASEEQUAL // ===
%token SEQUENCE // sequence
%token RANDOMIZE // randomize
%token P_WILDEQUAL // ==?
%token D_WRITE // $write
%token D_HOLD // $hold
%token ALIAS // alias
%token ENDPRIMITIVE // endprimitive
%token TIMEPRECISION // timeprecision
%token ENDPROGRAM // endprogram
%token NOR // nor
%token JOIN // join
%token D_ONEHOT // $onehot
%token NOT // not
%token D_SETUPHOLD // $setuphold
%token D_FDISPLAY // $fdisplay
%token TOKEN_588 // 10
%token TOKEN_176 // 11
%token WAIT_ORDER // wait_order
%token STRING // string
%token TOKEN_648 // ~|
%token D_STOP // $stop
%token P_GTE // >=
%token P_SRIGHT // >>
%token TRIREG // trireg
%token THROUGHOUT // throughout
%token WHILE // while
%token D_SETUP // $setup
%token DEFAULT // default
%token TRIOR // trior
%token DO // do
%token PATHPULSE // PATHPULSE$
%token INSIDE // inside
%token D_WARNING // $warning
%token D_RECOVERY // $recovery
%token INOUT // inout
%token P_SLEFTEQ // <<<=
%token OUTPUT // output
%token<string> SIMPLE_IDENTIFIER_3_2 // simple_identifier_3_2
%token FIRST_MATCH // first_match
%token THIS // this
%token LARGE // large
%token ENDCASE // endcase
%token D_REMOVAL // $removal
%token FUNCTION // function
%token CMOS // cmos
%token INTEGER // integer
%token XOR // xor
%token<string> SYSTEM_TASK_IDENTIFIER_3 // system_task_identifier_3
%token WEAK0 // weak0
%token DISABLE // disable
%token WEAK1 // weak1
%token TOKEN_500 // @*
%token TOKEN_346 // [*
%token USE // use
%token D_FINISH // $finish
%token ENDTABLE // endtable
%token D_TIME // $time
%token FULLSKEW // $fullskew
%token RTRANIF0 // rtranif0
%token TOKEN_649 // =?=
%token TYPEDEF // typedef
%token RTRANIF1 // rtranif1
%token GENVAR // genvar
%token COVER // cover
%token TOKEN_431 // 1'B0
%token INCLUDE // include
%token TOKEN_432 // 1'B1
%token RTRAN // rtran
%token BREAK // break
%token XNOR // xnor
%token UNSIGNED // unsigned
%token MODPORT // modport
%token D_FWRITEH // $fwriteh
%token TOKEN_349 // [*->
%token P_ANDAND // &&
%token NOTIF0 // notif0
%token D_ERROR // $error
%token ANY_ASCII_CHAR // Any_ASCII_character
%token IMPORT // import
%token NOTIF1 // notif1
%token ALWAYS // always_comb
%token SPACE // space
%token END // end
%token WITHIN // within
%token P_MODEQ // %=
%token CLASS // class
%token STRUCT // struct
%token <token> MS
%token <token> US
%token <token> NS
%token <token> PS
%token <token> FS
%token <token> AS
%token <string> ASCNUM
%token <char> CHAR
%token <string> ID
%token <token * token > RANGE
%token <int> INT
%token <token * token> DOUBLE
%token <token * token * token> TRIPLE
%token <token * token * token * token> QUADRUPLE
%token <token * token * token * token * token> QUINTUPLE
%token <token * token * token * token * token * token> SEXTUPLE
%token <token * token * token * token * token * token * token> SEPTUPLE
%token <token * token * token * token * token * token * token * token> OCTUPLE
%token <token * token * token * token * token * token * token * token * token> NONUPLE
%token <token * token * token * token * token * token * token * token * token * token> DECUPLE
%token <token * token * token * token * token * token * token * token * token * token * token> UNDECUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token> DUODECUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token * token> TREDECUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token * token * token> QUATTUORDECUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token * token * token * token> QUINDECUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token> SEXDECUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token> SEPTENDECUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token> OCTODECUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token> NOVEMDECUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token> VIGENUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token> UNVIGENUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token> DUOVIGENUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token> TREVIGENUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token> QUATTUORVIGENUPLE
%token <token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token> QUINVIGENUPLE
%token ALTERNATIVE
%token  ASSIGNMENT
%token  BIDIR
%token <string> BINNUM
%token  BITSEL
%token  CASECOND
%token  CELLPIN
%token C_IDENTIFIER_2 
%token C_IDENTIFIER_3_2 
%token  CONCAT
%token  D_C
%token <string> DECNUM
%token  DLYASSIGNMENT
%token <token list> DOTTED
%token  D_RANDOM
%token  DRIVER
%token  D_STIME
%token  ENDLABEL
%token  ENDOFFILE
%token <float> FLOATNUM
%token FULLSKEW_TIMING_CHECK
%token  FUNCREF
%token  FUNCUSED
%token  GENCASE
%token  GENCASECOND
%token <string> HEXNUM
%token HOLD_TIMING_CHECK
%token  IMPLICIT
%token <string> INTNUM
%token  IOPORT
%token LEFT_BRACKET
%token LEFT_CURLY
%token  MEMORY
%token  MINTYPMAX
%token  MODINST
%token  NAMED
%token NOCHANGE_TIMING_CHECK
%token <string> OCTNUM
%token  PARAMUSED
%token  PARTSEL
%token  P_CELLDEFINE
%token  P_DEFINE
%token  P_DELAY_MODE_PATH
%token  P_DISABLE_PORTFAULTS
%token  P_ELSE
%token  P_ENABLE_PORTFAULTS
%token  P_ENDCELLDEFINE
%token  P_ENDIF
%token  P_ENDPROTECT
%token PERIOD_TIMING_CHECK
%token  P_IFDEF
%token <string> P_INCLUDE
%token  P_NOSUPPRESS_FAULTS
%token  P_PROTECT
%token <string> PRAGMATIC
%token <string> PREPROC
%token  P_RESETALL
%token  PRIMINST
%token  P_SUPPRESS_FAULTS
%token <string> P_TIMESCALE
%token  RECEIVER
%token RECOVERY_TIMING_CHECK
%token RECREM_TIMING_CHECK
%token REMOVAL_TIMING_CHECK
%token RIGHT_BRACKET
%token RIGHT_CURLY
%token  SCALAR
%token  SENSUSED
%token SETUPHOLD_TIMING_CHECK
%token SETUP_TIMING_CHECK
%token SIMPLE_IDENTIFIER_2 
%token SIMPLE_IDENTIFIER_3_2 
%token SKEW_TIMING_CHECK
%token  SPECIAL
%token  SUBCCT
%token  SUBMODULE
%token SUBTRACTION
%token SYSTEM_FUNCTION_IDENTIFIER_3 
%token SYSTEM_TASK_IDENTIFIER_3 
%token  TASKREF
%token  TASKUSED
%token TIMESKEW_TIMING_CHECK
%token  TIMINGSPEC
%token <token list> TLIST
%token TOKEN_707
%token TOKEN_708
%token  UNKNOWN
%token WIDTH_TIMING_CHECK

%start library_text
%type <token> library_text

%%

c_identifier_3_2: C_IDENTIFIER_3_2 { C_IDENTIFIER_3_2 $1 };
simple_identifier_2: SIMPLE_IDENTIFIER_2 { SIMPLE_IDENTIFIER_2 $1 };
c_identifier_2: C_IDENTIFIER_2 { C_IDENTIFIER_2 $1 };
system_function_identifier_3: SYSTEM_FUNCTION_IDENTIFIER_3 { SYSTEM_FUNCTION_IDENTIFIER_3 $1 };
simple_identifier_3_2: SIMPLE_IDENTIFIER_3_2 { SIMPLE_IDENTIFIER_3_2 $1 };
system_task_identifier_3: SYSTEM_TASK_IDENTIFIER_3 { SYSTEM_TASK_IDENTIFIER_3 $1 };
/* */
/* */
/* */
/* 




 Annex AFormal Syntax 





 
Annex A
 

Formal Syntax 



 
(Normative) 


 
The formal syntax of SystemVerilog is described using Backus-Naur Form (BNF). The conventions used are: 



 
Keywords and punctuation are in 
bold
 text.


 
Syntactic categories are named in non-bold text. 


 
A vertical bar (
 | 
) separates alternatives.


 
Square brackets (
 [ ] 
) enclose optional items.


 
Braces (
 { } 
) enclose items which can be repeated zero or more times.



 
The full syntax and semantics of Verilog and SystemVerilog are not described solely using BNF. The normative text description contained within the chapters of the IEEE 1364-2001 Verilog standard and this SystemVerilog document provide additional details on the syntax and semantics described in this BNF.



 
A.1 Source text 




 
A.1.1 Library source text 
 */


 
     /* library_text ::= { library_descriptions   } */


 
  
	 
	 
	 /* library_descriptions ::= library_declaration | include_statement | config_declaration */


 
  
	

    

   
		 

   

    

 /* library_declaration ::= 'library' library_identifier file_path_spec { ','   file_path_spec   } [ '-incdir'   file_path_spec   { ','   file_path_spec   }   ] ';' */


 
   /* file_path_spec ::= 'file_path' */


 
  

  

 /* include_statement ::= 'include' '<' file_path_spec '>' ';' */
/* 




 
A.1.2 Configuration source text 
 */


 
  
	

  

 
		 
		   
	

 /* config_declaration ::= 'config' config_identifier ';' design_statement { config_rule_statement   } 'endconfig' */


 
  

   
  
   

 /* design_statement ::= 'design' { [ library_identifier   '.'   ]   cell_identifier   } ';' */


 
  
	  
	
 
 
	
 
 
	
 
 
	
 
 /* config_rule_statement ::= default_clause liblist_clause | inst_clause liblist_clause | inst_clause use_clause | cell_clause liblist_clause | cell_clause use_clause */


 
  

 /* default_clause ::= 'default' */


 
  

  /* inst_clause ::= 'instance' inst_name */


 
    
 
  /* inst_name ::= topmodule_identifier { '.'   instance_identifier   } */


 
  
 
  
 
  /* cell_clause ::= 'cell' [ library_identifier   '.'   ] cell_identifier */


 
  

  /* liblist_clause ::= 'liblist' { library_identifier   } */


 
  

  
  
   
  
 /* use_clause ::= 'use' [ library_identifier   '.'   ] cell_identifier [ ':'   'config'   ] */
/* 




 
A.1.3 
 
Module and primitive source text 
 */


 
        /* source_text ::= [ timeunits_declaration   ] { description   } */


 
  
	 
	 
	 
	 /* description ::= module_declaration | udp_declaration | module_root_item | statement_or_null */


 
  
	           
		 

 /* module_nonansi_header ::= { attribute_instance   } module_keyword [ lifetime   ] module_identifier [ parameter_port_list   ] list_of_ports ';' */


 
  
	           
		   

 /* module_ansi_header ::= { attribute_instance   } module_keyword [ lifetime   ] module_identifier [ parameter_port_list   ] [ list_of_port_declarations   ] ';' */


 
  
	       
		

  

   
	       
		

  

   
	        
   
 
		      

  

   
	

  
	

  /* module_declaration ::= module_nonansi_header [ timeunits_declaration   ] { module_item   } 'endmodule' [ ':'   module_identifier   ] | module_ansi_header [ timeunits_declaration   ] { non_port_module_item   } 'endmodule' [ ':'   module_identifier   ] | { attribute_instance   } module_keyword [ lifetime   ] module_identifier '(' '.*' ')' ';' [ timeunits_declaration   ] { module_item   } 'endmodule' [ ':'   module_identifier   ] | 'extern' module_nonansi_header | 'extern' module_ansi_header */


 
  

  

 /* module_keyword ::= 'module' | 'macromodule' */


 
  
	   

     
		    

 /* interface_nonansi_header ::= { attribute_instance   } 'interface' [ lifetime   ] interface_identifier [ parameter_port_list   ] list_of_ports ';' */


 
  
	  

     
		      

 /* interface_ansi_header ::= { attribute_instance   } 'interface' [ lifetime   ] interface_identifier [ parameter_port_list   ] [ list_of_port_declarations   ] ';' */


 
  
	       
		

  

   
	       
		

  

   
	   

  
   
 
		      
	

  

   
	

  
	

  /* interface_declaration ::= interface_nonansi_header [ timeunits_declaration   ] { interface_item   } 'endinterface' [ ':'   interface_identifier   ] | interface_ansi_header [ timeunits_declaration   ] { non_port_interface_item   } 'endinterface' [ ':'   interface_identifier   ] | { attribute_instance   } 'interface' interface_identifier '(' '.*' ')' ';' [ timeunits_declaration   ] { interface_item   } 'endinterface' [ ':'   interface_identifier   ] | 'extern' interface_nonansi_header | 'extern' interface_ansi_header */


 
  
	   

     
		    

 /* program_nonansi_header ::= { attribute_instance   } 'program' [ lifetime   ] program_identifier [ parameter_port_list   ] list_of_ports ';' */


 
  
	  

     
		      

 /* program_ansi_header ::= { attribute_instance   } 'program' [ lifetime   ] program_identifier [ parameter_port_list   ] [ list_of_port_declarations   ] ';' */


 
  
	       
		

  

   
	       
		

  

   
	   

  
   
 
		      
	

  

   
	

  
	

  /* program_declaration ::= program_nonansi_header [ timeunits_declaration   ] { program_item   } 'endprogram' [ ':'   program_identifier   ] | program_ansi_header [ timeunits_declaration   ] { non_port_program_item   } 'endprogram' [ ':'   program_identifier   ] | { attribute_instance   } 'program' program_identifier '(' '.*' ')' ';' [ timeunits_declaration   ] { program_item   } 'endprogram' [ ':'   program_identifier   ] | 'extern' program_nonansi_header | 'extern' program_ansi_header */


 
  
	    

  

        
		 

   

       
	

  

  /* class_declaration ::= { attribute_instance   } [ 'virtual'   ] 'class' [ lifetime   ] class_identifier [ parameter_port_list   ] [ 'extends'   class_identifier   ] ';' [ timeunits_declaration   ] { class_item   } 'endclass' [ ':'   class_identifier   ] */


 
  
	

   
	

   
	

   
	

   
	

   
	

   /* timeunits_declaration ::= 'timeunit' time_literal ';' | 'timeprecision' time_literal ';' | 'timeunit' time_literal ';' 'timeprecision' time_literal ';' | 'timeprecision' time_literal ';' 'timeunit' time_literal ';' */
/* 




 
A.1.4 
 
Module parameters and ports 
 */


 
  
 
   

   

 /* parameter_port_list ::= '#' '(' parameter_declaration { ','   parameter_declaration   } ')' */


 
  

   

   

 /* list_of_ports ::= '(' port { ','   port   } ')' */


 
  
	

   

   

 
	
 
 /* list_of_port_declarations ::= '(' port_declaration { ','   port_declaration   } ')' | '(' ')' */


 
  
	    
	    
	    
	    
	    /* non_generic_port_declaration ::= { attribute_instance   } inout_declaration | { attribute_instance   } input_declaration | { attribute_instance   } output_declaration | { attribute_instance   } ref_declaration | { attribute_instance   } interface_port_declaration */


 
  
	   
	

  

    

 /* port ::= [ port_expression   ] | '.' port_identifier '(' [ port_expression   ] ')' */


 
  
	 
	

   

   

 /* port_expression ::= port_reference | { port_reference { ','   port_reference   } } */


 
  
	  

  

  /* port_reference ::= port_identifier [ [   constant_range_expression   ]   ] */


 
  
	 
	    /* port_declaration ::= non_generic_port_declaration | { attribute_instance   } generic_interface_port_declaration */
/* 




 
A.1.5 
 
Module items 
 */


 
  
	    
	    
	    
	    
	    /* module_common_item ::= { attribute_instance   } module_or_generate_item_declaration | { attribute_instance   } interface_instantiation | { attribute_instance   } program_instantiation | { attribute_instance   } concurrent_assertion_item | { attribute_instance   } bind_directive */


 
  
	 

 
	 /* module_item ::= non_generic_port_declaration ';' | non_port_module_item */


 
  
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	 
	   

 /* module_or_generate_item ::= { attribute_instance   } parameter_override | { attribute_instance   } continuous_assign | { attribute_instance   } gate_instantiation | { attribute_instance   } udp_instantiation | { attribute_instance   } module_instantiation | { attribute_instance   } initial_construct | { attribute_instance   } always_construct | { attribute_instance   } combinational_construct | { attribute_instance   } latch_construct | { attribute_instance   } ff_construct | { attribute_instance   } net_alias | { attribute_instance   } final_construct | module_common_item | { attribute_instance   } ';' */


 
  
	    
	    
	 
	 
	 
	 /* module_root_item ::= { attribute_instance   } module_instantiation | { attribute_instance   } local_parameter_declaration | interface_declaration | program_declaration | class_declaration | module_common_item */


 
  
	 
	 
	 
	 
	 
	 
	 
	 
	 
	

 

  

 /* module_or_generate_item_declaration ::= net_declaration | data_declaration | genvar_declaration | task_declaration | function_declaration | dpi_import_export | extern_constraint_declaration | extern_method_declaration | clocking_decl | 'default' 'clocking' clocking_identifier ';' */


 
  
	    
	    
	 
	    

 
	    
	    
	 
	 
	 /* non_port_module_item ::= { attribute_instance   } generated_module_instantiation | { attribute_instance   } local_parameter_declaration | module_or_generate_item | { attribute_instance   } parameter_declaration ';' | { attribute_instance   } specify_block | { attribute_instance   } specparam_declaration | program_declaration | class_declaration | module_declaration */


 
  

  

 /* parameter_override ::= 'defparam' list_of_defparam_assignments ';' */


 
  
	

   

 
	

   

 /* bind_directive ::= 'bind' module_identifier bind_instantiation ';' | 'bind' name_of_instance bind_instantiation ';' */


 
  
	 
	 
	 /* bind_instantiation ::= program_instantiation | module_instantiation | interface_instantiation */
/* 




 
A.1.6 
 
Interface items 
 */


 
  
	    
	    
	    
	    
	    
	    
	    
	    

 
	 
	    
	    
	    
	   

 /* interface_or_generate_item ::= { attribute_instance   } continuous_assign | { attribute_instance   } initial_construct | { attribute_instance   } always_construct | { attribute_instance   } combinational_construct | { attribute_instance   } latch_construct | { attribute_instance   } ff_construct | { attribute_instance   } local_parameter_declaration | { attribute_instance   } parameter_declaration ';' | module_common_item | { attribute_instance   } modport_declaration | { attribute_instance   } extern_tf_declaration | { attribute_instance   } final_construct | { attribute_instance   } ';' */


 
  
	

  
	

 

 

  

 /* extern_tf_declaration ::= 'extern' method_prototype | 'extern' 'forkjoin' 'task' named_task_proto ';' */


 
  
	 

 
	 /* interface_item ::= non_generic_port_declaration ';' | non_port_interface_item */


 
  
    
	    
	 
	 
	 
	 /* non_port_interface_item ::= { attribute_instance   } generated_interface_instantiation | { attribute_instance   } specparam_declaration | interface_or_generate_item | program_declaration | class_declaration | interface_declaration */
/* 




 
A.1.7 
 
Program items 
 */


 
  
	 

 
	 /* program_item ::= port_declaration ';' | non_port_program_item */


 
  
	    
	    
	    
	    
	    

 
	    
	    
	 /* non_port_program_item ::= { attribute_instance   } continuous_assign | { attribute_instance   } module_or_generate_item_declaration | { attribute_instance   } specparam_declaration | { attribute_instance   } local_parameter_declaration | { attribute_instance   } parameter_declaration ';' | { attribute_instance   } initial_construct | { attribute_instance   } concurrent_assertion_item | class_declaration */
/* 




 
A.1.8 
 
Class items 
 */


 
/* */


 
  
	    
	    
	    /* class_item ::= { attribute_instance   } class_property | { attribute_instance   } class_method | { attribute_instance   } class_constraint */


 
  
	    
	

       

   

 /* class_property ::= { property_qualifier   } data_declaration | 'const' { class_item_qualifier   } data_type const_identifier [ '='   constant_expression   ] ';' */


 
  
	    
	    
	

     /* class_method ::= { method_qualifier   } task_declaration | { method_qualifier   } function_declaration | 'extern' { method_qualifier   } method_prototype */


 
  
	 
	 /* class_constraint ::= constraint_prototype | constraint_declaration */


 

  
	

 
	

 
	

 /* class_item_qualifier ::= 'static' | 'protected' | 'local' */


 

  
	

 
	

 
	 /* property_qualifier ::= 'rand' | 'randc' | class_item_qualifier */


 

  
	

 
	 /* method_qualifier ::= 'virtual' | class_item_qualifier */


 
  
	

  

 
	

  

 /* method_prototype ::= 'task' named_task_proto ';' | 'function' named_function_proto ';' */


 
  
	

     

  
	

     

  /* extern_method_declaration ::= 'function' [ lifetime   ] class_identifier '::' function_body_declaration | 'task' [ lifetime   ] class_identifier '::' task_body_declaration */
/* 




 
A.1.9 
 
Constraints 
 */


 
   

  

  

    

 /* constraint_declaration ::= [ 'static'   ] 'constraint' constraint_identifier { { constraint_block   } } */


 
  
	

  

  

 
	 

 

  

 

 
	 /* constraint_block ::= 'solve' identifier_list 'before' identifier_list ';' | expression 'dist' { dist_list } ';' | constraint_expression */


 
  
	 

 
	 

  
	

 

  

   

   /* constraint_expression ::= expression ';' | expression '=>' constraint_set | 'if' '(' expression ')' constraint_set [ 'else'   constraint_set   ] */


 
  
	 
	

    

 /* constraint_set ::= constraint_expression | { { constraint_expression   } } */


 
    

   /* dist_list ::= dist_item { ','   dist_item   } */


 
  
	 

  
	 

  /* dist_item ::= value_range ':=' expression | value_range ':/' expression */


 
   

  

  /* constraint_prototype ::= [ 'static'   ] 'constraint' constraint_identifier */


 
  
	 

  

  

  

    

 /* extern_constraint_declaration ::= [ 'static'   ] 'constraint' class_identifier '::' constraint_identifier { { constraint_block   } } */


 
    

   /* identifier_list ::= identifier { ','   identifier   } */
/* 




 
A.2 Declarations 




 
A.2.1 
 
Declaration types 



 
A.2.1.1 
 
Module parameter declarations 
 */


 
  
	

           

 
	

 
 
 

 /* local_parameter_declaration ::= 'localparam' [ signing   ] { packed_dimension   } [ range   ] list_of_param_assignments ';' | 'localparam' data_type list_of_param_assignments ';' */


 
  
	

           
	

 
 
 
	

 


 
 /* parameter_declaration ::= 'parameter' [ signing   ] { packed_dimension   } [ range   ] list_of_param_assignments | 'parameter' data_type list_of_param_assignments | 'parameter' 'type' list_of_type_assignments */


 
  
	

     

 /* specparam_declaration ::= 'specparam' [ range   ] list_of_specparam_assignments ';' */
/* 




 
A.2.1.2 
 
Port declarations 
 */


 
  

	
     
	

   /* inout_declaration ::= 'inout' [ port_type   ] list_of_port_identifiers | 'inout' data_type list_of_variable_identifiers */


 
 
	

     
	

   /* input_declaration ::= 'input' [ port_type   ] list_of_port_identifiers | 'input' data_type list_of_variable_identifiers */


 
  
	

     
	

 
 
 /* output_declaration ::= 'output' [ port_type   ] list_of_port_identifiers | 'output' data_type list_of_variable_port_identifiers */


 
  
	  
	
 
 
 
 /* interface_port_declaration ::= interface_identifier list_of_interface_identifiers | interface_identifier '.' modport_identifier list_of_interface_identifiers */


 
  

   /* ref_declaration ::= 'ref' data_type list_of_port_identifiers */


 
  
	

  
	

 

   /* generic_interface_port_declaration ::= 'interface' list_of_interface_identifiers | 'interface' '.' modport_identifier list_of_interface_identifiers */
/* 




 
A.2.1.3 
 
Type declarations 
 */


 
  
	 
	 
	 /* block_data_declaration ::= block_variable_declaration | constant_declaration | type_declaration */


 
  

   
 
/* constant_declaration ::= 'const' data_type const_assignment ';' */


 
  
	 
	 
	 /* data_declaration ::= variable_declaration | constant_declaration | type_declaration */


 
  

  

 /* genvar_declaration ::= 'genvar' list_of_genvar_identifiers ';' */


 
  
	    
		    

 
	       
		    

 
	  

  

     
		        

 
	     

  

     
		        

 
	

       
		    

 
	

       
		    

 
	

     

  

     
		        

 
	

     

  

     
		        

 /* net_declaration ::= net_type [ signing   ] [ delay3   ] list_of_net_identifiers ';' | net_type [ drive_strength   ] [ signing   ] [ delay3   ] list_of_net_decl_assignments ';' | net_type [ 'vectored'   |   'scalared'   ] [ signing   ] { packed_dimension   } range [ delay3   ] list_of_net_identifiers ';' | net_type [ drive_strength   ] [ 'vectored'   |   'scalared'   ] [ signing   ] { packed_dimension   } range [ delay3   ] list_of_net_decl_assignments ';' | 'trireg' [ charge_strength   ] [ signing   ] [ delay3   ] list_of_net_identifiers ';' | 'trireg' [ drive_strength   ] [ signing   ] [ delay3   ] list_of_net_decl_assignments ';' | 'trireg' [ charge_strength   ] [ 'vectored'   |   'scalared'   ] [ signing   ] { packed_dimension   } range [ delay3   ] list_of_net_identifiers ';' | 'trireg' [ drive_strength   ] [ 'vectored'   |   'scalared'   ] [ signing   ] { packed_dimension   } range [ delay3   ] list_of_net_decl_assignments ';' */


 
  
	

     

 
	

  

   

 
	

  

   

 
	

      

 /* type_declaration ::= 'typedef' [ data_type   ] type_declaration_identifier ';' | 'typedef' hierarchical_identifier '.' type_identifier type_declaration_identifier ';' | 'typedef' [ 'class'   ] class_identifier ';' | 'typedef' class_identifier [ parameter_value_assignment   ] type_declaration_identifier ';' */


 
  
	   
 
 

 
	 
 
 

 /* block_variable_declaration ::= [ lifetime   ] data_type list_of_variable_identifiers ';' | lifetime data_type list_of_variable_decl_assignments ';' */


 
  
   
 
 

 /* variable_declaration ::= [ lifetime   ] data_type list_of_variable_identifiers_or_assignments ';' */


 
  

  

 /* lifetime ::= 'static' | 'automatic' */
/* 





 
A.2.2 
 
Declaration data types 



 
A.2.2.1 
 
Net and variable types 
 */


 
       /* casting_type ::= simple_type | number | signing */


 
  
	          
	    
	    
	 
	

 

    

    

    
	

 

    

    

    
	

    

    

 
	

    

    

 
	

          
		

   

    

   

    

 
	

 
	

 
	

 
	 /* data_type ::= integer_vector_type [ signing   ] { packed_dimension   } [ range   ] | integer_atom_type [ signing   ] | type_declaration_identifier { packed_dimension   } | non_integer_type | 'struct' 'packed' [ signing   ] { { struct_union_member   } } { packed_dimension   } | 'union' 'packed' [ signing   ] { { struct_union_member   } } { packed_dimension   } | 'struct' [ signing   ] { { struct_union_member   } } | 'union' [ signing   ] { { struct_union_member   } } | 'enum' [ integer_type   [ signing   ]   { packed_dimension   }   ] { enum_identifier [ '='   constant_expression   ] { ','   enum_identifier   [ '='   constant_expression   ]   } } | 'string' | 'event' | 'chandle' | class_scope_type_identifier */


 
 
	 

   

   
	 

   

   /* class_scope_type_identifier ::= class_identifier '::' { class_identifier   '::'   } type_declaration_identifier | class_identifier '::' { class_identifier   '::'   } class_identifier */


 
     /* integer_type ::= integer_vector_type | integer_atom_type */


 
  

  

  

  

  

 /* integer_atom_type ::= 'byte' | 'shortint' | 'int' | 'longint' | 'integer' */


 
  

  

  

 /* integer_vector_type ::= 'bit' | 'logic' | 'reg' */


 
  

  

  

  

 /* non_integer_type ::= 'time' | 'shortreal' | 'real' | 'realtime' */


 
  

  

  

  

  

  

  

  

  

  

 /* net_type ::= 'supply0' | 'supply1' | 'tri' | 'triand' | 'trior' | 'tri0' | 'tri1' | 'wire' | 'wand' | 'wor' */


 
  
	 
	       
	

       
	       /* port_type ::= data_type | net_type [ signing   ] { packed_dimension   } | 'trireg' [ signing   ] { packed_dimension   } | [ signing   ] { packed_dimension   } range */


 
  

  

 /* signing ::= 'signed' | 'unsigned' */


 
       /* simple_type ::= integer_type | non_integer_type | type_identifier */


 
     
 
 

 /* struct_union_member ::= { attribute_instance   } data_type list_of_variable_identifiers_or_assignments ';' */
/* 




 
A.2.2.2 Strengths 
 */


 
  
	     
	     
	   

  
	   

  
	 

    
	 

    /* drive_strength ::= '(' strength0 ',' strength1 ')' | '(' strength1 ',' strength0 ')' | '(' strength0 ',' 'highz1' ')' | '(' strength1 ',' 'highz0' ')' | '(' 'highz0' ',' strength1 ')' | '(' 'highz1' ',' strength0 ')' */


 
  

  

  

  

 /* strength0 ::= 'supply0' | 'strong0' | 'pull0' | 'weak0' */


 
  

  

  

  

 /* strength1 ::= 'supply1' | 'strong1' | 'pull1' | 'weak1' */


 
  
  
  
  
  
  
 /* charge_strength ::= '(' 'small' ')' | '(' 'medium' ')' | '(' 'large' ')' */
/* 




 
A.2.2.3 Delays 
 */


 
  

   
 
   

   

    

 /* delay3 ::= '#' delay_value | '#' '(' mintypmax_expression [ ','   mintypmax_expression   [ ','   mintypmax_expression   ]   ] ')' */


 
  

   
 
   

   

 /* delay2 ::= '#' delay_value | '#' '(' mintypmax_expression [ ','   mintypmax_expression   ] ')' */


 
  
	 
	 
	 /* delay_value ::= unsigned_number | real_number | identifier */
/* 





 
A.2.3 
 
Declaration lists 
 */


 
    

   /* list_of_defparam_assignments ::= defparam_assignment { ','   defparam_assignment   } */


 
    

   /* list_of_genvar_identifiers ::= genvar_identifier { ','   genvar_identifier   } */


 
      
		 

      /* list_of_interface_identifiers ::= interface_identifier { unpacked_dimension   } { ','   interface_identifier   { unpacked_dimension   }   } */


 
    

  /* list_of_modport_port_identifiers ::= port_identifier { ','   port_identifier   } */


 
    

   /* list_of_net_decl_assignments ::= net_decl_assignment { ','   net_decl_assignment   } */


 
      
		 

      /* list_of_net_identifiers ::= net_identifier { unpacked_dimension   } { ','   net_identifier   { unpacked_dimension   }   } */


 
    

   /* list_of_param_assignments ::= param_assignment { ','   param_assignment   } */


 
      
		 

      /* list_of_port_identifiers ::= port_identifier { unpacked_dimension   } { ','   port_identifier   { unpacked_dimension   }   } */


 
    

   /* list_of_udp_port_identifiers ::= port_identifier { ','   port_identifier   } */


 
    

   /* list_of_specparam_assignments ::= specparam_assignment { ','   specparam_assignment   } */


 
       

   
		 

      

    /* list_of_tf_port_identifiers ::= port_identifier { unpacked_dimension   } [ '='   expression   ] { ','   port_identifier   { unpacked_dimension   }   [ '='   expression   ]   } */


 
     

   
		 

    

    /* list_of_tf_variable_identifiers ::= port_identifier variable_dimension [ '='   expression   ] { ','   port_identifier   variable_dimension   [ '='   expression   ]   } */


 
    

   /* list_of_type_assignments ::= type_assignment { ','   type_assignment   } */


 
    

   /* list_of_variable_decl_assignments ::= variable_decl_assignment { ','   variable_decl_assignment   } */


 
    
		 

    /* list_of_variable_identifiers ::= variable_identifier variable_dimension { ','   variable_identifier   variable_dimension   } */


 
  
	 
	 /* list_of_variable_identifiers_or_assignments ::= list_of_variable_decl_assignments | list_of_variable_identifiers */


 
     

   
		 

    

    /* list_of_variable_port_identifiers ::= port_identifier variable_dimension [ '='   constant_expression   ] { ','   port_identifier   variable_dimension   [ '='   constant_expression   ]   } */
/* 




 
A.2.4 
 
Declaration assignments 
 */


 
   

  /* const_assignment ::= const_identifier '=' constant_expression */


 
   

  /* defparam_assignment ::= hierarchical_parameter_identifier '=' constant_expression */


 
   

  /* net_decl_assignment ::= net_identifier '=' expression */


 
   

  /* param_assignment ::= parameter_identifier '=' constant_param_expression */


 
  
	 

  
	 /* specparam_assignment ::= specparam_identifier '=' constant_mintypmax_expression | pulse_control_specparam */


 
   

  /* type_assignment ::= type_identifier '=' data_type */


 
  
	

 
 
   

   
 
 
	



 
		
 
   

   
 
 /* pulse_control_specparam ::= 'PATHPULSE$' '=' '(' reject_limit_value [ ','   error_limit_value   ] ')' ';' | 'PATHPULSE$' specify_input_terminal_descriptor '$' specify_output_terminal_descriptor '=' '(' reject_limit_value [ ','   error_limit_value   ] ')' ';' */


 
   /* error_limit_value ::= limit_value */


 
   /* reject_limit_value ::= limit_value */


 
   /* limit_value ::= constant_mintypmax_expression */


 
  
	     

   
	 
    
  

  

  

  
	    
 
  

  

  /* variable_decl_assignment ::= variable_identifier [ variable_dimension   ] [ '='   constant_expression   ] | variable_identifier [ ] '=' 'new' [ constant_expression ] [ '('   variable_identifier   ')'   ] | class_identifier [ parameter_value_assignment   ] '=' 'new' [ '('   list_of_arguments   ')'   ] */
/* 




 
A.2.5 Declaration ranges 
 */


 
  

  

  

 
	

  

 /* unpacked_dimension ::= [ dimension_constant_expression ':' dimension_constant_expression ] | [ dimension_constant_expression ] */


 

  

	
  

  

 
	
 
 /* packed_dimension ::= [ dimension_constant_expression ':' dimension_constant_expression ] | [ ] */


 
  

  

  

 /* range ::= [ msb_constant_expression ':' lsb_constant_expression ] */


 
  
	

  

 
	
  
 /* associative_dimension ::= [ data_type ] | [ '*' ] */


 
  
	   
	
 
 
	 /* variable_dimension ::= { unpacked_dimension   } | [ ] | associative_dimension */


 
  
	 
	 
 
  /* dpi_dimension ::= variable_dimension | { [   ]   } */
/* 




 
A.2.6 
 
Function declarations 
 */


 

  
	       
	 
	    
	 
	

 

  

   

    
	

  

  

    

    
	

       
		

              

 
	

 
	

 
	

 /* function_data_type ::= integer_vector_type { packed_dimension   } [ range   ] | integer_atom_type | type_declaration_identifier { packed_dimension   } | non_integer_type | 'struct' [ 'packed'   ] { { struct_union_member   } } { packed_dimension   } | 'union' [ 'packed'   ] { { struct_union_member   } } { packed_dimension   } | 'enum' [ integer_type   { packed_dimension   }   ] { enum_identifier [ '='   constant_expression   ] { ','   enum_identifier   [ '='   constant_expression   ]   } } | 'string' | 'chandle' | 'void' */


 
  
	      
		  

   

 
	   
	   
	

  

   
	      
		  

   

  

 

 
	   
	   
	

  

   /* function_body_declaration ::= [ signing   ] [ range_or_type   ] [ interface_identifier   '.'   ] function_identifier ';' { function_item_declaration   } { function_statement_or_null   } 'endfunction' [ ':'   function_identifier   ] | [ signing   ] [ range_or_type   ] [ interface_identifier   '.'   ] function_identifier '(' function_port_list ')' ';' { block_item_declaration   } { function_statement_or_null   } 'endfunction' [ ':'   function_identifier   ] */


 
  
	

     /* function_declaration ::= 'function' [ lifetime   ] function_body_declaration */


 
  
	 
	    

 
	    

 
	    

 
	    

 /* function_item_declaration ::= block_item_declaration | { attribute_instance   } tf_input_declaration ';' | { attribute_instance   } tf_output_declaration ';' | { attribute_instance   } tf_inout_declaration ';' | { attribute_instance   } tf_ref_declaration ';' */


 
  
	    
	    
	    
	    
	     
	     /* function_port_item ::= { attribute_instance   } tf_input_declaration | { attribute_instance   } tf_output_declaration | { attribute_instance   } tf_inout_declaration | { attribute_instance   } tf_ref_declaration | { attribute_instance   } port_type list_of_tf_port_identifiers | { attribute_instance   } tf_data_type list_of_tf_variable_identifiers */


 
    

   /* function_port_list ::= function_port_item { ','   function_port_item   } */


 
      

  

 /* named_function_proto ::= [ signing   ] function_data_type function_identifier '(' list_of_function_proto_formals ')' */


 
  
	      

       /* list_of_function_proto_formals ::= [ { attribute_instance   }   function_proto_formal   { ','   { attribute_instance   }   function_proto_formal   }   ] */


 
  
	 
	 
	 
	 /* function_proto_formal ::= tf_input_declaration | tf_output_declaration | tf_inout_declaration | tf_ref_declaration */


 
  
	    
	 /* range_or_type ::= { packed_dimension   } range | function_data_type */


 
  
	
 
      

   

 
	
 
   

  

  

 /* dpi_import_export ::= 'import' '"DPI"' [ dpi_import_property   ] [ c_identifier   '='   ] dpi_function_proto ';' | 'export' '"DPI"' [ c_identifier   '='   ] 'function' function_identifier ';' */


 
  

  

 /* dpi_import_property ::= 'context' | 'pure' */


 
  
	 
	     

  

 /* dpi_function_proto ::= named_function_proto | [ signing   ] function_data_type function_identifier '(' list_of_dpi_proto_formals ')' */


 
  
	      

       /* list_of_dpi_proto_formals ::= [ { attribute_instance   }   dpi_proto_formal   { ','   { attribute_instance   }   dpi_proto_formal   }   ] */


 
  
	     

     /* dpi_proto_formal ::= data_type [ port_identifier   dpi_dimension   { ','   port_identifier   dpi_dimension   }   ] */
/* 




 
A.2.7 
 
Task declarations 
 */


 
  
	  

   

 
	   
	   
	

  

   
	  

   

  
 
 
	   
	   
	

  

   /* task_body_declaration ::= [ interface_identifier   '.'   ] task_identifier ';' { task_item_declaration   } { statement_or_null   } 'endtask' [ ':'   task_identifier   ] | [ interface_identifier   '.'   ] task_identifier '(' task_port_list ')' ';' { block_item_declaration   } { statement_or_null   } 'endtask' [ ':'   task_identifier   ] */


 
  

     /* task_declaration ::= 'task' [ lifetime   ] task_body_declaration */


 
  
	 
	    

 
	    

 
	    

 
	    

 /* task_item_declaration ::= block_item_declaration | { attribute_instance   } tf_input_declaration ';' | { attribute_instance   } tf_output_declaration ';' | { attribute_instance   } tf_inout_declaration ';' | { attribute_instance   } tf_ref_declaration ';' */


 
    

   
	  

   /* task_port_list ::= task_port_item { ','   task_port_item   } | list_of_port_identifiers { ','   task_port_item   } */


 
  
	    
	    
	    
	    

 
	     
	     /* task_port_item ::= { attribute_instance   } tf_input_declaration | { attribute_instance   } tf_output_declaration | { attribute_instance   } tf_inout_declaration | { attribute_instance   } tf_ref_declaration ';' | { attribute_instance   } port_type list_of_tf_port_identifiers | { attribute_instance   } tf_data_type list_of_tf_variable_identifiers */


 
  
	

        
	

   /* tf_input_declaration ::= 'input' [ signing   ] { packed_dimension   } list_of_tf_port_identifiers | 'input' tf_data_type list_of_tf_variable_identifiers */


 
  
	

        
	

   /* tf_output_declaration ::= 'output' [ signing   ] { packed_dimension   } list_of_tf_port_identifiers | 'output' tf_data_type list_of_tf_variable_identifiers */


 
  
	

        
	

   /* tf_inout_declaration ::= 'inout' [ signing   ] { packed_dimension   } list_of_tf_port_identifiers | 'inout' tf_data_type list_of_tf_variable_identifiers */


 
  
	 

  

   /* tf_ref_declaration ::= [ 'const'   ] 'ref' tf_data_type list_of_tf_variable_identifiers */


 
  
	
	

 /* tf_data_type ::= data_type | 'chandle' */


 
   

   

   

 /* named_task_proto ::= task_identifier '(' task_proto_formal { ','   task_proto_formal   } ')' */


 
  
	 
	 
	 
	 /* task_proto_formal ::= tf_input_declaration | tf_output_declaration | tf_inout_declaration | tf_ref_declaration */
/* 




 
A.2.8 Block item declarations 
 */


 
  
	    
	    
	    

 /* block_item_declaration ::= { attribute_instance   } block_data_declaration | { attribute_instance   } local_parameter_declaration | { attribute_instance   } parameter_declaration ';' */
/* 




 
A.2.9 
 
Interface declarations 
 */


 
  

   

   

 /* modport_declaration ::= 'modport' modport_item { ','   modport_item   } ';' */


 
   

   

   

 /* modport_item ::= modport_identifier '(' modport_ports_declaration { ','   modport_ports_declaration   } ')' */


 
 
	 
	 
	 /* modport_ports_declaration ::= modport_simple_ports_declaration | modport_hierarchical_ports_declaration | modport_tf_ports_declaration */


 
  
	

  
	

  
	

  
	

     /* modport_simple_ports_declaration ::= 'input' list_of_modport_port_identifiers | 'output' list_of_modport_port_identifiers | 'inout' list_of_modport_port_identifiers | 'ref' [ data_type   ] list_of_modport_port_identifiers */


 
  
  

  

  

  /* modport_hierarchical_ports_declaration ::= interface_instance_identifier [ [   constant_expression   ]   ] '.' modport_identifier */


 
  
 /* modport_tf_ports_declaration ::= import_export modport_tf_port */


 
  
	

   

   
	

   

   
	  

   /* modport_tf_port ::= 'task' named_task_proto { ','   named_task_proto   } | 'function' named_function_proto { ','   named_function_proto   } | task_or_function_identifier { ','   task_or_function_identifier   } */


 
  

  

 /* import_export ::= 'import' | 'export' */
/* 




 
A.2.10 
 
Assertion declarations 
 */


 
  
	 
	 
	 /* concurrent_assertion_item ::= concurrent_assert_statement | concurrent_cover_statement | concurrent_assertion_item_declaration */


 
  
	

  /* concurrent_assert_statement ::= [ block_identifier   ':'   ] assert_property_statement */


 
  
	

  /* concurrent_cover_statement ::= [ block_identifier   ':'   ] cover_property_statement */


 
 
	

 

 

  

  
	

 

 

  

  /* assert_property_statement ::= 'assert' 'property' '(' property_spec ')' action_block | 'assert' 'property' '(' property_instance ')' action_block */


 
 
	

 

 

  

  
	

 

 

  

  /* cover_property_statement ::= 'cover' 'property' '(' property_spec ')' statement_or_null | 'cover' 'property' '(' property_instance ')' statement_or_null */


 
  
	  

  

  /* property_instance ::= property_identifier [ '('   actual_arg_list   ')'   ] */


 
  
	 
	 /* concurrent_assertion_item_declaration ::= property_declaration | sequence_declaration */


 
  
	

     

 
		   
		 

 
	

  

   /* property_declaration ::= 'property' property_identifier [ property_formal_list   ] ';' { assertion_variable_declaration   } property_spec ';' 'endproperty' [ ':'   property_identifier   ] */


 
  
	

   

   

 /* property_formal_list ::= '(' formal_list_item { ','   formal_list_item   } ')' */


 
  
	   
 
  

  

  

   
	 
  
  

   

   /* property_spec ::= [ clocking_event   ] [ 'disable'   'iff'   ] '(' expression ')' [ 'not'   ] property_expr | [ 'disable'   'iff'   '('   expression   ')'   ] [ 'not'   ] multi_clock_property_expr */


 
  
	 
	 

  

   
	 

  

   
	

  

 /* property_expr ::= sequence_expr | sequence_expr '|->' [ 'not'   ] sequence_expr | sequence_expr '|=>' [ 'not'   ] sequence_expr | '(' property_expr ')' */


 
  
	 
	 

  

   
	

  

 /* multi_clock_property_expr ::= multi_clock_sequence | multi_clock_sequence '|=>' [ 'not'   ] multi_clock_sequence | '(' multi_clock_property_expr ')' */


 
  
	

     

 
		   
		 

 
	

  

   /* sequence_declaration ::= 'sequence' sequence_identifier [ sequence_formal_list   ] ';' { assertion_variable_declaration   } sequence_spec ';' 'endsequence' [ ':'   sequence_identifier   ] */


 
  
	

   

   

 /* sequence_formal_list ::= '(' formal_list_item { ','   formal_list_item   } ')' */


 
  
	 
	 /* sequence_spec ::= multi_clock_sequence | sequence_expr */


 
 
	  

   /* multi_clock_sequence ::= clocked_sequence { '##'   clocked_sequence   } */


 
 
	  /* clocked_sequence ::= clocking_event sequence_expr */


 
  
	     
	      
	  

      
	

  

   

    
	    
	

  

    
	 

  
	 

  
	 

  
	

 

  

 
	 

  
	 

  /* sequence_expr ::= cycle_delay_range sequence_expr { cycle_delay_range   sequence_expr   } | sequence_expr cycle_delay_range sequence_expr { cycle_delay_range   sequence_expr   } | expression { ','   function_blocking_assignment   } [ boolean_abbrev   ] | '(' expression { ','   function_blocking_assignment   } ')' [ boolean_abbrev   ] | sequence_instance [ sequence_abbrev   ] | '(' sequence_expr ')' [ sequence_abbrev   ] | sequence_expr 'and' sequence_expr | sequence_expr 'intersect' sequence_expr | sequence_expr 'or' sequence_expr | 'first_match' '(' sequence_expr ')' | expression 'throughout' sequence_expr | sequence_expr 'within' sequence_expr */


 
  
	

  
	

 

  

 /* cycle_delay_range ::= '##' constant_expression | '##' [ cycle_delay_const_range_expression ] */


 
  
	  

  

  /* sequence_instance ::= sequence_identifier [ '('   actual_arg_list   ')'   ] */


 
  
  

   /* formal_list_item ::= formal_identifier [ '='   actual_arg_expr   ] */


 
  
	

   

   

 
	
 
  

  

  
 
  

  

  

 /* actual_arg_list ::= '(' actual_arg_expr { ','   actual_arg_expr   } ')' | '(' '.' formal_identifier '(' actual_arg_expr ')' { ','   '.'   formal_identifier   '('   actual_arg_expr   ')'   } ')' */


 
  
	 /* actual_arg_expr ::= event_expression */


 
  
	 
	
	/* boolean_abbrev ::= consecutive_repetition | non_consecutive_repetition | goto_repetition */


 
   /* sequence_abbrev ::= consecutive_repetition */


 
  

  

 /* consecutive_repetition ::= '[*' const_or_range_expression ] */


 
  

  

 /* non_consecutive_repetition ::= '[*=' const_or_range_expression ] */


 
  

  

 /* goto_repetition ::= '[*->' const_or_range_expression ] */


 
  
	 
	 /* const_or_range_expression ::= constant_expression | cycle_delay_const_range_expression */


 
  
	 

  
	 
 
 /* cycle_delay_const_range_expression ::= constant_expression ':' constant_expression | constant_expression ':' '$' */


 
  
	   /* assertion_variable_declaration ::= data_type list_of_variable_identifiers ';' */
/* 




 
A.3 Primitive instances 




 
A.3.1 Primitive instantiation and instances 
 */


 
  
	    

   

 
	     

   

 
	    

   

 
	     

   

 
	   
		 

   

 
	       

 
	   

   

 
	

    

   

 
	

    

   

 /* gate_instantiation ::= cmos_switchtype [ delay3   ] cmos_switch_instance { ','   cmos_switch_instance   } ';' | enable_gatetype [ drive_strength   ] [ delay3   ] enable_gate_instance { ','   enable_gate_instance   } ';' | mos_switchtype [ delay3   ] mos_switch_instance { ','   mos_switch_instance   } ';' | n_input_gatetype [ drive_strength   ] [ delay2   ] n_input_gate_instance { ','   n_input_gate_instance   } ';' | n_output_gatetype [ drive_strength   ] [ delay2   ] n_output_gate_instance { ','   n_output_gate_instance   } ';' | pass_en_switchtype [ delay2   ] pass_enable_switch_instance { ','   pass_enable_switch_instance   } ';' | pass_switchtype pass_switch_instance { ','   pass_switch_instance   } ';' | 'pulldown' [ pulldown_strength   ] pull_gate_instance { ','   pull_gate_instance   } ';' | 'pullup' [ pullup_strength   ] pull_gate_instance { ','   pull_gate_instance   } ';' */


 
     

  

  

 
		 

  

 /* cmos_switch_instance ::= [ name_of_gate_instance   ] '(' output_terminal ',' input_terminal ',' ncontrol_terminal ',' pcontrol_terminal ')' */


 
     

  

  

  

 /* enable_gate_instance ::= [ name_of_gate_instance   ] '(' output_terminal ',' input_terminal ',' enable_terminal ')' */


 
     

  

  

  

 /* mos_switch_instance ::= [ name_of_gate_instance   ] '(' output_terminal ',' input_terminal ',' enable_terminal ')' */


 
     

  

   

   

 /* n_input_gate_instance ::= [ name_of_gate_instance   ] '(' output_terminal ',' input_terminal { ','   input_terminal   } ')' */


 
     

   

   

 
		 

 /* n_output_gate_instance ::= [ name_of_gate_instance   ] '(' output_terminal { ','   output_terminal   } ',' input_terminal ')' */


 
     

  

  

 /* pass_switch_instance ::= [ name_of_gate_instance   ] '(' inout_terminal ',' inout_terminal ')' */


 
     

    
 

		 

 /* pass_enable_switch_instance ::= [ name_of_gate_instance   ] '(' inout_terminal ',' inout_terminal ',' enable_terminal ')' */


 
     

  

 /* pull_gate_instance ::= [ name_of_gate_instance   ] '(' output_terminal ')' */


 
      /* name_of_gate_instance ::= gate_instance_identifier { range   } */
/* 




 
A.3.2 Primitive strengths 
 */


 
  
	

  

  

 
	

  

  

 
	

  

 /* pulldown_strength ::= '(' strength0 ',' strength1 ')' | '(' strength1 ',' strength0 ')' | '(' strength0 ')' */


 
  
	

  

  

 
	

  

  

 
	

  

 /* pullup_strength ::= '(' strength0 ',' strength1 ')' | '(' strength1 ',' strength0 ')' | '(' strength1 ')' */
/* 




 
A.3.3 Primitive terminals 
 */


 
   /* enable_terminal ::= expression */


 
   /* inout_terminal ::= net_lvalue */


 
   /* input_terminal ::= expression */


 
   /* ncontrol_terminal ::= expression */


 
   /* output_terminal ::= net_lvalue */


 
   /* pcontrol_terminal ::= expression */
/* 




 
A.3.4 Primitive gate and switch types 
 */


 
  

  

 /* cmos_switchtype ::= 'cmos' | 'rcmos' */


 
  

  

  

  

 /* enable_gatetype ::= 'bufif0' | 'bufif1' | 'notif0' | 'notif1' */


 
  

  

  

  

 /* mos_switchtype ::= 'nmos' | 'pmos' | 'rnmos' | 'rpmos' */


 
  

  

  

  

  

  

 /* n_input_gatetype ::= 'and' | 'nand' | 'or' | 'nor' | 'xor' | 'xnor' */


 
  

  

 /* n_output_gatetype ::= 'buf' | 'not' */


 
  

  

  

  

 /* pass_en_switchtype ::= 'tranif0' | 'tranif1' | 'rtranif1' | 'rtranif0' */


 
  

  

 /* pass_switchtype ::= 'tran' | 'rtran' */
/* 




 
A.4 Module, interface and generated instantiation 




 
A.4.1 Instantiation 



 
A.4.1.1 
 
Module instantiation 
 */


 
  
	      

   

 /* module_instantiation ::= module_identifier [ parameter_value_assignment   ] module_instance { ','   module_instance   } ';' */


 
  
 
  

 /* parameter_value_assignment ::= '#' '(' list_of_parameter_assignments ')' */


 
  
	  

   
	  

   /* list_of_parameter_assignments ::= ordered_parameter_assignment { ','   ordered_parameter_assignment   } | named_parameter_assignment { ','   named_parameter_assignment   } */


 
     /* ordered_parameter_assignment ::= expression | data_type */


 
  
	

  

    

 
	

  

  

 /* named_parameter_assignment ::= '.' parameter_identifier '(' [ expression   ] ')' | '.' parameter_identifier '(' data_type ')' */


 
   

    

 /* module_instance ::= name_of_instance '(' [ list_of_port_connections   ] ')' */


 
      /* name_of_instance ::= module_instance_identifier { range   } */


 
  
	  

   
	  

   
	  

    

   /* list_of_port_connections ::= ordered_port_connection { ','   ordered_port_connection   } | dot_named_port_connection { ','   dot_named_port_connection   } | { named_port_connection   ','   } dot_star_port_connection { ','   named_port_connection   } */


 
        /* ordered_port_connection ::= { attribute_instance   } [ expression   ] */


 
     

  

    

 /* named_port_connection ::= { attribute_instance   } '.' port_identifier '(' [ expression   ] ')' */


 
  
	   

 
	 /* dot_named_port_connection ::= { attribute_instance   } '.' port_identifier | named_port_connection */


 
     

 /* dot_star_port_connection ::= { attribute_instance   } '.*' */
/* 




 
A.4.1.2 
 
Interface instantiation 
 */


 
  
	      

   

 /* interface_instantiation ::= interface_identifier [ parameter_value_assignment   ] module_instance { ','   module_instance   } ';' */
/* 




 
Program instantiation 
 */


 
  
	      

   

 /* program_instantiation ::= program_identifier [ parameter_value_assignment   ] program_instance { ','   program_instance   } ';' */


 
      

    

 /* program_instance ::= program_instance_identifier { range   } '(' [ list_of_port_connections   ] ')' */
/* 





 
A.4.2 Generated instantiation 



 
A.4.2.1 Generated module instantiation 
 */


 
  

    

 /* generated_module_instantiation ::= 'generate' { generate_module_item   } 'endgenerate' */


 
  
	 
	 
	 
	     
	 /* generate_module_item ::= generate_module_conditional_statement | generate_module_case_statement | generate_module_loop_statement | [ generate_block_identifier   ':'   ] generate_module_block | module_or_generate_item */


 
  
	

      

   /* generate_module_conditional_statement ::= 'if' '(' constant_expression ')' generate_module_item [ 'else'   generate_module_item   ] */


 
  
	

 

  

    

 /* generate_module_case_statement ::= 'case' '(' constant_expression ')' genvar_module_case_item { genvar_module_case_item   } 'endcase' */


 
  
	  

   

  
	

  

   /* genvar_module_case_item ::= constant_expression { ','   constant_expression   } ':' generate_module_item | 'default' [ ':'   ] generate_module_item */


 
  
	

 

  

  

  

 
		 /* generate_module_loop_statement ::= 'for' '(' genvar_decl_assignment ';' constant_expression ';' genvar_assignment ')' generate_module_named_block */


 
  
	   
	  
	  /* genvar_assignment ::= genvar_identifier assignment_operator constant_expression | inc_or_dec_operator genvar_identifier | genvar_identifier inc_or_dec_operator */


 
  
	 

   

  /* genvar_decl_assignment ::= [ 'genvar'   ] genvar_identifier '=' constant_expression */


 
  
	
 
     

     
	 

  /* generate_module_named_block ::= 'begin' ':' generate_block_identifier { generate_module_item   } 'end' [ ':'   generate_block_identifier   ] | generate_block_identifier ':' generate_module_block */


 
  
	

  

      

  

   /* generate_module_block ::= 'begin' [ ':'   generate_block_identifier   ] { generate_module_item   } 'end' [ ':'   generate_block_identifier   ] */
/* 




 
A.4.2.2 Generated interface instantiation 
 */


 
  

    

 /* generated_interface_instantiation ::= 'generate' { generate_interface_item   } 'endgenerate' */


 
  
	 
	 
	 
	     
	 /* generate_interface_item ::= generate_interface_conditional_statement | generate_interface_case_statement | generate_interface_loop_statement | [ generate_block_identifier   ':'   ] generate_interface_block | interface_or_generate_item */


 
  
	

      

   /* generate_interface_conditional_statement ::= 'if' '(' constant_expression ')' generate_interface_item [ 'else'   generate_interface_item   ] */


 
  
	

        

 /* generate_interface_case_statement ::= 'case' '(' constant_expression ')' genvar_interface_case_item { genvar_interface_case_item   } 'endcase' */


 
  
	  

   

  
	

  

   /* genvar_interface_case_item ::= constant_expression { ','   constant_expression   } ':' generate_interface_item | 'default' [ ':'   ] generate_interface_item */


 
  
	
 
  

  

  

 
		 /* generate_interface_loop_statement ::= 'for' '(' genvar_decl_assignment ';' constant_expression ';' genvar_assignment ')' generate_interface_named_block */


 
  
	
 
     

     
	 

  /* generate_interface_named_block ::= 'begin' ':' generate_block_identifier { generate_interface_item   } 'end' [ ':'   generate_block_identifier   ] | generate_block_identifier ':' generate_interface_block */


 
  
	

  

   
	   
	

  

   /* generate_interface_block ::= 'begin' [ ':'   generate_block_identifier   ] { generate_interface_item   } 'end' [ ':'   generate_block_identifier   ] */
/* 





 
A.5 UDP declaration and instantiation 




 
A.5.1 UDP declaration 
 */


 
  
	   

  

  
 
 /* udp_nonansi_declaration ::= { attribute_instance   } 'primitive' udp_identifier '(' udp_port_list ')' ';' */


 
  
	   

  

  
 
 /* udp_ansi_declaration ::= { attribute_instance   } 'primitive' udp_identifier '(' udp_declaration_port_list ')' ';' */


 
  
	     
		 
	

 
 
   
	  

  

   
	

  
	

  
	   

  
   
 
		    

  

   /* udp_declaration ::= udp_nonansi_declaration udp_port_declaration { udp_port_declaration   } udp_body 'endprimitive' [ ':'   udp_identifier   ] | udp_ansi_declaration udp_body 'endprimitive' [ ':'   udp_identifier   ] | 'extern' udp_nonansi_declaration | 'extern' udp_ansi_declaration | { attribute_instance   } 'primitive' udp_identifier '(' '.*' ')' ';' { udp_port_declaration   } udp_body 'endprimitive' [ ':'   udp_identifier   ] */


 
  
	   

  

  
 
 
		    
		 
	

 
	   

  

  
 
 
		 
	

 /* udp_declaration ::= { attribute_instance   } 'primitive' udp_identifier '(' udp_port_list ')' ';' udp_port_declaration { udp_port_declaration   } udp_body 'endprimitive' | { attribute_instance   } 'primitive' udp_identifier '(' udp_declaration_port_list ')' ';' udp_body 'endprimitive' */
/* 




 
A.5.2 UDP ports 
 */


 
   

   

   /* udp_port_list ::= output_port_identifier ',' input_port_identifier { ','   input_port_identifier   } */


 
   

   

   /* udp_declaration_port_list ::= udp_output_declaration ',' udp_input_declaration { ','   udp_input_declaration   } */


 
  
	  
	  
	  /* udp_port_declaration ::= udp_output_declaration ';' | udp_input_declaration ';' | udp_reg_declaration ';' */


 
  
	   

  
	   

 

   

   /* udp_output_declaration ::= { attribute_instance   } 'output' port_identifier | { attribute_instance   } 'output' 'reg' port_identifier [ '='   constant_expression   ] */


 
     

  /* udp_input_declaration ::= { attribute_instance   } 'input' list_of_udp_port_identifiers */


 
     

  /* udp_reg_declaration ::= { attribute_instance   } 'reg' variable_identifier */
/* 




 
A.5.3 UDP body 
 */


 
     /* udp_body ::= combinational_body | sequential_body */


 
  

     

 /* combinational_body ::= 'table' combinational_entry { combinational_entry   } 'endtable' */


 
   

  

 /* combinational_entry ::= level_input_list ':' output_symbol ';' */


 
     

     

 /* sequential_body ::= [ udp_initial_statement   ] 'table' sequential_entry { sequential_entry   } 'endtable' */


 
  

  

  

 /* udp_initial_statement ::= 'initial' output_port_identifier '=' init_val ';' */


 
  

  

  

  

  

  

  

  

  

  

 /* init_val ::= '1'b0' | '1'b1' | '1'bx' | '1'bX' | '1'B0' | '1'B1' | '1'Bx' | '1'BX' | '1' | '0' */


 
   

  

  

 /* sequential_entry ::= seq_input_list ':' current_state ':' next_state ';' */


 
     /* seq_input_list ::= level_input_list | edge_input_list */


 
      /* level_input_list ::= level_symbol { level_symbol   } */


 
         /* edge_input_list ::= { level_symbol   } edge_indicator { level_symbol   } */


 
   
 
    /* edge_indicator ::= '(' level_symbol level_symbol ')' | edge_symbol */


 
   /* current_state ::= level_symbol */


 
    

 /* next_state ::= output_symbol | - */


 
  

  

  

  

 /* output_symbol ::= '0' | '1' | X | X */


 
  

  

  

  

  

  

  

 /* level_symbol ::= '0' | '1' | x | X | '?' | B | B */


 
  

  

  

  

  

  

  

  

  

 /* edge_symbol ::= R | R | F | F | P | P | N | N | '*' */
/* 




 
A.5.4 UDP instantiation 
 */


 
           

   

 /* udp_instantiation ::= udp_identifier [ drive_strength   ] [ delay2   ] udp_instance { ','   udp_instance   } ';' */


 
        

  

   

   

 /* udp_instance ::= [ name_of_udp_instance   ] { range   } '(' output_terminal ',' input_terminal { ','   input_terminal   } ')' */


 
      /* name_of_udp_instance ::= udp_instance_identifier { range   } */
/* 




 
A.6 Behavioral statements 




 
A.6.1 Continuous assignment and net alias statements 
 */


 
  

	
        

 
	

     

 /* continuous_assign ::= 'assign' [ drive_strength   ] [ delay3   ] list_of_net_assignments ';' | 'assign' [ delay_control   ] list_of_variable_assignments ';' */


 
    

   /* list_of_net_assignments ::= net_assignment { ','   net_assignment   } */


 
    

   /* list_of_variable_assignments ::= variable_assignment { ','   variable_assignment   } */


 
  

  

  

 /* net_alias ::= 'alias' net_lvalue '=' net_lvalue ';' */


 
   

  /* net_assignment ::= net_lvalue '=' expression */
/* 




 
A.6.2 
 
Procedural blocks and assignments 
 */


 
  

  /* initial_construct ::= 'initial' statement_or_null */


 
  

  /* always_construct ::= 'always_comb' statement */


 
  

  /* combinational_construct ::= 'always_comb' statement */


 
  

  /* latch_construct ::= 'always_comb' statement */


 
  

  /* ff_construct ::= 'always_comb' statement */


 
  

  /* final_construct ::= 'final' function_statement */


 
  
	 

 
 
 
	 
  
  

  

  

  
	    
 
  

  

  
	 
 
  
 
  

  

 
	 /* blocking_assignment ::= variable_lvalue '=' delay_or_event_control expression | hierarchical_variable_identifier '=' 'new' [ constant_expression ] [ '('   variable_identifier   ')'   ] | class_identifier [ parameter_value_assignment   ] '=' 'new' [ '('   list_of_arguments   ')'   ] | class_identifier '.' 'randomize' [ '('   ')'   ] 'with' constraint_block ';' | operator_assignment */


 
  
 

 
 /* operator_assignment ::= variable_lvalue assignment_operator expression */


 
  
	

  

  

  

  

  

  

  

  

  

  

  

  

 /* assignment_operator ::= '=' | '+=' | '-=' | '*=' | '/=' | '%=' | '&=' | '|=' | '^=' | '<<<=' | '>>=' | '<<<=' | '>>>=' */


 
   

     /* nonblocking_assignment ::= variable_lvalue '<=' [ delay_or_event_control   ] expression */


 
  
	

  
	

  
	

  
	

  
	

  
	

  /* procedural_continuous_assignments ::= 'assign' variable_assignment | 'deassign' variable_lvalue | 'force' variable_assignment | 'force' net_assignment | 'release' variable_lvalue | 'release' net_lvalue */


 
   

  /* function_blocking_assignment ::= variable_lvalue '=' expression */


 
  
	 
	   

 /* function_statement_or_null ::= function_statement | { attribute_instance   } ';' */


 
  
	 
	 /* variable_assignment ::= operator_assignment | inc_or_dec_expression */
/* 




 
A.6.3 
 
Parallel and sequential blocks 
 */


 
  
	 
	   

  /* action_block ::= statement_or_null | [ statement   ] 'else' statement_or_null */


 
  
	

  

         
	

  

   /* function_seq_block ::= 'begin' [ ':'   block_identifier   { block_item_declaration   }   ] { function_statement_or_null   } 'end' [ ':'   block_identifier   ] */


 
  
	

  

         

	
  

   /* seq_block ::= 'begin' [ ':'   block_identifier   ] { block_item_declaration   } { statement_or_null   } 'end' [ ':'   block_identifier   ] */


 
  
	

  

         
	  

   /* par_block ::= 'fork' [ ':'   block_identifier   ] { block_item_declaration   } { statement_or_null   } join_keyword [ ':'   block_identifier   ] */


 
  

  

  

 /* join_keyword ::= 'join' | 'join_any' | 'join_none' */
/* 




 
A.6.4 
 
Statements 
 */


 
  
	 
	   

 /* statement_or_null ::= statement | { attribute_instance   } ';' */


 
    

   /* statement ::= [ block_identifier   ':'   ] statement_item */


 
  
	    

 
	    

 
	    

 
	    
	    
	    

 
	    

 
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    /* statement_item ::= { attribute_instance   } blocking_assignment ';' | { attribute_instance   } nonblocking_assignment ';' | { attribute_instance   } procedural_continuous_assignments ';' | { attribute_instance   } case_statement | { attribute_instance   } conditional_statement | { attribute_instance   } inc_or_dec_expression ';' | { attribute_instance   } function_call ';' | { attribute_instance   } disable_statement | { attribute_instance   } event_trigger | { attribute_instance   } loop_statement | { attribute_instance   } jump_statement | { attribute_instance   } par_block | { attribute_instance   } procedural_timing_control_statement | { attribute_instance   } seq_block | { attribute_instance   } system_task_enable | { attribute_instance   } task_enable | { attribute_instance   } wait_statement | { attribute_instance   } procedural_assertion_item | { attribute_instance   } clocking_drive */


 
    

   /* function_statement ::= [ block_identifier   ':'   ] function_statement_item */


 
  
	    

 
	    
	    
	    

 
	    

 
	    
	    
	    
	    
	    /* function_statement_item ::= { attribute_instance   } function_blocking_assignment ';' | { attribute_instance   } function_case_statement | { attribute_instance   } function_conditional_statement | { attribute_instance   } inc_or_dec_expression ';' | { attribute_instance   } function_call ';' | { attribute_instance   } function_loop_statement | { attribute_instance   } jump_statement | { attribute_instance   } function_seq_block | { attribute_instance   } disable_statement | { attribute_instance   } system_task_enable */
/* 




 
A.6.5 
 
Timing control statements 
 */


 
  
	  /* procedural_timing_control_statement ::= procedural_timing_control statement_or_null */


 
  
	 
	 
	

 

  

  /* delay_or_event_control ::= delay_control | event_control | 'repeat' '(' expression ')' event_control */


 
  
	

  
	
 
  

 /* delay_control ::= '#' delay_value | '#' '(' mintypmax_expression ')' */


 
  
	

  
	
 
  

 
	

 
	
 
 /* event_control ::= '@' event_identifier | '@' '(' event_expression ')' | '@*' | '@' '(*)' */


 
  
	     

   
	 

  
	 

  /* event_expression ::= [ edge_identifier   ] expression [ 'iff'   expression   ] | event_expression 'or' event_expression | event_expression ',' event_expression */


 
  
	 
	/* procedural_timing_control ::= delay_control | event_control */


 
  
	

    

 
	
 
 
	
 
 /* jump_statement ::= 'return' [ expression   ] ';' | 'break' ';' | 'continue' ';' */


 
  
	
 
  

  
	
  
 
	

 

   

   

  /* wait_statement ::= 'wait' '(' expression ')' statement_or_null | 'wait' 'fork' ';' | 'wait_order' '(' hierarchical_identifier [ ','   hierarchical_identifier   ] ')' action_block */


 
  
	

  

 


     

 /* event_trigger ::= '->' hierarchical_event_identifier ';' | '->>' [ delay_or_event_control   ] hierarchical_event_identifier ';' */


 
  
	

  

 
	

  

 
	
  
 /* disable_statement ::= 'disable' hierarchical_task_identifier ';' | 'disable' hierarchical_block_identifier ';' | 'disable' 'fork' ';' */
/* 




 
A.6.6 
 
Conditional statements 
 */


 
  
	   

 

  

   

   
	 /* conditional_statement ::= [ unique_priority   ] 'if' '(' expression ')' statement_or_null [ 'else'   statement_or_null   ] | if_else_if_statement */


 
  
	   

 

  

  
		 

    

 

  

   
		 

   /* if_else_if_statement ::= [ unique_priority   ] 'if' '(' expression ')' statement_or_null { 'else'   [ unique_priority   ]   'if'   '('   expression   ')'   statement_or_null   } [ 'else'   statement_or_null   ] */


 
  
	   

 

  

  
		 

   
	 /* function_conditional_statement ::= [ unique_priority   ] 'if' '(' expression ')' function_statement_or_null [ 'else'   function_statement_or_null   ] | function_if_else_if_statement */


 
  
	   

 

  

  
		 

    

 

  

   
		 

   /* function_if_else_if_statement ::= [ unique_priority   ] 'if' '(' expression ')' function_statement_or_null { 'else'   [ unique_priority   ]   'if'   '('   expression   ')'   function_statement_or_null   } [ 'else'   function_statement_or_null   ] */


 
  

  

 /* unique_priority ::= 'unique' | 'priority' */
/* 




 
A.6.7 
 
Case statements 
 */


 
  
	   
 
  

     

 
	   
 
  

     

 
	   
 
  

     

 /* case_statement ::= [ unique_priority   ] 'case' '(' expression ')' case_item { case_item   } 'endcase' | [ unique_priority   ] 'casez' '(' expression ')' case_item { case_item   } 'endcase' | [ unique_priority   ] 'casex' '(' expression ')' case_item { case_item   } 'endcase' */


 
  
	  

   

  
	

  

   /* case_item ::= expression { ','   expression   } ':' statement_or_null | 'default' [ ':'   ] statement_or_null */


 
  
	   

 

  

     

 
	   

 

  

     

 
	   

 

  

     

 /* function_case_statement ::= [ unique_priority   ] 'case' '(' expression ')' function_case_item { function_case_item   } 'endcase' | [ unique_priority   ] 'casez' '(' expression ')' function_case_item { function_case_item   } 'endcase' | [ unique_priority   ] 'casex' '(' expression ')' function_case_item { function_case_item   } 'endcase' */


 
  
	  

   

  
	

  

   /* function_case_item ::= expression { ','   expression   } ':' function_statement_or_null | 'default' [ ':'   ] function_statement_or_null */
/* 




 
A.6.8 
 
Looping statements 
 */


 
  
	

  
	

 

  

  
	

 

  

  
	

 

   

   

  
 

		  

   

  
	

  

 

  

 

 /* function_loop_statement ::= 'forever' function_statement_or_null | 'repeat' '(' expression ')' function_statement_or_null | 'while' '(' expression ')' function_statement_or_null | 'for' '(' variable_decl_or_assignment { ','   variable_decl_or_assignment   } ';' expression ';' variable_assignment { ','   variable_assignment   } ')' function_statement_or_null | 'do' function_statement_or_null 'while' '(' expression ')' ';' */


 
  
	

  
	

 

  

  
	

 

  

  
	

 

  

  

  

  
	

 

   

   

  
 

		  

   

  
	

  

 

  

 

 /* loop_statement ::= 'forever' statement_or_null | 'repeat' '(' expression ')' statement_or_null | 'while' '(' expression ')' statement_or_null | 'for' '(' variable_decl_or_assignment ';' expression ';' variable_assignment ')' statement_or_null | 'for' '(' variable_decl_or_assignment { ','   variable_decl_or_assignment   } ';' expression ';' variable_assignment { ','   variable_assignment   } ')' statement_or_null | 'do' statement_or_null 'while' '(' expression ')' ';' */


 
  
	  
	 /* variable_decl_or_assignment ::= data_type list_of_variable_identifiers_or_assignments | variable_assignment */
/* 




 
A.6.9 Task enable statements 
 */


 
    

     

     

  

 /* system_task_enable ::= system_task_identifier [ '('   [ expression   ]   { ','   [ expression   ]   }   ')'   ] ';' */


 
    

  

  

 /* task_enable ::= hierarchical_task_identifier [ '('   list_of_arguments   ')'   ] ';' */
/* 




 
A.6.10 
 
Assertion statements
 */


 
  
	 
	 
	 /* procedural_assertion_item ::= assert_property_statement | cover_property_statement | immediate_assert_statement */


 
  


 

  

  /* immediate_assert_statement ::= 'assert' '(' expression ')' action_block */
/* 




 
A.6.11 
 
Clocking domain
 */


 
   

  

     

 
		   
	

 /* clocking_decl ::= [ 'default'   ] 'clocking' [ clocking_identifier   ] clocking_event ';' { clocking_item   } 'endclocking' */


 
  
	

  
	
 
  

 /* clocking_event ::= '@' identifier | '@' '(' event_expression ')' */


 
  
	

  

 
	  

 
	    /* clocking_item ::= 'default' default_skew ';' | clocking_direction list_of_clocking_decl_assign ';' | { attribute_instance   } concurrent_assertion_item_declaration */


 
  
	

  
	

  
	

  

  /* default_skew ::= 'input' clocking_skew | 'output' clocking_skew | 'input' clocking_skew 'output' clocking_skew */


 
  
	

    
	

    
	

    

    
	

 /* clocking_direction ::= 'input' [ clocking_skew   ] | 'output' [ clocking_skew   ] | 'input' [ clocking_skew   ] 'output' [ clocking_skew   ] | 'inout' */


 
       /* list_of_clocking_decl_assign ::= clocking_decl_assign { ','   clocking_decl_assign   } */


 
    

   /* clocking_decl_assign ::= signal_identifier [ '='   hierarchical_identifier   ] */


 
  
	    
	 /* clocking_skew ::= edge_identifier [ delay_control   ] | delay_control */


 
  
	 

     
	  

  /* clocking_drive ::= clockvar_expression '<=' [ cycle_delay   ] expression | cycle_delay clockvar_expression '<=' expression */


 
  

  /* cycle_delay ::= '##' expression */


 
   

  /* clockvar ::= clocking_identifier '.' identifier */


 
  
	  
	 

  

 /* clockvar_expression ::= clockvar range | clockvar [ range_expression ] */
/* 




 
A.7 Specify section 




 
A.7.1 Specify block declaration 
 */


 
  

    

 /* specify_block ::= 'specify' { specify_item   } 'endspecify' */


 
  
	 
	 
	 
	 
	 /* specify_item ::= specparam_declaration | pulsestyle_declaration | showcancelled_declaration | path_declaration | system_timing_check */


 
  
	

  

 
	

  

 /* pulsestyle_declaration ::= 'pulsestyle_onevent' list_of_path_outputs ';' | 'pulsestyle_ondetect' list_of_path_outputs ';' */


 
  
	

  

 
	

  

 /* showcancelled_declaration ::= 'showcancelled' list_of_path_outputs ';' | 'noshowcancelled' list_of_path_outputs ';' */
/* 




 
A.7.2 Specify path declarations 
 */


 
  
	 

 
	 

 
	 

 /* path_declaration ::= simple_path_declaration ';' | edge_sensitive_path_declaration ';' | state_dependent_path_declaration ';' */


 
  
	 

  
	 

  /* simple_path_declaration ::= parallel_path_description '=' path_delay_value | full_path_description '=' path_delay_value */


 
  
	

     

  

 /* parallel_path_description ::= '(' specify_input_terminal_descriptor [ polarity_operator   ] '=>' specify_output_terminal_descriptor ')' */


 
  
	

     

  

 /* full_path_description ::= '(' list_of_path_inputs [ polarity_operator   ] '*>' list_of_path_outputs ')' */


 
  
	  

   /* list_of_path_inputs ::= specify_input_terminal_descriptor { ','   specify_input_terminal_descriptor   } */


 
  
	  

   /* list_of_path_outputs ::= specify_output_terminal_descriptor { ','   specify_output_terminal_descriptor   } */
/* 




 
A.7.3 Specify block terminals 
 */


 
  
	  

  

  /* specify_input_terminal_descriptor ::= input_identifier [ [   constant_range_expression   ]   ] */


 
  
	  

  

  /* specify_output_terminal_descriptor ::= output_identifier [ [   constant_range_expression   ]   ] */


 
     /* input_identifier ::= input_port_identifier | inout_port_identifier */


 
     /* output_identifier ::= output_port_identifier | inout_port_identifier */
/* 




 
A.7.4 
 
Specify path delays 
 */


 
  
	 
	

  

 /* path_delay_value ::= list_of_path_delay_expressions | '(' list_of_path_delay_expressions ')' */


 
  
	 
	 

  
	 

  

  
	 

  

 
 
 
		 

  

  
	 

  

  
 

		 

  

  

 
		 

  

  

 
		 

  

  /* list_of_path_delay_expressions ::= t_path_delay_expression | trise_path_delay_expression ',' tfall_path_delay_expression | trise_path_delay_expression ',' tfall_path_delay_expression ',' tz_path_delay_expression | t01_path_delay_expression ',' t10_path_delay_expression ',' t0z_path_delay_expression ',' tz1_path_delay_expression ',' t1z_path_delay_expression ',' tz0_path_delay_expression | t01_path_delay_expression ',' t10_path_delay_expression ',' t0z_path_delay_expression ',' tz1_path_delay_expression ',' t1z_path_delay_expression ',' tz0_path_delay_expression ',' t0x_path_delay_expression ',' tx1_path_delay_expression ',' t1x_path_delay_expression ',' tx0_path_delay_expression ',' txz_path_delay_expression ',' tzx_path_delay_expression */


 
   /* t_path_delay_expression ::= path_delay_expression */


 
   /* trise_path_delay_expression ::= path_delay_expression */


 
   /* tfall_path_delay_expression ::= path_delay_expression */


 
   /* tz_path_delay_expression ::= path_delay_expression */


 
   /* t01_path_delay_expression ::= path_delay_expression */


 
   /* t10_path_delay_expression ::= path_delay_expression */


 
   /* t0z_path_delay_expression ::= path_delay_expression */


 
   /* tz1_path_delay_expression ::= path_delay_expression */


 
   /* t1z_path_delay_expression ::= path_delay_expression */


 
   /* tz0_path_delay_expression ::= path_delay_expression */


 
   /* t0x_path_delay_expression ::= path_delay_expression */


 
   /* tx1_path_delay_expression ::= path_delay_expression */


 
   /* t1x_path_delay_expression ::= path_delay_expression */


 
   /* tx0_path_delay_expression ::= path_delay_expression */


 
   /* txz_path_delay_expression ::= path_delay_expression */


 
   /* tzx_path_delay_expression ::= path_delay_expression */


 
   /* path_delay_expression ::= constant_mintypmax_expression */


 
  
	 

  
	 

  /* edge_sensitive_path_declaration ::= parallel_edge_sensitive_path_description '=' path_delay_value | full_edge_sensitive_path_description '=' path_delay_value */


 
  
	

     

 
		    

  

 /* parallel_edge_sensitive_path_description ::= '(' [ edge_identifier   ] specify_input_terminal_descriptor '=>' specify_output_terminal_descriptor [ polarity_operator   ] ':' data_source_expression ')' */


 
  
	

     

 
		    

  

 /* full_edge_sensitive_path_description ::= '(' [ edge_identifier   ] list_of_path_inputs '*>' list_of_path_outputs [ polarity_operator   ] ':' data_source_expression ')' */


 
   /* data_source_expression ::= expression */


 
  

  

 /* edge_identifier ::= 'posedge' | 'negedge' */


 
  
	

 

  

  
	

 

  

  
	

  /* state_dependent_path_declaration ::= 'if' '(' module_path_expression ')' simple_path_declaration | 'if' '(' module_path_expression ')' edge_sensitive_path_declaration | 'ifnone' simple_path_declaration */


 
  

  

 /* polarity_operator ::= '+' | - */
/* 




 
A.7.5 System timing checks 



 
A.7.5.1 System timing check commands 
 */


 
  
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 /* system_timing_check ::= $setup_timing_check | $hold_timing_check | $setuphold_timing_check | $recovery_timing_check | $removal_timing_check | $recrem_timing_check | $skew_timing_check | $timeskew_timing_check | $fullskew_timing_check | $period_timing_check | $width_timing_check | $nochange_timing_check */


 
  
	
 
  

  

   

     
 
 /* $setup_timing_check ::= '$setup' '(' data_event ',' reference_event ',' timing_check_limit [ ','   [ notify_reg   ]   ] ')' ';' */


 
  
	
 
  

  

   

     
 
 /* $hold_timing_check ::= '$hold' '(' reference_event ',' data_event ',' timing_check_limit [ ','   [ notify_reg   ]   ] ')' ';' */


 
  
	
 
  

  

  

  
		 

     

     

    
		 

     

         
 
 /* $setuphold_timing_check ::= '$setuphold' '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit [ ','   [ notify_reg   ]   [ ','   [ stamptime_condition   ]   [ ','   [ checktime_condition   ]   [ ','   [ delayed_reference   ]   [ ','   [ delayed_data   ]   ]   ]   ]   ]   ] ')' ';' */


 
  
	
 
  

  

   

     
 
 /* $recovery_timing_check ::= '$recovery' '(' reference_event ',' data_event ',' timing_check_limit [ ','   [ notify_reg   ]   ] ')' ';' */


 
  
	
 
  

  

   

     
 
 /* $removal_timing_check ::= '$removal' '(' reference_event ',' data_event ',' timing_check_limit [ ','   [ notify_reg   ]   ] ')' ';' */


 
  
	
 
  

  

  

  
		 

     

     

    
		 

     

         
 
 /* $recrem_timing_check ::= '$recrem' '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit [ ','   [ notify_reg   ]   [ ','   [ stamptime_condition   ]   [ ','   [ checktime_condition   ]   [ ','   [ delayed_reference   ]   [ ','   [ delayed_data   ]   ]   ]   ]   ]   ] ')' ';' */


 
  
	
 
  

  

   

     
 
 /* $skew_timing_check ::= '$skew' '(' reference_event ',' data_event ',' timing_check_limit [ ','   [ notify_reg   ]   ] ')' ';' */


 
  
	
 
  

  

  
		 

     

     

       
 
 /* $timeskew_timing_check ::= '$timeskew' '(' reference_event ',' data_event ',' timing_check_limit [ ','   [ notify_reg   ]   [ ','   [ event_based_flag   ]   [ ','   [ remain_active_flag   ]   ]   ]   ] ')' ';' */


 
  
	
 
  

  

  

  
		 

     

     

       
 
 /* $fullskew_timing_check ::= '$fullskew' '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit [ ','   [ notify_reg   ]   [ ','   [ event_based_flag   ]   [ ','   [ remain_active_flag   ]   ]   ]   ] ')' ';' */


 
  
	
 
  

   

     
 
 /* $period_timing_check ::= '$period' '(' controlled_reference_event ',' timing_check_limit [ ','   [ notify_reg   ]   ] ')' ';' */


 
  
	
 
  

  

   

     
 
 /* $width_timing_check ::= '$width' '(' controlled_reference_event ',' timing_check_limit ',' threshold [ ','   [ notify_reg   ]   ] ')' ';' */


 
  
	
 
  

  

  

 
		  

     
 
 /* $nochange_timing_check ::= '$nochange' '(' reference_event ',' data_event ',' start_edge_offset ',' end_edge_offset [ ','   [ notify_reg   ]   ] ')' ';' */
/* 




 
A.7.5.2 System timing check command arguments 
 */


 
   /* checktime_condition ::= mintypmax_expression */


 
   /* controlled_reference_event ::= controlled_timing_check_event */


 
   /* data_event ::= timing_check_event */


 
  
	 
	 

  

 /* delayed_data ::= terminal_identifier | terminal_identifier [ constant_mintypmax_expression ] */


 
  
	 
	 

  

 /* delayed_reference ::= terminal_identifier | terminal_identifier [ constant_mintypmax_expression ] */


 
   /* end_edge_offset ::= mintypmax_expression */


 
   /* event_based_flag ::= constant_expression */


 
   /* notify_reg ::= variable_identifier */


 
   /* reference_event ::= timing_check_event */


 
   /* remain_active_flag ::= constant_mintypmax_expression */


 
   /* stamptime_condition ::= mintypmax_expression */


 
   /* start_edge_offset ::= mintypmax_expression */


 
  /* threshold ::= constant_expression */


 
   /* timing_check_limit ::= expression */
/* 




 
A.7.5.3 System timing check event definitions 
 */


 
  
	   

   /* timing_check_event ::= [ timing_check_event_control   ] specify_terminal_descriptor [ '&&&'   timing_check_condition   ] */


 
  
	   

   /* controlled_timing_check_event ::= timing_check_event_control specify_terminal_descriptor [ '&&&'   timing_check_condition   ] */


 
  
	

 
	

 
	 /* timing_check_event_control ::= 'posedge' | 'negedge' | edge_control_specifier */


 
  
	 
	 /* specify_terminal_descriptor ::= specify_input_terminal_descriptor | specify_output_terminal_descriptor */


 
  

 

   

   

 /* edge_control_specifier ::= 'edge' [ edge_descriptor { ','   edge_descriptor   } ] */


 

  

  

  
 
  
 
 /* edge_descriptor ::= '01' | '10' | z_or_x zero_or_one | zero_or_one z_or_x */


 
  

  

 /* zero_or_one ::= '0' | '1' */


 
  

  

  

  

 /* z_or_x ::= x | X | Z | Z */


 
  
	 
	

  

 /* timing_check_condition ::= scalar_timing_check_condition | '(' scalar_timing_check_condition ')' */


 
  
	 
	

  
	 
 
 
	 

  
	 

  
	 

  /* scalar_timing_check_condition ::= expression | '~' expression | expression '==' scalar_constant | expression '===' scalar_constant | expression '!=' scalar_constant | expression '!==' scalar_constant */


 
  

  

  

  

  

  

  

  

  

  

 /* scalar_constant ::= '1'b0' | '1'b1' | '1'B0' | '1'B1' | ''b0' | ''b1' | ''B0' | ''B1' | '1' | '0' */
/* 





 
A.8 Expressions 




 
A.8.1 
 
Concatenations 
 */


 
  
	

   

   

 
	

  

   

     

 
	

  

   

     

 /* concatenation ::= { expression { ','   expression   } } | { struct_member_label ':' expression { ','   struct_member_label   ':'   expression   } } | { array_member_label ':' expression { ','   array_member_label   ':'   expression   } } */


 
  
	

   

   

 
	

  

   

     

 
	

  

   

     

 /* constant_concatenation ::= { constant_expression { ','   constant_expression   } } | { struct_member_label ':' constant_expression { ','   struct_member_label   ':'   constant_expression   } } | { array_member_label ':' constant_expression { ','   array_member_label   ':'   constant_expression   } } */


 
  
	

 
	 
	 /* struct_member_label ::= 'default' | type_identifier | variable_identifier */


 
  
	

 
	 
	/* array_member_label ::= 'default' | type_identifier | constant_expression */


 
  

   

 /* constant_multiple_concatenation ::= { constant_expression constant_concatenation } */


 
  

   

   

 /* module_path_concatenation ::= { module_path_expression { ','   module_path_expression   } } */


 
  

   

 /* module_path_multiple_concatenation ::= { constant_expression module_path_concatenation } */


 
  

   

 /* multiple_concatenation ::= { constant_expression concatenation } */
/* 




 
A.8.2 Function calls 
 */


 
      
	  

  

  /* constant_function_call ::= function_identifier { attribute_instance   } [ '('   list_of_constant_arguments   ')'   ] */


 
       

  

  /* function_call ::= hierarchical_function_identifier { attribute_instance   } [ '('   list_of_arguments   ')'   ] */


 
  
	    

     
	

  

    

  

 

  

    

  /* list_of_arguments ::= [ expression   ] { ','   [ expression   ]   } | '.' identifier '(' [ expression   ] ')' { ','   '.'   identifier   '('   [ expression   ]   ')'   } */


 
  
	    

     
	

  

    

  

 

  

    

  /* list_of_constant_arguments ::= [ constant_expression   ] { ','   [ constant_expression   ]   } | '.' identifier '(' [ constant_expression   ] ')' { ','   '.'   identifier   '('   [ constant_expression   ]   ')'   } */


 
    

   

   

  /* system_function_call ::= system_function_identifier [ '('   expression   { ','   expression   }   ')'   ] */
/* 




 
A.8.3 
 
Expressions 
 */


 
   /* base_expression ::= expression */


 
  
	     
	     /* inc_or_dec_expression ::= inc_or_dec_operator { attribute_instance   } variable_lvalue | variable_lvalue { attribute_instance   } inc_or_dec_operator */


 
   

     

  /* conditional_expression ::= expression1 '?' { attribute_instance   } expression2 ':' expression3 */


 
   /* constant_base_expression ::= constant_expression */


 
  
	 
	     
	      
	 

     

  
	 /* constant_expression ::= constant_primary | unary_operator { attribute_instance   } constant_primary | constant_expression binary_operator { attribute_instance   } constant_expression | constant_expression '?' { attribute_instance   } constant_expression ':' constant_expression | string_literal */


 
  
	 
	 

  

  /* constant_mintypmax_expression ::= constant_expression | constant_expression ':' constant_expression ':' constant_expression */


 
  
	 /* constant_param_expression ::= constant_expression */


 
  
	 
	 

  
	 

  
	 

  /* constant_range_expression ::= constant_expression | msb_constant_expression ':' lsb_constant_expression | constant_base_expression '+:' width_constant_expression | constant_base_expression '-:' width_constant_expression */


 
   /* dimension_constant_expression ::= constant_expression */


 
   /* expression1 ::= expression */


 
   /* expression2 ::= expression */


 
   /* expression3 ::= expression */


 
  
	 
	     
	 
	

  

 
	      
	 
	 
	 /* expression ::= primary | unary_operator { attribute_instance   } primary | inc_or_dec_expression | '(' operator_assignment ')' | expression binary_operator { attribute_instance   } expression | conditional_expression | string_literal | inside_expression */


 
   

  /* inside_expression ::= expression 'inside' range_list_or_array */


 
  
	 
	

   

   

 /* range_list_or_array ::= variable_identifier | { value_range { ','   value_range   } } */


 
  
	 
	

  

  

 /* value_range ::= expression | [ expression ':' expression ] */


 
   /* lsb_constant_expression ::= constant_expression */


 
  
	 
	 

  

  /* mintypmax_expression ::= expression | expression ':' expression ':' expression */


 
   

    
	 

  /* module_path_conditional_expression ::= module_path_expression '?' { attribute_instance   } module_path_expression ':' module_path_expression */


 
  
	 
	     
	
 
    
		 
	 /* module_path_expression ::= module_path_primary | unary_module_path_operator { attribute_instance   } module_path_primary | module_path_expression binary_module_path_operator { attribute_instance   } module_path_expression | module_path_conditional_expression */


 
  
	 
	 

  

  /* module_path_mintypmax_expression ::= module_path_expression | module_path_expression ':' module_path_expression ':' module_path_expression */


 
   /* msb_constant_expression ::= constant_expression */


 
  
	 
	 

  
	 

  
	 

  /* range_expression ::= expression | msb_constant_expression ':' lsb_constant_expression | base_expression '+:' width_constant_expression | base_expression '-:' width_constant_expression */


 
   /* width_constant_expression ::= constant_expression */
/* 




 
A.8.4 
 
Primaries 
 */


 
  
	 
	 
	

  

 
	 
	 
	 
	 
	 
	 

 

  

 
	 

  
	 

  
	 
	

  

  

  

  

  

 /* constant_primary ::= constant_concatenation | constant_function_call | '(' constant_mintypmax_expression ')' | constant_multiple_concatenation | genvar_identifier | number | parameter_identifier | specparam_identifier | casting_type ''' '(' constant_expression ')' | casting_type ''' constant_concatenation | casting_type ''' constant_multiple_concatenation | time_literal | ''0' | ''1' | ''z' | ''Z' | ''x' | ''X' */


 
  
	 
	 
	 
	 
	 
	 
	 
	

  

 /* module_path_primary ::= number | identifier | module_path_concatenation | module_path_multiple_concatenation | function_call | system_function_call | constant_function_call | '(' module_path_mintypmax_expression ')' */


 
  
	 
	   

  

   

  

  
		 

      

   

   

   
	 
	 
	 
	 
	 
	 

   

   
	

  

 
	 
 
  

 
	
  
  

 
	 
 
 
	 
 
 
	 
	

  

  

  

  

  

 
	

 /* primary ::= number | implicit_class_handle hierarchical_identifier { [   expression   ]   } [ [   range_expression   ]   ] [ '.'   method_identifier   { attribute_instance   }   [ '('   expression   { ','   expression   }   ')'   ]   ] | concatenation | multiple_concatenation | function_call | system_function_call | constant_function_call | class_identifier '::' { class_identifier   '::'   } identifier | '(' mintypmax_expression ')' | casting_type ''' '(' expression ')' | 'void' ''' '(' function_call ')' | casting_type ''' concatenation | casting_type ''' multiple_concatenation | time_literal | ''0' | ''1' | ''z' | ''Z' | ''x' | ''X' | 'null' */


 

  
	  
	 /* time_literal ::= unsigned_number time_unit | fixed_point_number time_unit */


 
  

  

  

  

  

  

  

 /* time_unit ::= S | MS | US | NS | PS | FS | 'step' */


 

   

    

  /* implicit_class_handle ::= [ 'this'   '.'   ] | [ 'super'   '.'   ] */
/* 




 
A.8.5 Expression left-side values 
 */


 
  
	  

  

   

  

 
	

   

   

 /* net_lvalue ::= hierarchical_net_identifier { [   constant_expression   ]   } [ [   constant_range_expression   ]   ] | { net_lvalue { ','   net_lvalue   } } */


 
  
	  

  

   

  

  
	

   

   

 /* variable_lvalue ::= hierarchical_variable_identifier { [   expression   ]   } [ [   range_expression   ]   ] | { variable_lvalue { ','   variable_lvalue   } } */
/* 




 
A.8.6 
 
Operators 
 */


 
  
	

  

  

  

  

  

  

  

  

  

  

 /* unary_operator ::= '+' | - | '!' | '~' | '&' | '~&' | | | '~|' | '^' | '~^' | '~^' */


 
  
	

  

  

  

  

  

  

  

  

  

  

  

  

  

 
	

  

  

  

  

  

  

  

  

  

  

  

  

 /* binary_operator ::= '+' | - | '*' | '/' | '%' | '==' | '!=' | '===' | '!==' | '=?=' | '!?=' | '&&' | '||' | '**' | '<' | '<=' | '>' | '>=' | '&' | | | '^' | '~^' | '~^' | '>>' | '<<' | '>>>' | '<<' */


 
  

  

 /* inc_or_dec_operator ::= '++' | '--' */


 
 

 
          

  

  

  

  

  

  

  

  

 /* unary_module_path_operator ::= '!' | '~' | '&' | '~&' | | | '~|' | '^' | '~^' | '~^' */


 
 

 
          

  

  

  

  

  

  

  

  

 /* binary_module_path_operator ::= '==' | '!=' | '&&' | '||' | '&' | | | '^' | '~^' | '~^' */
/* 




 
A.8.7 
 
Numbers 
 */


 
  
	 
	 
	 
	 
	 /* number ::= decimal_number | octal_number | binary_number | hex_number | real_number */


 
  
	 
	   
 
 
	   
 
  

  
	   
 
  

  /* decimal_number ::= unsigned_number | [ size   ] decimal_base unsigned_number | [ size   ] decimal_base x_digit { '_'   } | [ size   ] decimal_base z_digit { '_'   } */


 
     
 
 /* binary_number ::= [ size   ] binary_base binary_value */


 
     
 
 /* octal_number ::= [ size   ] octal_base octal_value */


 
     
 
 /* hex_number ::= [ size   ] hex_base hex_value */


 
  

  

 /* sign ::= '+' | - */


 
   /* size ::= non_zero_unsigned_number */


 

    

   /* non_zero_unsigned_number ::= non_zero_decimal_digit { '_'   |   decimal_digit   } */


 

  
	 
	  

        /* real_number ::= fixed_point_number | unsigned_number [ '.'   unsigned_number   ] exp [ sign   ] unsigned_number */


 

   

  /* fixed_point_number ::= unsigned_number '.' unsigned_number */


 
  

  

 /* exp ::= E | E */


 

    

    /* unsigned_number ::= decimal_digit { '_'   |   decimal_digit   } */


 

    

    /* binary_value ::= binary_digit { '_'   |   binary_digit   } */


 

    

    /* octal_value ::= octal_digit { '_'   |   octal_digit   } */


 

    

    /* hex_value ::= hex_digit { '_'   |   hex_digit   } */


 

  







  







 /* decimal_base ::= ''' [ s   |   S   ] D | ''' [ s   |   S   ] D */


 

  







  







 /* binary_base ::= ''' [ s   |   S   ] b | ''' [ s   |   S   ] B */


 

  







  







 /* octal_base ::= ''' [ s   |   S   ] O | ''' [ s   |   S   ] O */


 

  







  







 /* hex_base ::= ''' [ s   |   S   ] H | ''' [ s   |   S   ] H */


 
  

  

  

  

  

  

  

  

  

 /* non_zero_decimal_digit ::= '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' */


 
  

  

  

  

  

  

  

  

  

  

 /* decimal_digit ::= '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' */


 
      

  

 /* binary_digit ::= x_digit | z_digit | '0' | '1' */


 
      

  

  

  

  

  

  

  

 /* octal_digit ::= x_digit | z_digit | '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' */


 
      

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

 /* hex_digit ::= x_digit | z_digit | '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' | A | b | C | d | e | f | A | B | C | D | E | F */


 
  

  

 /* x_digit ::= x | X */


 
  

  

  

 /* z_digit ::= z | Z | '?' */
/* 




 
A.8.8 
 
Strings 
 */


 
  

    

 /* string_literal ::= '"' { 'Any_ASCII_Characters'   } '"' */
/* 




 
A.9 General 




 
A.9.1 
 
Attributes 
 */


 
  

   

   

 /* attribute_instance ::= '(*' attr_spec { ','   attr_spec   } '*)' */


 
  
	 

  
	 /* attr_spec ::= attr_name '=' constant_expression | attr_name */


 
   /* attr_name ::= identifier */
/* 




 
A.9.2 Comments 
 */


 
  
	 
	 /* comment ::= one_line_comment | block_comment */


 
  

   /* one_line_comment ::= '//' comment_text '\n' */


 
  

  

 /* block_comment ::= '/' '*'  comment_text '*' '/'  */


 
     /* comment_text ::= { 'Any_ASCII_character'   } */
/* 




 
A.9.3 Identifiers 
 */


 
   /* block_identifier ::= identifier */


 

   







    









   /* c_identifier ::= [ "a" .. "z"   |   "A" .. "Z"   '_'   ] { [ "a" .. "z"   |   "A" .. "Z"   |   "'0'" .. "'9_'"   ]   } */


 
   /* cell_identifier ::= identifier */


 
   /* class_identifier ::= identifier */


 
   /* clocking_identifier ::= identifier */


 
   /* config_identifier ::= identifier */


 
   /* constraint_identifier ::= identifier */


 
   /* const_identifier ::= identifier */


 
   /* enum_identifier ::= identifier */


 

  
	  

  

  /* escaped_hierarchical_identifier ::= escaped_hierarchical_branch { '.'   simple_hierarchical_branch   |   '.'   escaped_hierarchical_branch   } */


 
  

   /* escaped_identifier ::= '\' '{any_ASCII_character_except_white_space}' white_space */


 
   /* event_identifier ::= identifier */


 
   /* formal_identifier ::= identifier */


 
   /* function_identifier ::= identifier */


 
   /* gate_instance_identifier ::= identifier */


 
   /* generate_block_identifier ::= identifier */


 
   /* genvar_identifier ::= identifier */


 
   /* hierarchical_block_identifier ::= hierarchical_identifier */


 
   /* hierarchical_event_identifier ::= hierarchical_identifier */


 
   /* hierarchical_function_identifier ::= hierarchical_identifier */


 
  
	 
	 /* hierarchical_identifier ::= simple_hierarchical_identifier | escaped_hierarchical_identifier */


 
   /* hierarchical_parameter_identifier ::= hierarchical_identifier */


 
   /* hierarchical_net_identifier ::= hierarchical_identifier */


 
   /* hierarchical_variable_identifier ::= hierarchical_identifier */


 
   /* hierarchical_task_identifier ::= hierarchical_identifier */


 
  
	 
	 /* identifier ::= simple_identifier | escaped_identifier */


 
   /* interface_identifier ::= identifier */


 
   /* interface_instance_identifier ::= identifier */


 
     /* inout_port_identifier ::= identifier */


 
   /* input_port_identifier ::= identifier */


 
   /* instance_identifier ::= identifier */


 
   /* library_identifier ::= identifier */


 
   /* method_identifier ::= identifier */


 
   /* modport_identifier ::= identifier */


 
   /* module_identifier ::= identifier */


 
   /* module_instance_identifier ::= identifier */


 
     /* net_identifier ::= identifier */


 
   /* output_port_identifier ::= identifier */


 
   /* parameter_identifier ::= identifier */


 
   /* port_identifier ::= identifier */


 
   /* program_identifier ::= identifier */


 
   /* program_instance_identifier ::= identifier */


 
   /* property_identifier ::= identifier */


 
   /* sequence_identifier ::= identifier */


 
   /* signal_identifier ::= identifier */


 

    

   /* simple_hierarchical_identifier ::= simple_hierarchical_branch [ '.'   escaped_identifier   ] */


 

   





    







   /* simple_identifier ::= [ ""a" .. "ZA"" .. "Z_"   ] { [ """a" .. "zA"" .. "Z0"" .. "'9_$'"   ]   } */


 
   /* specparam_identifier ::= identifier */


 

  

 







   







   /* system_function_identifier ::= '$' [ """a" .. "zA"" .. "Z0"" .. "'9_$'"   ']{'   [ """a" .. "zA"" .. "Z0"" .. "'9_$'"   ]   ] */


 

  

 







   







   /* system_task_identifier ::= '$' [ """a" .. "zA"" .. "Z0"" .. "'9_$'"   ']{'   [ """a" .. "zA"" .. "Z0"" .. "'9_$'"   ]   ] */


 
    /* task_or_function_identifier ::= task_identifier | function_identifier */


 
   /* task_identifier ::= identifier */


 
   /* terminal_identifier ::= identifier */


 
   /* text_macro_identifier ::= simple_identifier */


 
   /* topmodule_identifier ::= identifier */


 
      /* type_declaration_identifier ::= type_identifier { unpacked_dimension   } */


 
   /* type_identifier ::= identifier */


 
   /* udp_identifier ::= identifier */


 
   /* udp_instance_identifier ::= identifier */


 
   /* variable_identifier ::= identifier */
/* 




 
A.9.4 Identifier branches 
 */


 

  
	  

  

    

   

  

    /* simple_hierarchical_branch ::= simple_identifier { [   unsigned_number   ]   } [ { '.'   simple_identifier   { [   unsigned_number   ]   }   }   ] */


 

  
	  

  

    

   

  

    /* escaped_hierarchical_branch ::= escaped_identifier { [   unsigned_number   ]   } [ { '.'   escaped_identifier   { [   unsigned_number   ]   }   }   ] */
/* 




 
A.9.5 White space 
 */


 
        
 /* white_space ::= 'space' | 'tab' | 'newline' | 'eof' */
/* 



 
NOTES 



 
Embedded spaces are illegal. 


 
A simple_identifier, c_identifier, and arrayed_reference shall start with an alpha or underscore (_) character, shall have at least one character, and shall not have any spaces. 


 
The period (.) in simple_hierarchical_identifier and simple_hierarchical_branch shall not be preceded or followed by white_space. 


 
The period in escaped_hierarchical_identifier and escaped_hierarchical_branch shall be preceded by white_space, but shall not be followed by white_space. 


 
The $ character in a system_function_identifier or system_task_identifier shall not be followed by white_space. A system_function_identifier or system_task_identifier shall not be escaped. 


 
End of file. 


 
The unsigned number or fixed point number in time_literal shall not be followed by a white_space.


 
void functions, non integer type functions, and functions with a typedef type cannot have a signing declaration.


 
Open-array (  */

 
        


 
          
 


 
       

  

      

  

    

  

    



 
/* [ ] ')' form shall only be used 'with' dpi_proto_formal implicit_class_handle shall only appear 'within' the scope of a class_declaration 'or' extern_method_declaration '.' In any one declaration, only one of 'protected' 'or' 'local' is allowed, only one of 'rand' 'or' 'randc' is allowed, 'and' 'static' and/or 'virtual' can appear only once. */

property_qualifier : RAND { (RAND); }
	| RANDC { (RANDC); }
	| class_item_qualifier { ($1); }
	;

data_declaration : variable_declaration { ($1); }
	| constant_declaration { ($1); }
	| type_declaration { ($1); }
	;

port_expression : port_reference { ($1); }
	| LCURLY port_reference port_expression_6 RCURLY { QUADRUPLE(LCURLY, $2, $3, RCURLY); }
	;

tf_output_declaration : OUTPUT tf_output_declaration_3 tf_output_declaration_4 list_of_tf_port_identifiers { QUADRUPLE(OUTPUT, $2, $3, $4); }
	| OUTPUT tf_data_type list_of_tf_variable_identifiers { TRIPLE(OUTPUT, $2, $3); }
	;

z_digit : 'z' { (CHAR 'z'); }
	| 'Z' { (CHAR 'Z'); }
	| QUERY { (QUERY); }
	;

d_nochange_timing_check : NOCHANGE LPAREN reference_event COMMA data_event COMMA start_edge_offset COMMA end_edge_offset d_nochange_timing_check_11 RPAREN SEMICOLON { DUODECUPLE(NOCHANGE, LPAREN, $3, COMMA, $5, COMMA, $7, COMMA, $9, $10, RPAREN, SEMICOLON); }
	;

tf_input_declaration : INPUT tf_input_declaration_3 tf_input_declaration_4 list_of_tf_port_identifiers { QUADRUPLE(INPUT, $2, $3, $4); }
	| INPUT tf_data_type list_of_tf_variable_identifiers { TRIPLE(INPUT, $2, $3); }
	;

timeunits_declaration : TIMEUNIT time_literal SEMICOLON { TRIPLE(TIMEUNIT, $2, SEMICOLON); }
	| TIMEPRECISION time_literal SEMICOLON { TRIPLE(TIMEPRECISION, $2, SEMICOLON); }
	| TIMEUNIT time_literal SEMICOLON TIMEPRECISION time_literal SEMICOLON { SEXTUPLE(TIMEUNIT, $2, SEMICOLON, TIMEPRECISION, $5, SEMICOLON); }
	| TIMEPRECISION time_literal SEMICOLON TIMEUNIT time_literal SEMICOLON { SEXTUPLE(TIMEPRECISION, $2, SEMICOLON, TIMEUNIT, $5, SEMICOLON); }
	;

class_identifier : identifier { ($1); }
	;

cmos_switch_instance : cmos_switch_instance_2 LPAREN output_terminal COMMA input_terminal COMMA ncontrol_terminal COMMA pcontrol_terminal RPAREN { DECUPLE($1, LPAREN, $3, COMMA, $5, COMMA, $7, COMMA, $9, RPAREN); }
	;

timing_check_event_control : POSEDGE { (POSEDGE); }
	| NEGEDGE { (NEGEDGE); }
	| edge_control_specifier { ($1); }
	;

genvar_declaration : GENVAR list_of_genvar_identifiers SEMICOLON { TRIPLE(GENVAR, $2, SEMICOLON); }
	;

combinational_entry : level_input_list COLON output_symbol SEMICOLON { QUADRUPLE($1, COLON, $3, SEMICOLON); }
	;

hierarchical_task_identifier : hierarchical_identifier { ($1); }
	;

list_of_interface_identifiers : interface_identifier list_of_interface_identifiers_3 list_of_interface_identifiers_4 { TRIPLE($1, $2, $3); }
	;

sign : PLUS { (PLUS); }
	| MINUS { (MINUS); }
	;

n_input_gate_instance : n_input_gate_instance_2 LPAREN output_terminal COMMA input_terminal n_input_gate_instance_7 RPAREN { SEPTUPLE($1, LPAREN, $3, COMMA, $5, $6, RPAREN); }
	;

list_of_arguments : list_of_arguments_2 list_of_arguments_3 { DOUBLE($1, $2); }
	| DOT identifier LPAREN list_of_arguments_8 RPAREN list_of_arguments_10 { SEXTUPLE(DOT, $2, LPAREN, $4, RPAREN, $6); }
	;

function_body_declaration : function_body_declaration_2 function_body_declaration_3 function_body_declaration_4 function_identifier SEMICOLON function_body_declaration_7 function_body_declaration_8 ENDFUNCTION function_body_declaration_10 { NONUPLE($1, $2, $3, $4, SEMICOLON, $6, $7, ENDFUNCTION, $9); }
	| function_body_declaration_12 function_body_declaration_13 function_body_declaration_14 function_identifier LPAREN function_port_list RPAREN SEMICOLON function_body_declaration_20 function_body_declaration_21 ENDFUNCTION function_body_declaration_23 { DUODECUPLE($1, $2, $3, $4, LPAREN, $6, RPAREN, SEMICOLON, $9, $10, ENDFUNCTION, $12); }
	;

module_common_item : module_common_item_2 module_or_generate_item_declaration { DOUBLE($1, $2); }
	| module_common_item_5 interface_instantiation { DOUBLE($1, $2); }
	| module_common_item_8 program_instantiation { DOUBLE($1, $2); }
	| module_common_item_11 concurrent_assertion_item { DOUBLE($1, $2); }
	| module_common_item_14 bind_directive { DOUBLE($1, $2); }
	;

function_case_statement : function_case_statement_2 CASE LPAREN expression RPAREN function_case_item function_case_statement_8 ENDCASE { OCTUPLE($1, CASE, LPAREN, $4, RPAREN, $6, $7, ENDCASE); }
	| function_case_statement_11 CASEZ LPAREN expression RPAREN function_case_item function_case_statement_17 ENDCASE { OCTUPLE($1, CASEZ, LPAREN, $4, RPAREN, $6, $7, ENDCASE); }
	| function_case_statement_20 CASEX LPAREN expression RPAREN function_case_item function_case_statement_26 ENDCASE { OCTUPLE($1, CASEX, LPAREN, $4, RPAREN, $6, $7, ENDCASE); }
	;

list_of_function_proto_formals : list_of_function_proto_formals_2 { ($1); }
	;

assertion_variable_declaration : data_type list_of_variable_identifiers SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	;

module_item : non_generic_port_declaration SEMICOLON { DOUBLE($1, SEMICOLON); }
	| non_port_module_item { ($1); }
	;

action_block : statement_or_null { ($1); }
	| action_block_4 ELSE statement_or_null { TRIPLE($1, ELSE, $3); }
	;

decimal_base : SQUOTE decimal_base_3 'D' { TRIPLE(SQUOTE, $2, CHAR 'D'); }
	| SQUOTE decimal_base_7 'D' { TRIPLE(SQUOTE, $2, CHAR 'D'); }
	;

enum_identifier : identifier { ($1); }
	;

named_task_proto : task_identifier LPAREN task_proto_formal named_task_proto_5 RPAREN { QUINTUPLE($1, LPAREN, $3, $4, RPAREN); }
	;

udp_nonansi_declaration : udp_nonansi_declaration_2 PRIMITIVE udp_identifier LPAREN udp_port_list RPAREN SEMICOLON { SEPTUPLE($1, PRIMITIVE, $3, LPAREN, $5, RPAREN, SEMICOLON); }
	;

port_reference : port_identifier port_reference_3 { DOUBLE($1, $2); }
	;

program_instance_identifier : identifier { ($1); }
	;

dot_star_port_connection : dot_star_port_connection_2 P_DOTSTAR { DOUBLE($1, P_DOTSTAR); }
	;

strength0 : SUPPLY0 { (SUPPLY0); }
	| STRONG0 { (STRONG0); }
	| PULL0 { (PULL0); }
	| WEAK0 { (WEAK0); }
	;

strength1 : SUPPLY1 { (SUPPLY1); }
	| STRONG1 { (STRONG1); }
	| PULL1 { (PULL1); }
	| WEAK1 { (WEAK1); }
	;

modport_item : modport_identifier LPAREN modport_ports_declaration modport_item_5 RPAREN { QUINTUPLE($1, LPAREN, $3, $4, RPAREN); }
	;

name_of_instance : module_instance_identifier name_of_instance_3 { DOUBLE($1, $2); }
	;

octal_number : octal_number_2 octal_base octal_value { TRIPLE($1, $2, $3); }
	;

event_identifier : identifier { ($1); }
	;

constant_function_call : function_identifier constant_function_call_3 constant_function_call_4 { TRIPLE($1, $2, $3); }
	;

casting_type : simple_type { ($1); }
	| number { ($1); }
	| signing { ($1); }
	;

variable_decl_assignment : variable_identifier variable_decl_assignment_3 variable_decl_assignment_4 { TRIPLE($1, $2, $3); }
	| variable_identifier LBRACK RBRACK EQUALS NEW LBRACK constant_expression RBRACK variable_decl_assignment_14 { NONUPLE($1, LBRACK, RBRACK, EQUALS, NEW, LBRACK, $7, RBRACK, $9); }
	| class_identifier variable_decl_assignment_17 EQUALS NEW variable_decl_assignment_20 { QUINTUPLE($1, $2, EQUALS, NEW, $5); }
	;

task_port_list : task_port_item task_port_list_3 { DOUBLE($1, $2); }
	| list_of_port_identifiers task_port_list_6 { DOUBLE($1, $2); }
	;

net_identifier : identifier { ($1); }
	;

conditional_expression : expression1 QUERY conditional_expression_4 expression2 COLON expression3 { SEXTUPLE($1, QUERY, $3, $4, COLON, $6); }
	;

tz1_path_delay_expression : path_delay_expression { ($1); }
	;

modport_hierarchical_ports_declaration : interface_instance_identifier modport_hierarchical_ports_declaration_3 DOT modport_identifier { QUADRUPLE($1, $2, DOT, $4); }
	;

function_conditional_statement : function_conditional_statement_2 IF LPAREN expression RPAREN function_statement_or_null function_conditional_statement_8 { SEPTUPLE($1, IF, LPAREN, $4, RPAREN, $6, $7); }
	| function_if_else_if_statement { ($1); }
	;

list_of_variable_decl_assignments : variable_decl_assignment list_of_variable_decl_assignments_3 { DOUBLE($1, $2); }
	;

list_of_variable_port_identifiers : port_identifier variable_dimension list_of_variable_port_identifiers_4 list_of_variable_port_identifiers_5 { QUADRUPLE($1, $2, $3, $4); }
	;

hierarchical_variable_identifier : hierarchical_identifier { ($1); }
	;

design_statement : DESIGN design_statement_3 SEMICOLON { TRIPLE(DESIGN, $2, SEMICOLON); }
	;

t_path_delay_expression : path_delay_expression { ($1); }
	;

formal_list_item : formal_identifier formal_list_item_3 { DOUBLE($1, $2); }
	;

system_timing_check : d_setup_timing_check { ($1); }
	| d_hold_timing_check { ($1); }
	| d_setuphold_timing_check { ($1); }
	| d_recovery_timing_check { ($1); }
	| d_removal_timing_check { ($1); }
	| d_recrem_timing_check { ($1); }
	| d_skew_timing_check { ($1); }
	| d_timeskew_timing_check { ($1); }
	| d_fullskew_timing_check { ($1); }
	| d_period_timing_check { ($1); }
	| d_width_timing_check { ($1); }
	| d_nochange_timing_check { ($1); }
	;

width_constant_expression : constant_expression { ($1); }
	;

generate_block_identifier : identifier { ($1); }
	;

list_of_port_declarations : LPAREN port_declaration list_of_port_declarations_4 RPAREN { QUADRUPLE(LPAREN, $2, $3, RPAREN); }
	| LPAREN RPAREN { DOUBLE(LPAREN, RPAREN); }
	;

dpi_function_proto : named_function_proto { ($1); }
	| dpi_function_proto_4 function_data_type function_identifier LPAREN list_of_dpi_proto_formals RPAREN { SEXTUPLE($1, $2, $3, LPAREN, $5, RPAREN); }
	;

clocking_decl : clocking_decl_2 CLOCKING clocking_decl_4 clocking_event SEMICOLON clocking_decl_7 ENDCLOCKING { SEPTUPLE($1, CLOCKING, $3, $4, SEMICOLON, $6, ENDCLOCKING); }
	;

dpi_dimension : variable_dimension { ($1); }
	| dpi_dimension_4 { ($1); }
	;

udp_output_declaration : udp_output_declaration_2 OUTPUT port_identifier { TRIPLE($1, OUTPUT, $3); }
	| udp_output_declaration_6 OUTPUT REG port_identifier udp_output_declaration_10 { QUINTUPLE($1, OUTPUT, REG, $4, $5); }
	;

full_path_description : LPAREN list_of_path_inputs full_path_description_4 P_ASTGT list_of_path_outputs RPAREN { SEXTUPLE(LPAREN, $2, $3, P_ASTGT, $5, RPAREN); }
	;

pass_enable_switch_instance : pass_enable_switch_instance_2 LPAREN inout_terminal COMMA inout_terminal COMMA enable_terminal RPAREN { OCTUPLE($1, LPAREN, $3, COMMA, $5, COMMA, $7, RPAREN); }
	;

parameter_declaration : PARAMETER parameter_declaration_3 parameter_declaration_4 parameter_declaration_5 list_of_param_assignments { QUINTUPLE(PARAMETER, $2, $3, $4, $5); }
	| PARAMETER data_type list_of_param_assignments { TRIPLE(PARAMETER, $2, $3); }
	| PARAMETER TYPE list_of_type_assignments { TRIPLE(PARAMETER, TYPE, $3); }
	;

config_rule_statement : default_clause liblist_clause { DOUBLE($1, $2); }
	| inst_clause liblist_clause { DOUBLE($1, $2); }
	| inst_clause use_clause { DOUBLE($1, $2); }
	| cell_clause liblist_clause { DOUBLE($1, $2); }
	| cell_clause use_clause { DOUBLE($1, $2); }
	;

type_assignment : type_identifier EQUALS data_type { TRIPLE($1, EQUALS, $3); }
	;

generate_interface_case_statement : CASE LPAREN constant_expression RPAREN genvar_interface_case_item generate_interface_case_statement_7 ENDCASE { SEPTUPLE(CASE, LPAREN, $3, RPAREN, $5, $6, ENDCASE); }
	;

generated_interface_instantiation : GENERATE generated_interface_instantiation_3 ENDGENERATE { TRIPLE(GENERATE, $2, ENDGENERATE); }
	;

list_of_net_decl_assignments : net_decl_assignment list_of_net_decl_assignments_3 { DOUBLE($1, $2); }
	;

input_port_identifier : identifier { ($1); }
	;

tx1_path_delay_expression : path_delay_expression { ($1); }
	;

n_input_gatetype : AND { (AND); }
	| NAND { (NAND); }
	| OR { (OR); }
	| NOR { (NOR); }
	| XOR { (XOR); }
	| XNOR { (XNOR); }
	;

modport_tf_port : TASK named_task_proto modport_tf_port_4 { TRIPLE(TASK, $2, $3); }
	| FUNCTION named_function_proto modport_tf_port_8 { TRIPLE(FUNCTION, $2, $3); }
	| task_or_function_identifier modport_tf_port_11 { DOUBLE($1, $2); }
	;

ncontrol_terminal : expression { ($1); }
	;

simple_hierarchical_branch : simple_identifier simple_hierarchical_branch_3 simple_hierarchical_branch_4 { TRIPLE($1, $2, $3); }
	;

latch_construct : ALWAYS statement { DOUBLE(ALWAYS, $2); }
	;

pass_en_switchtype : TRANIF0 { (TRANIF0); }
	| TRANIF1 { (TRANIF1); }
	| RTRANIF1 { (RTRANIF1); }
	| RTRANIF0 { (RTRANIF0); }
	;

procedural_timing_control : delay_control { ($1); }
	| event_control { ($1); }
	;

delay2 : HASH delay_value { DOUBLE(HASH, $2); }
	| HASH LPAREN mintypmax_expression delay2_8 RPAREN { QUINTUPLE(HASH, LPAREN, $3, $4, RPAREN); }
	;

class_declaration : class_declaration_2 class_declaration_3 CLASS class_declaration_5 class_identifier class_declaration_7 class_declaration_8 SEMICOLON class_declaration_10 class_declaration_11 ENDCLASS class_declaration_13 { DUODECUPLE($1, $2, CLASS, $4, $5, $6, $7, SEMICOLON, $9, $10, ENDCLASS, $12); }
	;

delay3 : HASH delay_value { DOUBLE(HASH, $2); }
	| HASH LPAREN mintypmax_expression delay3_8 RPAREN { QUINTUPLE(HASH, LPAREN, $3, $4, RPAREN); }
	;

inst_name : topmodule_identifier inst_name_3 { DOUBLE($1, $2); }
	;

non_integer_type : TIME { (TIME); }
	| SHORTREAL { (SHORTREAL); }
	| REAL { (REAL); }
	| REALTIME { (REALTIME); }
	;

list_of_dpi_proto_formals : list_of_dpi_proto_formals_2 { ($1); }
	;

t01_path_delay_expression : path_delay_expression { ($1); }
	;

binary_base : SQUOTE binary_base_3 'b' { TRIPLE(SQUOTE, $2, CHAR 'b'); }
	| SQUOTE binary_base_7 'B' { TRIPLE(SQUOTE, $2, CHAR 'B'); }
	;

simple_hierarchical_identifier : simple_hierarchical_branch simple_hierarchical_identifier_3 { DOUBLE($1, $2); }
	;

extern_method_declaration : FUNCTION extern_method_declaration_3 class_identifier P_COLONCOLON function_body_declaration { QUINTUPLE(FUNCTION, $2, $3, P_COLONCOLON, $5); }
	| TASK extern_method_declaration_9 class_identifier P_COLONCOLON task_body_declaration { QUINTUPLE(TASK, $2, $3, P_COLONCOLON, $5); }
	;

state_dependent_path_declaration : IF LPAREN module_path_expression RPAREN simple_path_declaration { QUINTUPLE(IF, LPAREN, $3, RPAREN, $5); }
	| IF LPAREN module_path_expression RPAREN edge_sensitive_path_declaration { QUINTUPLE(IF, LPAREN, $3, RPAREN, $5); }
	| IF_NONE simple_path_declaration { DOUBLE(IF_NONE, $2); }
	;

integer_vector_type : BIT { (BIT); }
	| LOGIC { (LOGIC); }
	| REG { (REG); }
	;

limit_value : constant_mintypmax_expression { ($1); }
	;

udp_instance : udp_instance_2 udp_instance_3 LPAREN output_terminal COMMA input_terminal udp_instance_8 RPAREN { OCTUPLE($1, $2, LPAREN, $4, COMMA, $6, $7, RPAREN); }
	;

module_ansi_header : module_ansi_header_2 module_keyword module_ansi_header_4 module_identifier module_ansi_header_6 module_ansi_header_7 SEMICOLON { SEPTUPLE($1, $2, $3, $4, $5, $6, SEMICOLON); }
	;

sequence_identifier : identifier { ($1); }
	;

inc_or_dec_expression : inc_or_dec_operator inc_or_dec_expression_3 variable_lvalue { TRIPLE($1, $2, $3); }
	| variable_lvalue inc_or_dec_expression_7 inc_or_dec_operator { TRIPLE($1, $2, $3); }
	;

unsigned_number : decimal_digit unsigned_number_3 { DOUBLE($1, $2); }
	;

config_identifier : identifier { ($1); }
	;

default_clause : DEFAULT { (DEFAULT); }
	;

named_parameter_assignment : DOT parameter_identifier LPAREN named_parameter_assignment_5 RPAREN { QUINTUPLE(DOT, $2, LPAREN, $4, RPAREN); }
	| DOT parameter_identifier LPAREN data_type RPAREN { QUINTUPLE(DOT, $2, LPAREN, $4, RPAREN); }
	;

statement_or_null : statement { ($1); }
	| statement_or_null_4 SEMICOLON { DOUBLE($1, SEMICOLON); }
	;

non_port_module_item : non_port_module_item_2 generated_module_instantiation { DOUBLE($1, $2); }
	| non_port_module_item_5 local_parameter_declaration { DOUBLE($1, $2); }
	| module_or_generate_item { ($1); }
	| non_port_module_item_10 parameter_declaration SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| non_port_module_item_14 specify_block { DOUBLE($1, $2); }
	| non_port_module_item_17 specparam_declaration { DOUBLE($1, $2); }
	| program_declaration { ($1); }
	| class_declaration { ($1); }
	| module_declaration { ($1); }
	;

task_port_item : task_port_item_2 tf_input_declaration { DOUBLE($1, $2); }
	| task_port_item_5 tf_output_declaration { DOUBLE($1, $2); }
	| task_port_item_8 tf_inout_declaration { DOUBLE($1, $2); }
	| task_port_item_11 tf_ref_declaration SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| task_port_item_15 port_type list_of_tf_port_identifiers { TRIPLE($1, $2, $3); }
	| task_port_item_19 tf_data_type list_of_tf_variable_identifiers { TRIPLE($1, $2, $3); }
	;

clocking_event : AT identifier { DOUBLE(AT, $2); }
	| AT LPAREN event_expression RPAREN { QUADRUPLE(AT, LPAREN, $3, RPAREN); }
	;

identifier : simple_identifier { ($1); }
	| escaped_identifier { ($1); }
	;

time_unit : 'S' { (CHAR 'S'); }
	| MS { ($1); }
	| US { ($1); }
	| NS { ($1); }
	| PS { ($1); }
	| FS { ($1); }
	| STEP { (STEP); }
	;

delayed_data : terminal_identifier { ($1); }
	| terminal_identifier LBRACK constant_mintypmax_expression RBRACK { QUADRUPLE($1, LBRACK, $3, RBRACK); }
	;

input_terminal : expression { ($1); }
	;

array_member_label : DEFAULT { (DEFAULT); }
	| type_identifier { ($1); }
	| constant_expression { ($1); }
	;

tf_data_type : data_type { ($1); }
	| CHANDLE { (CHANDLE); }
	;

variable_dimension : variable_dimension_2 { ($1); }
	| LBRACK RBRACK { DOUBLE(LBRACK, RBRACK); }
	| associative_dimension { ($1); }
	;

d_setuphold_timing_check : D_SETUPHOLD LPAREN reference_event COMMA data_event COMMA timing_check_limit COMMA timing_check_limit d_setuphold_timing_check_11 RPAREN SEMICOLON { DUODECUPLE(D_SETUPHOLD, LPAREN, $3, COMMA, $5, COMMA, $7, COMMA, $9, $10, RPAREN, SEMICOLON); }
	;

genvar_interface_case_item : constant_expression genvar_interface_case_item_3 COLON generate_interface_item { QUADRUPLE($1, $2, COLON, $4); }
	| DEFAULT genvar_interface_case_item_8 generate_interface_item { TRIPLE(DEFAULT, $2, $3); }
	;

variable_declaration : variable_declaration_2 data_type list_of_variable_identifiers_or_assignments SEMICOLON { QUADRUPLE($1, $2, $3, SEMICOLON); }
	;

list_of_variable_identifiers_or_assignments : list_of_variable_decl_assignments { ($1); }
	| list_of_variable_identifiers { ($1); }
	;

topmodule_identifier : identifier { ($1); }
	;

port_identifier : identifier { ($1); }
	;

white_space : SPACE { (SPACE); }
	| TAB { (TAB); }
	| NEWLINE { (NEWLINE); }
	| EOF { (EOF); }
	;

hierarchical_block_identifier : hierarchical_identifier { ($1); }
	;

concurrent_assertion_item : concurrent_assert_statement { ($1); }
	| concurrent_cover_statement { ($1); }
	| concurrent_assertion_item_declaration { ($1); }
	;

function_statement_or_null : function_statement { ($1); }
	| function_statement_or_null_4 SEMICOLON { DOUBLE($1, SEMICOLON); }
	;

number : decimal_number { ($1); }
	| octal_number { ($1); }
	| binary_number { ($1); }
	| hex_number { ($1); }
	| real_number { ($1); }
	;

goto_repetition : TOKEN_349 const_or_range_expression RBRACK { TRIPLE(TOKEN_349, $2, RBRACK); }
	;

scalar_timing_check_condition : expression { ($1); }
	| TILDE expression { DOUBLE(TILDE, $2); }
	| expression P_EQUAL scalar_constant { TRIPLE($1, P_EQUAL, $3); }
	| expression P_CASEEQUAL scalar_constant { TRIPLE($1, P_CASEEQUAL, $3); }
	| expression P_NOTEQUAL scalar_constant { TRIPLE($1, P_NOTEQUAL, $3); }
	| expression P_CASENOTEQUAL scalar_constant { TRIPLE($1, P_CASENOTEQUAL, $3); }
	;

module_instantiation : module_identifier module_instantiation_3 module_instance module_instantiation_5 SEMICOLON { QUINTUPLE($1, $2, $3, $4, SEMICOLON); }
	;

ref_declaration : REF data_type list_of_port_identifiers { TRIPLE(REF, $2, $3); }
	;

dimension_constant_expression : constant_expression { ($1); }
	;

unique_priority : UNIQUE { (UNIQUE); }
	| PRIORITY { (PRIORITY); }
	;

timing_check_condition : scalar_timing_check_condition { ($1); }
	| LPAREN scalar_timing_check_condition RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

ordered_port_connection : ordered_port_connection_2 ordered_port_connection_3 { DOUBLE($1, $2); }
	;

combinational_construct : ALWAYS statement { DOUBLE(ALWAYS, $2); }
	;

if_else_if_statement : if_else_if_statement_2 IF LPAREN expression RPAREN statement_or_null if_else_if_statement_8 if_else_if_statement_9 { OCTUPLE($1, IF, LPAREN, $4, RPAREN, $6, $7, $8); }
	;

generate_interface_named_block : BEGIN COLON generate_block_identifier generate_interface_named_block_5 END generate_interface_named_block_7 { SEXTUPLE(BEGIN, COLON, $3, $4, END, $6); }
	| generate_block_identifier COLON generate_interface_block { TRIPLE($1, COLON, $3); }
	;

function_if_else_if_statement : function_if_else_if_statement_2 IF LPAREN expression RPAREN function_statement_or_null function_if_else_if_statement_8 function_if_else_if_statement_9 { OCTUPLE($1, IF, LPAREN, $4, RPAREN, $6, $7, $8); }
	;

function_case_item : expression function_case_item_3 COLON function_statement_or_null { QUADRUPLE($1, $2, COLON, $4); }
	| DEFAULT function_case_item_8 function_statement_or_null { TRIPLE(DEFAULT, $2, $3); }
	;

library_declaration : LIBRARY library_identifier file_path_spec library_declaration_5 library_declaration_6 SEMICOLON { SEXTUPLE(LIBRARY, $2, $3, $4, $5, SEMICOLON); }
	;

clocked_sequence : clocking_event sequence_expr { DOUBLE($1, $2); }
	;

class_constraint : constraint_prototype { ($1); }
	| constraint_declaration { ($1); }
	;

modport_declaration : MODPORT modport_item modport_declaration_4 SEMICOLON { QUADRUPLE(MODPORT, $2, $3, SEMICOLON); }
	;

path_delay_value : list_of_path_delay_expressions { ($1); }
	| LPAREN list_of_path_delay_expressions RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

hex_digit : x_digit { ($1); }
	| z_digit { ($1); }
	| TOKEN_436 { (TOKEN_436); }
	| TOKEN_435 { (TOKEN_435); }
	| TOKEN_687 { (TOKEN_687); }
	| TOKEN_688 { (TOKEN_688); }
	| TOKEN_689 { (TOKEN_689); }
	| TOKEN_690 { (TOKEN_690); }
	| TOKEN_691 { (TOKEN_691); }
	| TOKEN_639 { (TOKEN_639); }
	| TOKEN_272 { (TOKEN_272); }
	| TOKEN_266 { (TOKEN_266); }
	| 'A' { (CHAR 'A'); }
	| 'b' { (CHAR 'b'); }
	| 'C' { (CHAR 'C'); }
	| 'd' { (CHAR 'd'); }
	| 'e' { (CHAR 'e'); }
	| 'f' { (CHAR 'f'); }
	| 'A' { (CHAR 'A'); }
	| 'B' { (CHAR 'B'); }
	| 'C' { (CHAR 'C'); }
	| 'D' { (CHAR 'D'); }
	| 'E' { (CHAR 'E'); }
	| 'F' { (CHAR 'F'); }
	;

input_declaration : INPUT input_declaration_3 list_of_port_identifiers { TRIPLE(INPUT, $2, $3); }
	| INPUT data_type list_of_variable_identifiers { TRIPLE(INPUT, $2, $3); }
	;

tzx_path_delay_expression : path_delay_expression { ($1); }
	;

parallel_path_description : LPAREN specify_input_terminal_descriptor parallel_path_description_4 P_EQGT specify_output_terminal_descriptor RPAREN { SEXTUPLE(LPAREN, $2, $3, P_EQGT, $5, RPAREN); }
	;

local_parameter_declaration : LOCALPARAM local_parameter_declaration_3 local_parameter_declaration_4 local_parameter_declaration_5 list_of_param_assignments SEMICOLON { SEXTUPLE(LOCALPARAM, $2, $3, $4, $5, SEMICOLON); }
	| LOCALPARAM data_type list_of_param_assignments SEMICOLON { QUADRUPLE(LOCALPARAM, $2, $3, SEMICOLON); }
	;

event_control : AT event_identifier { DOUBLE(AT, $2); }
	| AT LPAREN event_expression RPAREN { QUADRUPLE(AT, LPAREN, $3, RPAREN); }
	| TOKEN_500 { (TOKEN_500); }
	| AT TOKEN_501 { DOUBLE(AT, TOKEN_501); }
	;

function_item_declaration : block_item_declaration { ($1); }
	| function_item_declaration_4 tf_input_declaration SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| function_item_declaration_8 tf_output_declaration SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| function_item_declaration_12 tf_inout_declaration SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| function_item_declaration_16 tf_ref_declaration SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	;

constraint_expression : expression SEMICOLON { DOUBLE($1, SEMICOLON); }
	| expression P_EQGT constraint_set { TRIPLE($1, P_EQGT, $3); }
	| IF LPAREN expression RPAREN constraint_set constraint_expression_14 { SEXTUPLE(IF, LPAREN, $3, RPAREN, $5, $6); }
	;

lsb_constant_expression : constant_expression { ($1); }
	;

udp_ansi_declaration : udp_ansi_declaration_2 PRIMITIVE udp_identifier LPAREN udp_declaration_port_list RPAREN SEMICOLON { SEPTUPLE($1, PRIMITIVE, $3, LPAREN, $5, RPAREN, SEMICOLON); }
	;

specparam_assignment : specparam_identifier EQUALS constant_mintypmax_expression { TRIPLE($1, EQUALS, $3); }
	| pulse_control_specparam { ($1); }
	;

dpi_import_property : CONTEXT { (CONTEXT); }
	| PURE { (PURE); }
	;

next_state : output_symbol { ($1); }
	| MINUS { (MINUS); }
	;

trise_path_delay_expression : path_delay_expression { ($1); }
	;

clockvar_expression : clockvar range { DOUBLE($1, $2); }
	| clockvar LBRACK range_expression RBRACK { QUADRUPLE($1, LBRACK, $3, RBRACK); }
	;

x_digit : 'x' { (CHAR 'x'); }
	| 'X' { (CHAR 'X'); }
	;

dist_list : dist_item dist_list_3 { DOUBLE($1, $2); }
	;

lifetime : STATIC { (STATIC); }
	| AUTOMATIC { (AUTOMATIC); }
	;

net_lvalue : hierarchical_net_identifier net_lvalue_3 net_lvalue_4 { TRIPLE($1, $2, $3); }
	| LCURLY net_lvalue net_lvalue_8 RCURLY { QUADRUPLE(LCURLY, $2, $3, RCURLY); }
	;

notify_reg : variable_identifier { ($1); }
	;

gate_instance_identifier : identifier { ($1); }
	;

modport_tf_ports_declaration : import_export modport_tf_port { DOUBLE($1, $2); }
	;

generate_interface_block : BEGIN generate_interface_block_3 generate_interface_block_4 END generate_interface_block_6 { QUINTUPLE(BEGIN, $2, $3, END, $5); }
	;

path_delay_expression : constant_mintypmax_expression { ($1); }
	;

generic_interface_port_declaration : INTERFACE list_of_interface_identifiers { DOUBLE(INTERFACE, $2); }
	| INTERFACE DOT modport_identifier list_of_interface_identifiers { QUADRUPLE(INTERFACE, DOT, $3, $4); }
	;

disable_statement : DISABLE hierarchical_task_identifier SEMICOLON { TRIPLE(DISABLE, $2, SEMICOLON); }
	| DISABLE hierarchical_block_identifier SEMICOLON { TRIPLE(DISABLE, $2, SEMICOLON); }
	| DISABLE FORK SEMICOLON { TRIPLE(DISABLE, FORK, SEMICOLON); }
	;

list_of_genvar_identifiers : genvar_identifier list_of_genvar_identifiers_3 { DOUBLE($1, $2); }
	;

t1x_path_delay_expression : path_delay_expression { ($1); }
	;

binary_operator : PLUS { (PLUS); }
	| MINUS { (MINUS); }
	| TIMES { (TIMES); }
	| DIVIDE { (DIVIDE); }
	| MODULO { (MODULO); }
	| P_EQUAL { (P_EQUAL); }
	| P_NOTEQUAL { (P_NOTEQUAL); }
	| P_CASEEQUAL { (P_CASEEQUAL); }
	| P_CASENOTEQUAL { (P_CASENOTEQUAL); }
	| TOKEN_649 { (TOKEN_649); }
	| TOKEN_650 { (TOKEN_650); }
	| P_ANDAND { (P_ANDAND); }
	| TOKEN_651 { (TOKEN_651); }
	| P_POW { (P_POW); }
	| LESS { (LESS); }
	| P_LTE { (P_LTE); }
	| GREATER { (GREATER); }
	| P_GTE { (P_GTE); }
	| AMPERSAND { (AMPERSAND); }
	| VBAR { (VBAR); }
	| CARET { (CARET); }
	| P_XNOR { (P_XNOR); }
	| P_XNOR { (P_XNOR); }
	| P_SRIGHT { (P_SRIGHT); }
	| P_SLEFT { (P_SLEFT); }
	| P_SSRIGHT { (P_SSRIGHT); }
	| P_SLEFT { (P_SLEFT); }
	;

cover_property_statement : COVER PROPERTY LPAREN property_spec RPAREN statement_or_null { SEXTUPLE(COVER, PROPERTY, LPAREN, $4, RPAREN, $6); }
	| COVER PROPERTY LPAREN property_instance RPAREN statement_or_null { SEXTUPLE(COVER, PROPERTY, LPAREN, $4, RPAREN, $6); }
	;

pcontrol_terminal : expression { ($1); }
	;

property_instance : property_identifier property_instance_3 { DOUBLE($1, $2); }
	;

genvar_module_case_item : constant_expression genvar_module_case_item_3 COLON generate_module_item { QUADRUPLE($1, $2, COLON, $4); }
	| DEFAULT genvar_module_case_item_8 generate_module_item { TRIPLE(DEFAULT, $2, $3); }
	;

non_consecutive_repetition : TOKEN_348 const_or_range_expression RBRACK { TRIPLE(TOKEN_348, $2, RBRACK); }
	;

edge_control_specifier : EDGE LBRACK edge_descriptor edge_control_specifier_5 RBRACK { QUINTUPLE(EDGE, LBRACK, $3, $4, RBRACK); }
	;

cell_identifier : identifier { ($1); }
	;

parameter_override : DEFPARAM list_of_defparam_assignments SEMICOLON { TRIPLE(DEFPARAM, $2, SEMICOLON); }
	;

output_identifier : output_port_identifier { ($1); }
	| inout_port_identifier { ($1); }
	;

property_expr : sequence_expr { ($1); }
	| sequence_expr TOKEN_327 property_expr_6 sequence_expr { QUADRUPLE($1, TOKEN_327, $3, $4); }
	| sequence_expr TOKEN_328 property_expr_11 sequence_expr { QUADRUPLE($1, TOKEN_328, $3, $4); }
	| LPAREN property_expr RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

cell_clause : CELL cell_clause_3 cell_identifier { TRIPLE(CELL, $2, $3); }
	;

function_seq_block : BEGIN function_seq_block_3 function_seq_block_4 END function_seq_block_6 { QUINTUPLE(BEGIN, $2, $3, END, $5); }
	;

net_decl_assignment : net_identifier EQUALS expression { TRIPLE($1, EQUALS, $3); }
	;

t0x_path_delay_expression : path_delay_expression { ($1); }
	;

concurrent_cover_statement : concurrent_cover_statement_2 cover_property_statement { DOUBLE($1, $2); }
	;

hierarchical_parameter_identifier : hierarchical_identifier { ($1); }
	;

list_of_specparam_assignments : specparam_assignment list_of_specparam_assignments_3 { DOUBLE($1, $2); }
	;

one_line_comment : TOKEN_704 comment_text TOKEN_601 { TRIPLE(TOKEN_704, $2, TOKEN_601); }
	;

type_identifier : identifier { ($1); }
	;

module_instance : name_of_instance LPAREN module_instance_4 RPAREN { QUADRUPLE($1, LPAREN, $3, RPAREN); }
	;

file_path_spec : FILE_PATH { (FILE_PATH); }
	;

system_task_identifier : DOLLAR system_task_identifier_3 { DOUBLE(DOLLAR, $2); }
	;

base_expression : expression { ($1); }
	;

constant_range_expression : constant_expression { ($1); }
	| msb_constant_expression COLON lsb_constant_expression { TRIPLE($1, COLON, $3); }
	| constant_base_expression P_PLUSCOLON width_constant_expression { TRIPLE($1, P_PLUSCOLON, $3); }
	| constant_base_expression P_MINUSCOLON width_constant_expression { TRIPLE($1, P_MINUSCOLON, $3); }
	;

text_macro_identifier : simple_identifier { ($1); }
	;

bind_directive : BIND module_identifier bind_instantiation SEMICOLON { QUADRUPLE(BIND, $2, $3, SEMICOLON); }
	| BIND name_of_instance bind_instantiation SEMICOLON { QUADRUPLE(BIND, $2, $3, SEMICOLON); }
	;

struct_union_member : struct_union_member_2 data_type list_of_variable_identifiers_or_assignments SEMICOLON { QUADRUPLE($1, $2, $3, SEMICOLON); }
	;

packed_dimension : LBRACK dimension_constant_expression COLON dimension_constant_expression RBRACK { QUINTUPLE(LBRACK, $2, COLON, $4, RBRACK); }
	| LBRACK RBRACK { DOUBLE(LBRACK, RBRACK); }
	;

parameter_port_list : HASH LPAREN parameter_declaration parameter_port_list_5 RPAREN { QUINTUPLE(HASH, LPAREN, $3, $4, RPAREN); }
	;

comment : one_line_comment { ($1); }
	| block_comment { ($1); }
	;

input_identifier : input_port_identifier { ($1); }
	| inout_port_identifier { ($1); }
	;

library_descriptions : library_declaration { ($1); }
	| include_statement { ($1); }
	| config_declaration { ($1); }
	;

module_instance_identifier : identifier { ($1); }
	;

const_assignment : const_identifier EQUALS constant_expression { TRIPLE($1, EQUALS, $3); }
	;

hex_number : hex_number_2 hex_base hex_value { TRIPLE($1, $2, $3); }
	;

task_body_declaration : task_body_declaration_2 task_identifier SEMICOLON task_body_declaration_5 task_body_declaration_6 ENDTASK task_body_declaration_8 { SEPTUPLE($1, $2, SEMICOLON, $4, $5, ENDTASK, $7); }
	| task_body_declaration_10 task_identifier LPAREN task_port_list RPAREN SEMICOLON task_body_declaration_16 task_body_declaration_17 ENDTASK task_body_declaration_19 { DECUPLE($1, $2, LPAREN, $4, RPAREN, SEMICOLON, $7, $8, ENDTASK, $10); }
	;

octal_value : octal_digit octal_value_3 { DOUBLE($1, $2); }
	;

value_range : expression { ($1); }
	| LBRACK expression COLON expression RBRACK { QUINTUPLE(LBRACK, $2, COLON, $4, RBRACK); }
	;

sequence_instance : sequence_identifier sequence_instance_3 { DOUBLE($1, $2); }
	;

inst_clause : INSTANCE inst_name { DOUBLE(INSTANCE, $2); }
	;

udp_port_declaration : udp_output_declaration SEMICOLON { DOUBLE($1, SEMICOLON); }
	| udp_input_declaration SEMICOLON { DOUBLE($1, SEMICOLON); }
	| udp_reg_declaration SEMICOLON { DOUBLE($1, SEMICOLON); }
	;

interface_instantiation : interface_identifier interface_instantiation_3 module_instance interface_instantiation_5 SEMICOLON { QUINTUPLE($1, $2, $3, $4, SEMICOLON); }
	;

dist_item : value_range P_COLONEQ expression { TRIPLE($1, P_COLONEQ, $3); }
	| value_range P_COLONDIV expression { TRIPLE($1, P_COLONDIV, $3); }
	;

system_task_enable : system_task_identifier system_task_enable_3 SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	;

instance_identifier : identifier { ($1); }
	;

hierarchical_function_identifier : hierarchical_identifier { ($1); }
	;

extern_constraint_declaration : extern_constraint_declaration_2 CONSTRAINT class_identifier P_COLONCOLON constraint_identifier LCURLY extern_constraint_declaration_8 RCURLY { OCTUPLE($1, CONSTRAINT, $3, P_COLONCOLON, $5, LCURLY, $7, RCURLY); }
	;

ff_construct : ALWAYS statement { DOUBLE(ALWAYS, $2); }
	;

function_port_list : function_port_item function_port_list_3 { DOUBLE($1, $2); }
	;

method_prototype : TASK named_task_proto SEMICOLON { TRIPLE(TASK, $2, SEMICOLON); }
	| FUNCTION named_function_proto SEMICOLON { TRIPLE(FUNCTION, $2, SEMICOLON); }
	;

defparam_assignment : hierarchical_parameter_identifier EQUALS constant_expression { TRIPLE($1, EQUALS, $3); }
	;

tf_ref_declaration : tf_ref_declaration_2 REF tf_data_type list_of_tf_variable_identifiers { QUADRUPLE($1, REF, $3, $4); }
	;

dot_named_port_connection : dot_named_port_connection_2 DOT port_identifier { TRIPLE($1, DOT, $3); }
	| named_port_connection { ($1); }
	;

class_method : class_method_2 task_declaration { DOUBLE($1, $2); }
	| class_method_5 function_declaration { DOUBLE($1, $2); }
	| EXTERN class_method_9 method_prototype { TRIPLE(EXTERN, $2, $3); }
	;

mos_switchtype : NMOS { (NMOS); }
	| PMOS { (PMOS); }
	| RNMOS { (RNMOS); }
	| RPMOS { (RPMOS); }
	;

constraint_block : SOLVE identifier_list BEFORE identifier_list SEMICOLON { QUINTUPLE(SOLVE, $2, BEFORE, $4, SEMICOLON); }
	| expression DIST LCURLY dist_list RCURLY SEMICOLON { SEXTUPLE($1, DIST, LCURLY, $4, RCURLY, SEMICOLON); }
	| constraint_expression { ($1); }
	;

udp_declaration : udp_declaration_2 PRIMITIVE udp_identifier LPAREN udp_port_list RPAREN SEMICOLON udp_port_declaration udp_declaration_10 udp_body ENDPRIMITIVE { UNDECUPLE($1, PRIMITIVE, $3, LPAREN, $5, RPAREN, SEMICOLON, $8, $9, $10, ENDPRIMITIVE); }
	| udp_declaration_14 PRIMITIVE udp_identifier LPAREN udp_declaration_port_list RPAREN SEMICOLON udp_body ENDPRIMITIVE { NONUPLE($1, PRIMITIVE, $3, LPAREN, $5, RPAREN, SEMICOLON, $8, ENDPRIMITIVE); }
	;

udp_declaration : udp_nonansi_declaration udp_port_declaration udp_declaration_4 udp_body ENDPRIMITIVE udp_declaration_7 { SEXTUPLE($1, $2, $3, $4, ENDPRIMITIVE, $6); }
	| udp_ansi_declaration udp_body ENDPRIMITIVE udp_declaration_12 { QUADRUPLE($1, $2, ENDPRIMITIVE, $4); }
	| EXTERN udp_nonansi_declaration { DOUBLE(EXTERN, $2); }
	| EXTERN udp_ansi_declaration { DOUBLE(EXTERN, $2); }
	| udp_declaration_20 PRIMITIVE udp_identifier LPAREN P_DOTSTAR RPAREN SEMICOLON udp_declaration_27 udp_body ENDPRIMITIVE udp_declaration_30 { UNDECUPLE($1, PRIMITIVE, $3, LPAREN, P_DOTSTAR, RPAREN, SEMICOLON, $8, $9, ENDPRIMITIVE, $11); }
	;

variable_assignment : operator_assignment { ($1); }
	| inc_or_dec_expression { ($1); }
	;

concurrent_assertion_item_declaration : property_declaration { ($1); }
	| sequence_declaration { ($1); }
	;

multiple_concatenation : LCURLY constant_expression concatenation RCURLY { QUADRUPLE(LCURLY, $2, $3, RCURLY); }
	;

genvar_decl_assignment : genvar_decl_assignment_2 genvar_identifier EQUALS constant_expression { QUADRUPLE($1, $2, EQUALS, $4); }
	;

module_declaration : module_nonansi_header module_declaration_3 module_declaration_4 ENDMODULE module_declaration_6 { QUINTUPLE($1, $2, $3, ENDMODULE, $5); }
	| module_ansi_header module_declaration_9 module_declaration_10 ENDMODULE module_declaration_12 { QUINTUPLE($1, $2, $3, ENDMODULE, $5); }
	| module_declaration_14 module_keyword module_declaration_16 module_identifier LPAREN P_DOTSTAR RPAREN SEMICOLON module_declaration_22 module_declaration_23 ENDMODULE module_declaration_25 { DUODECUPLE($1, $2, $3, $4, LPAREN, P_DOTSTAR, RPAREN, SEMICOLON, $9, $10, ENDMODULE, $12); }
	| EXTERN module_nonansi_header { DOUBLE(EXTERN, $2); }
	| EXTERN module_ansi_header { DOUBLE(EXTERN, $2); }
	;

non_port_interface_item : non_port_interface_item_2 generated_interface_instantiation { DOUBLE($1, $2); }
	| non_port_interface_item_5 specparam_declaration { DOUBLE($1, $2); }
	| interface_or_generate_item { ($1); }
	| program_declaration { ($1); }
	| class_declaration { ($1); }
	| interface_declaration { ($1); }
	;

non_port_program_item : non_port_program_item_2 continuous_assign { DOUBLE($1, $2); }
	| non_port_program_item_5 module_or_generate_item_declaration { DOUBLE($1, $2); }
	| non_port_program_item_8 specparam_declaration { DOUBLE($1, $2); }
	| non_port_program_item_11 local_parameter_declaration { DOUBLE($1, $2); }
	| non_port_program_item_14 parameter_declaration SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| non_port_program_item_18 initial_construct { DOUBLE($1, $2); }
	| non_port_program_item_21 concurrent_assertion_item { DOUBLE($1, $2); }
	| class_declaration { ($1); }
	;

generate_module_item : generate_module_conditional_statement { ($1); }
	| generate_module_case_statement { ($1); }
	| generate_module_loop_statement { ($1); }
	| generate_module_item_8 generate_module_block { DOUBLE($1, $2); }
	| module_or_generate_item { ($1); }
	;

msb_constant_expression : constant_expression { ($1); }
	;

block_variable_declaration : block_variable_declaration_2 data_type list_of_variable_identifiers SEMICOLON { QUADRUPLE($1, $2, $3, SEMICOLON); }
	| lifetime data_type list_of_variable_decl_assignments SEMICOLON { QUADRUPLE($1, $2, $3, SEMICOLON); }
	;

statement_item : statement_item_2 blocking_assignment SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| statement_item_6 nonblocking_assignment SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| statement_item_10 procedural_continuous_assignments SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| statement_item_14 case_statement { DOUBLE($1, $2); }
	| statement_item_17 conditional_statement { DOUBLE($1, $2); }
	| statement_item_20 inc_or_dec_expression SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| statement_item_24 function_call SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| statement_item_28 disable_statement { DOUBLE($1, $2); }
	| statement_item_31 event_trigger { DOUBLE($1, $2); }
	| statement_item_34 loop_statement { DOUBLE($1, $2); }
	| statement_item_37 jump_statement { DOUBLE($1, $2); }
	| statement_item_40 par_block { DOUBLE($1, $2); }
	| statement_item_43 procedural_timing_control_statement { DOUBLE($1, $2); }
	| statement_item_46 seq_block { DOUBLE($1, $2); }
	| statement_item_49 system_task_enable { DOUBLE($1, $2); }
	| statement_item_52 task_enable { DOUBLE($1, $2); }
	| statement_item_55 wait_statement { DOUBLE($1, $2); }
	| statement_item_58 procedural_assertion_item { DOUBLE($1, $2); }
	| statement_item_61 clocking_drive { DOUBLE($1, $2); }
	;

module_nonansi_header : module_nonansi_header_2 module_keyword module_nonansi_header_4 module_identifier module_nonansi_header_6 list_of_ports SEMICOLON { SEPTUPLE($1, $2, $3, $4, $5, $6, SEMICOLON); }
	;

inout_port_identifier : identifier { ($1); }
	;

d_width_timing_check : D_WIDTH LPAREN controlled_reference_event COMMA timing_check_limit COMMA threshold d_width_timing_check_9 RPAREN SEMICOLON { DECUPLE(D_WIDTH, LPAREN, $3, COMMA, $5, COMMA, $7, $8, RPAREN, SEMICOLON); }
	;

list_of_defparam_assignments : defparam_assignment list_of_defparam_assignments_3 { DOUBLE($1, $2); }
	;

property_spec : property_spec_2 property_spec_3 LPAREN expression RPAREN property_spec_7 property_expr { SEPTUPLE($1, $2, LPAREN, $4, RPAREN, $6, $7); }
	| property_spec_10 property_spec_11 multi_clock_property_expr { TRIPLE($1, $2, $3); }
	;

range : LBRACK msb_constant_expression COLON lsb_constant_expression RBRACK { QUINTUPLE(LBRACK, $2, COLON, $4, RBRACK); }
	;

name_of_gate_instance : gate_instance_identifier name_of_gate_instance_3 { DOUBLE($1, $2); }
	;

charge_strength : LPAREN SMALL RPAREN { TRIPLE(LPAREN, SMALL, RPAREN); }
	| LPAREN MEDIUM RPAREN { TRIPLE(LPAREN, MEDIUM, RPAREN); }
	| LPAREN LARGE RPAREN { TRIPLE(LPAREN, LARGE, RPAREN); }
	;

list_of_clocking_decl_assign : clocking_decl_assign list_of_clocking_decl_assign_3 { DOUBLE($1, $2); }
	;

function_declaration : FUNCTION function_declaration_3 function_body_declaration { TRIPLE(FUNCTION, $2, $3); }
	;

comment_text : comment_text_2 { ($1); }
	;

program_nonansi_header : program_nonansi_header_2 PROGRAM program_nonansi_header_4 program_identifier program_nonansi_header_6 list_of_ports SEMICOLON { SEPTUPLE($1, PROGRAM, $3, $4, $5, $6, SEMICOLON); }
	;

interface_ansi_header : interface_ansi_header_2 INTERFACE interface_ansi_header_4 interface_identifier interface_ansi_header_6 interface_ansi_header_7 SEMICOLON { SEPTUPLE($1, INTERFACE, $3, $4, $5, $6, SEMICOLON); }
	;

const_or_range_expression : constant_expression { ($1); }
	| cycle_delay_const_range_expression { ($1); }
	;

method_identifier : identifier { ($1); }
	;

wait_statement : WAIT LPAREN expression RPAREN statement_or_null { QUINTUPLE(WAIT, LPAREN, $3, RPAREN, $5); }
	| WAIT FORK SEMICOLON { TRIPLE(WAIT, FORK, SEMICOLON); }
	| WAIT_ORDER LPAREN hierarchical_identifier wait_statement_15 RPAREN action_block { SEXTUPLE(WAIT_ORDER, LPAREN, $3, $4, RPAREN, $6); }
	;

source_text : source_text_2 source_text_3 { DOUBLE($1, $2); }
	;

seq_input_list : level_input_list { ($1); }
	| edge_input_list { ($1); }
	;

final_construct : FINAL function_statement { DOUBLE(FINAL, $2); }
	;

primary : number { ($1); }
	| implicit_class_handle hierarchical_identifier primary_6 primary_7 primary_8 { QUINTUPLE($1, $2, $3, $4, $5); }
	| concatenation { ($1); }
	| multiple_concatenation { ($1); }
	| function_call { ($1); }
	| system_function_call { ($1); }
	| constant_function_call { ($1); }
	| class_identifier P_COLONCOLON primary_22 identifier { QUADRUPLE($1, P_COLONCOLON, $3, $4); }
	| LPAREN mintypmax_expression RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	| casting_type SQUOTE LPAREN expression RPAREN { QUINTUPLE($1, SQUOTE, LPAREN, $4, RPAREN); }
	| VOID SQUOTE LPAREN function_call RPAREN { QUINTUPLE(VOID, SQUOTE, LPAREN, $4, RPAREN); }
	| casting_type SQUOTE concatenation { TRIPLE($1, SQUOTE, $3); }
	| casting_type SQUOTE multiple_concatenation { TRIPLE($1, SQUOTE, $3); }
	| time_literal { ($1); }
	| TOKEN_631 { (TOKEN_631); }
	| TOKEN_632 { (TOKEN_632); }
	| TOKEN_633 { (TOKEN_633); }
	| TOKEN_634 { (TOKEN_634); }
	| TOKEN_635 { (TOKEN_635); }
	| TOKEN_636 { (TOKEN_636); }
	| NULL { (NULL); }
	;

escaped_identifier : TOKEN_718 TOKEN_719 white_space { TRIPLE(TOKEN_718, TOKEN_719, $3); }
	;

escaped_hierarchical_branch : escaped_identifier escaped_hierarchical_branch_3 escaped_hierarchical_branch_4 { TRIPLE($1, $2, $3); }
	;

non_zero_unsigned_number : non_zero_decimal_digit non_zero_unsigned_number_3 { DOUBLE($1, $2); }
	;

udp_instantiation : udp_identifier udp_instantiation_3 udp_instantiation_4 udp_instance udp_instantiation_6 SEMICOLON { SEXTUPLE($1, $2, $3, $4, $5, SEMICOLON); }
	;

sequential_body : sequential_body_2 TABLE sequential_entry sequential_body_5 ENDTABLE { QUINTUPLE($1, TABLE, $3, $4, ENDTABLE); }
	;

net_declaration : net_type net_declaration_3 net_declaration_4 list_of_net_identifiers SEMICOLON { QUINTUPLE($1, $2, $3, $4, SEMICOLON); }
	| net_type net_declaration_9 net_declaration_10 net_declaration_11 list_of_net_decl_assignments SEMICOLON { SEXTUPLE($1, $2, $3, $4, $5, SEMICOLON); }
	| net_type net_declaration_16 net_declaration_17 net_declaration_18 range net_declaration_20 list_of_net_identifiers SEMICOLON { OCTUPLE($1, $2, $3, $4, $5, $6, $7, SEMICOLON); }
	| net_type net_declaration_25 net_declaration_26 net_declaration_27 net_declaration_28 range net_declaration_30 list_of_net_decl_assignments SEMICOLON { NONUPLE($1, $2, $3, $4, $5, $6, $7, $8, SEMICOLON); }
	| TRIREG net_declaration_35 net_declaration_36 net_declaration_37 list_of_net_identifiers SEMICOLON { SEXTUPLE(TRIREG, $2, $3, $4, $5, SEMICOLON); }
	| TRIREG net_declaration_42 net_declaration_43 net_declaration_44 list_of_net_decl_assignments SEMICOLON { SEXTUPLE(TRIREG, $2, $3, $4, $5, SEMICOLON); }
	| TRIREG net_declaration_49 net_declaration_50 net_declaration_51 net_declaration_52 range net_declaration_54 list_of_net_identifiers SEMICOLON { NONUPLE(TRIREG, $2, $3, $4, $5, $6, $7, $8, SEMICOLON); }
	| TRIREG net_declaration_59 net_declaration_60 net_declaration_61 net_declaration_62 range net_declaration_64 list_of_net_decl_assignments SEMICOLON { NONUPLE(TRIREG, $2, $3, $4, $5, $6, $7, $8, SEMICOLON); }
	;

constraint_identifier : identifier { ($1); }
	;

terminal_identifier : identifier { ($1); }
	;

named_function_proto : named_function_proto_2 function_data_type function_identifier LPAREN list_of_function_proto_formals RPAREN { SEXTUPLE($1, $2, $3, LPAREN, $5, RPAREN); }
	;

output_declaration : OUTPUT output_declaration_3 list_of_port_identifiers { TRIPLE(OUTPUT, $2, $3); }
	| OUTPUT data_type list_of_variable_port_identifiers { TRIPLE(OUTPUT, $2, $3); }
	;

description : module_declaration { ($1); }
	| udp_declaration { ($1); }
	| module_root_item { ($1); }
	| statement_or_null { ($1); }
	;

specparam_identifier : identifier { ($1); }
	;

case_item : expression case_item_3 COLON statement_or_null { QUADRUPLE($1, $2, COLON, $4); }
	| DEFAULT case_item_8 statement_or_null { TRIPLE(DEFAULT, $2, $3); }
	;

program_ansi_header : program_ansi_header_2 PROGRAM program_ansi_header_4 program_identifier program_ansi_header_6 program_ansi_header_7 SEMICOLON { SEPTUPLE($1, PROGRAM, $3, $4, $5, $6, SEMICOLON); }
	;

function_port_item : function_port_item_2 tf_input_declaration { DOUBLE($1, $2); }
	| function_port_item_5 tf_output_declaration { DOUBLE($1, $2); }
	| function_port_item_8 tf_inout_declaration { DOUBLE($1, $2); }
	| function_port_item_11 tf_ref_declaration { DOUBLE($1, $2); }
	| function_port_item_14 port_type list_of_tf_port_identifiers { TRIPLE($1, $2, $3); }
	| function_port_item_18 tf_data_type list_of_tf_variable_identifiers { TRIPLE($1, $2, $3); }
	;

udp_initial_statement : INITIAL output_port_identifier EQUALS init_val SEMICOLON { QUINTUPLE(INITIAL, $2, EQUALS, $4, SEMICOLON); }
	;

module_path_mintypmax_expression : module_path_expression { ($1); }
	| module_path_expression COLON module_path_expression COLON module_path_expression { QUINTUPLE($1, COLON, $3, COLON, $5); }
	;

cycle_delay_range : P_POUNDPOUND constant_expression { DOUBLE(P_POUNDPOUND, $2); }
	| P_POUNDPOUND LBRACK cycle_delay_const_range_expression RBRACK { QUADRUPLE(P_POUNDPOUND, LBRACK, $3, RBRACK); }
	;

data_event : timing_check_event { ($1); }
	;

level_input_list : level_symbol level_input_list_3 { DOUBLE($1, $2); }
	;

constant_declaration : CONST data_type const_assignment SEMICOLON { QUADRUPLE(CONST, $2, $3, SEMICOLON); }
	;

simple_type : integer_type { ($1); }
	| non_integer_type { ($1); }
	| type_identifier { ($1); }
	;

interface_instance_identifier : identifier { ($1); }
	;

d_skew_timing_check : D_SKEW LPAREN reference_event COMMA data_event COMMA timing_check_limit d_skew_timing_check_9 RPAREN SEMICOLON { DECUPLE(D_SKEW, LPAREN, $3, COMMA, $5, COMMA, $7, $8, RPAREN, SEMICOLON); }
	;

scalar_constant : TOKEN_427 { (TOKEN_427); }
	| TOKEN_428 { (TOKEN_428); }
	| TOKEN_431 { (TOKEN_431); }
	| TOKEN_432 { (TOKEN_432); }
	| TOKEN_595 { (TOKEN_595); }
	| TOKEN_596 { (TOKEN_596); }
	| TOKEN_597 { (TOKEN_597); }
	| TOKEN_598 { (TOKEN_598); }
	| TOKEN_435 { (TOKEN_435); }
	| TOKEN_436 { (TOKEN_436); }
	;

multi_clock_sequence : clocked_sequence multi_clock_sequence_3 { DOUBLE($1, $2); }
	;

n_output_gate_instance : n_output_gate_instance_2 LPAREN output_terminal n_output_gate_instance_5 COMMA input_terminal RPAREN { SEPTUPLE($1, LPAREN, $3, $4, COMMA, $6, RPAREN); }
	;

enable_terminal : expression { ($1); }
	;

delayed_reference : terminal_identifier { ($1); }
	| terminal_identifier LBRACK constant_mintypmax_expression RBRACK { QUADRUPLE($1, LBRACK, $3, RBRACK); }
	;

event_based_flag : constant_expression { ($1); }
	;

edge_descriptor : TOKEN_587 { (TOKEN_587); }
	| TOKEN_588 { (TOKEN_588); }
	| z_or_x zero_or_one { DOUBLE($1, $2); }
	| zero_or_one z_or_x { DOUBLE($1, $2); }
	;

specify_terminal_descriptor : specify_input_terminal_descriptor { ($1); }
	| specify_output_terminal_descriptor { ($1); }
	;

formal_identifier : identifier { ($1); }
	;

decimal_number : unsigned_number { ($1); }
	| decimal_number_4 decimal_base unsigned_number { TRIPLE($1, $2, $3); }
	| decimal_number_8 decimal_base x_digit decimal_number_11 { QUADRUPLE($1, $2, $3, $4); }
	| decimal_number_13 decimal_base z_digit decimal_number_16 { QUADRUPLE($1, $2, $3, $4); }
	;

integer_atom_type : BYTE { (BYTE); }
	| SHORTINT { (SHORTINT); }
	| SVINT { (SVINT); }
	| LONGINT { (LONGINT); }
	| INTEGER { (INTEGER); }
	;

level_symbol : TOKEN_436 { (TOKEN_436); }
	| TOKEN_435 { (TOKEN_435); }
	| 'x' { (CHAR 'x'); }
	| 'X' { (CHAR 'X'); }
	| QUERY { (QUERY); }
	| 'B' { (CHAR 'B'); }
	| 'B' { (CHAR 'B'); }
	;

constant_base_expression : constant_expression { ($1); }
	;

udp_identifier : identifier { ($1); }
	;

time_literal : unsigned_number time_unit { DOUBLE($1, $2); }
	| fixed_point_number time_unit { DOUBLE($1, $2); }
	;

generate_module_block : BEGIN generate_module_block_3 generate_module_block_4 END generate_module_block_6 { QUINTUPLE(BEGIN, $2, $3, END, $5); }
	;

output_symbol : TOKEN_436 { (TOKEN_436); }
	| TOKEN_435 { (TOKEN_435); }
	| 'X' { (CHAR 'X'); }
	| 'X' { (CHAR 'X'); }
	;

type_declaration_identifier : type_identifier type_declaration_identifier_3 { DOUBLE($1, $2); }
	;

param_assignment : parameter_identifier EQUALS constant_param_expression { TRIPLE($1, EQUALS, $3); }
	;

list_of_path_outputs : specify_output_terminal_descriptor list_of_path_outputs_3 { DOUBLE($1, $2); }
	;

dpi_import_export : IMPORT TOKEN_287 dpi_import_export_4 dpi_import_export_5 dpi_function_proto SEMICOLON { SEXTUPLE(IMPORT, TOKEN_287, $3, $4, $5, SEMICOLON); }
	| EXPORT TOKEN_287 dpi_import_export_11 FUNCTION function_identifier SEMICOLON { SEXTUPLE(EXPORT, TOKEN_287, $3, FUNCTION, $5, SEMICOLON); }
	;

list_of_param_assignments : param_assignment list_of_param_assignments_3 { DOUBLE($1, $2); }
	;

full_edge_sensitive_path_description : LPAREN full_edge_sensitive_path_description_3 list_of_path_inputs P_ASTGT list_of_path_outputs full_edge_sensitive_path_description_7 COLON data_source_expression RPAREN { NONUPLE(LPAREN, $2, $3, P_ASTGT, $5, $6, COLON, $8, RPAREN); }
	;

cmos_switchtype : CMOS { (CMOS); }
	| RCMOS { (RCMOS); }
	;

pulldown_strength : LPAREN strength0 COMMA strength1 RPAREN { QUINTUPLE(LPAREN, $2, COMMA, $4, RPAREN); }
	| LPAREN strength1 COMMA strength0 RPAREN { QUINTUPLE(LPAREN, $2, COMMA, $4, RPAREN); }
	| LPAREN strength0 RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

cycle_delay : P_POUNDPOUND expression { DOUBLE(P_POUNDPOUND, $2); }
	;

seq_block : BEGIN seq_block_3 seq_block_4 seq_block_5 END seq_block_7 { SEXTUPLE(BEGIN, $2, $3, $4, END, $6); }
	;

udp_declaration_port_list : udp_output_declaration COMMA udp_input_declaration udp_declaration_port_list_5 { QUADRUPLE($1, COMMA, $3, $4); }
	;

named_port_connection : named_port_connection_2 DOT port_identifier LPAREN named_port_connection_6 RPAREN { SEXTUPLE($1, DOT, $3, LPAREN, $5, RPAREN); }
	;

cycle_delay_const_range_expression : constant_expression COLON constant_expression { TRIPLE($1, COLON, $3); }
	| constant_expression COLON DOLLAR { TRIPLE($1, COLON, DOLLAR); }
	;

module_path_conditional_expression : module_path_expression QUERY module_path_conditional_expression_4 module_path_expression COLON module_path_expression { SEXTUPLE($1, QUERY, $3, $4, COLON, $6); }
	;

constraint_declaration : constraint_declaration_2 CONSTRAINT constraint_identifier LCURLY constraint_declaration_6 RCURLY { SEXTUPLE($1, CONSTRAINT, $3, LCURLY, $5, RCURLY); }
	;

clocking_decl_assign : signal_identifier clocking_decl_assign_3 { DOUBLE($1, $2); }
	;

unary_module_path_operator : PLING { (PLING); }
	| TILDE { (TILDE); }
	| AMPERSAND { (AMPERSAND); }
	| P_NAND { (P_NAND); }
	| VBAR { (VBAR); }
	| TOKEN_648 { (TOKEN_648); }
	| CARET { (CARET); }
	| P_XNOR { (P_XNOR); }
	| P_XNOR { (P_XNOR); }
	;

variable_lvalue : hierarchical_variable_identifier variable_lvalue_3 variable_lvalue_4 { TRIPLE($1, $2, $3); }
	| LCURLY variable_lvalue variable_lvalue_8 RCURLY { QUADRUPLE(LCURLY, $2, $3, RCURLY); }
	;

dpi_proto_formal : data_type dpi_proto_formal_3 { DOUBLE($1, $2); }
	;

list_of_tf_variable_identifiers : port_identifier variable_dimension list_of_tf_variable_identifiers_4 list_of_tf_variable_identifiers_5 { QUADRUPLE($1, $2, $3, $4); }
	;

start_edge_offset : mintypmax_expression { ($1); }
	;

include_statement : INCLUDE LESS file_path_spec GREATER SEMICOLON { QUINTUPLE(INCLUDE, LESS, $3, GREATER, SEMICOLON); }
	;

constant_multiple_concatenation : LCURLY constant_expression constant_concatenation RCURLY { QUADRUPLE(LCURLY, $2, $3, RCURLY); }
	;

const_identifier : identifier { ($1); }
	;

list_of_path_delay_expressions : t_path_delay_expression { ($1); }
	| trise_path_delay_expression COMMA tfall_path_delay_expression { TRIPLE($1, COMMA, $3); }
	| trise_path_delay_expression COMMA tfall_path_delay_expression COMMA tz_path_delay_expression { QUINTUPLE($1, COMMA, $3, COMMA, $5); }
	| t01_path_delay_expression COMMA t10_path_delay_expression COMMA t0z_path_delay_expression COMMA tz1_path_delay_expression COMMA t1z_path_delay_expression COMMA tz0_path_delay_expression { UNDECUPLE($1, COMMA, $3, COMMA, $5, COMMA, $7, COMMA, $9, COMMA, $11); }
	| t01_path_delay_expression COMMA t10_path_delay_expression COMMA t0z_path_delay_expression COMMA tz1_path_delay_expression COMMA t1z_path_delay_expression COMMA tz0_path_delay_expression COMMA t0x_path_delay_expression COMMA tx1_path_delay_expression COMMA t1x_path_delay_expression COMMA tx0_path_delay_expression COMMA txz_path_delay_expression COMMA tzx_path_delay_expression { TREVIGENUPLE($1, COMMA, $3, COMMA, $5, COMMA, $7, COMMA, $9, COMMA, $11, COMMA, $13, COMMA, $15, COMMA, $17, COMMA, $19, COMMA, $21, COMMA, $23); }
	;

list_of_ports : LPAREN port list_of_ports_4 RPAREN { QUADRUPLE(LPAREN, $2, $3, RPAREN); }
	;

timing_check_limit : expression { ($1); }
	;

modport_identifier : identifier { ($1); }
	;

extern_tf_declaration : EXTERN method_prototype { DOUBLE(EXTERN, $2); }
	| EXTERN FORKJOIN TASK named_task_proto SEMICOLON { QUINTUPLE(EXTERN, FORKJOIN, TASK, $4, SEMICOLON); }
	;

struct_member_label : DEFAULT { (DEFAULT); }
	| type_identifier { ($1); }
	| variable_identifier { ($1); }
	;

list_of_net_identifiers : net_identifier list_of_net_identifiers_3 list_of_net_identifiers_4 { TRIPLE($1, $2, $3); }
	;

block_item_declaration : block_item_declaration_2 block_data_declaration { DOUBLE($1, $2); }
	| block_item_declaration_5 local_parameter_declaration { DOUBLE($1, $2); }
	| block_item_declaration_8 parameter_declaration SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	;

block_identifier : identifier { ($1); }
	;

port : port_2 { ($1); }
	| DOT port_identifier LPAREN port_7 RPAREN { QUINTUPLE(DOT, $2, LPAREN, $4, RPAREN); }
	;

task_item_declaration : block_item_declaration { ($1); }
	| task_item_declaration_4 tf_input_declaration SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| task_item_declaration_8 tf_output_declaration SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| task_item_declaration_12 tf_inout_declaration SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| task_item_declaration_16 tf_ref_declaration SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	;

procedural_timing_control_statement : procedural_timing_control statement_or_null { DOUBLE($1, $2); }
	;

zero_or_one : TOKEN_436 { (TOKEN_436); }
	| TOKEN_435 { (TOKEN_435); }
	;

integer_type : integer_vector_type { ($1); }
	| integer_atom_type { ($1); }
	;

list_of_variable_identifiers : variable_identifier variable_dimension list_of_variable_identifiers_4 { TRIPLE($1, $2, $3); }
	;

init_val : TOKEN_427 { (TOKEN_427); }
	| TOKEN_428 { (TOKEN_428); }
	| TOKEN_429 { (TOKEN_429); }
	| TOKEN_430 { (TOKEN_430); }
	| TOKEN_431 { (TOKEN_431); }
	| TOKEN_432 { (TOKEN_432); }
	| TOKEN_433 { (TOKEN_433); }
	| TOKEN_434 { (TOKEN_434); }
	| TOKEN_435 { (TOKEN_435); }
	| TOKEN_436 { (TOKEN_436); }
	;

delay_or_event_control : delay_control { ($1); }
	| event_control { ($1); }
	| REPEAT LPAREN expression RPAREN event_control { QUINTUPLE(REPEAT, LPAREN, $3, RPAREN, $5); }
	;

bind_instantiation : program_instantiation { ($1); }
	| module_instantiation { ($1); }
	| interface_instantiation { ($1); }
	;

list_of_modport_port_identifiers : port_identifier list_of_modport_port_identifiers_3 { DOUBLE($1, $2); }
	;

module_root_item : module_root_item_2 module_instantiation { DOUBLE($1, $2); }
	| module_root_item_5 local_parameter_declaration { DOUBLE($1, $2); }
	| interface_declaration { ($1); }
	| program_declaration { ($1); }
	| class_declaration { ($1); }
	| module_common_item { ($1); }
	;

net_alias : ALIAS net_lvalue EQUALS net_lvalue SEMICOLON { QUINTUPLE(ALIAS, $2, EQUALS, $4, SEMICOLON); }
	;

default_skew : INPUT clocking_skew { DOUBLE(INPUT, $2); }
	| OUTPUT clocking_skew { DOUBLE(OUTPUT, $2); }
	| INPUT clocking_skew OUTPUT clocking_skew { QUADRUPLE(INPUT, $2, OUTPUT, $4); }
	;

procedural_assertion_item : assert_property_statement { ($1); }
	| cover_property_statement { ($1); }
	| immediate_assert_statement { ($1); }
	;

event_trigger : P_MINUSGT hierarchical_event_identifier SEMICOLON { TRIPLE(P_MINUSGT, $2, SEMICOLON); }
	| TOKEN_504 event_trigger_7 hierarchical_event_identifier SEMICOLON { QUADRUPLE(TOKEN_504, $2, $3, SEMICOLON); }
	;

list_of_port_identifiers : port_identifier list_of_port_identifiers_3 list_of_port_identifiers_4 { TRIPLE($1, $2, $3); }
	;

d_recovery_timing_check : D_RECOVERY LPAREN reference_event COMMA data_event COMMA timing_check_limit d_recovery_timing_check_9 RPAREN SEMICOLON { DECUPLE(D_RECOVERY, LPAREN, $3, COMMA, $5, COMMA, $7, $8, RPAREN, SEMICOLON); }
	;

clockvar : clocking_identifier DOT identifier { TRIPLE($1, DOT, $3); }
	;

concatenation : LCURLY expression concatenation_4 RCURLY { QUADRUPLE(LCURLY, $2, $3, RCURLY); }
	| LCURLY struct_member_label COLON expression concatenation_11 RCURLY { SEXTUPLE(LCURLY, $2, COLON, $4, $5, RCURLY); }
	| LCURLY array_member_label COLON expression concatenation_18 RCURLY { SEXTUPLE(LCURLY, $2, COLON, $4, $5, RCURLY); }
	;

range_list_or_array : variable_identifier { ($1); }
	| LCURLY value_range range_list_or_array_6 RCURLY { QUADRUPLE(LCURLY, $2, $3, RCURLY); }
	;

n_output_gatetype : BUF { (BUF); }
	| NOT { (NOT); }
	;

binary_value : binary_digit binary_value_3 { DOUBLE($1, $2); }
	;

drive_strength : LPAREN strength0 COMMA strength1 RPAREN { QUINTUPLE(LPAREN, $2, COMMA, $4, RPAREN); }
	| LPAREN strength1 COMMA strength0 RPAREN { QUINTUPLE(LPAREN, $2, COMMA, $4, RPAREN); }
	| LPAREN strength0 COMMA HIGHZ1 RPAREN { QUINTUPLE(LPAREN, $2, COMMA, HIGHZ1, RPAREN); }
	| LPAREN strength1 COMMA HIGHZ0 RPAREN { QUINTUPLE(LPAREN, $2, COMMA, HIGHZ0, RPAREN); }
	| LPAREN HIGHZ0 COMMA strength1 RPAREN { QUINTUPLE(LPAREN, HIGHZ0, COMMA, $4, RPAREN); }
	| LPAREN HIGHZ1 COMMA strength0 RPAREN { QUINTUPLE(LPAREN, HIGHZ1, COMMA, $4, RPAREN); }
	;

class_property : class_property_2 data_declaration { DOUBLE($1, $2); }
	| CONST class_property_6 data_type const_identifier class_property_9 SEMICOLON { SEXTUPLE(CONST, $2, $3, $4, $5, SEMICOLON); }
	;

clocking_item : DEFAULT default_skew SEMICOLON { TRIPLE(DEFAULT, $2, SEMICOLON); }
	| clocking_direction list_of_clocking_decl_assign SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| clocking_item_10 concurrent_assertion_item_declaration { DOUBLE($1, $2); }
	;

constraint_prototype : constraint_prototype_2 CONSTRAINT constraint_identifier { TRIPLE($1, CONSTRAINT, $3); }
	;

output_terminal : net_lvalue { ($1); }
	;

variable_identifier : identifier { ($1); }
	;

txz_path_delay_expression : path_delay_expression { ($1); }
	;

t1z_path_delay_expression : path_delay_expression { ($1); }
	;

module_path_expression : module_path_primary { ($1); }
	| unary_module_path_operator module_path_expression_5 module_path_primary { TRIPLE($1, $2, $3); }
	| module_path_expression binary_module_path_operator module_path_expression_10 module_path_expression { QUADRUPLE($1, $2, $3, $4); }
	| module_path_conditional_expression { ($1); }
	;

function_blocking_assignment : variable_lvalue EQUALS expression { TRIPLE($1, EQUALS, $3); }
	;

module_identifier : identifier { ($1); }
	;

clocking_direction : INPUT clocking_direction_3 { DOUBLE(INPUT, $2); }
	| OUTPUT clocking_direction_6 { DOUBLE(OUTPUT, $2); }
	| INPUT clocking_direction_9 OUTPUT clocking_direction_11 { QUADRUPLE(INPUT, $2, OUTPUT, $4); }
	| INOUT { (INOUT); }
	;

assert_property_statement : ASSERT PROPERTY LPAREN property_spec RPAREN action_block { SEXTUPLE(ASSERT, PROPERTY, LPAREN, $4, RPAREN, $6); }
	| ASSERT PROPERTY LPAREN property_instance RPAREN action_block { SEXTUPLE(ASSERT, PROPERTY, LPAREN, $4, RPAREN, $6); }
	;

edge_indicator : LPAREN level_symbol level_symbol RPAREN { QUADRUPLE(LPAREN, $2, $3, RPAREN); }
	| edge_symbol { ($1); }
	;

name_of_udp_instance : udp_instance_identifier name_of_udp_instance_3 { DOUBLE($1, $2); }
	;

method_qualifier : VIRTUAL { (VIRTUAL); }
	| class_item_qualifier { ($1); }
	;

udp_reg_declaration : udp_reg_declaration_2 REG variable_identifier { TRIPLE($1, REG, $3); }
	;

sequence_expr : cycle_delay_range sequence_expr sequence_expr_4 { TRIPLE($1, $2, $3); }
	| sequence_expr cycle_delay_range sequence_expr sequence_expr_9 { QUADRUPLE($1, $2, $3, $4); }
	| expression sequence_expr_12 sequence_expr_13 { TRIPLE($1, $2, $3); }
	| LPAREN expression sequence_expr_17 RPAREN sequence_expr_19 { QUINTUPLE(LPAREN, $2, $3, RPAREN, $5); }
	| sequence_instance sequence_expr_22 { DOUBLE($1, $2); }
	| LPAREN sequence_expr RPAREN sequence_expr_27 { QUADRUPLE(LPAREN, $2, RPAREN, $4); }
	| sequence_expr AND sequence_expr { TRIPLE($1, AND, $3); }
	| sequence_expr INTERSECT sequence_expr { TRIPLE($1, INTERSECT, $3); }
	| sequence_expr OR sequence_expr { TRIPLE($1, OR, $3); }
	| FIRST_MATCH LPAREN sequence_expr RPAREN { QUADRUPLE(FIRST_MATCH, LPAREN, $3, RPAREN); }
	| expression THROUGHOUT sequence_expr { TRIPLE($1, THROUGHOUT, $3); }
	| sequence_expr WITHIN sequence_expr { TRIPLE($1, WITHIN, $3); }
	;

generate_module_loop_statement : FOR LPAREN genvar_decl_assignment SEMICOLON constant_expression SEMICOLON genvar_assignment RPAREN generate_module_named_block { NONUPLE(FOR, LPAREN, $3, SEMICOLON, $5, SEMICOLON, $7, RPAREN, $9); }
	;

list_of_parameter_assignments : ordered_parameter_assignment list_of_parameter_assignments_3 { DOUBLE($1, $2); }
	| named_parameter_assignment list_of_parameter_assignments_6 { DOUBLE($1, $2); }
	;

binary_number : binary_number_2 binary_base binary_value { TRIPLE($1, $2, $3); }
	;

inout_terminal : net_lvalue { ($1); }
	;

t0z_path_delay_expression : path_delay_expression { ($1); }
	;

program_identifier : identifier { ($1); }
	;

task_declaration : TASK task_declaration_3 task_body_declaration { TRIPLE(TASK, $2, $3); }
	;

tf_inout_declaration : INOUT tf_inout_declaration_3 tf_inout_declaration_4 list_of_tf_port_identifiers { QUADRUPLE(INOUT, $2, $3, $4); }
	| INOUT tf_data_type list_of_tf_variable_identifiers { TRIPLE(INOUT, $2, $3); }
	;

checktime_condition : mintypmax_expression { ($1); }
	;

udp_port_list : output_port_identifier COMMA input_port_identifier udp_port_list_5 { QUADRUPLE($1, COMMA, $3, $4); }
	;

c_identifier : c_identifier_2 c_identifier_3 { DOUBLE($1, $2); }
	;

non_generic_port_declaration : non_generic_port_declaration_2 inout_declaration { DOUBLE($1, $2); }
	| non_generic_port_declaration_5 input_declaration { DOUBLE($1, $2); }
	| non_generic_port_declaration_8 output_declaration { DOUBLE($1, $2); }
	| non_generic_port_declaration_11 ref_declaration { DOUBLE($1, $2); }
	| non_generic_port_declaration_14 interface_port_declaration { DOUBLE($1, $2); }
	;

path_declaration : simple_path_declaration SEMICOLON { DOUBLE($1, SEMICOLON); }
	| edge_sensitive_path_declaration SEMICOLON { DOUBLE($1, SEMICOLON); }
	| state_dependent_path_declaration SEMICOLON { DOUBLE($1, SEMICOLON); }
	;

module_or_generate_item_declaration : net_declaration { ($1); }
	| data_declaration { ($1); }
	| genvar_declaration { ($1); }
	| task_declaration { ($1); }
	| function_declaration { ($1); }
	| dpi_import_export { ($1); }
	| extern_constraint_declaration { ($1); }
	| extern_method_declaration { ($1); }
	| clocking_decl { ($1); }
	| DEFAULT CLOCKING clocking_identifier SEMICOLON { QUADRUPLE(DEFAULT, CLOCKING, $3, SEMICOLON); }
	;

z_or_x : 'x' { (CHAR 'x'); }
	| 'X' { (CHAR 'X'); }
	| 'Z' { (CHAR 'Z'); }
	| 'Z' { (CHAR 'Z'); }
	;

remain_active_flag : constant_mintypmax_expression { ($1); }
	;

interface_declaration : interface_nonansi_header interface_declaration_3 interface_declaration_4 ENDINTERFACE interface_declaration_6 { QUINTUPLE($1, $2, $3, ENDINTERFACE, $5); }
	| interface_ansi_header interface_declaration_9 interface_declaration_10 ENDINTERFACE interface_declaration_12 { QUINTUPLE($1, $2, $3, ENDINTERFACE, $5); }
	| interface_declaration_14 INTERFACE interface_identifier LPAREN P_DOTSTAR RPAREN SEMICOLON interface_declaration_21 interface_declaration_22 ENDINTERFACE interface_declaration_24 { UNDECUPLE($1, INTERFACE, $3, LPAREN, P_DOTSTAR, RPAREN, SEMICOLON, $8, $9, ENDINTERFACE, $11); }
	| EXTERN interface_nonansi_header { DOUBLE(EXTERN, $2); }
	| EXTERN interface_ansi_header { DOUBLE(EXTERN, $2); }
	;

interface_item : non_generic_port_declaration SEMICOLON { DOUBLE($1, SEMICOLON); }
	| non_port_interface_item { ($1); }
	;

d_fullskew_timing_check : FULLSKEW LPAREN reference_event COMMA data_event COMMA timing_check_limit COMMA timing_check_limit d_fullskew_timing_check_11 RPAREN SEMICOLON { DUODECUPLE(FULLSKEW, LPAREN, $3, COMMA, $5, COMMA, $7, COMMA, $9, $10, RPAREN, SEMICOLON); }
	;

immediate_assert_statement : ASSERT LPAREN expression RPAREN action_block { QUINTUPLE(ASSERT, LPAREN, $3, RPAREN, $5); }
	;

port_declaration : non_generic_port_declaration { ($1); }
	| port_declaration_4 generic_interface_port_declaration { DOUBLE($1, $2); }
	;

generate_module_conditional_statement : IF LPAREN constant_expression RPAREN generate_module_item generate_module_conditional_statement_7 { SEXTUPLE(IF, LPAREN, $3, RPAREN, $5, $6); }
	;

loop_statement : FOREVER statement_or_null { DOUBLE(FOREVER, $2); }
	| REPEAT LPAREN expression RPAREN statement_or_null { QUINTUPLE(REPEAT, LPAREN, $3, RPAREN, $5); }
	| WHILE LPAREN expression RPAREN statement_or_null { QUINTUPLE(WHILE, LPAREN, $3, RPAREN, $5); }
	| FOR LPAREN variable_decl_or_assignment SEMICOLON expression SEMICOLON variable_assignment RPAREN statement_or_null { NONUPLE(FOR, LPAREN, $3, SEMICOLON, $5, SEMICOLON, $7, RPAREN, $9); }
	| FOR LPAREN variable_decl_or_assignment loop_statement_30 SEMICOLON expression SEMICOLON variable_assignment loop_statement_35 RPAREN statement_or_null { UNDECUPLE(FOR, LPAREN, $3, $4, SEMICOLON, $6, SEMICOLON, $8, $9, RPAREN, $11); }
	| DO statement_or_null WHILE LPAREN expression RPAREN SEMICOLON { SEPTUPLE(DO, $2, WHILE, LPAREN, $5, RPAREN, SEMICOLON); }
	;

property_formal_list : LPAREN formal_list_item property_formal_list_4 RPAREN { QUADRUPLE(LPAREN, $2, $3, RPAREN); }
	;

escaped_hierarchical_identifier : escaped_hierarchical_branch escaped_hierarchical_identifier_3 { DOUBLE($1, $2); }
	;

parallel_edge_sensitive_path_description : LPAREN parallel_edge_sensitive_path_description_3 specify_input_terminal_descriptor P_EQGT specify_output_terminal_descriptor parallel_edge_sensitive_path_description_7 COLON data_source_expression RPAREN { NONUPLE(LPAREN, $2, $3, P_EQGT, $5, $6, COLON, $8, RPAREN); }
	;

timing_check_event : timing_check_event_2 specify_terminal_descriptor timing_check_event_4 { TRIPLE($1, $2, $3); }
	;

generate_module_named_block : BEGIN COLON generate_block_identifier generate_module_named_block_5 END generate_module_named_block_7 { SEXTUPLE(BEGIN, COLON, $3, $4, END, $6); }
	| generate_block_identifier COLON generate_module_block { TRIPLE($1, COLON, $3); }
	;

tfall_path_delay_expression : path_delay_expression { ($1); }
	;

list_of_path_inputs : specify_input_terminal_descriptor list_of_path_inputs_3 { DOUBLE($1, $2); }
	;

function_statement_item : function_statement_item_2 function_blocking_assignment SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| function_statement_item_6 function_case_statement { DOUBLE($1, $2); }
	| function_statement_item_9 function_conditional_statement { DOUBLE($1, $2); }
	| function_statement_item_12 inc_or_dec_expression SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| function_statement_item_16 function_call SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| function_statement_item_20 function_loop_statement { DOUBLE($1, $2); }
	| function_statement_item_23 jump_statement { DOUBLE($1, $2); }
	| function_statement_item_26 function_seq_block { DOUBLE($1, $2); }
	| function_statement_item_29 disable_statement { DOUBLE($1, $2); }
	| function_statement_item_32 system_task_enable { DOUBLE($1, $2); }
	;

pass_switchtype : TRAN { (TRAN); }
	| RTRAN { (RTRAN); }
	;

multi_clock_property_expr : multi_clock_sequence { ($1); }
	| multi_clock_sequence TOKEN_328 multi_clock_property_expr_6 multi_clock_sequence { QUADRUPLE($1, TOKEN_328, $3, $4); }
	| LPAREN multi_clock_property_expr RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

d_setup_timing_check : D_SETUP LPAREN data_event COMMA reference_event COMMA timing_check_limit d_setup_timing_check_9 RPAREN SEMICOLON { DECUPLE(D_SETUP, LPAREN, $3, COMMA, $5, COMMA, $7, $8, RPAREN, SEMICOLON); }
	;

list_of_net_assignments : net_assignment list_of_net_assignments_3 { DOUBLE($1, $2); }
	;

modport_simple_ports_declaration : INPUT list_of_modport_port_identifiers { DOUBLE(INPUT, $2); }
	| OUTPUT list_of_modport_port_identifiers { DOUBLE(OUTPUT, $2); }
	| INOUT list_of_modport_port_identifiers { DOUBLE(INOUT, $2); }
	| REF modport_simple_ports_declaration_12 list_of_modport_port_identifiers { TRIPLE(REF, $2, $3); }
	;

threshold : constant_expression { ($1); }
	;

module_path_concatenation : LCURLY module_path_expression module_path_concatenation_4 RCURLY { QUADRUPLE(LCURLY, $2, $3, RCURLY); }
	;

always_construct : ALWAYS statement { DOUBLE(ALWAYS, $2); }
	;

port_type : data_type { ($1); }
	| net_type port_type_5 port_type_6 { TRIPLE($1, $2, $3); }
	| TRIREG port_type_9 port_type_10 { TRIPLE(TRIREG, $2, $3); }
	| port_type_12 port_type_13 range { TRIPLE($1, $2, $3); }
	;

module_keyword : MODULE { (MODULE); }
	| MACROMODULE { (MACROMODULE); }
	;

program_instantiation : program_identifier program_instantiation_3 program_instance program_instantiation_5 SEMICOLON { QUINTUPLE($1, $2, $3, $4, SEMICOLON); }
	;

jump_statement : RETURN jump_statement_3 SEMICOLON { TRIPLE(RETURN, $2, SEMICOLON); }
	| BREAK SEMICOLON { DOUBLE(BREAK, SEMICOLON); }
	| CONTINUE SEMICOLON { DOUBLE(CONTINUE, SEMICOLON); }
	;

assignment_operator : EQUALS { (EQUALS); }
	| P_PLUSEQ { (P_PLUSEQ); }
	| P_MINUSEQ { (P_MINUSEQ); }
	| P_TIMESEQ { (P_TIMESEQ); }
	| P_DIVEQ { (P_DIVEQ); }
	| P_MODEQ { (P_MODEQ); }
	| P_ANDEQ { (P_ANDEQ); }
	| TOKEN_471 { (TOKEN_471); }
	| P_XOREQ { (P_XOREQ); }
	| P_SLEFTEQ { (P_SLEFTEQ); }
	| P_SRIGHTEQ { (P_SRIGHTEQ); }
	| P_SLEFTEQ { (P_SLEFTEQ); }
	| P_SSRIGHTEQ { (P_SSRIGHTEQ); }
	;

d_timeskew_timing_check : D_TIMESKEW LPAREN reference_event COMMA data_event COMMA timing_check_limit d_timeskew_timing_check_9 RPAREN SEMICOLON { DECUPLE(D_TIMESKEW, LPAREN, $3, COMMA, $5, COMMA, $7, $8, RPAREN, SEMICOLON); }
	;

library_identifier : identifier { ($1); }
	;

constant_primary : constant_concatenation { ($1); }
	| constant_function_call { ($1); }
	| LPAREN constant_mintypmax_expression RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	| constant_multiple_concatenation { ($1); }
	| genvar_identifier { ($1); }
	| number { ($1); }
	| parameter_identifier { ($1); }
	| specparam_identifier { ($1); }
	| casting_type SQUOTE LPAREN constant_expression RPAREN { QUINTUPLE($1, SQUOTE, LPAREN, $4, RPAREN); }
	| casting_type SQUOTE constant_concatenation { TRIPLE($1, SQUOTE, $3); }
	| casting_type SQUOTE constant_multiple_concatenation { TRIPLE($1, SQUOTE, $3); }
	| time_literal { ($1); }
	| TOKEN_631 { (TOKEN_631); }
	| TOKEN_632 { (TOKEN_632); }
	| TOKEN_633 { (TOKEN_633); }
	| TOKEN_634 { (TOKEN_634); }
	| TOKEN_635 { (TOKEN_635); }
	| TOKEN_636 { (TOKEN_636); }
	;

end_edge_offset : mintypmax_expression { ($1); }
	;

simple_path_declaration : parallel_path_description EQUALS path_delay_value { TRIPLE($1, EQUALS, $3); }
	| full_path_description EQUALS path_delay_value { TRIPLE($1, EQUALS, $3); }
	;

nonblocking_assignment : variable_lvalue P_LTE nonblocking_assignment_4 expression { QUADRUPLE($1, P_LTE, $3, $4); }
	;

function_call : hierarchical_function_identifier function_call_3 function_call_4 { TRIPLE($1, $2, $3); }
	;

program_declaration : program_nonansi_header program_declaration_3 program_declaration_4 ENDPROGRAM program_declaration_6 { QUINTUPLE($1, $2, $3, ENDPROGRAM, $5); }
	| program_ansi_header program_declaration_9 program_declaration_10 ENDPROGRAM program_declaration_12 { QUINTUPLE($1, $2, $3, ENDPROGRAM, $5); }
	| program_declaration_14 PROGRAM program_identifier LPAREN P_DOTSTAR RPAREN SEMICOLON program_declaration_21 program_declaration_22 ENDPROGRAM program_declaration_24 { UNDECUPLE($1, PROGRAM, $3, LPAREN, P_DOTSTAR, RPAREN, SEMICOLON, $8, $9, ENDPROGRAM, $11); }
	| EXTERN program_nonansi_header { DOUBLE(EXTERN, $2); }
	| EXTERN program_ansi_header { DOUBLE(EXTERN, $2); }
	;

interface_port_declaration : interface_identifier list_of_interface_identifiers { DOUBLE($1, $2); }
	| interface_identifier DOT modport_identifier list_of_interface_identifiers { QUADRUPLE($1, DOT, $3, $4); }
	;

octal_digit : x_digit { ($1); }
	| z_digit { ($1); }
	| TOKEN_436 { (TOKEN_436); }
	| TOKEN_435 { (TOKEN_435); }
	| TOKEN_687 { (TOKEN_687); }
	| TOKEN_688 { (TOKEN_688); }
	| TOKEN_689 { (TOKEN_689); }
	| TOKEN_690 { (TOKEN_690); }
	| TOKEN_691 { (TOKEN_691); }
	| TOKEN_639 { (TOKEN_639); }
	;

actual_arg_expr : event_expression { ($1); }
	;

identifier_list : identifier identifier_list_3 { DOUBLE($1, $2); }
	;

list_of_variable_assignments : variable_assignment list_of_variable_assignments_3 { DOUBLE($1, $2); }
	;

string_literal : TOKEN_695 string_literal_3 TOKEN_695 { TRIPLE(TOKEN_695, $2, TOKEN_695); }
	;

controlled_reference_event : controlled_timing_check_event { ($1); }
	;

size : non_zero_unsigned_number { ($1); }
	;

property_declaration : PROPERTY property_identifier property_declaration_4 SEMICOLON property_declaration_6 property_spec SEMICOLON ENDPROPERTY property_declaration_10 { NONUPLE(PROPERTY, $2, $3, SEMICOLON, $5, $6, SEMICOLON, ENDPROPERTY, $9); }
	;

generate_module_case_statement : CASE LPAREN constant_expression RPAREN genvar_module_case_item generate_module_case_statement_7 ENDCASE { SEPTUPLE(CASE, LPAREN, $3, RPAREN, $5, $6, ENDCASE); }
	;

real_number : fixed_point_number { ($1); }
	| unsigned_number real_number_5 exp real_number_7 unsigned_number { QUINTUPLE($1, $2, $3, $4, $5); }
	;

hierarchical_event_identifier : hierarchical_identifier { ($1); }
	;

function_data_type : integer_vector_type function_data_type_3 function_data_type_4 { TRIPLE($1, $2, $3); }
	| integer_atom_type { ($1); }
	| type_declaration_identifier function_data_type_9 { DOUBLE($1, $2); }
	| non_integer_type { ($1); }
	| STRUCT function_data_type_14 LCURLY function_data_type_16 RCURLY function_data_type_18 { SEXTUPLE(STRUCT, $2, LCURLY, $4, RCURLY, $6); }
	| UNION function_data_type_21 LCURLY function_data_type_23 RCURLY function_data_type_25 { SEXTUPLE(UNION, $2, LCURLY, $4, RCURLY, $6); }
	| ENUM function_data_type_28 LCURLY enum_identifier function_data_type_31 function_data_type_32 RCURLY { SEPTUPLE(ENUM, $2, LCURLY, $4, $5, $6, RCURLY); }
	| STRING { (STRING); }
	| CHANDLE { (CHANDLE); }
	| VOID { (VOID); }
	;

output_port_identifier : identifier { ($1); }
	;

sequence_spec : multi_clock_sequence { ($1); }
	| sequence_expr { ($1); }
	;

polarity_operator : PLUS { (PLUS); }
	| MINUS { (MINUS); }
	;

list_of_udp_port_identifiers : port_identifier list_of_udp_port_identifiers_3 { DOUBLE($1, $2); }
	;

clocking_drive : clockvar_expression P_LTE clocking_drive_4 expression { QUADRUPLE($1, P_LTE, $3, $4); }
	| cycle_delay clockvar_expression P_LTE expression { QUADRUPLE($1, $2, P_LTE, $4); }
	;

unary_operator : PLUS { (PLUS); }
	| MINUS { (MINUS); }
	| PLING { (PLING); }
	| TILDE { (TILDE); }
	| AMPERSAND { (AMPERSAND); }
	| P_NAND { (P_NAND); }
	| VBAR { (VBAR); }
	| TOKEN_648 { (TOKEN_648); }
	| CARET { (CARET); }
	| P_XNOR { (P_XNOR); }
	| P_XNOR { (P_XNOR); }
	;

interface_or_generate_item : interface_or_generate_item_2 continuous_assign { DOUBLE($1, $2); }
	| interface_or_generate_item_5 initial_construct { DOUBLE($1, $2); }
	| interface_or_generate_item_8 always_construct { DOUBLE($1, $2); }
	| interface_or_generate_item_11 combinational_construct { DOUBLE($1, $2); }
	| interface_or_generate_item_14 latch_construct { DOUBLE($1, $2); }
	| interface_or_generate_item_17 ff_construct { DOUBLE($1, $2); }
	| interface_or_generate_item_20 local_parameter_declaration { DOUBLE($1, $2); }
	| interface_or_generate_item_23 parameter_declaration SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	| module_common_item { ($1); }
	| interface_or_generate_item_29 modport_declaration { DOUBLE($1, $2); }
	| interface_or_generate_item_32 extern_tf_declaration { DOUBLE($1, $2); }
	| interface_or_generate_item_35 final_construct { DOUBLE($1, $2); }
	| interface_or_generate_item_38 SEMICOLON { DOUBLE($1, SEMICOLON); }
	;

list_of_constant_arguments : list_of_constant_arguments_2 list_of_constant_arguments_3 { DOUBLE($1, $2); }
	| DOT identifier LPAREN list_of_constant_arguments_8 RPAREN list_of_constant_arguments_10 { SEXTUPLE(DOT, $2, LPAREN, $4, RPAREN, $6); }
	;

enable_gate_instance : enable_gate_instance_2 LPAREN output_terminal COMMA input_terminal COMMA enable_terminal RPAREN { OCTUPLE($1, LPAREN, $3, COMMA, $5, COMMA, $7, RPAREN); }
	;

genvar_assignment : genvar_identifier assignment_operator constant_expression { TRIPLE($1, $2, $3); }
	| inc_or_dec_operator genvar_identifier { DOUBLE($1, $2); }
	| genvar_identifier inc_or_dec_operator { DOUBLE($1, $2); }
	;

task_proto_formal : tf_input_declaration { ($1); }
	| tf_output_declaration { ($1); }
	| tf_inout_declaration { ($1); }
	| tf_ref_declaration { ($1); }
	;

continuous_assign : ASSIGN continuous_assign_3 continuous_assign_4 list_of_net_assignments SEMICOLON { QUINTUPLE(ASSIGN, $2, $3, $4, SEMICOLON); }
	| ASSIGN continuous_assign_9 list_of_variable_assignments SEMICOLON { QUADRUPLE(ASSIGN, $2, $3, SEMICOLON); }
	;

tz_path_delay_expression : path_delay_expression { ($1); }
	;

ordered_parameter_assignment : expression { ($1); }
	| data_type { ($1); }
	;

function_statement : function_statement_2 function_statement_item { DOUBLE($1, $2); }
	;

case_statement : case_statement_2 CASE LPAREN expression RPAREN case_item case_statement_8 ENDCASE { OCTUPLE($1, CASE, LPAREN, $4, RPAREN, $6, $7, ENDCASE); }
	| case_statement_11 CASEZ LPAREN expression RPAREN case_item case_statement_17 ENDCASE { OCTUPLE($1, CASEZ, LPAREN, $4, RPAREN, $6, $7, ENDCASE); }
	| case_statement_20 CASEX LPAREN expression RPAREN case_item case_statement_26 ENDCASE { OCTUPLE($1, CASEX, LPAREN, $4, RPAREN, $6, $7, ENDCASE); }
	;

non_zero_decimal_digit : TOKEN_435 { (TOKEN_435); }
	| TOKEN_687 { (TOKEN_687); }
	| TOKEN_688 { (TOKEN_688); }
	| TOKEN_689 { (TOKEN_689); }
	| TOKEN_690 { (TOKEN_690); }
	| TOKEN_691 { (TOKEN_691); }
	| TOKEN_639 { (TOKEN_639); }
	| TOKEN_272 { (TOKEN_272); }
	| TOKEN_266 { (TOKEN_266); }
	;

udp_instance_identifier : identifier { ($1); }
	;

class_scope_type_identifier : class_identifier P_COLONCOLON class_scope_type_identifier_4 type_declaration_identifier { QUADRUPLE($1, P_COLONCOLON, $3, $4); }
	| class_identifier P_COLONCOLON class_scope_type_identifier_9 class_identifier { QUADRUPLE($1, P_COLONCOLON, $3, $4); }
	;

hierarchical_net_identifier : hierarchical_identifier { ($1); }
	;

sequential_entry : seq_input_list COLON current_state COLON next_state SEMICOLON { SEXTUPLE($1, COLON, $3, COLON, $5, SEMICOLON); }
	;

controlled_timing_check_event : timing_check_event_control specify_terminal_descriptor controlled_timing_check_event_4 { TRIPLE($1, $2, $3); }
	;

delay_value : unsigned_number { ($1); }
	| real_number { ($1); }
	| identifier { ($1); }
	;

specify_input_terminal_descriptor : input_identifier specify_input_terminal_descriptor_3 { DOUBLE($1, $2); }
	;

generated_module_instantiation : GENERATE generated_module_instantiation_3 ENDGENERATE { TRIPLE(GENERATE, $2, ENDGENERATE); }
	;

simple_identifier : simple_identifier_2 simple_identifier_3 { DOUBLE($1, $2); }
	;

function_proto_formal : tf_input_declaration { ($1); }
	| tf_output_declaration { ($1); }
	| tf_inout_declaration { ($1); }
	| tf_ref_declaration { ($1); }
	;

associative_dimension : LBRACK data_type RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	| LBRACK TIMES RBRACK { TRIPLE(LBRACK, TIMES, RBRACK); }
	;

use_clause : USE use_clause_3 cell_identifier use_clause_5 { QUADRUPLE(USE, $2, $3, $4); }
	;

boolean_abbrev : consecutive_repetition { ($1); }
	| non_consecutive_repetition { ($1); }
	| goto_repetition { ($1); }
	;

attr_name : identifier { ($1); }
	;

specparam_declaration : SPECPARAM specparam_declaration_3 list_of_specparam_assignments SEMICOLON { QUADRUPLE(SPECPARAM, $2, $3, SEMICOLON); }
	;

edge_identifier : POSEDGE { (POSEDGE); }
	| NEGEDGE { (NEGEDGE); }
	;

fixed_point_number : unsigned_number DOT unsigned_number { TRIPLE($1, DOT, $3); }
	;

generate_interface_conditional_statement : IF LPAREN constant_expression RPAREN generate_interface_item generate_interface_conditional_statement_7 { SEXTUPLE(IF, LPAREN, $3, RPAREN, $5, $6); }
	;

consecutive_repetition : TOKEN_346 const_or_range_expression RBRACK { TRIPLE(TOKEN_346, $2, RBRACK); }
	;

clocking_identifier : identifier { ($1); }
	;

udp_input_declaration : udp_input_declaration_2 INPUT list_of_udp_port_identifiers { TRIPLE($1, INPUT, $3); }
	;

current_state : level_symbol { ($1); }
	;

class_item_qualifier : STATIC { (STATIC); }
	| PROTECTED { (PROTECTED); }
	| LOCAL { (LOCAL); }
	;

edge_input_list : edge_input_list_2 edge_indicator edge_input_list_4 { TRIPLE($1, $2, $3); }
	;

interface_identifier : identifier { ($1); }
	;

enable_gatetype : BUFIF0 { (BUFIF0); }
	| BUFIF1 { (BUFIF1); }
	| NOTIF0 { (NOTIF0); }
	| NOTIF1 { (NOTIF1); }
	;

pulsestyle_declaration : PULSESTYLE_ONEVENT list_of_path_outputs SEMICOLON { TRIPLE(PULSESTYLE_ONEVENT, $2, SEMICOLON); }
	| PULSESTYLE_ONDETECT list_of_path_outputs SEMICOLON { TRIPLE(PULSESTYLE_ONDETECT, $2, SEMICOLON); }
	;

inc_or_dec_operator : TOKEN_652 { (TOKEN_652); }
	| TOKEN_653 { (TOKEN_653); }
	;

constant_expression : constant_primary { ($1); }
	| unary_operator constant_expression_5 constant_primary { TRIPLE($1, $2, $3); }
	| constant_expression binary_operator constant_expression_10 constant_expression { QUADRUPLE($1, $2, $3, $4); }
	| constant_expression QUERY constant_expression_15 constant_expression COLON constant_expression { SEXTUPLE($1, QUERY, $3, $4, COLON, $6); }
	| string_literal { ($1); }
	;

delay_control : HASH delay_value { DOUBLE(HASH, $2); }
	| HASH LPAREN mintypmax_expression RPAREN { QUADRUPLE(HASH, LPAREN, $3, RPAREN); }
	;

unpacked_dimension : LBRACK dimension_constant_expression COLON dimension_constant_expression RBRACK { QUINTUPLE(LBRACK, $2, COLON, $4, RBRACK); }
	| LBRACK dimension_constant_expression RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

combinational_body : TABLE combinational_entry combinational_body_4 ENDTABLE { QUADRUPLE(TABLE, $2, $3, ENDTABLE); }
	;

mos_switch_instance : mos_switch_instance_2 LPAREN output_terminal COMMA input_terminal COMMA enable_terminal RPAREN { OCTUPLE($1, LPAREN, $3, COMMA, $5, COMMA, $7, RPAREN); }
	;

property_identifier : identifier { ($1); }
	;

mintypmax_expression : expression { ($1); }
	| expression COLON expression COLON expression { QUINTUPLE($1, COLON, $3, COLON, $5); }
	;

initial_construct : INITIAL statement_or_null { DOUBLE(INITIAL, $2); }
	;

d_recrem_timing_check : D_RECREM LPAREN reference_event COMMA data_event COMMA timing_check_limit COMMA timing_check_limit d_recrem_timing_check_11 RPAREN SEMICOLON { DUODECUPLE(D_RECREM, LPAREN, $3, COMMA, $5, COMMA, $7, COMMA, $9, $10, RPAREN, SEMICOLON); }
	;

pass_switch_instance : pass_switch_instance_2 LPAREN inout_terminal COMMA inout_terminal RPAREN { SEXTUPLE($1, LPAREN, $3, COMMA, $5, RPAREN); }
	;

par_block : FORK par_block_3 par_block_4 par_block_5 join_keyword par_block_7 { SEXTUPLE(FORK, $2, $3, $4, $5, $6); }
	;

program_instance : program_instance_identifier program_instance_3 LPAREN program_instance_5 RPAREN { QUINTUPLE($1, $2, LPAREN, $4, RPAREN); }
	;

liblist_clause : LIBLIST liblist_clause_3 { DOUBLE(LIBLIST, $2); }
	;

showcancelled_declaration : SHOWCANCELLED list_of_path_outputs SEMICOLON { TRIPLE(SHOWCANCELLED, $2, SEMICOLON); }
	| NOSHOWCANCELLED list_of_path_outputs SEMICOLON { TRIPLE(NOSHOWCANCELLED, $2, SEMICOLON); }
	;

expression1 : expression { ($1); }
	;

constant_param_expression : constant_expression { ($1); }
	;

parameter_identifier : identifier { ($1); }
	;

inside_expression : expression INSIDE range_list_or_array { TRIPLE($1, INSIDE, $3); }
	;

expression2 : expression { ($1); }
	;

variable_decl_or_assignment : data_type list_of_variable_identifiers_or_assignments { DOUBLE($1, $2); }
	| variable_assignment { ($1); }
	;

d_hold_timing_check : D_HOLD LPAREN reference_event COMMA data_event COMMA timing_check_limit d_hold_timing_check_9 RPAREN SEMICOLON { DECUPLE(D_HOLD, LPAREN, $3, COMMA, $5, COMMA, $7, $8, RPAREN, SEMICOLON); }
	;

module_path_multiple_concatenation : LCURLY constant_expression module_path_concatenation RCURLY { QUADRUPLE(LCURLY, $2, $3, RCURLY); }
	;

expression3 : expression { ($1); }
	;

class_item : class_item_2 class_property { DOUBLE($1, $2); }
	| class_item_5 class_method { DOUBLE($1, $2); }
	| class_item_8 class_constraint { DOUBLE($1, $2); }
	;

actual_arg_list : LPAREN actual_arg_expr actual_arg_list_4 RPAREN { QUADRUPLE(LPAREN, $2, $3, RPAREN); }
	| LPAREN DOT formal_identifier LPAREN actual_arg_expr RPAREN actual_arg_list_13 RPAREN { OCTUPLE(LPAREN, DOT, $3, LPAREN, $5, RPAREN, $7, RPAREN); }
	;

library_text : library_text_2 { ($1); }
	;

inout_declaration : INOUT inout_declaration_3 list_of_port_identifiers { TRIPLE(INOUT, $2, $3); }
	| INOUT data_type list_of_variable_identifiers { TRIPLE(INOUT, $2, $3); }
	;

generate_interface_item : generate_interface_conditional_statement { ($1); }
	| generate_interface_case_statement { ($1); }
	| generate_interface_loop_statement { ($1); }
	| generate_interface_item_8 generate_interface_block { DOUBLE($1, $2); }
	| interface_or_generate_item { ($1); }
	;

function_identifier : identifier { ($1); }
	;

event_expression : event_expression_2 expression event_expression_4 { TRIPLE($1, $2, $3); }
	| event_expression OR event_expression { TRIPLE($1, OR, $3); }
	| event_expression COMMA event_expression { TRIPLE($1, COMMA, $3); }
	;

module_path_primary : number { ($1); }
	| identifier { ($1); }
	| module_path_concatenation { ($1); }
	| module_path_multiple_concatenation { ($1); }
	| function_call { ($1); }
	| system_function_call { ($1); }
	| constant_function_call { ($1); }
	| LPAREN module_path_mintypmax_expression RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

block_comment : TOKEN_BEGIN_COMMENT comment_text TOKEN_END_COMMENT { TRIPLE(TOKEN_BEGIN_COMMENT, $2, TOKEN_END_COMMENT); }
	;

attribute_instance : TOKEN_697 attr_spec attribute_instance_4 TOKEN_699 { QUADRUPLE(TOKEN_697, $2, $3, TOKEN_699); }
	;

reference_event : timing_check_event { ($1); }
	;

octal_base : SQUOTE octal_base_3 'O' { TRIPLE(SQUOTE, $2, CHAR 'O'); }
	| SQUOTE octal_base_7 'O' { TRIPLE(SQUOTE, $2, CHAR 'O'); }
	;

constant_mintypmax_expression : constant_expression { ($1); }
	| constant_expression COLON constant_expression COLON constant_expression { QUINTUPLE($1, COLON, $3, COLON, $5); }
	;

error_limit_value : limit_value { ($1); }
	;

sequence_abbrev : consecutive_repetition { ($1); }
	;

constraint_set : constraint_expression { ($1); }
	| LCURLY constraint_set_5 RCURLY { TRIPLE(LCURLY, $2, RCURLY); }
	;

parameter_value_assignment : HASH LPAREN list_of_parameter_assignments RPAREN { QUADRUPLE(HASH, LPAREN, $3, RPAREN); }
	;

list_of_port_connections : ordered_port_connection list_of_port_connections_3 { DOUBLE($1, $2); }
	| dot_named_port_connection list_of_port_connections_6 { DOUBLE($1, $2); }
	| list_of_port_connections_8 dot_star_port_connection list_of_port_connections_10 { TRIPLE($1, $2, $3); }
	;

hex_value : hex_digit hex_value_3 { DOUBLE($1, $2); }
	;

net_type : SUPPLY0 { (SUPPLY0); }
	| SUPPLY1 { (SUPPLY1); }
	| TRI { (TRI); }
	| TRIAND { (TRIAND); }
	| TRIOR { (TRIOR); }
	| TRI0 { (TRI0); }
	| TRI1 { (TRI1); }
	| WIRE { (WIRE); }
	| WAND { (WAND); }
	| WOR { (WOR); }
	;

operator_assignment : variable_lvalue assignment_operator expression { TRIPLE($1, $2, $3); }
	;

net_assignment : net_lvalue EQUALS expression { TRIPLE($1, EQUALS, $3); }
	;

range_or_type : range_or_type_2 range { DOUBLE($1, $2); }
	| function_data_type { ($1); }
	;

conditional_statement : conditional_statement_2 IF LPAREN expression RPAREN statement_or_null conditional_statement_8 { SEPTUPLE($1, IF, LPAREN, $4, RPAREN, $6, $7); }
	| if_else_if_statement { ($1); }
	;

reject_limit_value : limit_value { ($1); }
	;

system_function_call : system_function_identifier system_function_call_3 { DOUBLE($1, $2); }
	;

pull_gate_instance : pull_gate_instance_2 LPAREN output_terminal RPAREN { QUADRUPLE($1, LPAREN, $3, RPAREN); }
	;

d_removal_timing_check : D_REMOVAL LPAREN reference_event COMMA data_event COMMA timing_check_limit d_removal_timing_check_9 RPAREN SEMICOLON { DECUPLE(D_REMOVAL, LPAREN, $3, COMMA, $5, COMMA, $7, $8, RPAREN, SEMICOLON); }
	;

task_or_function_identifier : task_identifier { ($1); }
	| function_identifier { ($1); }
	;

attr_spec : attr_name EQUALS constant_expression { TRIPLE($1, EQUALS, $3); }
	| attr_name { ($1); }
	;

modport_ports_declaration : modport_simple_ports_declaration { ($1); }
	| modport_hierarchical_ports_declaration { ($1); }
	| modport_tf_ports_declaration { ($1); }
	;

data_source_expression : expression { ($1); }
	;

sequence_formal_list : LPAREN formal_list_item sequence_formal_list_4 RPAREN { QUADRUPLE(LPAREN, $2, $3, RPAREN); }
	;

pullup_strength : LPAREN strength0 COMMA strength1 RPAREN { QUINTUPLE(LPAREN, $2, COMMA, $4, RPAREN); }
	| LPAREN strength1 COMMA strength0 RPAREN { QUINTUPLE(LPAREN, $2, COMMA, $4, RPAREN); }
	| LPAREN strength1 RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

list_of_tf_port_identifiers : port_identifier list_of_tf_port_identifiers_3 list_of_tf_port_identifiers_4 list_of_tf_port_identifiers_5 { QUADRUPLE($1, $2, $3, $4); }
	;

d_period_timing_check : D_PERIOD LPAREN controlled_reference_event COMMA timing_check_limit d_period_timing_check_7 RPAREN SEMICOLON { OCTUPLE(D_PERIOD, LPAREN, $3, COMMA, $5, $6, RPAREN, SEMICOLON); }
	;

blocking_assignment : variable_lvalue EQUALS delay_or_event_control expression { QUADRUPLE($1, EQUALS, $3, $4); }
	| hierarchical_variable_identifier EQUALS NEW LBRACK constant_expression RBRACK blocking_assignment_13 { SEPTUPLE($1, EQUALS, NEW, LBRACK, $5, RBRACK, $7); }
	| class_identifier blocking_assignment_16 EQUALS NEW blocking_assignment_19 { QUINTUPLE($1, $2, EQUALS, NEW, $5); }
	| class_identifier DOT RANDOMIZE blocking_assignment_24 WITH constraint_block SEMICOLON { SEPTUPLE($1, DOT, RANDOMIZE, $4, WITH, $6, SEMICOLON); }
	| operator_assignment { ($1); }
	;

edge_sensitive_path_declaration : parallel_edge_sensitive_path_description EQUALS path_delay_value { TRIPLE($1, EQUALS, $3); }
	| full_edge_sensitive_path_description EQUALS path_delay_value { TRIPLE($1, EQUALS, $3); }
	;

task_enable : hierarchical_task_identifier task_enable_3 SEMICOLON { TRIPLE($1, $2, SEMICOLON); }
	;

exp : 'E' { (CHAR 'E'); }
	| 'E' { (CHAR 'E'); }
	;

type_declaration : TYPEDEF type_declaration_3 type_declaration_identifier SEMICOLON { QUADRUPLE(TYPEDEF, $2, $3, SEMICOLON); }
	| TYPEDEF hierarchical_identifier DOT type_identifier type_declaration_identifier SEMICOLON { SEXTUPLE(TYPEDEF, $2, DOT, $4, $5, SEMICOLON); }
	| TYPEDEF type_declaration_15 class_identifier SEMICOLON { QUADRUPLE(TYPEDEF, $2, $3, SEMICOLON); }
	| TYPEDEF class_identifier type_declaration_21 type_declaration_identifier SEMICOLON { QUINTUPLE(TYPEDEF, $2, $3, $4, SEMICOLON); }
	;

tz0_path_delay_expression : path_delay_expression { ($1); }
	;

task_identifier : identifier { ($1); }
	;

function_loop_statement : FOREVER function_statement_or_null { DOUBLE(FOREVER, $2); }
	| REPEAT LPAREN expression RPAREN function_statement_or_null { QUINTUPLE(REPEAT, LPAREN, $3, RPAREN, $5); }
	| WHILE LPAREN expression RPAREN function_statement_or_null { QUINTUPLE(WHILE, LPAREN, $3, RPAREN, $5); }
	| FOR LPAREN variable_decl_or_assignment function_loop_statement_20 SEMICOLON expression SEMICOLON variable_assignment function_loop_statement_25 RPAREN function_statement_or_null { UNDECUPLE(FOR, LPAREN, $3, $4, SEMICOLON, $6, SEMICOLON, $8, $9, RPAREN, $11); }
	| DO function_statement_or_null WHILE LPAREN expression RPAREN SEMICOLON { SEPTUPLE(DO, $2, WHILE, LPAREN, $5, RPAREN, SEMICOLON); }
	;

join_keyword : JOIN { (JOIN); }
	| JOIN_ANY { (JOIN_ANY); }
	| JOIN_NONE { (JOIN_NONE); }
	;

specify_block : SPECIFY specify_block_3 ENDSPECIFY { TRIPLE(SPECIFY, $2, ENDSPECIFY); }
	;

pulse_control_specparam : PATHPULSE EQUALS LPAREN reject_limit_value pulse_control_specparam_6 RPAREN SEMICOLON { SEPTUPLE(PATHPULSE, EQUALS, LPAREN, $4, $5, RPAREN, SEMICOLON); }
	| PATHPULSE specify_input_terminal_descriptor DOLLAR specify_output_terminal_descriptor EQUALS LPAREN reject_limit_value pulse_control_specparam_17 RPAREN SEMICOLON { DECUPLE(PATHPULSE, $2, DOLLAR, $4, EQUALS, LPAREN, $7, $8, RPAREN, SEMICOLON); }
	;

module_or_generate_item : module_or_generate_item_2 parameter_override { DOUBLE($1, $2); }
	| module_or_generate_item_5 continuous_assign { DOUBLE($1, $2); }
	| module_or_generate_item_8 gate_instantiation { DOUBLE($1, $2); }
	| module_or_generate_item_11 udp_instantiation { DOUBLE($1, $2); }
	| module_or_generate_item_14 module_instantiation { DOUBLE($1, $2); }
	| module_or_generate_item_17 initial_construct { DOUBLE($1, $2); }
	| module_or_generate_item_20 always_construct { DOUBLE($1, $2); }
	| module_or_generate_item_23 combinational_construct { DOUBLE($1, $2); }
	| module_or_generate_item_26 latch_construct { DOUBLE($1, $2); }
	| module_or_generate_item_29 ff_construct { DOUBLE($1, $2); }
	| module_or_generate_item_32 net_alias { DOUBLE($1, $2); }
	| module_or_generate_item_35 final_construct { DOUBLE($1, $2); }
	| module_common_item { ($1); }
	| module_or_generate_item_40 SEMICOLON { DOUBLE($1, SEMICOLON); }
	;

udp_body : combinational_body { ($1); }
	| sequential_body { ($1); }
	;

decimal_digit : TOKEN_436 { (TOKEN_436); }
	| TOKEN_435 { (TOKEN_435); }
	| TOKEN_687 { (TOKEN_687); }
	| TOKEN_688 { (TOKEN_688); }
	| TOKEN_689 { (TOKEN_689); }
	| TOKEN_690 { (TOKEN_690); }
	| TOKEN_691 { (TOKEN_691); }
	| TOKEN_639 { (TOKEN_639); }
	| TOKEN_272 { (TOKEN_272); }
	| TOKEN_266 { (TOKEN_266); }
	;

genvar_identifier : identifier { ($1); }
	;

stamptime_condition : mintypmax_expression { ($1); }
	;

binary_digit : x_digit { ($1); }
	| z_digit { ($1); }
	| TOKEN_436 { (TOKEN_436); }
	| TOKEN_435 { (TOKEN_435); }
	;

hex_base : SQUOTE hex_base_3 'H' { TRIPLE(SQUOTE, $2, CHAR 'H'); }
	| SQUOTE hex_base_7 'H' { TRIPLE(SQUOTE, $2, CHAR 'H'); }
	;

config_declaration : CONFIG config_identifier SEMICOLON design_statement config_declaration_6 ENDCONFIG { SEXTUPLE(CONFIG, $2, SEMICOLON, $4, $5, ENDCONFIG); }
	;

implicit_class_handle : implicit_class_handle_2 { ($1); }
	| implicit_class_handle_4 { ($1); }
	;

procedural_continuous_assignments : ASSIGN variable_assignment { DOUBLE(ASSIGN, $2); }
	| DEASSIGN variable_lvalue { DOUBLE(DEASSIGN, $2); }
	| FORCE variable_assignment { DOUBLE(FORCE, $2); }
	| FORCE net_assignment { DOUBLE(FORCE, $2); }
	| RELEASE variable_lvalue { DOUBLE(RELEASE, $2); }
	| RELEASE net_lvalue { DOUBLE(RELEASE, $2); }
	;

specify_item : specparam_declaration { ($1); }
	| pulsestyle_declaration { ($1); }
	| showcancelled_declaration { ($1); }
	| path_declaration { ($1); }
	| system_timing_check { ($1); }
	;

specify_output_terminal_descriptor : output_identifier specify_output_terminal_descriptor_3 { DOUBLE($1, $2); }
	;

sequence_declaration : SEQUENCE sequence_identifier sequence_declaration_4 SEMICOLON sequence_declaration_6 sequence_spec SEMICOLON ENDSEQUENCE sequence_declaration_10 { NONUPLE(SEQUENCE, $2, $3, SEMICOLON, $5, $6, SEMICOLON, ENDSEQUENCE, $9); }
	;

data_type : integer_vector_type data_type_3 data_type_4 data_type_5 { QUADRUPLE($1, $2, $3, $4); }
	| integer_atom_type data_type_8 { DOUBLE($1, $2); }
	| type_declaration_identifier data_type_11 { DOUBLE($1, $2); }
	| non_integer_type { ($1); }
	| STRUCT PACKED data_type_17 LCURLY data_type_19 RCURLY data_type_21 { SEPTUPLE(STRUCT, PACKED, $3, LCURLY, $5, RCURLY, $7); }
	| UNION PACKED data_type_25 LCURLY data_type_27 RCURLY data_type_29 { SEPTUPLE(UNION, PACKED, $3, LCURLY, $5, RCURLY, $7); }
	| STRUCT data_type_32 LCURLY data_type_34 RCURLY { QUINTUPLE(STRUCT, $2, LCURLY, $4, RCURLY); }
	| UNION data_type_38 LCURLY data_type_40 RCURLY { QUINTUPLE(UNION, $2, LCURLY, $4, RCURLY); }
	| ENUM data_type_44 LCURLY enum_identifier data_type_47 data_type_48 RCURLY { SEPTUPLE(ENUM, $2, LCURLY, $4, $5, $6, RCURLY); }
	| STRING { (STRING); }
	| EVENT { (EVENT); }
	| CHANDLE { (CHANDLE); }
	| class_scope_type_identifier { ($1); }
	;

signal_identifier : identifier { ($1); }
	;

constant_concatenation : LCURLY constant_expression constant_concatenation_4 RCURLY { QUADRUPLE(LCURLY, $2, $3, RCURLY); }
	| LCURLY struct_member_label COLON constant_expression constant_concatenation_11 RCURLY { SEXTUPLE(LCURLY, $2, COLON, $4, $5, RCURLY); }
	| LCURLY array_member_label COLON constant_expression constant_concatenation_18 RCURLY { SEXTUPLE(LCURLY, $2, COLON, $4, $5, RCURLY); }
	;

tx0_path_delay_expression : path_delay_expression { ($1); }
	;

signing : SIGNED { (SIGNED); }
	| UNSIGNED { (UNSIGNED); }
	;

interface_nonansi_header : interface_nonansi_header_2 INTERFACE interface_nonansi_header_4 interface_identifier interface_nonansi_header_6 list_of_ports SEMICOLON { SEPTUPLE($1, INTERFACE, $3, $4, $5, $6, SEMICOLON); }
	;

hierarchical_identifier : simple_hierarchical_identifier { ($1); }
	| escaped_hierarchical_identifier { ($1); }
	;

expression : primary { ($1); }
	| unary_operator expression_5 primary { TRIPLE($1, $2, $3); }
	| inc_or_dec_expression { ($1); }
	| LPAREN operator_assignment RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	| expression binary_operator expression_16 expression { QUADRUPLE($1, $2, $3, $4); }
	| conditional_expression { ($1); }
	| string_literal { ($1); }
	| inside_expression { ($1); }
	;

import_export : IMPORT { (IMPORT); }
	| EXPORT { (EXPORT); }
	;

program_item : port_declaration SEMICOLON { DOUBLE($1, SEMICOLON); }
	| non_port_program_item { ($1); }
	;

block_data_declaration : block_variable_declaration { ($1); }
	| constant_declaration { ($1); }
	| type_declaration { ($1); }
	;

clocking_skew : edge_identifier clocking_skew_3 { DOUBLE($1, $2); }
	| delay_control { ($1); }
	;

gate_instantiation : cmos_switchtype gate_instantiation_3 cmos_switch_instance gate_instantiation_5 SEMICOLON { QUINTUPLE($1, $2, $3, $4, SEMICOLON); }
	| enable_gatetype gate_instantiation_9 gate_instantiation_10 enable_gate_instance gate_instantiation_12 SEMICOLON { SEXTUPLE($1, $2, $3, $4, $5, SEMICOLON); }
	| mos_switchtype gate_instantiation_16 mos_switch_instance gate_instantiation_18 SEMICOLON { QUINTUPLE($1, $2, $3, $4, SEMICOLON); }
	| n_input_gatetype gate_instantiation_22 gate_instantiation_23 n_input_gate_instance gate_instantiation_25 SEMICOLON { SEXTUPLE($1, $2, $3, $4, $5, SEMICOLON); }
	| n_output_gatetype gate_instantiation_29 gate_instantiation_30 n_output_gate_instance gate_instantiation_32 SEMICOLON { SEXTUPLE($1, $2, $3, $4, $5, SEMICOLON); }
	| pass_en_switchtype gate_instantiation_36 pass_enable_switch_instance gate_instantiation_38 SEMICOLON { QUINTUPLE($1, $2, $3, $4, SEMICOLON); }
	| pass_switchtype pass_switch_instance gate_instantiation_43 SEMICOLON { QUADRUPLE($1, $2, $3, SEMICOLON); }
	| PULLDOWN gate_instantiation_47 pull_gate_instance gate_instantiation_49 SEMICOLON { QUINTUPLE(PULLDOWN, $2, $3, $4, SEMICOLON); }
	| PULLUP gate_instantiation_53 pull_gate_instance gate_instantiation_55 SEMICOLON { QUINTUPLE(PULLUP, $2, $3, $4, SEMICOLON); }
	;

t10_path_delay_expression : path_delay_expression { ($1); }
	;

range_expression : expression { ($1); }
	| msb_constant_expression COLON lsb_constant_expression { TRIPLE($1, COLON, $3); }
	| base_expression P_PLUSCOLON width_constant_expression { TRIPLE($1, P_PLUSCOLON, $3); }
	| base_expression P_MINUSCOLON width_constant_expression { TRIPLE($1, P_MINUSCOLON, $3); }
	;

list_of_type_assignments : type_assignment list_of_type_assignments_3 { DOUBLE($1, $2); }
	;

edge_symbol : 'R' { (CHAR 'R'); }
	| 'R' { (CHAR 'R'); }
	| 'F' { (CHAR 'F'); }
	| 'F' { (CHAR 'F'); }
	| 'P' { (CHAR 'P'); }
	| 'P' { (CHAR 'P'); }
	| 'N' { (CHAR 'N'); }
	| 'N' { (CHAR 'N'); }
	| TIMES { (TIMES); }
	;

generate_interface_loop_statement : FOR LPAREN genvar_decl_assignment SEMICOLON constant_expression SEMICOLON genvar_assignment RPAREN generate_interface_named_block { NONUPLE(FOR, LPAREN, $3, SEMICOLON, $5, SEMICOLON, $7, RPAREN, $9); }
	;

statement : statement_2 statement_item { DOUBLE($1, $2); }
	;

binary_module_path_operator : P_EQUAL { (P_EQUAL); }
	| P_NOTEQUAL { (P_NOTEQUAL); }
	| P_ANDAND { (P_ANDAND); }
	| TOKEN_651 { (TOKEN_651); }
	| AMPERSAND { (AMPERSAND); }
	| VBAR { (VBAR); }
	| CARET { (CARET); }
	| P_XNOR { (P_XNOR); }
	| P_XNOR { (P_XNOR); }
	;

system_function_identifier : DOLLAR system_function_identifier_3 { DOUBLE(DOLLAR, $2); }
	;

concurrent_assert_statement : concurrent_assert_statement_2 assert_property_statement { DOUBLE($1, $2); }
	;

port_expression_6 : COMMA port_reference { DOUBLE(COMMA, $2); }
	;

tf_output_declaration_3 : signing { ($1); }
	;

tf_output_declaration_4 : packed_dimension { ($1); }
	;

d_nochange_timing_check_11_3 : notify_reg { ($1); }
	;

d_nochange_timing_check_11 : COMMA d_nochange_timing_check_11_3 { DOUBLE(COMMA, $2); }
	;

tf_input_declaration_3 : signing { ($1); }
	;

tf_input_declaration_4 : packed_dimension { ($1); }
	;

cmos_switch_instance_2 : name_of_gate_instance { ($1); }
	;

list_of_interface_identifiers_3 : unpacked_dimension { ($1); }
	;

list_of_interface_identifiers_4_4 : unpacked_dimension { ($1); }
	;

list_of_interface_identifiers_4 : COMMA interface_identifier list_of_interface_identifiers_4_4 { TRIPLE(COMMA, $2, $3); }
	;

n_input_gate_instance_2 : name_of_gate_instance { ($1); }
	;

n_input_gate_instance_7 : COMMA input_terminal { DOUBLE(COMMA, $2); }
	;

list_of_arguments_2 : expression { ($1); }
	;

list_of_arguments_3_3 : expression { ($1); }
	;

list_of_arguments_3 : COMMA list_of_arguments_3_3 { DOUBLE(COMMA, $2); }
	;

list_of_arguments_8 : expression { ($1); }
	;

list_of_arguments_10_6 : expression { ($1); }
	;

list_of_arguments_10 : COMMA DOT identifier LPAREN list_of_arguments_10_6 RPAREN { SEXTUPLE(COMMA, DOT, $3, LPAREN, $5, RPAREN); }
	;

function_body_declaration_2 : signing { ($1); }
	;

function_body_declaration_3 : range_or_type { ($1); }
	;

function_body_declaration_4 : interface_identifier DOT { DOUBLE($1, DOT); }
	;

function_body_declaration_7 : function_item_declaration { ($1); }
	;

function_body_declaration_8 : function_statement_or_null { ($1); }
	;

function_body_declaration_10 : COLON function_identifier { DOUBLE(COLON, $2); }
	;

function_body_declaration_12 : signing { ($1); }
	;

function_body_declaration_13 : range_or_type { ($1); }
	;

function_body_declaration_14 : interface_identifier DOT { DOUBLE($1, DOT); }
	;

function_body_declaration_20 : block_item_declaration { ($1); }
	;

function_body_declaration_21 : function_statement_or_null { ($1); }
	;

function_body_declaration_23 : COLON function_identifier { DOUBLE(COLON, $2); }
	;

module_common_item_2 : attribute_instance { ($1); }
	;

module_common_item_5 : attribute_instance { ($1); }
	;

module_common_item_8 : attribute_instance { ($1); }
	;

module_common_item_11 : attribute_instance { ($1); }
	;

module_common_item_14 : attribute_instance { ($1); }
	;

function_case_statement_2 : unique_priority { ($1); }
	;

function_case_statement_8 : function_case_item { ($1); }
	;

function_case_statement_11 : unique_priority { ($1); }
	;

function_case_statement_17 : function_case_item { ($1); }
	;

function_case_statement_20 : unique_priority { ($1); }
	;

function_case_statement_26 : function_case_item { ($1); }
	;

list_of_function_proto_formals_2_2 : attribute_instance { ($1); }
	;

list_of_function_proto_formals_2_4_3 : attribute_instance { ($1); }
	;

list_of_function_proto_formals_2_4 : COMMA list_of_function_proto_formals_2_4_3 function_proto_formal { TRIPLE(COMMA, $2, $3); }
	;

list_of_function_proto_formals_2 : list_of_function_proto_formals_2_2 function_proto_formal list_of_function_proto_formals_2_4 { TRIPLE($1, $2, $3); }
	;

action_block_4 : statement { ($1); }
	;

decimal_base_3 : 's' { (CHAR 's'); }
	| 'S' { (CHAR 'S'); }
	;

decimal_base_7 : 's' { (CHAR 's'); }
	| 'S' { (CHAR 'S'); }
	;

named_task_proto_5 : COMMA task_proto_formal { DOUBLE(COMMA, $2); }
	;

udp_nonansi_declaration_2 : attribute_instance { ($1); }
	;

port_reference_3 : LBRACK constant_range_expression RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

dot_star_port_connection_2 : attribute_instance { ($1); }
	;

modport_item_5 : COMMA modport_ports_declaration { DOUBLE(COMMA, $2); }
	;

name_of_instance_3 : range { ($1); }
	;

octal_number_2 : size { ($1); }
	;

constant_function_call_3 : attribute_instance { ($1); }
	;

constant_function_call_4 : LPAREN list_of_constant_arguments RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

variable_decl_assignment_3 : variable_dimension { ($1); }
	;

variable_decl_assignment_4 : EQUALS constant_expression { DOUBLE(EQUALS, $2); }
	;

variable_decl_assignment_14 : LPAREN variable_identifier RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

variable_decl_assignment_17 : parameter_value_assignment { ($1); }
	;

variable_decl_assignment_20 : LPAREN list_of_arguments RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

task_port_list_3 : COMMA task_port_item { DOUBLE(COMMA, $2); }
	;

task_port_list_6 : COMMA task_port_item { DOUBLE(COMMA, $2); }
	;

conditional_expression_4 : attribute_instance { ($1); }
	;

modport_hierarchical_ports_declaration_3 : LBRACK constant_expression RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

function_conditional_statement_2 : unique_priority { ($1); }
	;

function_conditional_statement_8 : ELSE function_statement_or_null { DOUBLE(ELSE, $2); }
	;

list_of_variable_decl_assignments_3 : COMMA variable_decl_assignment { DOUBLE(COMMA, $2); }
	;

list_of_variable_port_identifiers_4 : EQUALS constant_expression { DOUBLE(EQUALS, $2); }
	;

list_of_variable_port_identifiers_5_5 : EQUALS constant_expression { DOUBLE(EQUALS, $2); }
	;

list_of_variable_port_identifiers_5 : COMMA port_identifier variable_dimension list_of_variable_port_identifiers_5_5 { QUADRUPLE(COMMA, $2, $3, $4); }
	;

design_statement_3_2 : library_identifier DOT { DOUBLE($1, DOT); }
	;

design_statement_3 : design_statement_3_2 cell_identifier { DOUBLE($1, $2); }
	;

formal_list_item_3 : EQUALS actual_arg_expr { DOUBLE(EQUALS, $2); }
	;

list_of_port_declarations_4 : COMMA port_declaration { DOUBLE(COMMA, $2); }
	;

dpi_function_proto_4 : signing { ($1); }
	;

clocking_decl_2 : DEFAULT { (DEFAULT); }
	;

clocking_decl_4 : clocking_identifier { ($1); }
	;

clocking_decl_7 : clocking_item { ($1); }
	;

dpi_dimension_4 : LBRACK RBRACK { DOUBLE(LBRACK, RBRACK); }
	;

udp_output_declaration_2 : attribute_instance { ($1); }
	;

udp_output_declaration_6 : attribute_instance { ($1); }
	;

udp_output_declaration_10 : EQUALS constant_expression { DOUBLE(EQUALS, $2); }
	;

full_path_description_4 : polarity_operator { ($1); }
	;

pass_enable_switch_instance_2 : name_of_gate_instance { ($1); }
	;

parameter_declaration_3 : signing { ($1); }
	;

parameter_declaration_4 : packed_dimension { ($1); }
	;

parameter_declaration_5 : range { ($1); }
	;

generate_interface_case_statement_7 : genvar_interface_case_item { ($1); }
	;

generated_interface_instantiation_3 : generate_interface_item { ($1); }
	;

list_of_net_decl_assignments_3 : COMMA net_decl_assignment { DOUBLE(COMMA, $2); }
	;

modport_tf_port_4 : COMMA named_task_proto { DOUBLE(COMMA, $2); }
	;

modport_tf_port_8 : COMMA named_function_proto { DOUBLE(COMMA, $2); }
	;

modport_tf_port_11 : COMMA task_or_function_identifier { DOUBLE(COMMA, $2); }
	;

simple_hierarchical_branch_3 : LBRACK unsigned_number RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

simple_hierarchical_branch_4_2_4 : LBRACK unsigned_number RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

simple_hierarchical_branch_4_2 : DOT simple_identifier simple_hierarchical_branch_4_2_4 { TRIPLE(DOT, $2, $3); }
	;

simple_hierarchical_branch_4 : simple_hierarchical_branch_4_2 { ($1); }
	;

delay2_8 : COMMA mintypmax_expression { DOUBLE(COMMA, $2); }
	;

class_declaration_2 : attribute_instance { ($1); }
	;

class_declaration_3 : VIRTUAL { (VIRTUAL); }
	;

class_declaration_5 : lifetime { ($1); }
	;

class_declaration_7 : parameter_port_list { ($1); }
	;

class_declaration_8 : EXTENDS class_identifier { DOUBLE(EXTENDS, $2); }
	;

class_declaration_10 : timeunits_declaration { ($1); }
	;

class_declaration_11 : class_item { ($1); }
	;

class_declaration_13 : COLON class_identifier { DOUBLE(COLON, $2); }
	;

delay3_8_4 : COMMA mintypmax_expression { DOUBLE(COMMA, $2); }
	;

delay3_8 : COMMA mintypmax_expression delay3_8_4 { TRIPLE(COMMA, $2, $3); }
	;

inst_name_3 : DOT instance_identifier { DOUBLE(DOT, $2); }
	;

list_of_dpi_proto_formals_2_2 : attribute_instance { ($1); }
	;

list_of_dpi_proto_formals_2_4_3 : attribute_instance { ($1); }
	;

list_of_dpi_proto_formals_2_4 : COMMA list_of_dpi_proto_formals_2_4_3 dpi_proto_formal { TRIPLE(COMMA, $2, $3); }
	;

list_of_dpi_proto_formals_2 : list_of_dpi_proto_formals_2_2 dpi_proto_formal list_of_dpi_proto_formals_2_4 { TRIPLE($1, $2, $3); }
	;

binary_base_3 : 's' { (CHAR 's'); }
	| 'S' { (CHAR 'S'); }
	;

binary_base_7 : 's' { (CHAR 's'); }
	| 'S' { (CHAR 'S'); }
	;

simple_hierarchical_identifier_3 : DOT escaped_identifier { DOUBLE(DOT, $2); }
	;

extern_method_declaration_3 : lifetime { ($1); }
	;

extern_method_declaration_9 : lifetime { ($1); }
	;

udp_instance_2 : name_of_udp_instance { ($1); }
	;

udp_instance_3 : range { ($1); }
	;

udp_instance_8 : COMMA input_terminal { DOUBLE(COMMA, $2); }
	;

module_ansi_header_2 : attribute_instance { ($1); }
	;

module_ansi_header_4 : lifetime { ($1); }
	;

module_ansi_header_6 : parameter_port_list { ($1); }
	;

module_ansi_header_7 : list_of_port_declarations { ($1); }
	;

inc_or_dec_expression_3 : attribute_instance { ($1); }
	;

inc_or_dec_expression_7 : attribute_instance { ($1); }
	;

unsigned_number_3 : TOKEN_661 { (TOKEN_661); }
	| decimal_digit { ($1); }
	;

named_parameter_assignment_5 : expression { ($1); }
	;

statement_or_null_4 : attribute_instance { ($1); }
	;

non_port_module_item_2 : attribute_instance { ($1); }
	;

non_port_module_item_5 : attribute_instance { ($1); }
	;

non_port_module_item_10 : attribute_instance { ($1); }
	;

non_port_module_item_14 : attribute_instance { ($1); }
	;

non_port_module_item_17 : attribute_instance { ($1); }
	;

task_port_item_2 : attribute_instance { ($1); }
	;

task_port_item_5 : attribute_instance { ($1); }
	;

task_port_item_8 : attribute_instance { ($1); }
	;

task_port_item_11 : attribute_instance { ($1); }
	;

task_port_item_15 : attribute_instance { ($1); }
	;

task_port_item_19 : attribute_instance { ($1); }
	;

variable_dimension_2 : unpacked_dimension { ($1); }
	;

d_setuphold_timing_check_11_3 : notify_reg { ($1); }
	;

d_setuphold_timing_check_11_4_3 : stamptime_condition { ($1); }
	;

d_setuphold_timing_check_11_4_4_3 : checktime_condition { ($1); }
	;

d_setuphold_timing_check_11_4_4_4_3 : delayed_reference { ($1); }
	;

d_setuphold_timing_check_11_4_4_4_4_3 : delayed_data { ($1); }
	;

d_setuphold_timing_check_11_4_4_4_4 : COMMA d_setuphold_timing_check_11_4_4_4_4_3 { DOUBLE(COMMA, $2); }
	;

d_setuphold_timing_check_11_4_4_4 : COMMA d_setuphold_timing_check_11_4_4_4_3 d_setuphold_timing_check_11_4_4_4_4 { TRIPLE(COMMA, $2, $3); }
	;

d_setuphold_timing_check_11_4_4 : COMMA d_setuphold_timing_check_11_4_4_3 d_setuphold_timing_check_11_4_4_4 { TRIPLE(COMMA, $2, $3); }
	;

d_setuphold_timing_check_11_4 : COMMA d_setuphold_timing_check_11_4_3 d_setuphold_timing_check_11_4_4 { TRIPLE(COMMA, $2, $3); }
	;

d_setuphold_timing_check_11 : COMMA d_setuphold_timing_check_11_3 d_setuphold_timing_check_11_4 { TRIPLE(COMMA, $2, $3); }
	;

genvar_interface_case_item_3 : COMMA constant_expression { DOUBLE(COMMA, $2); }
	;

genvar_interface_case_item_8 : COLON { (COLON); }
	;

variable_declaration_2 : lifetime { ($1); }
	;

function_statement_or_null_4 : attribute_instance { ($1); }
	;

module_instantiation_3 : parameter_value_assignment { ($1); }
	;

module_instantiation_5 : COMMA module_instance { DOUBLE(COMMA, $2); }
	;

ordered_port_connection_2 : attribute_instance { ($1); }
	;

ordered_port_connection_3 : expression { ($1); }
	;

if_else_if_statement_2 : unique_priority { ($1); }
	;

if_else_if_statement_8_3 : unique_priority { ($1); }
	;

if_else_if_statement_8 : ELSE if_else_if_statement_8_3 IF LPAREN expression RPAREN statement_or_null { SEPTUPLE(ELSE, $2, IF, LPAREN, $5, RPAREN, $7); }
	;

if_else_if_statement_9 : ELSE statement_or_null { DOUBLE(ELSE, $2); }
	;

generate_interface_named_block_5 : generate_interface_item { ($1); }
	;

generate_interface_named_block_7 : COLON generate_block_identifier { DOUBLE(COLON, $2); }
	;

function_if_else_if_statement_2 : unique_priority { ($1); }
	;

function_if_else_if_statement_8_3 : unique_priority { ($1); }
	;

function_if_else_if_statement_8 : ELSE function_if_else_if_statement_8_3 IF LPAREN expression RPAREN function_statement_or_null { SEPTUPLE(ELSE, $2, IF, LPAREN, $5, RPAREN, $7); }
	;

function_if_else_if_statement_9 : ELSE function_statement_or_null { DOUBLE(ELSE, $2); }
	;

function_case_item_3 : COMMA expression { DOUBLE(COMMA, $2); }
	;

function_case_item_8 : COLON { (COLON); }
	;

library_declaration_5 : COMMA file_path_spec { DOUBLE(COMMA, $2); }
	;

library_declaration_6_4 : COMMA file_path_spec { DOUBLE(COMMA, $2); }
	;

library_declaration_6 : INCDIR file_path_spec library_declaration_6_4 { TRIPLE(INCDIR, $2, $3); }
	;

modport_declaration_4 : COMMA modport_item { DOUBLE(COMMA, $2); }
	;

input_declaration_3 : port_type { ($1); }
	;

parallel_path_description_4 : polarity_operator { ($1); }
	;

local_parameter_declaration_3 : signing { ($1); }
	;

local_parameter_declaration_4 : packed_dimension { ($1); }
	;

local_parameter_declaration_5 : range { ($1); }
	;

function_item_declaration_4 : attribute_instance { ($1); }
	;

function_item_declaration_8 : attribute_instance { ($1); }
	;

function_item_declaration_12 : attribute_instance { ($1); }
	;

function_item_declaration_16 : attribute_instance { ($1); }
	;

constraint_expression_14 : ELSE constraint_set { DOUBLE(ELSE, $2); }
	;

udp_ansi_declaration_2 : attribute_instance { ($1); }
	;

dist_list_3 : COMMA dist_item { DOUBLE(COMMA, $2); }
	;

net_lvalue_3 : LBRACK constant_expression RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

net_lvalue_4 : LBRACK constant_range_expression RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

net_lvalue_8 : COMMA net_lvalue { DOUBLE(COMMA, $2); }
	;

generate_interface_block_3 : COLON generate_block_identifier { DOUBLE(COLON, $2); }
	;

generate_interface_block_4 : generate_interface_item { ($1); }
	;

generate_interface_block_6 : COLON generate_block_identifier { DOUBLE(COLON, $2); }
	;

list_of_genvar_identifiers_3 : COMMA genvar_identifier { DOUBLE(COMMA, $2); }
	;

property_instance_3 : LPAREN actual_arg_list RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

genvar_module_case_item_3 : COMMA constant_expression { DOUBLE(COMMA, $2); }
	;

genvar_module_case_item_8 : COLON { (COLON); }
	;

edge_control_specifier_5 : COMMA edge_descriptor { DOUBLE(COMMA, $2); }
	;

property_expr_6 : NOT { (NOT); }
	;

property_expr_11 : NOT { (NOT); }
	;

cell_clause_3 : library_identifier DOT { DOUBLE($1, DOT); }
	;

function_seq_block_3_4 : block_item_declaration { ($1); }
	;

function_seq_block_3 : COLON block_identifier function_seq_block_3_4 { TRIPLE(COLON, $2, $3); }
	;

function_seq_block_4 : function_statement_or_null { ($1); }
	;

function_seq_block_6 : COLON block_identifier { DOUBLE(COLON, $2); }
	;

concurrent_cover_statement_2 : block_identifier COLON { DOUBLE($1, COLON); }
	;

list_of_specparam_assignments_3 : COMMA specparam_assignment { DOUBLE(COMMA, $2); }
	;

module_instance_4 : list_of_port_connections { ($1); }
	;

/* system_task_identifier_3 : 
	; */

struct_union_member_2 : attribute_instance { ($1); }
	;

parameter_port_list_5 : COMMA parameter_declaration { DOUBLE(COMMA, $2); }
	;

hex_number_2 : size { ($1); }
	;

task_body_declaration_2 : interface_identifier DOT { DOUBLE($1, DOT); }
	;

task_body_declaration_5 : task_item_declaration { ($1); }
	;

task_body_declaration_6 : statement_or_null { ($1); }
	;

task_body_declaration_8 : COLON task_identifier { DOUBLE(COLON, $2); }
	;

task_body_declaration_10 : interface_identifier DOT { DOUBLE($1, DOT); }
	;

task_body_declaration_16 : block_item_declaration { ($1); }
	;

task_body_declaration_17 : statement_or_null { ($1); }
	;

task_body_declaration_19 : COLON task_identifier { DOUBLE(COLON, $2); }
	;

octal_value_3 : TOKEN_661 { (TOKEN_661); }
	| octal_digit { ($1); }
	;

sequence_instance_3 : LPAREN actual_arg_list RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

interface_instantiation_3 : parameter_value_assignment { ($1); }
	;

interface_instantiation_5 : COMMA module_instance { DOUBLE(COMMA, $2); }
	;

system_task_enable_3_3 : expression { ($1); }
	;

system_task_enable_3_4_3 : expression { ($1); }
	;

system_task_enable_3_4 : COMMA system_task_enable_3_4_3 { DOUBLE(COMMA, $2); }
	;

system_task_enable_3 : LPAREN system_task_enable_3_3 system_task_enable_3_4 RPAREN { QUADRUPLE(LPAREN, $2, $3, RPAREN); }
	;

extern_constraint_declaration_2 : STATIC { (STATIC); }
	;

extern_constraint_declaration_8 : constraint_block { ($1); }
	;

function_port_list_3 : COMMA function_port_item { DOUBLE(COMMA, $2); }
	;

tf_ref_declaration_2 : CONST { (CONST); }
	;

dot_named_port_connection_2 : attribute_instance { ($1); }
	;

class_method_2 : method_qualifier { ($1); }
	;

class_method_5 : method_qualifier { ($1); }
	;

class_method_9 : method_qualifier { ($1); }
	;

udp_declaration_2 : attribute_instance { ($1); }
	;

udp_declaration_10 : udp_port_declaration { ($1); }
	;

udp_declaration_14 : attribute_instance { ($1); }
	;

udp_declaration_4 : udp_port_declaration { ($1); }
	;

udp_declaration_7 : COLON udp_identifier { DOUBLE(COLON, $2); }
	;

udp_declaration_12 : COLON udp_identifier { DOUBLE(COLON, $2); }
	;

udp_declaration_20 : attribute_instance { ($1); }
	;

udp_declaration_27 : udp_port_declaration { ($1); }
	;

udp_declaration_30 : COLON udp_identifier { DOUBLE(COLON, $2); }
	;

genvar_decl_assignment_2 : GENVAR { (GENVAR); }
	;

module_declaration_3 : timeunits_declaration { ($1); }
	;

module_declaration_4 : module_item { ($1); }
	;

module_declaration_6 : COLON module_identifier { DOUBLE(COLON, $2); }
	;

module_declaration_9 : timeunits_declaration { ($1); }
	;

module_declaration_10 : non_port_module_item { ($1); }
	;

module_declaration_12 : COLON module_identifier { DOUBLE(COLON, $2); }
	;

module_declaration_14 : attribute_instance { ($1); }
	;

module_declaration_16 : lifetime { ($1); }
	;

module_declaration_22 : timeunits_declaration { ($1); }
	;

module_declaration_23 : module_item { ($1); }
	;

module_declaration_25 : COLON module_identifier { DOUBLE(COLON, $2); }
	;

non_port_interface_item_2 : attribute_instance { ($1); }
	;

non_port_interface_item_5 : attribute_instance { ($1); }
	;

non_port_program_item_2 : attribute_instance { ($1); }
	;

non_port_program_item_5 : attribute_instance { ($1); }
	;

non_port_program_item_8 : attribute_instance { ($1); }
	;

non_port_program_item_11 : attribute_instance { ($1); }
	;

non_port_program_item_14 : attribute_instance { ($1); }
	;

non_port_program_item_18 : attribute_instance { ($1); }
	;

non_port_program_item_21 : attribute_instance { ($1); }
	;

generate_module_item_8 : generate_block_identifier COLON { DOUBLE($1, COLON); }
	;

block_variable_declaration_2 : lifetime { ($1); }
	;

statement_item_2 : attribute_instance { ($1); }
	;

statement_item_6 : attribute_instance { ($1); }
	;

statement_item_10 : attribute_instance { ($1); }
	;

statement_item_14 : attribute_instance { ($1); }
	;

statement_item_17 : attribute_instance { ($1); }
	;

statement_item_20 : attribute_instance { ($1); }
	;

statement_item_24 : attribute_instance { ($1); }
	;

statement_item_28 : attribute_instance { ($1); }
	;

statement_item_31 : attribute_instance { ($1); }
	;

statement_item_34 : attribute_instance { ($1); }
	;

statement_item_37 : attribute_instance { ($1); }
	;

statement_item_40 : attribute_instance { ($1); }
	;

statement_item_43 : attribute_instance { ($1); }
	;

statement_item_46 : attribute_instance { ($1); }
	;

statement_item_49 : attribute_instance { ($1); }
	;

statement_item_52 : attribute_instance { ($1); }
	;

statement_item_55 : attribute_instance { ($1); }
	;

statement_item_58 : attribute_instance { ($1); }
	;

statement_item_61 : attribute_instance { ($1); }
	;

module_nonansi_header_2 : attribute_instance { ($1); }
	;

module_nonansi_header_4 : lifetime { ($1); }
	;

module_nonansi_header_6 : parameter_port_list { ($1); }
	;

d_width_timing_check_9_3 : notify_reg { ($1); }
	;

d_width_timing_check_9 : COMMA d_width_timing_check_9_3 { DOUBLE(COMMA, $2); }
	;

list_of_defparam_assignments_3 : COMMA defparam_assignment { DOUBLE(COMMA, $2); }
	;

property_spec_2 : clocking_event { ($1); }
	;

property_spec_3 : DISABLE IFF { DOUBLE(DISABLE, IFF); }
	;

property_spec_7 : NOT { (NOT); }
	;

property_spec_10 : DISABLE IFF LPAREN expression RPAREN { QUINTUPLE(DISABLE, IFF, LPAREN, $4, RPAREN); }
	;

property_spec_11 : NOT { (NOT); }
	;

name_of_gate_instance_3 : range { ($1); }
	;

list_of_clocking_decl_assign_3 : COMMA clocking_decl_assign { DOUBLE(COMMA, $2); }
	;

function_declaration_3 : lifetime { ($1); }
	;

comment_text_2 : ANY_ASCII_CHAR { (ANY_ASCII_CHAR); }
	;

program_nonansi_header_2 : attribute_instance { ($1); }
	;

program_nonansi_header_4 : lifetime { ($1); }
	;

program_nonansi_header_6 : parameter_port_list { ($1); }
	;

interface_ansi_header_2 : attribute_instance { ($1); }
	;

interface_ansi_header_4 : lifetime { ($1); }
	;

interface_ansi_header_6 : parameter_port_list { ($1); }
	;

interface_ansi_header_7 : list_of_port_declarations { ($1); }
	;

wait_statement_15 : COMMA hierarchical_identifier { DOUBLE(COMMA, $2); }
	;

source_text_2 : timeunits_declaration { ($1); }
	;

source_text_3 : description { ($1); }
	;

primary_6 : LBRACK expression RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

primary_7 : LBRACK range_expression RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

primary_8_4 : attribute_instance { ($1); }
	;

primary_8_5_4 : COMMA expression { DOUBLE(COMMA, $2); }
	;

primary_8_5 : LPAREN expression primary_8_5_4 RPAREN { QUADRUPLE(LPAREN, $2, $3, RPAREN); }
	;

primary_8 : DOT method_identifier primary_8_4 primary_8_5 { QUADRUPLE(DOT, $2, $3, $4); }
	;

primary_22 : class_identifier P_COLONCOLON { DOUBLE($1, P_COLONCOLON); }
	;

escaped_hierarchical_branch_3 : LBRACK unsigned_number RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

escaped_hierarchical_branch_4_2_4 : LBRACK unsigned_number RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

escaped_hierarchical_branch_4_2 : DOT escaped_identifier escaped_hierarchical_branch_4_2_4 { TRIPLE(DOT, $2, $3); }
	;

escaped_hierarchical_branch_4 : escaped_hierarchical_branch_4_2 { ($1); }
	;

non_zero_unsigned_number_3 : TOKEN_661 { (TOKEN_661); }
	| decimal_digit { ($1); }
	;

udp_instantiation_3 : drive_strength { ($1); }
	;

udp_instantiation_4 : delay2 { ($1); }
	;

udp_instantiation_6 : COMMA udp_instance { DOUBLE(COMMA, $2); }
	;

sequential_body_2 : udp_initial_statement { ($1); }
	;

sequential_body_5 : sequential_entry { ($1); }
	;

net_declaration_3 : signing { ($1); }
	;

net_declaration_4 : delay3 { ($1); }
	;

net_declaration_9 : drive_strength { ($1); }
	;

net_declaration_10 : signing { ($1); }
	;

net_declaration_11 : delay3 { ($1); }
	;

net_declaration_16 : VECTORED { (VECTORED); }
	| SCALARED { (SCALARED); }
	;

net_declaration_17 : signing { ($1); }
	;

net_declaration_18 : packed_dimension { ($1); }
	;

net_declaration_20 : delay3 { ($1); }
	;

net_declaration_25 : drive_strength { ($1); }
	;

net_declaration_26 : VECTORED { (VECTORED); }
	| SCALARED { (SCALARED); }
	;

net_declaration_27 : signing { ($1); }
	;

net_declaration_28 : packed_dimension { ($1); }
	;

net_declaration_30 : delay3 { ($1); }
	;

net_declaration_35 : charge_strength { ($1); }
	;

net_declaration_36 : signing { ($1); }
	;

net_declaration_37 : delay3 { ($1); }
	;

net_declaration_42 : drive_strength { ($1); }
	;

net_declaration_43 : signing { ($1); }
	;

net_declaration_44 : delay3 { ($1); }
	;

net_declaration_49 : charge_strength { ($1); }
	;

net_declaration_50 : VECTORED { (VECTORED); }
	| SCALARED { (SCALARED); }
	;

net_declaration_51 : signing { ($1); }
	;

net_declaration_52 : packed_dimension { ($1); }
	;

net_declaration_54 : delay3 { ($1); }
	;

net_declaration_59 : drive_strength { ($1); }
	;

net_declaration_60 : VECTORED { (VECTORED); }
	| SCALARED { (SCALARED); }
	;

net_declaration_61 : signing { ($1); }
	;

net_declaration_62 : packed_dimension { ($1); }
	;

net_declaration_64 : delay3 { ($1); }
	;

named_function_proto_2 : signing { ($1); }
	;

output_declaration_3 : port_type { ($1); }
	;

case_item_3 : COMMA expression { DOUBLE(COMMA, $2); }
	;

case_item_8 : COLON { (COLON); }
	;

program_ansi_header_2 : attribute_instance { ($1); }
	;

program_ansi_header_4 : lifetime { ($1); }
	;

program_ansi_header_6 : parameter_port_list { ($1); }
	;

program_ansi_header_7 : list_of_port_declarations { ($1); }
	;

function_port_item_2 : attribute_instance { ($1); }
	;

function_port_item_5 : attribute_instance { ($1); }
	;

function_port_item_8 : attribute_instance { ($1); }
	;

function_port_item_11 : attribute_instance { ($1); }
	;

function_port_item_14 : attribute_instance { ($1); }
	;

function_port_item_18 : attribute_instance { ($1); }
	;

level_input_list_3 : level_symbol { ($1); }
	;

d_skew_timing_check_9_3 : notify_reg { ($1); }
	;

d_skew_timing_check_9 : COMMA d_skew_timing_check_9_3 { DOUBLE(COMMA, $2); }
	;

multi_clock_sequence_3 : P_POUNDPOUND clocked_sequence { DOUBLE(P_POUNDPOUND, $2); }
	;

n_output_gate_instance_2 : name_of_gate_instance { ($1); }
	;

n_output_gate_instance_5 : COMMA output_terminal { DOUBLE(COMMA, $2); }
	;

decimal_number_4 : size { ($1); }
	;

decimal_number_8 : size { ($1); }
	;

decimal_number_11 : TOKEN_661 { (TOKEN_661); }
	;

decimal_number_13 : size { ($1); }
	;

decimal_number_16 : TOKEN_661 { (TOKEN_661); }
	;

generate_module_block_3 : COLON generate_block_identifier { DOUBLE(COLON, $2); }
	;

generate_module_block_4 : generate_module_item { ($1); }
	;

generate_module_block_6 : COLON generate_block_identifier { DOUBLE(COLON, $2); }
	;

type_declaration_identifier_3 : unpacked_dimension { ($1); }
	;

list_of_path_outputs_3 : COMMA specify_output_terminal_descriptor { DOUBLE(COMMA, $2); }
	;

dpi_import_export_4 : dpi_import_property { ($1); }
	;

dpi_import_export_5 : c_identifier EQUALS { DOUBLE($1, EQUALS); }
	;

dpi_import_export_11 : c_identifier EQUALS { DOUBLE($1, EQUALS); }
	;

list_of_param_assignments_3 : COMMA param_assignment { DOUBLE(COMMA, $2); }
	;

full_edge_sensitive_path_description_3 : edge_identifier { ($1); }
	;

full_edge_sensitive_path_description_7 : polarity_operator { ($1); }
	;

seq_block_3 : COLON block_identifier { DOUBLE(COLON, $2); }
	;

seq_block_4 : block_item_declaration { ($1); }
	;

seq_block_5 : statement_or_null { ($1); }
	;

seq_block_7 : COLON block_identifier { DOUBLE(COLON, $2); }
	;

udp_declaration_port_list_5 : COMMA udp_input_declaration { DOUBLE(COMMA, $2); }
	;

named_port_connection_2 : attribute_instance { ($1); }
	;

named_port_connection_6 : expression { ($1); }
	;

module_path_conditional_expression_4 : attribute_instance { ($1); }
	;

constraint_declaration_2 : STATIC { (STATIC); }
	;

constraint_declaration_6 : constraint_block { ($1); }
	;

clocking_decl_assign_3 : EQUALS hierarchical_identifier { DOUBLE(EQUALS, $2); }
	;

variable_lvalue_3 : LBRACK expression RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

variable_lvalue_4 : LBRACK range_expression RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

variable_lvalue_8 : COMMA variable_lvalue { DOUBLE(COMMA, $2); }
	;

dpi_proto_formal_3_4 : COMMA port_identifier dpi_dimension { TRIPLE(COMMA, $2, $3); }
	;

dpi_proto_formal_3 : port_identifier dpi_dimension dpi_proto_formal_3_4 { TRIPLE($1, $2, $3); }
	;

list_of_tf_variable_identifiers_4 : EQUALS expression { DOUBLE(EQUALS, $2); }
	;

list_of_tf_variable_identifiers_5_5 : EQUALS expression { DOUBLE(EQUALS, $2); }
	;

list_of_tf_variable_identifiers_5 : COMMA port_identifier variable_dimension list_of_tf_variable_identifiers_5_5 { QUADRUPLE(COMMA, $2, $3, $4); }
	;

list_of_ports_4 : COMMA port { DOUBLE(COMMA, $2); }
	;

list_of_net_identifiers_3 : unpacked_dimension { ($1); }
	;

list_of_net_identifiers_4_4 : unpacked_dimension { ($1); }
	;

list_of_net_identifiers_4 : COMMA net_identifier list_of_net_identifiers_4_4 { TRIPLE(COMMA, $2, $3); }
	;

block_item_declaration_2 : attribute_instance { ($1); }
	;

block_item_declaration_5 : attribute_instance { ($1); }
	;

block_item_declaration_8 : attribute_instance { ($1); }
	;

port_2 : port_expression { ($1); }
	;

port_7 : port_expression { ($1); }
	;

task_item_declaration_4 : attribute_instance { ($1); }
	;

task_item_declaration_8 : attribute_instance { ($1); }
	;

task_item_declaration_12 : attribute_instance { ($1); }
	;

task_item_declaration_16 : attribute_instance { ($1); }
	;

list_of_variable_identifiers_4 : COMMA variable_identifier variable_dimension { TRIPLE(COMMA, $2, $3); }
	;

list_of_modport_port_identifiers_3 : COMMA port_identifier { DOUBLE(COMMA, $2); }
	;

module_root_item_2 : attribute_instance { ($1); }
	;

module_root_item_5 : attribute_instance { ($1); }
	;

event_trigger_7 : delay_or_event_control { ($1); }
	;

list_of_port_identifiers_3 : unpacked_dimension { ($1); }
	;

list_of_port_identifiers_4_4 : unpacked_dimension { ($1); }
	;

list_of_port_identifiers_4 : COMMA port_identifier list_of_port_identifiers_4_4 { TRIPLE(COMMA, $2, $3); }
	;

d_recovery_timing_check_9_3 : notify_reg { ($1); }
	;

d_recovery_timing_check_9 : COMMA d_recovery_timing_check_9_3 { DOUBLE(COMMA, $2); }
	;

concatenation_4 : COMMA expression { DOUBLE(COMMA, $2); }
	;

concatenation_11 : COMMA struct_member_label COLON expression { QUADRUPLE(COMMA, $2, COLON, $4); }
	;

concatenation_18 : COMMA array_member_label COLON expression { QUADRUPLE(COMMA, $2, COLON, $4); }
	;

range_list_or_array_6 : COMMA value_range { DOUBLE(COMMA, $2); }
	;

binary_value_3 : TOKEN_661 { (TOKEN_661); }
	| binary_digit { ($1); }
	;

class_property_2 : property_qualifier { ($1); }
	;

class_property_6 : class_item_qualifier { ($1); }
	;

class_property_9 : EQUALS constant_expression { DOUBLE(EQUALS, $2); }
	;

clocking_item_10 : attribute_instance { ($1); }
	;

constraint_prototype_2 : STATIC { (STATIC); }
	;

module_path_expression_5 : attribute_instance { ($1); }
	;

module_path_expression_10 : attribute_instance { ($1); }
	;

clocking_direction_3 : clocking_skew { ($1); }
	;

clocking_direction_6 : clocking_skew { ($1); }
	;

clocking_direction_9 : clocking_skew { ($1); }
	;

clocking_direction_11 : clocking_skew { ($1); }
	;

name_of_udp_instance_3 : range { ($1); }
	;

udp_reg_declaration_2 : attribute_instance { ($1); }
	;

sequence_expr_4 : cycle_delay_range sequence_expr { DOUBLE($1, $2); }
	;

sequence_expr_9 : cycle_delay_range sequence_expr { DOUBLE($1, $2); }
	;

sequence_expr_12 : COMMA function_blocking_assignment { DOUBLE(COMMA, $2); }
	;

sequence_expr_13 : boolean_abbrev { ($1); }
	;

sequence_expr_17 : COMMA function_blocking_assignment { DOUBLE(COMMA, $2); }
	;

sequence_expr_19 : boolean_abbrev { ($1); }
	;

sequence_expr_22 : sequence_abbrev { ($1); }
	;

sequence_expr_27 : sequence_abbrev { ($1); }
	;

list_of_parameter_assignments_3 : COMMA ordered_parameter_assignment { DOUBLE(COMMA, $2); }
	;

list_of_parameter_assignments_6 : COMMA named_parameter_assignment { DOUBLE(COMMA, $2); }
	;

binary_number_2 : size { ($1); }
	;

task_declaration_3 : lifetime { ($1); }
	;

tf_inout_declaration_3 : signing { ($1); }
	;

tf_inout_declaration_4 : packed_dimension { ($1); }
	;

udp_port_list_5 : COMMA input_port_identifier { DOUBLE(COMMA, $2); }
	;

/* c_identifier_2 : 
	; */

/* c_identifier_3_2 : 
	; */

c_identifier_3 : c_identifier_3_2 { ($1); }
	;

non_generic_port_declaration_2 : attribute_instance { ($1); }
	;

non_generic_port_declaration_5 : attribute_instance { ($1); }
	;

non_generic_port_declaration_8 : attribute_instance { ($1); }
	;

non_generic_port_declaration_11 : attribute_instance { ($1); }
	;

non_generic_port_declaration_14 : attribute_instance { ($1); }
	;

interface_declaration_3 : timeunits_declaration { ($1); }
	;

interface_declaration_4 : interface_item { ($1); }
	;

interface_declaration_6 : COLON interface_identifier { DOUBLE(COLON, $2); }
	;

interface_declaration_9 : timeunits_declaration { ($1); }
	;

interface_declaration_10 : non_port_interface_item { ($1); }
	;

interface_declaration_12 : COLON interface_identifier { DOUBLE(COLON, $2); }
	;

interface_declaration_14 : attribute_instance { ($1); }
	;

interface_declaration_21 : timeunits_declaration { ($1); }
	;

interface_declaration_22 : interface_item { ($1); }
	;

interface_declaration_24 : COLON interface_identifier { DOUBLE(COLON, $2); }
	;

d_fullskew_timing_check_11_3 : notify_reg { ($1); }
	;

d_fullskew_timing_check_11_4_3 : event_based_flag { ($1); }
	;

d_fullskew_timing_check_11_4_4_3 : remain_active_flag { ($1); }
	;

d_fullskew_timing_check_11_4_4 : COMMA d_fullskew_timing_check_11_4_4_3 { DOUBLE(COMMA, $2); }
	;

d_fullskew_timing_check_11_4 : COMMA d_fullskew_timing_check_11_4_3 d_fullskew_timing_check_11_4_4 { TRIPLE(COMMA, $2, $3); }
	;

d_fullskew_timing_check_11 : COMMA d_fullskew_timing_check_11_3 d_fullskew_timing_check_11_4 { TRIPLE(COMMA, $2, $3); }
	;

port_declaration_4 : attribute_instance { ($1); }
	;

generate_module_conditional_statement_7 : ELSE generate_module_item { DOUBLE(ELSE, $2); }
	;

loop_statement_30 : COMMA variable_decl_or_assignment { DOUBLE(COMMA, $2); }
	;

loop_statement_35 : COMMA variable_assignment { DOUBLE(COMMA, $2); }
	;

property_formal_list_4 : COMMA formal_list_item { DOUBLE(COMMA, $2); }
	;

escaped_hierarchical_identifier_3 : DOT simple_hierarchical_branch { DOUBLE(DOT, $2); }
	| DOT escaped_hierarchical_branch { DOUBLE(DOT, $2); }
	;

parallel_edge_sensitive_path_description_3 : edge_identifier { ($1); }
	;

parallel_edge_sensitive_path_description_7 : polarity_operator { ($1); }
	;

timing_check_event_2 : timing_check_event_control { ($1); }
	;

timing_check_event_4 : P_ANDANDAND timing_check_condition { DOUBLE(P_ANDANDAND, $2); }
	;

generate_module_named_block_5 : generate_module_item { ($1); }
	;

generate_module_named_block_7 : COLON generate_block_identifier { DOUBLE(COLON, $2); }
	;

list_of_path_inputs_3 : COMMA specify_input_terminal_descriptor { DOUBLE(COMMA, $2); }
	;

function_statement_item_2 : attribute_instance { ($1); }
	;

function_statement_item_6 : attribute_instance { ($1); }
	;

function_statement_item_9 : attribute_instance { ($1); }
	;

function_statement_item_12 : attribute_instance { ($1); }
	;

function_statement_item_16 : attribute_instance { ($1); }
	;

function_statement_item_20 : attribute_instance { ($1); }
	;

function_statement_item_23 : attribute_instance { ($1); }
	;

function_statement_item_26 : attribute_instance { ($1); }
	;

function_statement_item_29 : attribute_instance { ($1); }
	;

function_statement_item_32 : attribute_instance { ($1); }
	;

multi_clock_property_expr_6 : NOT { (NOT); }
	;

d_setup_timing_check_9_3 : notify_reg { ($1); }
	;

d_setup_timing_check_9 : COMMA d_setup_timing_check_9_3 { DOUBLE(COMMA, $2); }
	;

list_of_net_assignments_3 : COMMA net_assignment { DOUBLE(COMMA, $2); }
	;

modport_simple_ports_declaration_12 : data_type { ($1); }
	;

module_path_concatenation_4 : COMMA module_path_expression { DOUBLE(COMMA, $2); }
	;

port_type_5 : signing { ($1); }
	;

port_type_6 : packed_dimension { ($1); }
	;

port_type_9 : signing { ($1); }
	;

port_type_10 : packed_dimension { ($1); }
	;

port_type_12 : signing { ($1); }
	;

port_type_13 : packed_dimension { ($1); }
	;

program_instantiation_3 : parameter_value_assignment { ($1); }
	;

program_instantiation_5 : COMMA program_instance { DOUBLE(COMMA, $2); }
	;

jump_statement_3 : expression { ($1); }
	;

d_timeskew_timing_check_9_3 : notify_reg { ($1); }
	;

d_timeskew_timing_check_9_4_3 : event_based_flag { ($1); }
	;

d_timeskew_timing_check_9_4_4_3 : remain_active_flag { ($1); }
	;

d_timeskew_timing_check_9_4_4 : COMMA d_timeskew_timing_check_9_4_4_3 { DOUBLE(COMMA, $2); }
	;

d_timeskew_timing_check_9_4 : COMMA d_timeskew_timing_check_9_4_3 d_timeskew_timing_check_9_4_4 { TRIPLE(COMMA, $2, $3); }
	;

d_timeskew_timing_check_9 : COMMA d_timeskew_timing_check_9_3 d_timeskew_timing_check_9_4 { TRIPLE(COMMA, $2, $3); }
	;

nonblocking_assignment_4 : delay_or_event_control { ($1); }
	;

function_call_3 : attribute_instance { ($1); }
	;

function_call_4 : LPAREN list_of_arguments RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

program_declaration_3 : timeunits_declaration { ($1); }
	;

program_declaration_4 : program_item { ($1); }
	;

program_declaration_6 : COLON program_identifier { DOUBLE(COLON, $2); }
	;

program_declaration_9 : timeunits_declaration { ($1); }
	;

program_declaration_10 : non_port_program_item { ($1); }
	;

program_declaration_12 : COLON program_identifier { DOUBLE(COLON, $2); }
	;

program_declaration_14 : attribute_instance { ($1); }
	;

program_declaration_21 : timeunits_declaration { ($1); }
	;

program_declaration_22 : program_item { ($1); }
	;

program_declaration_24 : COLON program_identifier { DOUBLE(COLON, $2); }
	;

identifier_list_3 : COMMA identifier { DOUBLE(COMMA, $2); }
	;

list_of_variable_assignments_3 : COMMA variable_assignment { DOUBLE(COMMA, $2); }
	;

string_literal_3 : ANY_ASCII_CHARS { (ANY_ASCII_CHARS); }
	;

property_declaration_4 : property_formal_list { ($1); }
	;

property_declaration_6 : assertion_variable_declaration { ($1); }
	;

property_declaration_10 : COLON property_identifier { DOUBLE(COLON, $2); }
	;

generate_module_case_statement_7 : genvar_module_case_item { ($1); }
	;

real_number_5 : DOT unsigned_number { DOUBLE(DOT, $2); }
	;

real_number_7 : sign { ($1); }
	;

function_data_type_3 : packed_dimension { ($1); }
	;

function_data_type_4 : range { ($1); }
	;

function_data_type_9 : packed_dimension { ($1); }
	;

function_data_type_14 : PACKED { (PACKED); }
	;

function_data_type_16 : struct_union_member { ($1); }
	;

function_data_type_18 : packed_dimension { ($1); }
	;

function_data_type_21 : PACKED { (PACKED); }
	;

function_data_type_23 : struct_union_member { ($1); }
	;

function_data_type_25 : packed_dimension { ($1); }
	;

function_data_type_28_3 : packed_dimension { ($1); }
	;

function_data_type_28 : integer_type function_data_type_28_3 { DOUBLE($1, $2); }
	;

function_data_type_31 : EQUALS constant_expression { DOUBLE(EQUALS, $2); }
	;

function_data_type_32_4 : EQUALS constant_expression { DOUBLE(EQUALS, $2); }
	;

function_data_type_32 : COMMA enum_identifier function_data_type_32_4 { TRIPLE(COMMA, $2, $3); }
	;

list_of_udp_port_identifiers_3 : COMMA port_identifier { DOUBLE(COMMA, $2); }
	;

clocking_drive_4 : cycle_delay { ($1); }
	;

interface_or_generate_item_2 : attribute_instance { ($1); }
	;

interface_or_generate_item_5 : attribute_instance { ($1); }
	;

interface_or_generate_item_8 : attribute_instance { ($1); }
	;

interface_or_generate_item_11 : attribute_instance { ($1); }
	;

interface_or_generate_item_14 : attribute_instance { ($1); }
	;

interface_or_generate_item_17 : attribute_instance { ($1); }
	;

interface_or_generate_item_20 : attribute_instance { ($1); }
	;

interface_or_generate_item_23 : attribute_instance { ($1); }
	;

interface_or_generate_item_29 : attribute_instance { ($1); }
	;

interface_or_generate_item_32 : attribute_instance { ($1); }
	;

interface_or_generate_item_35 : attribute_instance { ($1); }
	;

interface_or_generate_item_38 : attribute_instance { ($1); }
	;

list_of_constant_arguments_2 : constant_expression { ($1); }
	;

list_of_constant_arguments_3_3 : constant_expression { ($1); }
	;

list_of_constant_arguments_3 : COMMA list_of_constant_arguments_3_3 { DOUBLE(COMMA, $2); }
	;

list_of_constant_arguments_8 : constant_expression { ($1); }
	;

list_of_constant_arguments_10_6 : constant_expression { ($1); }
	;

list_of_constant_arguments_10 : COMMA DOT identifier LPAREN list_of_constant_arguments_10_6 RPAREN { SEXTUPLE(COMMA, DOT, $3, LPAREN, $5, RPAREN); }
	;

enable_gate_instance_2 : name_of_gate_instance { ($1); }
	;

continuous_assign_3 : drive_strength { ($1); }
	;

continuous_assign_4 : delay3 { ($1); }
	;

continuous_assign_9 : delay_control { ($1); }
	;

function_statement_2 : block_identifier COLON { DOUBLE($1, COLON); }
	;

case_statement_2 : unique_priority { ($1); }
	;

case_statement_8 : case_item { ($1); }
	;

case_statement_11 : unique_priority { ($1); }
	;

case_statement_17 : case_item { ($1); }
	;

case_statement_20 : unique_priority { ($1); }
	;

case_statement_26 : case_item { ($1); }
	;

class_scope_type_identifier_4 : class_identifier P_COLONCOLON { DOUBLE($1, P_COLONCOLON); }
	;

class_scope_type_identifier_9 : class_identifier P_COLONCOLON { DOUBLE($1, P_COLONCOLON); }
	;

controlled_timing_check_event_4 : P_ANDANDAND timing_check_condition { DOUBLE(P_ANDANDAND, $2); }
	;

specify_input_terminal_descriptor_3 : LBRACK constant_range_expression RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

generated_module_instantiation_3 : generate_module_item { ($1); }
	;

/* simple_identifier_2 : 
	; */

/* simple_identifier_3_2 : 
	; */

simple_identifier_3 : simple_identifier_3_2 { ($1); }
	;

use_clause_3 : library_identifier DOT { DOUBLE($1, DOT); }
	;

use_clause_5 : COLON CONFIG { DOUBLE(COLON, CONFIG); }
	;

specparam_declaration_3 : range { ($1); }
	;

generate_interface_conditional_statement_7 : ELSE generate_interface_item { DOUBLE(ELSE, $2); }
	;

udp_input_declaration_2 : attribute_instance { ($1); }
	;

edge_input_list_2 : level_symbol { ($1); }
	;

edge_input_list_4 : level_symbol { ($1); }
	;

constant_expression_5 : attribute_instance { ($1); }
	;

constant_expression_10 : attribute_instance { ($1); }
	;

constant_expression_15 : attribute_instance { ($1); }
	;

combinational_body_4 : combinational_entry { ($1); }
	;

mos_switch_instance_2 : name_of_gate_instance { ($1); }
	;

d_recrem_timing_check_11_3 : notify_reg { ($1); }
	;

d_recrem_timing_check_11_4_3 : stamptime_condition { ($1); }
	;

d_recrem_timing_check_11_4_4_3 : checktime_condition { ($1); }
	;

d_recrem_timing_check_11_4_4_4_3 : delayed_reference { ($1); }
	;

d_recrem_timing_check_11_4_4_4_4_3 : delayed_data { ($1); }
	;

d_recrem_timing_check_11_4_4_4_4 : COMMA d_recrem_timing_check_11_4_4_4_4_3 { DOUBLE(COMMA, $2); }
	;

d_recrem_timing_check_11_4_4_4 : COMMA d_recrem_timing_check_11_4_4_4_3 d_recrem_timing_check_11_4_4_4_4 { TRIPLE(COMMA, $2, $3); }
	;

d_recrem_timing_check_11_4_4 : COMMA d_recrem_timing_check_11_4_4_3 d_recrem_timing_check_11_4_4_4 { TRIPLE(COMMA, $2, $3); }
	;

d_recrem_timing_check_11_4 : COMMA d_recrem_timing_check_11_4_3 d_recrem_timing_check_11_4_4 { TRIPLE(COMMA, $2, $3); }
	;

d_recrem_timing_check_11 : COMMA d_recrem_timing_check_11_3 d_recrem_timing_check_11_4 { TRIPLE(COMMA, $2, $3); }
	;

pass_switch_instance_2 : name_of_gate_instance { ($1); }
	;

par_block_3 : COLON block_identifier { DOUBLE(COLON, $2); }
	;

par_block_4 : block_item_declaration { ($1); }
	;

par_block_5 : statement_or_null { ($1); }
	;

par_block_7 : COLON block_identifier { DOUBLE(COLON, $2); }
	;

program_instance_3 : range { ($1); }
	;

program_instance_5 : list_of_port_connections { ($1); }
	;

liblist_clause_3 : library_identifier { ($1); }
	;

d_hold_timing_check_9_3 : notify_reg { ($1); }
	;

d_hold_timing_check_9 : COMMA d_hold_timing_check_9_3 { DOUBLE(COMMA, $2); }
	;

class_item_2 : attribute_instance { ($1); }
	;

class_item_5 : attribute_instance { ($1); }
	;

class_item_8 : attribute_instance { ($1); }
	;

actual_arg_list_4 : COMMA actual_arg_expr { DOUBLE(COMMA, $2); }
	;

actual_arg_list_13 : COMMA DOT formal_identifier LPAREN actual_arg_expr RPAREN { SEXTUPLE(COMMA, DOT, $3, LPAREN, $5, RPAREN); }
	;

library_text_2 : library_descriptions { ($1); }
	;

inout_declaration_3 : port_type { ($1); }
	;

generate_interface_item_8 : generate_block_identifier COLON { DOUBLE($1, COLON); }
	;

event_expression_2 : edge_identifier { ($1); }
	;

event_expression_4 : IFF expression { DOUBLE(IFF, $2); }
	;

attribute_instance_4 : COMMA attr_spec { DOUBLE(COMMA, $2); }
	;

octal_base_3 : 's' { (CHAR 's'); }
	| 'S' { (CHAR 'S'); }
	;

octal_base_7 : 's' { (CHAR 's'); }
	| 'S' { (CHAR 'S'); }
	;

constraint_set_5 : constraint_expression { ($1); }
	;

list_of_port_connections_3 : COMMA ordered_port_connection { DOUBLE(COMMA, $2); }
	;

list_of_port_connections_6 : COMMA dot_named_port_connection { DOUBLE(COMMA, $2); }
	;

list_of_port_connections_8 : named_port_connection COMMA { DOUBLE($1, COMMA); }
	;

list_of_port_connections_10 : COMMA named_port_connection { DOUBLE(COMMA, $2); }
	;

hex_value_3 : TOKEN_661 { (TOKEN_661); }
	| hex_digit { ($1); }
	;

range_or_type_2 : packed_dimension { ($1); }
	;

conditional_statement_2 : unique_priority { ($1); }
	;

conditional_statement_8 : ELSE statement_or_null { DOUBLE(ELSE, $2); }
	;

system_function_call_3_4 : COMMA expression { DOUBLE(COMMA, $2); }
	;

system_function_call_3 : LPAREN expression system_function_call_3_4 RPAREN { QUADRUPLE(LPAREN, $2, $3, RPAREN); }
	;

pull_gate_instance_2 : name_of_gate_instance { ($1); }
	;

d_removal_timing_check_9_3 : notify_reg { ($1); }
	;

d_removal_timing_check_9 : COMMA d_removal_timing_check_9_3 { DOUBLE(COMMA, $2); }
	;

sequence_formal_list_4 : COMMA formal_list_item { DOUBLE(COMMA, $2); }
	;

list_of_tf_port_identifiers_3 : unpacked_dimension { ($1); }
	;

list_of_tf_port_identifiers_4 : EQUALS expression { DOUBLE(EQUALS, $2); }
	;

list_of_tf_port_identifiers_5_4 : unpacked_dimension { ($1); }
	;

list_of_tf_port_identifiers_5_5 : EQUALS expression { DOUBLE(EQUALS, $2); }
	;

list_of_tf_port_identifiers_5 : COMMA port_identifier list_of_tf_port_identifiers_5_4 list_of_tf_port_identifiers_5_5 { QUADRUPLE(COMMA, $2, $3, $4); }
	;

d_period_timing_check_7_3 : notify_reg { ($1); }
	;

d_period_timing_check_7 : COMMA d_period_timing_check_7_3 { DOUBLE(COMMA, $2); }
	;

blocking_assignment_13 : LPAREN variable_identifier RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

blocking_assignment_16 : parameter_value_assignment { ($1); }
	;

blocking_assignment_19 : LPAREN list_of_arguments RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

blocking_assignment_24 : LPAREN RPAREN { DOUBLE(LPAREN, RPAREN); }
	;

task_enable_3 : LPAREN list_of_arguments RPAREN { TRIPLE(LPAREN, $2, RPAREN); }
	;

type_declaration_3 : data_type { ($1); }
	;

type_declaration_15 : CLASS { (CLASS); }
	;

type_declaration_21 : parameter_value_assignment { ($1); }
	;

function_loop_statement_20 : COMMA variable_decl_or_assignment { DOUBLE(COMMA, $2); }
	;

function_loop_statement_25 : COMMA variable_assignment { DOUBLE(COMMA, $2); }
	;

specify_block_3 : specify_item { ($1); }
	;

pulse_control_specparam_6 : COMMA error_limit_value { DOUBLE(COMMA, $2); }
	;

pulse_control_specparam_17 : COMMA error_limit_value { DOUBLE(COMMA, $2); }
	;

module_or_generate_item_2 : attribute_instance { ($1); }
	;

module_or_generate_item_5 : attribute_instance { ($1); }
	;

module_or_generate_item_8 : attribute_instance { ($1); }
	;

module_or_generate_item_11 : attribute_instance { ($1); }
	;

module_or_generate_item_14 : attribute_instance { ($1); }
	;

module_or_generate_item_17 : attribute_instance { ($1); }
	;

module_or_generate_item_20 : attribute_instance { ($1); }
	;

module_or_generate_item_23 : attribute_instance { ($1); }
	;

module_or_generate_item_26 : attribute_instance { ($1); }
	;

module_or_generate_item_29 : attribute_instance { ($1); }
	;

module_or_generate_item_32 : attribute_instance { ($1); }
	;

module_or_generate_item_35 : attribute_instance { ($1); }
	;

module_or_generate_item_40 : attribute_instance { ($1); }
	;

hex_base_3 : 's' { (CHAR 's'); }
	| 'S' { (CHAR 'S'); }
	;

hex_base_7 : 's' { (CHAR 's'); }
	| 'S' { (CHAR 'S'); }
	;

config_declaration_6 : config_rule_statement { ($1); }
	;

implicit_class_handle_2 : THIS DOT { DOUBLE(THIS, DOT); }
	;

implicit_class_handle_4 : SUPER DOT { DOUBLE(SUPER, DOT); }
	;

specify_output_terminal_descriptor_3 : LBRACK constant_range_expression RBRACK { TRIPLE(LBRACK, $2, RBRACK); }
	;

sequence_declaration_4 : sequence_formal_list { ($1); }
	;

sequence_declaration_6 : assertion_variable_declaration { ($1); }
	;

sequence_declaration_10 : COLON sequence_identifier { DOUBLE(COLON, $2); }
	;

data_type_3 : signing { ($1); }
	;

data_type_4 : packed_dimension { ($1); }
	;

data_type_5 : range { ($1); }
	;

data_type_8 : signing { ($1); }
	;

data_type_11 : packed_dimension { ($1); }
	;

data_type_17 : signing { ($1); }
	;

data_type_19 : struct_union_member { ($1); }
	;

data_type_21 : packed_dimension { ($1); }
	;

data_type_25 : signing { ($1); }
	;

data_type_27 : struct_union_member { ($1); }
	;

data_type_29 : packed_dimension { ($1); }
	;

data_type_32 : signing { ($1); }
	;

data_type_34 : struct_union_member { ($1); }
	;

data_type_38 : signing { ($1); }
	;

data_type_40 : struct_union_member { ($1); }
	;

data_type_44_3 : signing { ($1); }
	;

data_type_44_4 : packed_dimension { ($1); }
	;

data_type_44 : integer_type data_type_44_3 data_type_44_4 { TRIPLE($1, $2, $3); }
	;

data_type_47 : EQUALS constant_expression { DOUBLE(EQUALS, $2); }
	;

data_type_48_4 : EQUALS constant_expression { DOUBLE(EQUALS, $2); }
	;

data_type_48 : COMMA enum_identifier data_type_48_4 { TRIPLE(COMMA, $2, $3); }
	;

constant_concatenation_4 : COMMA constant_expression { DOUBLE(COMMA, $2); }
	;

constant_concatenation_11 : COMMA struct_member_label COLON constant_expression { QUADRUPLE(COMMA, $2, COLON, $4); }
	;

constant_concatenation_18 : COMMA array_member_label COLON constant_expression { QUADRUPLE(COMMA, $2, COLON, $4); }
	;

interface_nonansi_header_2 : attribute_instance { ($1); }
	;

interface_nonansi_header_4 : lifetime { ($1); }
	;

interface_nonansi_header_6 : parameter_port_list { ($1); }
	;

expression_5 : attribute_instance { ($1); }
	;

expression_16 : attribute_instance { ($1); }
	;

clocking_skew_3 : delay_control { ($1); }
	;

gate_instantiation_3 : delay3 { ($1); }
	;

gate_instantiation_5 : COMMA cmos_switch_instance { DOUBLE(COMMA, $2); }
	;

gate_instantiation_9 : drive_strength { ($1); }
	;

gate_instantiation_10 : delay3 { ($1); }
	;

gate_instantiation_12 : COMMA enable_gate_instance { DOUBLE(COMMA, $2); }
	;

gate_instantiation_16 : delay3 { ($1); }
	;

gate_instantiation_18 : COMMA mos_switch_instance { DOUBLE(COMMA, $2); }
	;

gate_instantiation_22 : drive_strength { ($1); }
	;

gate_instantiation_23 : delay2 { ($1); }
	;

gate_instantiation_25 : COMMA n_input_gate_instance { DOUBLE(COMMA, $2); }
	;

gate_instantiation_29 : drive_strength { ($1); }
	;

gate_instantiation_30 : delay2 { ($1); }
	;

gate_instantiation_32 : COMMA n_output_gate_instance { DOUBLE(COMMA, $2); }
	;

gate_instantiation_36 : delay2 { ($1); }
	;

gate_instantiation_38 : COMMA pass_enable_switch_instance { DOUBLE(COMMA, $2); }
	;

gate_instantiation_43 : COMMA pass_switch_instance { DOUBLE(COMMA, $2); }
	;

gate_instantiation_47 : pulldown_strength { ($1); }
	;

gate_instantiation_49 : COMMA pull_gate_instance { DOUBLE(COMMA, $2); }
	;

gate_instantiation_53 : pullup_strength { ($1); }
	;

gate_instantiation_55 : COMMA pull_gate_instance { DOUBLE(COMMA, $2); }
	;

list_of_type_assignments_3 : COMMA type_assignment { DOUBLE(COMMA, $2); }
	;

statement_2 : block_identifier COLON { DOUBLE($1, COLON); }
	;

/* system_function_identifier_3 : 
	; */

concurrent_assert_statement_2 : block_identifier COLON { DOUBLE($1, COLON); }
	;

// END_OF_FILE
