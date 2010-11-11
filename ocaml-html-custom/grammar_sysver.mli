exception Error

type token = 
  | Z_OR_X of (string)
  | Z_DIGIT of (string)
  | X_DIGIT of (string)
  | XOR
  | XNOR
  | WOR
  | WITHIN
  | WITH
  | WIRE
  | WIDTH_TIMING_CHECK
  | WHILE
  | WEAK1
  | WEAK0
  | WAND
  | WAIT_ORDER
  | WAIT
  | VOID
  | VIRTUAL
  | VIGENUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | VECTORED
  | VBAR
  | U_WIRE
  | USE
  | US of (token)
  | UNVIGENUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | UNSIGNED
  | UNKNOWN
  | UNIQUE
  | UNION
  | UNDECUPLE of (token * token * token * token * token * token * token * token * token * token * token)
  | TYPEDEF
  | TYPE
  | TRIREG
  | TRIPLE of (token * token * token)
  | TRIOR
  | TRIAND
  | TRI1
  | TRI0
  | TRI
  | TREVIGENUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | TREDECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token)
  | TRANIF1
  | TRANIF0
  | TRAN
  | TLIST of (token list)
  | TIMINGSPEC
  | TIME_UNIT of (string)
  | TIMEUNIT
  | TIMESKEW_TIMING_CHECK
  | TIMES
  | TIMEPRECISION
  | TIME
  | TILDE
  | AT_STAR
  | BACKSLASH
  | BEGIN_COMMENT
  | DASH_GT_GT
  | DOUBLE_QUOTES
  | END_COMMENT
  | EQUALS_QUERY_EQUALS
  | LBRACK_STAR
  | LBRACK_STAR_DASH_GT
  | TILDE_VBAR
  | TOKEN_1364_2001
  | TOKEN_9_
  | TOKEN_9_DOLLAR
  | TOKEN_ANY_ASCII
  | TOKEN_B0
  | TOKEN_B1
  | TOKEN_DASH_DASH
  | TOKEN_DPI
  | TOKEN_EDGE01
  | TOKEN_EDGE_10
  | TOKEN_EDGE_11
  | TOKEN_ESCAPED_NEWLINE
  | TOKEN_EIGHT
  | TOKEN_FALSE
  | TOKEN_FALSE1
  | TOKEN_FALSE2
  | TOKEN_FIVE
  | TOKEN_FOUR
  | TOKEN_LBRACK_STAR_EQUALS
  | TOKEN_LPAREN_STAR
  | TOKEN_LPAREN_STAR_RPAREN
  | TOKEN_NEWLINE
  | TOKEN_NINE
  | TOKEN_ONE
  | TOKEN_PLING_EQUALS_GT
  | TOKEN_PLING_QUERY_EQUALS
  | TOKEN_PLUS_PLUS
  | TOKEN_QUOTE_FALSE
  | TOKEN_QUOTE_TRUE
  | TOKEN_QUOTE_X1
  | TOKEN_QUOTE_Z1
  | TOKEN_QUOTE_X2
  | TOKEN_QUOTE_Z2
  | TOKEN_RBRACK_LCURLY
  | TOKEN_SEVEN
  | TOKEN_SIX
  | TOKEN_SLASH_SLASH
  | TOKEN_STAR_RPAREN
  | TOKEN_THREE
  | TOKEN_TRUE
  | TOKEN_TRUE1
  | TOKEN_TRUE2
  | TOKEN_TWO
  | TOKEN_VBAR_EQUALS
  | TOKEN_VBAR_VBAR
  | TOKEN_X0
  | TOKEN_X1
  | TOKEN_X2
  | TOKEN_X3
  | TOKEN_ZERO
  | UNDERSCORE
  | VBAR_DASH_GT
  | THROUGHOUT
  | THIS
  | TASKUSED
  | TASKREF
  | TASK
  | TABLE
  | TAB
  | SYSTEM_TASK_IDENTIFIER of (string)
  | SYSTEM_FUNCTION_IDENTIFIER of (string)
  | SVINT
  | SUPPLY1
  | SUPPLY0
  | SUPER
  | SUBTRACTION
  | SUBMODULE
  | SUBCCT
  | STRUCT
  | STRONG1
  | STRONG0
  | STRING
  | STEP
  | STATIC
  | SQUOTE
  | SPECPARAM
  | SPECIFY
  | SPECIAL
  | SPACE
  | SOLVE
  | SMALL
  | SKEW_TIMING_CHECK
  | SIMPLE_IDENTIFIER of (string)
  | SIGNED
  | SHOWCANCELLED
  | SHORTREAL
  | SHORTINT
  | SEXTUPLE of (token * token * token * token * token * token)
  | SEXDECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | SETUP_TIMING_CHECK
  | SETUPHOLD_TIMING_CHECK
  | SEQUENCE
  | SEPTUPLE of (token * token * token * token * token * token * token)
  | SEPTENDECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | SENSUSED
  | SEMICOLON
  | SCALARED
  | SCALAR
  | RTRANIF1
  | RTRANIF0
  | RTRAN
  | RPMOS
  | RPAREN
  | RNMOS
  | RIGHT_CURLY
  | RIGHT_BRACKET
  | RETURN
  | REPEAT
  | REMOVAL_TIMING_CHECK
  | RELEASE
  | REG
  | REF
  | RECREM_TIMING_CHECK
  | RECOVERY_TIMING_CHECK
  | RECEIVER
  | REALTIME
  | REAL
  | RCURLY
  | RCMOS
  | RBRACK
  | RANGE of (token * token )
  | RANDOMIZE
  | RANDC
  | RAND
  | QUINVIGENUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | QUINTUPLE of (token * token * token * token * token)
  | QUINDECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | QUERY
  | QUATTUORVIGENUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | QUATTUORDECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | QUADRUPLE of (token * token * token * token)
  | P_XOREQ
  | P_XNOR
  | P_WILDNOTEQUAL
  | P_WILDEQUAL
  | P_TIMESEQ
  | P_TIMESCALE of (string)
  | P_SUPPRESS_FAULTS
  | P_SSRIGHT3EQ
  | P_SSRIGHT3
  | P_SRIGHTEQ
  | P_SRIGHT
  | P_SLEFTEQ
  | P_SLEFT3EQ
  | P_SLEFT3
  | P_SLEFT
  | P_RESETALL
  | P_PROTECT
  | P_POW
  | P_POUNDPOUND
  | P_PLUSEQ
  | P_PLUSCOLON
  | P_OROR
  | P_ORMINUSGT
  | P_OREQGT
  | P_OREQ
  | P_NXOR
  | P_NOTEQUAL
  | P_NOSUPPRESS_FAULTS
  | P_NOR
  | P_NAND
  | P_MODEQ
  | P_MINUSGT
  | P_MINUSEQ
  | P_MINUSCOLON
  | P_LTE
  | P_INCLUDE of (string)
  | P_IFDEF
  | P_GTE
  | P_EQUAL
  | P_EQGT
  | P_ENDPROTECT
  | P_ENDIF
  | P_ENDCELLDEFINE
  | P_ENABLE_PORTFAULTS
  | P_ELSE
  | P_DOTSTAR
  | P_DIVEQ
  | P_DISABLE_PORTFAULTS
  | P_DELAY_MODE_PATH
  | P_DEFINE
  | P_COLONEQ
  | P_COLONDIV
  | P_COLONCOLON
  | P_CELLDEFINE
  | P_CASENOTEQUAL
  | P_CASEEQUAL
  | P_ATAT
  | P_ASTGT
  | P_ANDEQ
  | P_ANDANDAND
  | P_ANDAND
  | PURE
  | PULSESTYLE_ONEVENT
  | PULSESTYLE_ONDETECT
  | PULLUP
  | PULLDOWN
  | PULL1
  | PULL0
  | PS of (token)
  | PROTECTED
  | PROPERTY
  | PROGRAM
  | PRIORITY
  | PRIMITIVE
  | PRIMINST
  | PREPROC of (string)
  | PRAGMATIC of (string)
  | POSEDGE
  | PMOS
  | PLUS
  | PLING
  | PERIOD_TIMING_CHECK
  | PATHPULSE
  | PARTSEL
  | PARAMUSED
  | PARAMETER
  | PACKED
  | OUTPUT_SYMBOL of (string)
  | OUTPUT
  | OR
  | OCTUPLE of (token * token * token * token * token * token * token * token)
  | OCTODECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | OCTNUM of (string)
  | OCTAL_BASE_3 of (string)
  | OCTAL_BASE of (string)
  | NULL
  | NS of (token)
  | NOVEMDECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | NOTIF1
  | NOTIF0
  | NOT
  | NOSHOWCANCELLED
  | NOR
  | NONUPLE of (token * token * token * token * token * token * token * token * token)
  | NOCHANGE_TIMING_CHECK
  | NOCHANGE
  | NMOS
  | NEWLINE
  | NEW
  | NEGEDGE
  | NAND
  | NAMED
  | MS of (token)
  | MODULO
  | MODULE
  | MODPORT
  | MODINST
  | MINUS
  | MINTYPMAX
  | MEMORY
  | MEDIUM
  | MACROMODULE
  | LPAREN
  | LONGINT
  | LOGIC
  | LOCALPARAM
  | LOCAL
  | LIBRARY
  | LIBLIST
  | LEVEL_SYMBOL of (string)
  | LESS
  | LEFT_CURLY
  | LEFT_BRACKET
  | LCURLY
  | LBRACK
  | LARGE
  | JOIN_NONE
  | JOIN_ANY
  | JOIN
  | IS_DEFINED_AS
  | ISUNKNOWN
  | IOPORT
  | INTNUM of (string)
  | INTERSECT
  | INTERFACE
  | INTEGER
  | INT of (int)
  | INSTANCE
  | INSIDE
  | INPUT
  | INOUT
  | INITIAL
  | INCLUDE
  | INCDIR
  | IMPORT
  | IMPLICIT
  | IF_NONE
  | IFF
  | IF
  | ID of (string)
  | HOLD_TIMING_CHECK
  | HIGHZ1
  | HIGHZ0
  | HEX_DIGIT of (string)
  | HEX_BASE_3 of (string)
  | HEX_BASE of (string)
  | HEXNUM of (string)
  | HASH
  | GREATER
  | GENVAR
  | GENERATE
  | GENCASECOND
  | GENCASE
  | FUNCUSED
  | FUNCTION
  | FUNCREF
  | FULLSKEW_TIMING_CHECK
  | FULLSKEW
  | FS of (token)
  | FORKJOIN
  | FORK
  | FOREVER
  | FORCE
  | FOR
  | FLOATNUM of (float)
  | FIRST_MATCH
  | FINAL
  | FILE_PATH
  | EXTERN
  | EXTENDS
  | EXPORT
  | EXP of (string)
  | EVENT
  | EQUALS
  | EOF
  | ENUM
  | ENDTASK
  | ENDTABLE
  | ENDSPECIFY
  | ENDSEQUENCE
  | ENDPROPERTY
  | ENDPROGRAM
  | ENDPRIMITIVE
  | ENDOFFILE
  | ENDMODULE
  | ENDLABEL
  | ENDINTERFACE
  | ENDGENERATE
  | ENDFUNCTION
  | ENDCONFIG
  | ENDCLOCKING
  | ENDCLASS
  | ENDCASE
  | END
  | EMPTY
  | ELSE
  | EDGE_SYMBOL of (string)
  | EDGE
  | D_WRITE
  | D_WIDTH
  | D_WARNING
  | D_UNSIGNED
  | D_TIMESKEW
  | D_TIME
  | D_TEST_PLUSARGS
  | D_STOP
  | D_STIME
  | D_SSCANF
  | D_SKEW
  | D_SIGNED
  | D_SETUPHOLD
  | D_SETUP
  | D_REMOVAL
  | D_RECREM
  | D_RECOVERY
  | D_REALTIME
  | D_READMEMH
  | D_READMEMB
  | D_RANDOM
  | D_PERIOD
  | D_ONEHOT0
  | D_ONEHOT
  | D_MONITOR
  | D_ISUNKNOWN
  | D_INFO
  | D_HOLD
  | D_FWRITEH
  | D_FWRITE
  | D_FSCANF
  | D_FOPEN
  | D_FINISH
  | D_FGETS
  | D_FGETC
  | D_FFLUSH
  | D_FEOF
  | D_FDISPLAY
  | D_FCLOSE
  | D_FATAL
  | D_ERROR
  | D_DISPLAY
  | D_COUNTONES
  | D_COUNTDRIVERS
  | D_CLOG2
  | D_C
  | D_BITS
  | D_ATTRIBUTE
  | DUOVIGENUPLE of (token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token * token)
  | DUODECUPLE of (token * token * token * token * token * token * token * token * token * token * token * token)
  | DRIVER
  | DOUBLE of (token * token)
  | DOTTED of (token list)
  | DOT
  | DOLLAR
  | DO
  | DLYASSIGNMENT
  | DIVIDE
  | DIST
  | DISABLE
  | DESIGN
  | DEFPARAM
  | DEFAULT
  | DECUPLE of (token * token * token * token * token * token * token * token * token * token)
  | DECNUM of (string)
  | DECIMAL_BASE_3 of (string)
  | DECIMAL_BASE of (string)
  | DEASSIGN
  | C_IDENTIFIER of (string)
  | COVER
  | COUNTONES
  | CONTINUE
  | CONTEXT
  | CONSTRAINT
  | CONST
  | CONFIG
  | CONCAT
  | COMMA
  | COLON
  | CMOS
  | CLOCKING
  | CLASS
  | CHAR of (char)
  | CHANDLE
  | CELLPIN
  | CELL
  | CASEZ
  | CASEX
  | CASECOND
  | CASE
  | CARET
  | BYTE
  | BUFIF1
  | BUFIF0
  | BUF
  | BREAK
  | BOLD
  | BITSEL
  | BIT
  | BINNUM of (string)
  | BIND
  | BINARY_BASE_3 of (string)
  | BINARY_BASE of (string)
  | BIDIR
  | BEGIN
  | BEFORE
  | AUTOMATIC
  | AT
  | ASSIGNMENT
  | ASSIGN
  | ASSERT
  | ASCNUM of (string)
  | AS of (token)
  | ANY_ASCII_CHARS
  | ANY_ASCII_CHAR
  | AND
  | AMPERSAND
  | ALWAYS_LATCH
  | ALWAYS_FF
  | ALWAYS_COMB
  | ALWAYS
  | ALTERNATIVE
  | ALIAS
  | UNSIGNED_NUMBER of (string)
  | ATTRIBUTE_INSTANCE of (string)
  | NAME_OF_UDP_INSTANCE of (string)

val getstr : token -> string
