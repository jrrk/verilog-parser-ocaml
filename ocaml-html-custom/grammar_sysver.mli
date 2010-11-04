type token =
  | P_ATAT
  | MACROMODULE
  | FILE_PATH
  | D_CLOG2
  | D_READMEMB
  | INSTANCE
  | CONSTRAINT
  | TOKEN_46
  | PACKED
  | D_READMEMH
  | IFF
  | TOKEN_706
  | PRIMITIVE
  | WIRE
  | U_WIRE
  | D_FFLUSH
  | P_ANDEQ
  | EOF
  | BEGIN
  | ENDCLOCKING
  | NEW
  | D_FOPEN
  | C_IDENTIFIER_3_2 of (string)
  | TOKEN_597
  | TOKEN_631
  | D_FWRITE
  | TOKEN_598
  | TOKEN_632
  | ENDSPECIFY
  | TOKEN_434
  | PRIORITY
  | SOLVE
  | REALTIME
  | PROPERTY
  | P_OROR
  | BUFIF0
  | PLING
  | BUFIF1
  | D_PERIOD
  | TOKEN_697
  | TOKEN_695
  | HASH
  | PULLDOWN
  | ALWAYS
  | ALWAYS_COMB
  | ALWAYS_LATCH
  | ALWAYS_FF
  | DOLLAR
  | P_ORMINUSGT
  | SHOWCANCELLED
  | ENDSEQUENCE
  | PULLUP
  | MODULO
  | EDGE
  | AMPERSAND
  | SQUOTE
  | LIBRARY
  | LPAREN
  | TRANIF0
  | RPAREN
  | TRANIF1
  | PARAMETER
  | TAB
  | EMPTY
  | TIMES
  | PLUS
  | COMMA
  | MINUS
  | P_OREQGT
  | DOT
  | DIVIDE
  | TOKEN_436
  | TOKEN_435
  | RNMOS
  | SUPPLY0
  | IF
  | TOKEN_687
  | SUPPLY1
  | D_MONITOR
  | TOKEN_688
  | D_FSCANF
  | TOKEN_689
  | PROGRAM
  | TOKEN_690
  | P_OREQ
  | PMOS
  | TOKEN_691
  | PROTECTED
  | DESIGN
  | VECTORED
  | TOKEN_639
  | P_XOREQ
  | TOKEN_433
  | TOKEN_272
  | CASE
  | TOKEN_266
  | COLON
  | TABLE
  | D_BITS
  | SEMICOLON
  | LESS
  | EQUALS
  | TOKEN_636
  | TIMEUNIT
  | GREATER
  | QUERY
  | TOKEN_634
  | ENDFUNCTION
  | AT
  | TOKEN_601
  | FOREVER
  | P_SRIGHTEQ
  | D_TEST_PLUSARGS
  | P_SSRIGHT
  | P_SSRIGHT3
  | INPUT
  | TOKEN_699
  | BUF
  | P_POW
  | VOID
  | FORK
  | SUPER
  | SMALL
  | RELEASE
  | FORCE
  | D_FGETC
  | P_SLEFT
  | P_SLEFT3
  | TOKEN_END_COMMENT
  | TOKEN_504
  | P_SLEFTEQ
  | P_SLEFT3EQ
  | P_CASENOTEQUAL
  | P_WILDNOTEQUAL
  | INCDIR
  | TOKEN_427
  | D_FATAL
  | TOKEN_428
  | ENUM
  | ELSE
  | SIMPLE_IDENTIFIER_2 of (string)
  | TYPE
  | EVENT
  | IS_DEFINED_AS
  | BIND
  | D_FEOF
  | AND
  | BYTE
  | NOCHANGE
  | DIST
  | LBRACK
  | P_TIMESEQ
  | D_FGETS
  | ASSIGN
  | TOKEN_652
  | TOKEN_718
  | P_ASTGT
  | RBRACK
  | TOKEN_635
  | CARET
  | CELL
  | TOKEN_633
  | TOKEN_661
  | TRAN
  | D_COUNTDRIVERS
  | TOKEN_724
  | ENDINTERFACE
  | D_FCLOSE
  | ENDTASK
  | WAIT
  | RETURN
  | NEGEDGE
  | GENERATE
  | RANDC
  | P_PLUSCOLON
  | VIRTUAL
  | LOCAL
  | CONTEXT
  | EXTENDS
  | P_PLUSEQ
  | D_SKEW
  | P_SSRIGHTEQ
  | P_SSRIGHT3EQ
  | JOIN_ANY
  | REPEAT
  | TOKEN_471
  | TOKEN_327
  | BIT
  | WITH
  | REAL
  | TOKEN_650
  | TRI
  | PULSESTYLE_ONEVENT
  | TOKEN_595
  | TOKEN_596
  | D_DISPLAY
  | TOKEN_430
  | P_XNOR
  | P_NXOR
  | RCMOS
  | ENDPROPERTY
  | D_COUNTONES
  | COUNTONES
  | STATIC
  | LCURLY
  | CONTINUE
  | ANY_ASCII_CHARS
  | VBAR
  | RCURLY
  | P_COLONDIV
  | SPECIFY
  | TILDE
  | WOR
  | P_NAND
  | D_ISUNKNOWN
  | ISUNKNOWN
  | P_NOR
  | AUTOMATIC
  | TOKEN_653
  | FOR
  | SPECPARAM
  | P_COLONCOLON
  | TRIAND
  | TIME
  | JOIN_NONE
  | CONFIG
  | TOKEN_287
  | P_COLONEQ
  | C_IDENTIFIER_2 of (string)
  | D_ONEHOT0
  | P_ANDANDAND
  | ASSERT
  | NOSHOWCANCELLED
  | INITIAL
  | P_MINUSCOLON
  | NAND
  | IF_NONE
  | TOKEN_723
  | P_MINUSEQ
  | P_DOTSTAR
  | P_MINUSGT
  | TOKEN_429
  | MODULE
  | NEWLINE
  | D_UNSIGNED
  | TOKEN_713
  | D_SSCANF
  | CHANDLE
  | TOKEN_719
  | UNIQUE
  | PULSESTYLE_ONDETECT
  | LOGIC
  | D_WIDTH
  | BEFORE
  | NMOS
  | CASEX
  | TOKEN_328
  | INTERFACE
  | CASEZ
  | INTERSECT
  | DEASSIGN
  | BOLD
  | TOKEN_BEGIN_COMMENT
  | REF
  | NULL
  | PURE
  | EXPORT
  | REG
  | SCALARED
  | TOKEN_704
  | ENDCONFIG
  | ENDCLASS
  | TOKEN_348
  | TOKEN_501
  | SVINT
  | OR
  | TOKEN_651
  | P_NOTEQUAL
  | P_LTE
  | SHORTINT
  | CONST
  | WAND
  | STEP
  | EXTERN
  | MEDIUM
  | PULL0
  | PULL1
  | FORKJOIN
  | DEFPARAM
  | CLOCKING
  | TRI0
  | TASK
  | P_DIVEQ
  | TRI1
  | UNION
  | LIBLIST
  | ENDMODULE
  | P_POUNDPOUND
  | RAND
  | SHORTREAL
  | D_RECREM
  | LOCALPARAM
  | D_TIME
  | D_REALTIME
  | SIGNED
  | D_ATTRIBUTE
  | TOKEN_587
  | STRONG0
  | STRONG1
  | LONGINT
  | P_EQUAL
  | HIGHZ0
  | D_SIGNED
  | ENDGENERATE
  | P_EQGT
  | HIGHZ1
  | POSEDGE
  | D_INFO
  | FINAL
  | RPMOS
  | D_TIMESKEW
  | SYSTEM_FUNCTION_IDENTIFIER_3 of (string)
  | P_CASEEQUAL
  | SEQUENCE
  | RANDOMIZE
  | P_WILDEQUAL
  | D_WRITE
  | D_HOLD
  | ALIAS
  | ENDPRIMITIVE
  | TIMEPRECISION
  | ENDPROGRAM
  | NOR
  | JOIN
  | D_ONEHOT
  | NOT
  | D_SETUPHOLD
  | D_FDISPLAY
  | TOKEN_588
  | TOKEN_176
  | WAIT_ORDER
  | STRING
  | TOKEN_648
  | D_STOP
  | P_GTE
  | P_SRIGHT
  | TRIREG
  | THROUGHOUT
  | WHILE
  | D_SETUP
  | DEFAULT
  | TRIOR
  | DO
  | PATHPULSE
  | INSIDE
  | D_WARNING
  | D_RECOVERY
  | INOUT
  | OUTPUT
  | SIMPLE_IDENTIFIER_3_2 of (string)
  | FIRST_MATCH
  | THIS
  | LARGE
  | ENDCASE
  | D_REMOVAL
  | FUNCTION
  | CMOS
  | INTEGER
  | XOR
  | SYSTEM_TASK_IDENTIFIER_3 of (string)
  | WEAK0
  | DISABLE
  | WEAK1
  | TOKEN_500
  | TOKEN_346
  | USE
  | D_FINISH
  | ENDTABLE
  | FULLSKEW
  | RTRANIF0
  | TOKEN_649
  | TYPEDEF
  | RTRANIF1
  | GENVAR
  | COVER
  | TOKEN_431
  | INCLUDE
  | TOKEN_432
  | RTRAN
  | BREAK
  | XNOR
  | UNSIGNED
  | MODPORT
  | D_FWRITEH
  | TOKEN_349
  | P_ANDAND
  | NOTIF0
  | D_ERROR
  | ANY_ASCII_CHAR
  | IMPORT
  | NOTIF1
  | SPACE
  | END
  | WITHIN
  | P_MODEQ
  | CLASS
  | STRUCT
  | MS of (token)
  | US of (token)
  | NS of (token)
  | PS of (token)
  | FS of (token)
  | AS of (token)
  | ASCNUM of (string)
  | CHAR of (char)
  | ID of (string)
  | RANGE of (token * token )
  | INT of (int)
  | DOUBLE of (token * token)
  | TRIPLE of (token * token * token)
  | QUADRUPLE of (token * token * token * token)
  | QUINTUPLE of (token * token * token * token * token)
  | SEXTUPLE of (token * token * token * token * token * token)
  | SEPTUPLE of (token * token * token * token * token * token * token)
  | OCTUPLE of (token * token * token * token * token * token * token * token)
  | NONUPLE of (token * token * token * token * token * token * token * token * token)
  | DECUPLE of (token * token * token * token * token * token * token * token * token * token)
  | UNDECUPLE of (token * token * token * token * token * token * token * token * token * token * token)
  | DUODECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token)
  | TREDECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token)
  | QUATTUORDECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | QUINDECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | SEXDECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | SEPTENDECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | OCTODECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | NOVEMDECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | VIGENUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | UNVIGENUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | DUOVIGENUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | TREVIGENUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | QUATTUORVIGENUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | QUINVIGENUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | ALTERNATIVE
  | ASSIGNMENT
  | BIDIR
  | BINNUM of (string)
  | BITSEL
  | CASECOND
  | CELLPIN
  | CONCAT
  | D_C
  | DECNUM of (string)
  | DLYASSIGNMENT
  | DOTTED of (token list)
  | D_RANDOM
  | DRIVER
  | D_STIME
  | ENDLABEL
  | ENDOFFILE
  | FLOATNUM of (float)
  | FULLSKEW_TIMING_CHECK
  | FUNCREF
  | FUNCUSED
  | GENCASE
  | GENCASECOND
  | HEXNUM of (string)
  | HOLD_TIMING_CHECK
  | IMPLICIT
  | INTNUM of (string)
  | IOPORT
  | LEFT_BRACKET
  | LEFT_CURLY
  | MEMORY
  | MINTYPMAX
  | MODINST
  | NAMED
  | NOCHANGE_TIMING_CHECK
  | OCTNUM of (string)
  | PARAMUSED
  | PARTSEL
  | P_CELLDEFINE
  | P_DEFINE
  | P_DELAY_MODE_PATH
  | P_DISABLE_PORTFAULTS
  | P_ELSE
  | P_ENABLE_PORTFAULTS
  | P_ENDCELLDEFINE
  | P_ENDIF
  | P_ENDPROTECT
  | PERIOD_TIMING_CHECK
  | P_IFDEF
  | P_INCLUDE of (string)
  | P_NOSUPPRESS_FAULTS
  | P_PROTECT
  | PRAGMATIC of (string)
  | PREPROC of (string)
  | P_RESETALL
  | PRIMINST
  | P_SUPPRESS_FAULTS
  | P_TIMESCALE of (string)
  | RECEIVER
  | RECOVERY_TIMING_CHECK
  | RECREM_TIMING_CHECK
  | REMOVAL_TIMING_CHECK
  | RIGHT_BRACKET
  | RIGHT_CURLY
  | SCALAR
  | SENSUSED
  | SETUPHOLD_TIMING_CHECK
  | SETUP_TIMING_CHECK
  | SKEW_TIMING_CHECK
  | SPECIAL
  | SUBCCT
  | SUBMODULE
  | SUBTRACTION
  | TASKREF
  | TASKUSED
  | TIMESKEW_TIMING_CHECK
  | TIMINGSPEC
  | TLIST of (token list)
  | TOKEN_707
  | TOKEN_708
  | UNKNOWN
  | WIDTH_TIMING_CHECK
