//*****************************************************************************
//
//    DESCRIPTION: Verilog parser ocamlyacc grammar file
//
//*****************************************************************************
//
// Copyright 2010 by Jonathan Kimmitt.  This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// General Public License or the Perl Artistic License.
//
// This code is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
//*****************************************************************************
// Based on verilator parser code by Paul Wasson, Duane Galbi and Wilson Snyder
//*****************************************************************************

%{ open Vparser exception Error %}

// Generic void
%token EMPTY
// Generic double
%token<token * token > DOUBLE
// Generic triple
%token<token * token * token > TRIPLE
// Generic quadruple
%token<token * token * token * token > QUADRUPLE
// Generic quintuple
%token<token * token * token * token * token > QUINTUPLE
// Generic sextuple
%token<token * token * token * token * token * token > SEXTUPLE
// Generic septuple
%token<token * token * token * token * token * token * token > SEPTUPLE

// non-keyword tokens
%token<token list> PRIMARGS
%token FUNCARGS
%token FUNCBODY
%token BITSEL
%token PARTSEL
%token IOPORT
%token SUBMODULE
%token SUBCCT
%token PRIMINST
%token<token * token > RANGE
%token<token list> TLIST
// for undeclared wires
%token IMPLICIT
%token RECEIVER
%token DRIVER
%token BIDIR

// pre-proc tokens
%token<string> COMMENT_BEGIN
%token COMMENT_END
%token<string> PREPROC	// some other token, not (yet) recognized

// Generic lexer tokens, for example a number
// IEEE: real_number
%token<float>		FLOATNUM	// "FLOATING-POINT NUMBER"
// IEEE: identifier, class_identifier, class_variable_identifier,
// covergroup_variable_identifier, dynamic_array_variable_identifier,
// enum_identifier, interface_identifier, interface_instance_identifier,
// package_identifier, type_identifier, variable_identifier,
%token<string>		ID		// "IDENTIFIER"

// IEEE: integral_number
%token<int>	INTNUM	// "INTEGER NUMBER"
%token<string>		BINNUM	// "BINARY NUMBER"
%token<string>		DECNUM	// "DECIMAL NUMBER"
%token<string>		HEXNUM	// "HEXADECIMAL NUMBER"
// IEEE: string_literal
%token<string>		ASCNUM	// "ASCII NUMBER / STRING"
%token			TIMINGSPEC	// "TIMING SPEC ELEMENT"

%token<char> ILLEGAL
%token DOLLAR
%token EOF

// Specific keywords
%token AMPERSAND
%token AT
%token CARET
%token COLON
%token COMMA
%token DIVIDE
%token EQUALS
%token GREATER
%token HASH
%token LBRACK
%token LCURLY
%token LESS
%token LPAREN
%token MINUS
%token MODULO
%token DOT
%token PLING
%token PLUS
%token QUERY
%token RBRACK
%token RCURLY
%token RPAREN
%token SEMICOLON
%token TILDE
%token TIMES
%token VBAR
// KEYWORD means match // "keyword"
// Other cases are XX_KEYWORD where XX makes it unique,
// for example P_ for punctuation based operators.
%token ALWAYS		// "always"
%token AND		// "and"
%token ASSERT		// "assert"
%token ASSIGN		// "assign"
%token ASSIGNMENT	// "assignment"
%token AUTOMATIC	// "automatic"
%token BEGIN		// "begin"
%token BUF		// "buf"
%token<string> BUFIF	// "bufif"
%token CASE		// "case"
%token CASEX		// "casex"
%token CASEZ		// "casez"
%token CLOCKING	// "clocking"
%token COVER		// "cover"
%token DEFAULT	// "default"
%token DEFPARAM	// "defparam"
%token DISABLE	// "disable"
%token DO		// "do"
%token ELSE		// "else"
%token END		// "end"
%token ENDCASE	// "endcase"
%token ENDCLOCKING	// "endclocking"
%token ENDFUNCTION	// "endfunction"
%token ENDGENERATE	// "endgenerate"
%token ENDMODULE	// "endmodule"
%token ENDPRIMITIVE	// "endprimitive"
%token ENDSPECIFY	// "endspecify"
%token ENDTABLE	// "endtable"
%token ENDTASK	// "endtask"
%token FINAL		// "final"
%token FOR		// "for"
%token FUNCTION	// "function"
%token GENERATE	// "generate"
%token GENVAR		// "genvar"
%token IF		// "if"
%token IFF		// "iff"
%token INITIAL	// "initial"
%token INOUT		// "inout"
%token INPUT		// "input"
%token INTEGER	// "integer"
%token LOCALPARAM	// "localparam"
%token MODULE		// "module"
%token NAND		// "nand"
%token NEGEDGE	// "negedge"
%token NOR		// "nor"
%token NOT		// "not"
%token OR		// "or"
%token OUTPUT		// "output"
%token PARAMETER	// "parameter"
%token POSEDGE	// "posedge"
%token PRIMITIVE	// "primitive"
%token PROPERTY	// "property"
%token PULLUP	// "pullup"
%token REAL		// "real"
%token REG		// "reg"
%token SCALARED	// "scalared"
%token SIGNED		// "signed"
%token SPECIFY	// "specify"
%token STATIC		// "static"
%token SUPPLY0	// "supply0"
%token SUPPLY1	// "supply1"
%token TABLE	// "table"
%token TASK		// "task"
%token<string> TRI		// "tri"
%token UNSIGNED	// "unsigned"
%token VECTORED	// "vectored"
%token<string> WEAK		// "weak"
%token<string> PWEAK		// "(weak"
%token WHILE		// "while"
%token WIRE		// "wire"
%token XNOR		// "xnor"
%token XOR		// "xor"

%token D_ATTRIBUTE	// "$attribute"
%token D_BITS		// "$bits"
%token D_C		// "$c"
%token D_CLOG2	// "$clog2"
%token D_COUNTDRIVERS	// "$countdrivers"
%token D_COUNTONES	// "$countones"
%token D_DISPLAY	// "$display"
%token D_ERROR	// "$error"
%token D_FATAL	// "$fatal"
%token D_FCLOSE	// "$fclose"
%token D_FDISPLAY	// "$fdisplay"
%token D_FEOF		// "$feof"
%token D_FFLUSH	// "$fflush"
%token D_FGETC	// "$fgetc"
%token D_FGETS	// "$fgets"
%token D_FINISH	// "$finish"
%token D_FOPEN	// "$fopen"
%token D_FSCANF	// "$fscanf"
%token D_FWRITE	// "$fwrite"
%token D_INFO		// "$info"
%token D_ISUNKNOWN	// "$isunknown"
%token D_ONEHOT	// "$onehot"
%token D_ONEHOT0	// "$onehot0"
%token D_RANDOM	// "$random"
%token D_READMEMB	// "$readmemb"
%token D_READMEMH	// "$readmemh"
%token D_SIGNED	// "$signed"
%token D_SSCANF	// "$sscanf"
%token D_STIME	// "$stime"
%token D_STOP		// "$stop"
%token D_TEST_PLUSARGS	// "$test$plusargs"
%token D_TIME		// "$time"
%token D_UNSIGNED	// "$unsigned"
%token D_WARNING	// "$warning"
%token D_WRITE	// "$write"

%token P_OROR		// "||"
%token P_ANDAND	// "&&"
%token P_NOR		// "~|"
%token P_XNOR		// "^~"
%token P_NAND		// "~&"
%token P_EQUAL	// "=="
%token P_NOTEQUAL	// "!="
%token P_CASEEQUAL	// "==="
%token P_CASENOTEQUAL	// "!=="
%token P_WILDEQUAL	// "==?"
%token P_WILDNOTEQUAL	// "!=?"
%token P_GTE		// ">="
%token P_LTE		// "<="
%token P_SLEFT	// "<<"
%token P_SRIGHT	// ">>"
%token P_SSRIGHT	// ">>>"
%token P_POW		// "**"

%token P_PLUSCOLON	// "+:"
%token P_MINUSCOLON	// "-:"
%token P_EQGT		// "=>"
%token P_ASTGT	// "*>"
%token P_ANDANDAND	// "&&&"
%token P_POUNDPOUND	// "##"
%token P_DOTSTAR	// ".*"

%token P_ATAT		// "@@"
%token P_COLONCOLON	// "::"
%token P_COLONEQ	// ":="
%token P_COLONDIV	// ":/"
%token P_ORMINUSGT	// "|->"
%token P_OREQGT	// "|=>"

%token P_PLUSEQ	// "+="
%token P_MINUSEQ	// "-="
%token P_TIMESEQ	// "*="
%token P_DIVEQ	// "/="
%token P_MODEQ	// "%="
%token P_ANDEQ	// "&="
%token P_OREQ		// "|="
%token P_XOREQ	// "^="
%token P_SLEFTEQ	// "<<="
%token P_SRIGHTEQ	// ">>="
%token P_SSRIGHTEQ	// ">>>="

%token P_MINUSGT	// "->"

%token ENDOFFILE

// Verilog op precedence
%left		COLON
%left		QUERY
%left		P_OROR
%left		P_ANDAND
%left		VBAR P_NOR
%left		CARET
%left		P_XNOR
%left		AMPERSAND P_NAND
%left		P_EQUAL P_NOTEQUAL P_CASEEQUAL P_CASENOTEQUAL P_WILDEQUAL P_WILDNOTEQUAL
%left		GREATER LESS P_GTE P_LTE
%left		P_SLEFT P_SRIGHT P_SSRIGHT
%left		PLUS MINUS
%left		TIMES DIVIDE MODULO
%left		P_POW
%left	prUNARYARITH
%left	prREDUCTION
%left	prNEGATION

%nonassoc prLOWER_THAN_ELSE
%nonassoc ELSE

// Types are in same order as declarations.
// Naming:
//	Trailing E indicates this type may have empty match

%start start

%type <token> Anyrange
%type <token> AssertStmt
%type <token list> AssignList
%type <token> AssignOne
%type <token> beginNamed
%type <token> caseAttrE
%type <token list> caseCondList
%type <token list> caseList
%type <token> caseListE
%type <token> case
%type <token list> cateList
%type <token> cellpinItemE
%type <token list> cellpinItList
%type <token list> cellpinList
%type <token> commaEListE
%type <token> commaVRDListE
%type <token list> concIdList
%type <token> constExpr
%type <token list> cStrList
%type <token list> defpList
%type <token> defpOne
%type <token> delay
%type <token> delayE
%type <token> delayrange
%type <token> delayStrength
%type <token> dlyTerm
%type <token> endLabelE
%type <token> eventControl
%type <token> expr
%type <token list> exprList
%type <token> exprNoStr
%type <token> exprStrText
%type <token> funcBody
%type <token> funcDecl
%type <token> funcGuts
%type <token> funcRef
%type <token> funcTypeE
%type <token> funcVar
%type <token list> funcVarList
%type <token> gateAnd
%type <token list> gateAndList
%type <token list> gateAndPinList
%type <token> gateBuf
%type <token list> gateBufList
%type <token> gateDecl
%type <token> gateIdE
%type <token> gateNand
%type <token list> gateNandList
%type <token> gateNor
%type <token list> gateNorList
%type <token> gateNot
%type <token list> gateNotList
%type <token> gateOr
%type <token list> gateOrList
%type <token list> gateOrPinList
%type <token> gateXnor
%type <token list> gateXnorList
%type <token> gateXor
%type <token list> gateXorList
%type <token list> gateXorPinList
%type <token list> genCaseList
%type <token> genCaseListE
%type <token> generateRegion
%type <token> genItem
%type <token> genItemBegin
%type <token> genItemBlock
%type <token list> genItemList
%type <token> genTopBlock
%type <token> idArrayed
%type <token> idDotted
%type <token> instDecl
%type <token list> instnameList
%type <token> instnameParen
%type <token> instparamListE
%type <token> instRangeE
%type <token> labeledStmt
%type <token> lifetimeE
%type <token> minTypMax
%type <token> modItem
%type <token list> modItemList
%type <token> modItemListE
%type <token> modOrGenItem
%type <token list> modParArgs
%type <token> modParDecl
%type <token> modParE
%type <token list> modParList
%type <token> modParSecond
%type <token> modPortsE
%type <unit> moduleDecl
%type <token> netSig
%type <token list> netSigList
%type <token> param
%type <token list> paramList
%type <token> parenE
%type <token> Port
%type <token> PortDecl
%type <token>      PortDirection
%type <token list> PortList
%type <token> PortRangeE
%type <token list> RangeList
%type <token> RangeListE
%type <token> regrangeE
%type <token> regsig
%type <token list> regsigList
%type <token> senitem
%type <token> senitemEdge
%type <token> senitemVar
%type <token list> senList
%type <token> sigAndAttr
%type <token> sigAttrListE
%type <token> sigId
%type <token> signingE
%type <token list> Junk
%type <token list> JunkList
%type <unit>       start
%type <token> stateCaseForIf
%type <token> stmt
%type <token> stmtBlock
%type <token list> stmtList
%type <token> strAsInt
%type <token> strAsText
%type <token> taskDecl
%type <token> taskRef
%type <token> v2kVarDeclE
%type <token> varDecl
%type <token list> varDeclList
%type <token>      varGenVar
%type <token>      varGParam
%type <token>      varLParam
%type <token>      varNet
%type <token> varRefBase
%type <token> varRefDotBit
%type <token> varRefMem
%type <token>      varReg
%type <token list> vrdList
%type <token> identifier

%%

identifier:	ID	{ ID $1 }

//**********************************************************************
// Files

start:		ENDOFFILE				{ raise End_of_file }
	|	primDecl start				{ }
	|	PREPROC					{ (* Printf.fprintf Pervasives.stderr "%s\n" $1 *) }
	|	commentDecl				{ }
	|	moduleDecl start			{ }
	;

commentDecl:	COMMENT_BEGIN JunkList COMMENT_END { (* Printf.fprintf Pervasives.stderr "%s\n" *) $1 }	// placeholder

//**********************************************************************
// Module headers

// IEEE: module_declaration:
moduleDecl:	MODULE ID modParE modPortsE SEMICOLON modItemListE ENDMODULE
			{
			Hashtbl.add Globals.modprims $2
				{ Globals.tree=QUINTUPLE ( MODULE, ID $2, $3, $4, $6 );
				  symbols=Hashtbl.create 256}
			}
	;

// IEEE: primitive_declaration:
primDecl:	PRIMITIVE ID modParE modPortsE SEMICOLON primItemList ENDPRIMITIVE
			{
			Hashtbl.add Globals.modprims $2
				{ Globals.tree=QUINTUPLE ( PRIMITIVE, ID $2, $3, $4, TLIST $6 );
				  symbols=Hashtbl.create 256}
			}
	;

primItemList:
		primItem				{ [ $1 ] }
	|	primItem primItemList			{ $1 :: $2 }
	;

primItem:
		PortDecl 				{ $1 }
	|	varDecl 				{ $1 }
	|	tableDecl				{ $1 }
	;

modParE:
		/* empty */				{ EMPTY }
	|	HASH LPAREN RPAREN			{ EMPTY }
	|	HASH LPAREN modParArgs RPAREN		{ TLIST $3 }
	;

modParArgs:
		modParDecl				{ [ $1 ] }
	|	modParDecl COMMA modParList		{ $1 :: $3 }
	;

modParList:
		modParSecond				{ [ $1 ] }
	|	modParList COMMA modParSecond 		{ $1 @ [ $3 ] }
	;

// Called only after a comma in a v2k list, to allow parsing "parameter a,b, parameter x"
modParSecond:
		modParDecl				{ $1  }
	|	param					{ $1  }
	;

modPortsE:
		/* empty */				{ EMPTY }
	|	LPAREN RPAREN				{ EMPTY }
	|	LPAREN PortList RPAREN			{ TLIST $2 }
	|	LPAREN PortV2kArgs RPAREN		{ TLIST $2 }
	;

PortList:
		Port				       	{ [ $1 ] }
	|	Port COMMA PortList	  	   	{ $1 :: $3 }
	;

Port:
		identifier PortRangeE		       	{ $1 }
	|	DOT identifier LPAREN expr RPAREN	{ DOUBLE( DOT, $2  ) }
	;

PortV2kArgs:
		PortV2kDecl				{ [ $1 ] }
	|	PortV2kDecl COMMA PortV2kList		{ $1 :: $3 }
	;

PortV2kList:
		PortV2kSecond				{ [ $1 ] }
	|	PortV2kSecond COMMA PortV2kList		{ $1 :: $3 }
	;

// Called only after a comma in a v2k list, to allow parsing "input a,b"
PortV2kSecond:
		PortV2kDecl				{ $1 }
	|	PortV2kInit				{ $1 }
	;

PortV2kInit:
		PortV2kSig				{ $1 }
	|	PortV2kSig EQUALS expr			{ TRIPLE (EQUALS, $1, $3) }
	;

PortV2kSig:
		sigAndAttr				{ $1 }
	;

//************************************************
// Variable Declarations

varDeclList:
		varDecl					{ [ $1 ] }
	|	varDecl varDeclList			{ $1 :: $2 }
	;

regsigList:
		regsig  				{ [ $1 ] }
	|	regsigList COMMA regsig		       	{ $1 @ [ $3 ] }
	;

PortV2kDecl:
		PortDirection v2kVarDeclE signingE regrangeE PortV2kInit
			{  QUINTUPLE ( $1 , $2 , $3 , $4 , $5 )  }
	;

// IEEE: Port_declaration - plus SEMICOLON
PortDecl:
		PortDirection v2kVarDeclE signingE regrangeE regsigList SEMICOLON
			{  QUINTUPLE ( $1, $2, $3, $4, TLIST $5 )  }
	;

varDecl:
		varReg     signingE regrangeE  regsigList SEMICOLON
			{  QUADRUPLE ($1, $2, $3, TLIST $4 )  }
	|	varGParam  signingE regrangeE  paramList SEMICOLON
			{  QUADRUPLE ($1, $2, $3, TLIST $4 )  }
	|	varLParam  signingE regrangeE  paramList SEMICOLON
			{  QUADRUPLE ($1, $2, $3, TLIST $4 )  }
	|	varNet     signingE delayrange netSigList SEMICOLON
			{  QUADRUPLE ($1, $2, $3, TLIST $4 )  }
	|	varGenVar  signingE            regsigList SEMICOLON
			{  TRIPLE ($1, $2, TLIST $3 ) }
	;

modParDecl:
		varGParam  signingE regrangeE   param
		 	{ QUADRUPLE ($1, $2, $3, $4 ) }
	;

varNet:		SUPPLY0					{ SUPPLY0 }
	|	SUPPLY1					{ SUPPLY1 }
	|	WIRE 					{ WIRE }
	|	TRI 					{ TRI $1 }
	;
varGParam:	PARAMETER				{ PARAMETER }
	;
varLParam:	LOCALPARAM				{ LOCALPARAM }
	;
varGenVar:	GENVAR					{ GENVAR }
	;
varReg:		REG					{ REG }
	|	REAL					{ REAL }
	|	INTEGER					{ INTEGER }
	;

readmem:	D_READMEMB				{ D_READMEMB }
	|	D_READMEMH				{ D_READMEMH }
	;

//IEEE: Port_direction
PortDirection:	INPUT					{ INPUT }
	|	OUTPUT					{ OUTPUT }
	|	INOUT					{ INOUT }
//	|	REF					{ REF }
	;

// IEEE: signing - plus empty
signingE:	/*empty*/ 				{ EMPTY }
	|	SIGNED					{ SIGNED }
	|	UNSIGNED				{ UNSIGNED }
	;

v2kVarDeclE:	/*empty*/ 				{ EMPTY }
	|	varNet 					{ $1 }
	|	varReg 					{ $1 }
	;

//************************************************
// Module Items

modItemListE:
		/* empty */				{ EMPTY }
	|	modItemList				{ TLIST $1 }
	;

modItemList:
		modItem					{ [ $1 ] }
	|	modItem modItemList			{ $1 :: $2 }
	;

modItem:
		modOrGenItem 				{ $1 }
	|	generateRegion				{ $1 }
	|	SPECIFY JunkList ENDSPECIFY	{ DOUBLE (SPECIFY, TLIST $2) }
	|	SPECIFY ENDSPECIFY			{ DOUBLE (SPECIFY, EMPTY ) }
	|	PREPROC					{ (* Printf.fprintf Pervasives.stderr "%s\n" $1 *) PREPROC $1 }
	;

// IEEE: generate_region
generateRegion:
		GENERATE genTopBlock ENDGENERATE	{ DOUBLE (GENERATE, $2) }
	;

modOrGenItem:
		ALWAYS stmtBlock			{ DOUBLE (ALWAYS, $2) }
	|	FINAL stmtBlock				{ DOUBLE (FINAL, $2 ) }
	|	INITIAL stmtBlock			{ DOUBLE ( INITIAL, $2 ) }
	|	ASSIGN delayStrength AssignList SEMICOLON	{ TRIPLE ( ASSIGN, $2, TLIST $3 ) }
	|	DEFPARAM defpList SEMICOLON		{ DOUBLE (DEFPARAM, TLIST $2 ) }
	|	instDecl 				{ $1 }
	|	taskDecl 				{ $1 }
	|	funcDecl 				{ $1 }
	|	gateDecl 				{ $1 }
	|	attrDecl 				{ $1 }
	|	PortDecl 				{ $1 }
	|	varDecl 				{ $1 }
	|	tableDecl				{ $1 }
	|	concurrent_assertion_item		{ $1 }  // IEEE puts in modItem; seems silly
	|	clocking_declaration			{ $1 }
	;

//************************************************
// Generates

// Because genItemList includes variable declarations, we dont need beginNamed
genItemBlock:
		genItem					{ $1 }
	|	genItemBegin				{ $1 }
	;

genTopBlock:
		genItemList				{ TLIST $1 }
	|	genItemBegin				{ $1 }
	;

genItemBegin:
		BEGIN genItemList END			{ TLIST $2 }
	|	BEGIN END				{ EMPTY }
	|	BEGIN COLON identifier genItemList END endLabelE	{ TRIPLE ($3, TLIST $4, $6) }
	|	BEGIN COLON identifier 	           END endLabelE	{ TRIPLE ($3, EMPTY, $5) }
	;

genItemList:
		genItem					{ [ $1 ] }
	|	genItem genItemList			{ $1 :: $2 }
	;

genItem:
		modOrGenItem 				{ $1 }
	|	CASE  LPAREN expr RPAREN genCaseListE ENDCASE	{ TRIPLE (CASE, $3, $5) }
	|	IF LPAREN expr RPAREN genItemBlock	%prec prLOWER_THAN_ELSE
			{ TRIPLE (IF, $3, $5) }
	|	IF LPAREN expr RPAREN genItemBlock ELSE genItemBlock
			{ QUADRUPLE (IF, $3, $5, $7) }
	|	FOR LPAREN varRefBase EQUALS expr SEMICOLON
			expr SEMICOLON varRefBase EQUALS expr RPAREN genItemBlock
			{ SEPTUPLE (FOR, $3, $5, $7, $9, $11, $13) }
	;

genCaseListE:
		/* empty */				{ EMPTY }
	|	genCaseList				{ TLIST $1 }
	;

genCaseList:
		caseCondList COLON genItemBlock		{ [ TRIPLE (COLON, TLIST $1, $3) ] }
	|	DEFAULT COLON genItemBlock		{ [ DOUBLE (DEFAULT, $3) ] }
	|	DEFAULT genItemBlock			{ [ DOUBLE (DEFAULT, $2) ] }
	|	genCaseList caseCondList COLON genItemBlock	{ TRIPLE (COLON, TLIST $2, $4) :: $1 }
	|       genCaseList DEFAULT genItemBlock		{ DOUBLE (DEFAULT, $3) :: $1 }
	|	genCaseList DEFAULT COLON genItemBlock		{ DOUBLE (DEFAULT, $4) :: $1 }
	;

//************************************************
// Assignments and register declarations

AssignList:
		AssignOne				{ [ $1 ] }
	|	AssignList COMMA AssignOne		{ $1 @ [ $3 ] }
	;

AssignOne:
		varRefDotBit EQUALS expr			{ TRIPLE (EQUALS, $1, $3) }
	|	LCURLY concIdList RCURLY EQUALS expr		{ TRIPLE (EQUALS, TLIST $2, $5) }
	;

delayE:		/* empty */				{ EMPTY }
	|	delay					{ $1 } /* ignored */
	;

delayStrength:	/* empty */				{ EMPTY }
	|	delay					{ $1 } /* ignored */
	|	PWEAK strengthList RPAREN		{ TLIST ((WEAK $1) :: $2) }
	;

strengthList:
		/* empty */				{ [] }
	|	COMMA WEAK strengthList			{ WEAK $2 :: $3 }

delay:
		HASH dlyTerm
			{ DOUBLE (HASH, $2) } /* ignored */
	|	HASH LPAREN minTypMax RPAREN
			{ DOUBLE (HASH, $3) } /* ignored */
	|	HASH LPAREN minTypMax COMMA minTypMax RPAREN
			{ TRIPLE (HASH, $3, $5) } /* ignored */
	|	HASH LPAREN minTypMax COMMA minTypMax COMMA minTypMax RPAREN
			{ QUADRUPLE (HASH, $3, $5, $7) } /* ignored */
	;

dlyTerm:
		identifier 				{ $1 }
	|	INTNUM 					{ INTNUM $1 }
	|	FLOATNUM 				{ FLOATNUM $1 }
	;

// IEEE: mintypmax_expression and constant_mintypmax_expression
minTypMax:
		dlyTerm					{ $1 } /* ignored */
	|	dlyTerm COLON dlyTerm COLON dlyTerm	{ QUADRUPLE(COLON, $1, $3, $5) } /* ignored */
	;

sigAndAttr:
		sigId sigAttrListE			{ DOUBLE ( $1, $2 ) }
	;

netSigList:
		netSig  				{ [ $1 ] }
	|	netSigList COMMA netSig		       	{ $1 @ [ $3 ] }
	;

netSig:
		sigId sigAttrListE			{ DOUBLE ( $1, $2 ) }
	|	sigId sigAttrListE EQUALS expr		{ TRIPLE ( $1, $2, $4 ) }
	|	identifier RangeList sigAttrListE	{ TRIPLE ( $1, TLIST $2, $3 ) }
	;

regsig:
		identifier RangeListE sigAttrListE			{ TRIPLE ($1, $2, $3 ) }
	|	identifier RangeListE EQUALS constExpr sigAttrListE	{ QUADRUPLE ($1, $2, $4, $5 ) }
	;

sigId:	identifier					{ $1 }
	;

sigAttrListE:	/* empty */				{ EMPTY }
	;

RangeListE:
		/* empty */    		               	{ EMPTY }
	|	RangeList 				{ TLIST $1 }
	;

RangeList:
		Anyrange				{ [ $1 ] }
        |	RangeList Anyrange			{ $1 @ [ $2 ] }
	;

regrangeE:
		/* empty */    		               	{ EMPTY }
	|	Anyrange 				{ $1 }
	;

Anyrange:
		LBRACK constExpr COLON constExpr RBRACK	{ RANGE( $2, $4) }
	;

delayrange:
		regrangeE delayE 			{ TRIPLE (EMPTY, $1, $2) }
	|	SCALARED regrangeE delayE 		{ TRIPLE (SCALARED, $2, $3) }
	|	VECTORED regrangeE delayE 		{ TRIPLE (VECTORED, $2, $3) }
	;

PortRangeE:
		/* empty */	                   	{ EMPTY }
	|	LBRACK constExpr RBRACK              	{ $2 }
	|	LBRACK constExpr COLON constExpr RBRACK	{ RANGE ($2, $4) }
	;

//************************************************
// Parameters

param:
		sigId sigAttrListE EQUALS expr		{ TRIPLE ( $1, $2, $4 ) }
	;

paramList:
		param					{ [ $1 ] }
	|	paramList COMMA param			{ $1 @ [ $3 ] }
	;

// IEEE: list_of_defparam_assignments
defpList:
		defpOne					{ [ $1 ] }
	|	defpList COMMA defpOne			{ $1 @ [ $3 ] }
	;

defpOne:
		identifier DOT identifier EQUALS expr { TRIPLE ($1, $3 , $5 ) }
	;

//************************************************
// Instances

instDecl:
		identifier instparamListE instnameList SEMICOLON  { TRIPLE ($1, $2, TLIST $3 ) }
	| 	identifier instparamListE LPAREN varRefDotBit COMMA gateUdpPinList RPAREN SEMICOLON
							{ QUADRUPLE (PRIMINST, $1, $2, TLIST ($4::$6) ) }
instparamListE:
		/* empty */				{ EMPTY }
	|	HASH LPAREN cellpinList RPAREN		{ TLIST $3 }
	|	PWEAK strengthList RPAREN		{ TLIST ((WEAK $1) :: $2) }
	;

instnameList:
		instnameParen				{ [ $1 ] }
	|	instnameList COMMA instnameParen	{ $1 @ [ $3 ] }
	;

instnameParen:
		identifier instRangeE LPAREN cellpinList RPAREN	{ TRIPLE ($1, $2, TLIST $4 ) }
	|	identifier instRangeE 			{ DOUBLE ( $1, $2 ) }
	;

instRangeE:
		/* empty */				{ EMPTY }
	|	LBRACK constExpr COLON constExpr RBRACK	{ RANGE ($2, $4) }
	;

cellpinList:
		cellpinItList				{ $1 }
	;

cellpinItList:
		cellpinItemE				{ [ $1 ] }
	|	cellpinItList COMMA cellpinItemE	{ $1 @ [ $3 ] }
	;

cellpinItemE:
		/* empty: ',,' is legal */		{ EMPTY }
	|	P_DOTSTAR				{ P_DOTSTAR }
	|	DOT identifier			{ DOUBLE (DOT, $2) }
	|	DOT identifier LPAREN RPAREN		{ DOUBLE (DOT, $2) }
	|	DOT identifier LPAREN expr RPAREN	{ TRIPLE (DOT, $2, $4) }
	|	expr					{ $1 }
	;

//************************************************
// EventControl lists

// IEEE: event_control
eventControl:
		AT LPAREN senList RPAREN		{ DOUBLE ( AT, (TLIST $3) ) }
	|	AT senitemVar				{ DOUBLE ( AT, $2 ) }
	|	AT LPAREN TIMES RPAREN			{ AT }  /* Verilog 2001 */
	|	AT TIMES				{ AT }  /* Verilog 2001 */
	|	delay					{ $1 }
	;

// IEEE: event_expression - split over several
senList:
		senitem					{ [ $1 ] }
	|	senList OR senitem			{ $1 @ [ $3 ] }
	|	senList COMMA senitem			{ $1 @ [ $3 ] }	/* Verilog 2001 */
	;

senitem:
		senitemEdge				{ $1 }
	|	senitemVar				{ $1 }
	|	LPAREN senitemVar RPAREN		{ $2 }
	;

senitemVar:
		varRefDotBit				{ $1 }
	;

senitemEdge:
		POSEDGE varRefDotBit			{ DOUBLE ( POSEDGE, $2 ) }
	|	NEGEDGE varRefDotBit			{ DOUBLE ( NEGEDGE, $2 ) }
	|	POSEDGE LPAREN varRefDotBit RPAREN	{ DOUBLE ( POSEDGE, $3 ) }
	|	NEGEDGE LPAREN varRefDotBit RPAREN	{ DOUBLE ( NEGEDGE, $3 ) }
	;

//************************************************
// Statements

stmtBlock:
		stmt					{ $1 }
	|	BEGIN stmtList END			{ TLIST $2 }
	|	BEGIN END				{ EMPTY }
	|	beginNamed stmtList END endLabelE	{ TRIPLE ($1, TLIST $2, $4) }
	|	beginNamed 	    END endLabelE	{ EMPTY }
	;

beginNamed:
		BEGIN COLON identifier varDeclList	{ TRIPLE (COLON, $3 , TLIST $4 ) }
	|	BEGIN COLON identifier 			{ DOUBLE (COLON, $3 ) }
	;

stmtList:
		stmtBlock				{ [ $1 ] }
	|	stmtList stmtBlock			{ $1 @ [ $2 ] }
	;

stmt:
		SEMICOLON				{ EMPTY }
	|	labeledStmt				{ $1 }
	|	identifier COLON labeledStmt		{ DOUBLE ($1, $3 ) }

	|	eventControl stmtBlock			{ DOUBLE ($1, $2 ) }

	|	varRefDotBit P_LTE delayE expr SEMICOLON
			{ QUADRUPLE (P_LTE, $1, $3, $4 ) }
	|	varRefDotBit EQUALS delayE expr SEMICOLON
			{ QUADRUPLE ( ASSIGNMENT, $1, $3, $4 ) }
	|	varRefDotBit EQUALS D_FOPEN LPAREN expr RPAREN SEMICOLON
			{ TRIPLE (D_FOPEN, $1, $5) }
	|	ASSIGN varRefDotBit EQUALS delayStrength expr SEMICOLON
			{ QUADRUPLE (ASSIGN, $2, $4, $5 ) }
	|	LCURLY concIdList RCURLY P_LTE delayE expr SEMICOLON
			{ QUADRUPLE (P_LTE, TLIST $2, $5, $6 ) }
	|	LCURLY concIdList RCURLY EQUALS delayE expr SEMICOLON
			{ QUADRUPLE (EQUALS, TLIST $2, $5, $6 ) }
	|	D_C LPAREN cStrList RPAREN SEMICOLON
			{ TLIST $3 }
	|	D_FCLOSE LPAREN varRefDotBit RPAREN SEMICOLON
			{ $3 }
	|	D_FFLUSH SEMICOLON
			{ D_FFLUSH }
	|	D_FFLUSH LPAREN RPAREN SEMICOLON
			{ D_FFLUSH }
	|	D_FFLUSH LPAREN varRefDotBit RPAREN SEMICOLON
			{ $3 }
	|	D_FINISH parenE SEMICOLON
			{ $2 }
	|	D_FINISH LPAREN expr RPAREN SEMICOLON
			{ $3 }
	|	D_STOP parenE SEMICOLON
			{ $2 }
	|	D_STOP LPAREN expr RPAREN SEMICOLON
			{ $3 }
	|	stateCaseForIf
			{ $1 }
	|	taskRef SEMICOLON
			{ $1 }
	|	D_DISPLAY  parenE SEMICOLON
			{ $2 }
	|	D_DISPLAY  LPAREN ASCNUM commaEListE RPAREN SEMICOLON
			{ $4 }
	|	D_WRITE    LPAREN ASCNUM commaEListE RPAREN SEMICOLON
			{ $4 }
	|	D_FDISPLAY LPAREN varRefDotBit COMMA ASCNUM commaEListE RPAREN SEMICOLON
		 	{ TRIPLE ( D_FDISPLAY, $3, $6 ) }
	|	D_FWRITE   LPAREN varRefDotBit COMMA ASCNUM commaEListE RPAREN SEMICOLON
			{ TRIPLE ( D_FWRITE, $3, $6 ) }
	|	D_INFO	    parenE SEMICOLON
			{ $2 }
	|	D_INFO	    LPAREN ASCNUM commaEListE RPAREN SEMICOLON
			{ $4 }
	|	D_WARNING  parenE SEMICOLON
			{ $2 }
	|	D_WARNING  LPAREN ASCNUM commaEListE RPAREN SEMICOLON
			{ $4 }
	|	D_ERROR    parenE SEMICOLON
			{ $2 }
	|	D_ERROR    LPAREN ASCNUM commaEListE RPAREN SEMICOLON
			{ $4 }
	|	D_FATAL    parenE SEMICOLON
			{ $2 }
	|	D_FATAL    LPAREN expr RPAREN SEMICOLON
			{ $3 }
	|	D_FATAL    LPAREN expr COMMA ASCNUM commaEListE RPAREN SEMICOLON
			{ TRIPLE ( D_FATAL, $3, $6 ) }
	|	readmem LPAREN expr COMMA varRefMem RPAREN SEMICOLON
			{ TRIPLE ( D_READMEMB, $3, $5 ) }
	|	readmem LPAREN expr COMMA varRefMem COMMA expr RPAREN SEMICOLON
			{ QUADRUPLE ( D_READMEMB, $3, $5, $7 ) }
	|	readmem LPAREN expr COMMA varRefMem COMMA expr COMMA expr RPAREN SEMICOLON
			{ QUINTUPLE ( D_READMEMB, $3, $5, $7, $9 ) }
	|	P_MINUSGT varRefDotBit SEMICOLON
			{ DOUBLE ( P_MINUSGT, $2 ) }	
	|	PREPROC					{ (* Printf.fprintf Pervasives.stderr "%s\n" $1 *) PREPROC $1 }

;

//************************************************
// Case/If

stateCaseForIf:
		case LPAREN expr RPAREN caseAttrE caseListE ENDCASE
			{ QUADRUPLE ($1, $3, $5, $6) }
	|	IF LPAREN expr RPAREN stmtBlock	%prec prLOWER_THAN_ELSE
			{ TRIPLE (IF, $3, $5 ) }
	|	IF LPAREN expr RPAREN stmtBlock ELSE stmtBlock
			{ QUADRUPLE (IF, $3, $5, $7 ) }
	|	FOR LPAREN varRefBase EQUALS expr SEMICOLON
			expr SEMICOLON varRefBase EQUALS expr RPAREN stmtBlock
			{ SEPTUPLE ( FOR, $3, $5, $7, $9, $11, $13 ) }
	|	WHILE LPAREN expr RPAREN stmtBlock
			{ TRIPLE (WHILE, $3, $5 ) }
	|	DO stmtBlock WHILE LPAREN expr RPAREN
			{ TRIPLE (DO, $2, $5 ) }
	;

case:
	 	CASE		{ CASE }
	|	CASEX		{ CASEX }
	|	CASEZ		{ CASEZ }
	;

caseAttrE: 	/*empty*/				{ EMPTY }
	;

caseListE:
		/* empty */				{ EMPTY }
	|	caseList				{ TLIST $1 }
	;

caseList:
		caseCondList COLON stmtBlock		{ [ TRIPLE (COLON, TLIST $1, $3 ) ] }
	|	DEFAULT COLON stmtBlock			{ [ DOUBLE (DEFAULT, $3 ) ] }
	|	DEFAULT stmtBlock			{ [ DOUBLE (DEFAULT, $2 ) ] }
	|	caseList caseCondList COLON stmtBlock	{ TRIPLE (COLON, TLIST $2, $4) :: $1 }
	|       caseList DEFAULT stmtBlock		{ DOUBLE (DEFAULT, $3) :: $1 }
	|	caseList DEFAULT COLON stmtBlock	{ DOUBLE (DEFAULT, $4) :: $1 }
	;

caseCondList:
		expr 					{ [ $1 ] }
	|	caseCondList COMMA expr			{ $1 @ [ $3 ] }
	;

//************************************************
// Functions/tasks

taskRef:
		idDotted		 		{ $1 }
	|	idDotted LPAREN exprList RPAREN		{ TRIPLE (DOT, $1, TLIST $3) }
	;

funcRef:
		idDotted LPAREN exprList RPAREN		{ TRIPLE (FUNCTION, $1, TLIST $3) }
	;

taskDecl:
		TASK lifetimeE identifier funcGuts ENDTASK endLabelE
			{ QUINTUPLE ( TASK, $2, $3 , $4, $6 ) }
	;

funcDecl:
	 	FUNCTION lifetimeE        funcTypeE
			identifier                        funcGuts ENDFUNCTION endLabelE
			{ SEXTUPLE (FUNCTION, $2, $3, $4, $5, $7 ) }
	|	FUNCTION lifetimeE SIGNED funcTypeE
			identifier                        funcGuts ENDFUNCTION endLabelE
			{ SEXTUPLE (FUNCTION, $2, $4, $5, $6, $8) }
	;

// IEEE: lifetime - plus empty
lifetimeE:	/* empty */		 		{ EMPTY }
	|	STATIC			 		{ STATIC }
	|	AUTOMATIC		 		{ AUTOMATIC }
	;

funcGuts:
		LPAREN PortV2kArgs RPAREN SEMICOLON funcBody	{ TRIPLE (FUNCARGS, TLIST $2, $5) }
	|	SEMICOLON funcBody				{ DOUBLE (FUNCBODY, $2) }
	;

funcBody:
		funcVarList stmtBlock			{ DOUBLE (TLIST $1, $2 ) }
	|	stmtBlock				{ $1 }
	;

funcTypeE:
		/* empty */				{ EMPTY }
	|	REAL					{ REAL }
	|	INTEGER					{ INTEGER }
	|	LBRACK constExpr COLON constExpr RBRACK	{ RANGE ( $2, $4 ) }
	;

funcVarList:
		funcVar					{ [ $1 ] }
	|	funcVarList funcVar			{ $1 @ [ $2 ] }
	;

funcVar:
		PortDecl				{ $1 }
	|	varDecl 				{ $1 }
	;

parenE:		/* empty */				{ EMPTY }
	|	LPAREN RPAREN				{ EMPTY }
	;

//************************************************
// Expressions

constExpr:
		expr					{ $1 }
	;

exprNoStr:
		expr P_OROR expr			{ TRIPLE( P_OROR, $1, $3 ) }
	|	expr P_ANDAND expr			{ TRIPLE( P_ANDAND, $1, $3 ) }
	|	expr AMPERSAND expr			{ TRIPLE( AMPERSAND, $1, $3 ) }
	|	expr VBAR expr				{ TRIPLE( VBAR, $1, $3 ) }
	|	expr P_NAND expr			{ TRIPLE( P_NAND, $1, $3 ) }
	|	expr P_NOR expr				{ TRIPLE( P_NOR, $1, $3 ) }
	|	expr CARET expr				{ TRIPLE( CARET, $1, $3 ) }
	|	expr P_XNOR expr			{ TRIPLE( P_XNOR, $1, $3 ) }
	|	expr P_EQUAL expr			{ TRIPLE( P_EQUAL, $1, $3 ) }
	|	expr P_NOTEQUAL expr			{ TRIPLE( P_NOTEQUAL, $1, $3 ) }
	|	expr P_CASEEQUAL expr			{ TRIPLE( P_CASEEQUAL, $1, $3 ) }
	|	expr P_CASENOTEQUAL expr		{ TRIPLE( P_CASENOTEQUAL, $1, $3 ) }
	|	expr P_WILDEQUAL expr			{ TRIPLE( P_WILDEQUAL, $1, $3 ) }
	|	expr P_WILDNOTEQUAL expr		{ TRIPLE( P_WILDNOTEQUAL, $1, $3 ) }
	|	expr GREATER expr			{ TRIPLE( GREATER, $1, $3 ) }
	|	expr LESS expr				{ TRIPLE( LESS, $1, $3 ) }
	|	expr P_GTE expr				{ TRIPLE( P_GTE, $1, $3 ) }
	|	expr P_LTE expr				{ TRIPLE( P_LTE, $1, $3 ) }
	|	expr P_SLEFT expr			{ TRIPLE( P_SLEFT, $1, $3 ) }
	|	expr P_SRIGHT expr			{ TRIPLE( P_SRIGHT, $1, $3 ) }
	|	expr P_SSRIGHT expr			{ TRIPLE( P_SSRIGHT, $1, $3 ) }
	|	expr PLUS expr				{ TRIPLE( PLUS, $1, $3 ) }
	|	expr MINUS expr				{ TRIPLE( MINUS, $1, $3 ) }
	|	expr TIMES expr				{ TRIPLE( TIMES, $1, $3 ) }
	|	expr DIVIDE expr			{ TRIPLE( DIVIDE, $1, $3 ) }
	|	expr MODULO expr			{ TRIPLE( MODULO, $1, $3 ) }
	|	expr P_POW expr				{ TRIPLE( P_POW, $1, $3 ) }

	|	MINUS expr	%prec prUNARYARITH	{ DOUBLE (MINUS, $2) }
	|	PLUS expr	%prec prUNARYARITH	{ DOUBLE (PLUS, $2) }
	|	AMPERSAND expr	%prec prREDUCTION	{ DOUBLE (AMPERSAND, $2) }
	|	VBAR expr	%prec prREDUCTION	{ DOUBLE (VBAR, $2) }
	|	CARET expr	%prec prREDUCTION	{ DOUBLE (CARET, $2) }
	|	P_XNOR expr	%prec prREDUCTION	{ DOUBLE (P_XNOR, $2) }
	|	P_NAND expr	%prec prREDUCTION	{ DOUBLE (P_NAND, $2) }
	|	P_NOR expr	%prec prREDUCTION	{ DOUBLE (P_NOR, $2) }
	|	PLING expr	%prec prNEGATION	{ DOUBLE (PLING, $2) }
	|	TILDE expr	%prec prNEGATION	{ DOUBLE (TILDE, $2) }

	|	expr QUERY expr COLON expr		{ QUADRUPLE (QUERY, $1, $3, $5 ) }
	|	LPAREN expr RPAREN			{ $2 }
	|	LCURLY cateList RCURLY			{ TLIST $2 }
	|	LCURLY constExpr LCURLY cateList RCURLY RCURLY
							{ TRIPLE (LCURLY, $2, TLIST $4) }
	|	D_BITS LPAREN expr RPAREN		{ DOUBLE (D_BITS, $3 ) }
	|	D_C LPAREN cStrList RPAREN		{ DOUBLE (D_C, TLIST $3 ) }
	|	D_CLOG2 LPAREN expr RPAREN		{ DOUBLE (D_CLOG2, $3 ) }
	|	D_COUNTDRIVERS LPAREN expr RPAREN	{ DOUBLE (D_COUNTDRIVERS, $3 ) }
	|	D_COUNTONES LPAREN expr RPAREN		{ DOUBLE (D_COUNTONES, $3 ) }
	|	D_FEOF LPAREN expr RPAREN		{ DOUBLE (D_FEOF, $3 ) }
	|	D_FGETC LPAREN expr RPAREN		{ DOUBLE (D_FGETC, $3 ) }
	|	D_FGETS LPAREN varRefDotBit COMMA expr RPAREN
							{ TRIPLE (D_FGETS, $3, $5) }
	|	D_FSCANF LPAREN expr COMMA ASCNUM commaVRDListE RPAREN
							{ TRIPLE (D_FSCANF, $3, $6) }
	|	D_SSCANF LPAREN expr COMMA ASCNUM commaVRDListE RPAREN
							{ TRIPLE (D_SSCANF, $3, $6) }
	|	D_ISUNKNOWN LPAREN expr RPAREN		{ DOUBLE (D_ISUNKNOWN, $3 ) }
	|	D_ONEHOT LPAREN expr RPAREN		{ DOUBLE (D_ONEHOT, $3 ) }
	|	D_ONEHOT0 LPAREN expr RPAREN		{ DOUBLE (D_ONEHOT0, $3 ) }
	|	D_RANDOM LPAREN expr RPAREN		{ DOUBLE (D_RANDOM, $3 ) }
	|	D_RANDOM LPAREN RPAREN			{ D_RANDOM }
	|	D_RANDOM				{ D_RANDOM }
	|	D_SIGNED LPAREN expr RPAREN		{ DOUBLE (D_SIGNED, $3 ) }
	|	D_STIME					{ D_STIME }
	|	D_TIME					{ D_TIME }
	|	D_TEST_PLUSARGS LPAREN expr RPAREN	{ DOUBLE (D_TEST_PLUSARGS, $3 ) }
	|	D_UNSIGNED LPAREN expr RPAREN		{ DOUBLE (D_UNSIGNED, $3 ) }
	|	funcRef					{ $1 }
	|	INTNUM				{ INTNUM $1 }
	|	BINNUM				{ BINNUM $1 }
	|	DECNUM				{ DECNUM $1 }
	|	HEXNUM				{ HEXNUM $1 }
	|	varRefDotBit	  			{ $1 }
	;

// Generic expressions
expr:
		exprNoStr				{ $1 }
	|	strAsInt				{ $1 }
	|	floatnum				{ $1 }
	|	PREPROC					{ PREPROC $1 }
	;

// PLI calls exclude "" as integers, they're strings
// For $c("foo","bar") we want "bar" as a string, not a Verilog integer.
exprStrText:
		exprNoStr				{ $1 }
	|	strAsText				{ $1 }
	;

cStrList:
		exprStrText				{ [ $1 ] }
	|	exprStrText COMMA cStrList		{ $1 :: $3 }
	;

cateList:
		expr					{ [ $1 ] }
	|	cateList COMMA expr			{ $1 @ [ $3 ] }
	;

exprList:
		/* empty */				{ [] }
	|	expr					{ [ $1 ] }
	|	exprList COMMA expr			{ $1 @ [ $3 ] }
	;

commaEListE:
		/* empty */				{ EMPTY }
	|	COMMA exprList				{ TLIST $2 }
	;

vrdList:
		varRefDotBit				{ [ $1 ] }
	|	vrdList COMMA varRefDotBit		{ $1 @ [ $3 ] }
	;

commaVRDListE:
		/* empty */				{ EMPTY }
	|	COMMA vrdList				{ DOUBLE (COMMA, TLIST $2) }
	;

attrDecl:
		D_ATTRIBUTE LPAREN exprList RPAREN SEMICOLON	{ DOUBLE (D_ATTRIBUTE, TLIST $3) }

//************************************************
// Gate declarations

gateDecl:
		BUF  delayStrength gateBufList SEMICOLON		{ TRIPLE (BUF, $2, TLIST $3 ) }
	|	BUFIF delayStrength gateBufIfList SEMICOLON	{ TRIPLE (BUFIF $1, $2, TLIST $3 ) }
	|	NOT  delayStrength gateNotList SEMICOLON		{ TRIPLE (NOT, $2, TLIST $3 ) }
	|	AND  delayStrength gateAndList SEMICOLON		{ TRIPLE (AND, $2, TLIST $3 ) }
	|	NAND delayStrength gateNandList SEMICOLON		{ TRIPLE (NAND, $2, TLIST $3 ) }
	|	OR   delayStrength gateOrList SEMICOLON		{ TRIPLE (OR, $2, TLIST $3 ) }
	|	NOR  delayStrength gateNorList SEMICOLON		{ TRIPLE (NOR, $2, TLIST $3 ) }
	|	XOR  delayStrength gateXorList SEMICOLON		{ TRIPLE (XOR, $2, TLIST $3 ) }
	|	XNOR delayStrength gateXnorList SEMICOLON		{ TRIPLE (XNOR, $2, TLIST $3 ) }
	|	PULLUP delayStrength gatePullupList SEMICOLON		{ TRIPLE (PULLUP, $2, TLIST $3 ) }
	;

gatePullupList:
		gatePullup 				{ [ $1 ] }
	|	gatePullupList COMMA gatePullup		{ $1 @ [ $3 ] }
	;

gateBufList:
		gateBuf 				{ [ $1 ] }
	|	gateBufList COMMA gateBuf		{ $1 @ [ $3 ] }
	;

gateBufIfList:
		gateBufIf 				{ [ $1 ] }
	|	gateBufIfList COMMA gateBuf		{ $1 @ [ $3 ] }
	;

gateNotList:
		gateNot 				{ [ $1 ] }
	|	gateNotList COMMA gateNot		{ $1 @ [ $3 ] }
	;

gateAndList:
		gateAnd 				{ [ $1 ] }
	|	gateAndList COMMA gateAnd		{ $1 @ [ $3 ] }
	;
gateNandList:
		gateNand 				{ [ $1 ] }
	|	gateNandList COMMA gateNand		{ $1 @ [ $3 ] }
	;
gateOrList:
		gateOr 					{ [ $1 ] }
	|	gateOrList COMMA gateOr			{ $1 @ [ $3 ] }
	;
gateNorList:
		gateNor 				{ [ $1 ] }
	|	gateNorList COMMA gateNor		{ $1 @ [ $3 ] }
	;
gateXorList:
		gateXor 				{ [ $1 ] }
	|	gateXorList COMMA gateXor		{ $1 @ [ $3 ] }
	;
gateXnorList:
		gateXnor 				{ [ $1 ] }
	|	gateXnorList COMMA gateXnor		{ $1 @ [ $3 ] }
	;

gatePullup:	gateIdE instRangeE LPAREN varRefDotBit RPAREN
							{ TRIPLE ($1, $2, $4 ) }
	;

gateBuf:	gateIdE instRangeE LPAREN varRefDotBit COMMA expr RPAREN
							{ QUADRUPLE ($1, $2, $4, $6 ) }
	;

gateBufIf:	LPAREN varRefDotBit COMMA gateBufIfPinList RPAREN
							{ DOUBLE ($2, TLIST $4 ) }
	;

gateNot:	gateIdE instRangeE LPAREN varRefDotBit COMMA expr RPAREN
							{ QUADRUPLE ($1 , $2, $4 , $6 ) }
	;

gateAnd:	gateIdE instRangeE LPAREN varRefDotBit COMMA gateAndPinList RPAREN
							{ QUADRUPLE ($1 , $2, $4 , TLIST $6 ) }
	;

gateNand:	gateIdE instRangeE LPAREN varRefDotBit COMMA gateAndPinList RPAREN
							{ QUADRUPLE ($1 , $2, $4 , TLIST $6 ) }
	;

gateOr:		gateIdE instRangeE LPAREN varRefDotBit COMMA gateOrPinList RPAREN
							{ QUADRUPLE ($1 , $2, $4 , TLIST $6 ) }
	;

gateNor:	gateIdE instRangeE LPAREN varRefDotBit COMMA gateOrPinList RPAREN
							{ QUADRUPLE ($1 , $2, $4 , TLIST $6 ) }
	;

gateXor:	gateIdE instRangeE LPAREN varRefDotBit COMMA gateXorPinList RPAREN
							{ QUADRUPLE ($1 , $2, $4 , TLIST $6 ) }
	;

gateXnor:	gateIdE instRangeE LPAREN varRefDotBit COMMA gateXorPinList RPAREN
							{ QUADRUPLE ($1 , $2, $4 , TLIST $6 ) }
	;

gateIdE:	/*empty*/				{ EMPTY }
	|	identifier				{ $1 }
	;

gateBufIfPinList:
		expr 					{ [ $1 ] }
	|	gateBufIfPinList COMMA expr		{ $1 @ [ $3 ] }
	;

gateAndPinList:
		expr 					{ [ $1 ] }
	|	gateAndPinList COMMA expr		{ $1 @ [ $3 ] }
	;

gateOrPinList:
		expr 					{ [ $1 ] }
	|	gateOrPinList COMMA expr		{ $1 @ [ $3 ] }
	;

gateXorPinList:
		expr 					{ [ $1 ] }
	|	gateXorPinList COMMA expr		{ $1 @ [ $3 ] }
	;

gateUdpPinList:
		expr 					{ [ $1 ] }
	|	gateUdpPinList COMMA expr		{ $1 @ [ $3 ] }
	;

//************************************************
// Tables
// Not supported

tableDecl:	TABLE JunkList ENDTABLE { TABLE }	// placeholder

//************************************************
// Specify

JunkList:	Junk	 				{ $1 } /* ignored */
	|	JunkList Junk				{ $1 @ $2 } /* ignored */
	;

Junk:		dlyTerm 				{ [ $1 ] } /* ignored */
	|	ASSIGNMENT				{ [] }
	|	PRIMARGS				{ [] }
	|	PRIMINST				{ [] }
	|	BITSEL					{ [] }
	|	FUNCARGS				{ [] }
	|	FUNCBODY				{ [] }
	|	COMMENT_BEGIN				{ [] }
	|	EMPTY					{ [] }
	|	EOF					{ [] }
	|	ILLEGAL					{ [] }
	|	PARTSEL					{ [] }
	|	RANGE					{ [] }
	|	IOPORT					{ [] }
	|	SUBCCT					{ [] }
	|	SUBMODULE				{ [] }
	|	IMPLICIT				{ [] }
	|	BIDIR					{ [] }
	|	DRIVER					{ [] }
	|	RECEIVER				{ [] }
	|	DOUBLE					{ [] }
	|	TRIPLE					{ [] }
	|	QUADRUPLE				{ [] }
	|	QUINTUPLE				{ [] }
	|	SEXTUPLE				{ [] }
	|	SEPTUPLE				{ [] }
	|	PLING					{ [] }
	|	TLIST					{ [] }
	|	AMPERSAND				{ [] }
	|	LPAREN					{ [] }
	|	RPAREN					{ [] }
	|	TIMES					{ [] }
	|	DIVIDE					{ [] }
	|	MODULO					{ [] }
	|	PLUS					{ [] }
	|	MINUS					{ [] }
	|	COMMA					{ [] }
	|	COLON					{ [] }
	|	SEMICOLON				{ [] }
	|	DOLLAR					{ [] }
	|	EQUALS					{ [] }
	|	GREATER					{ [] }
	|	LESS					{ [] }
	|	QUERY					{ [] }
	|	CARET					{ [] }
	|	LCURLY					{ [] }
	|	RCURLY					{ [] }
	|	LBRACK					{ [] }
	|	RBRACK					{ [] }
	|	VBAR					{ [] }
	|	TILDE					{ [] }
	|	AT					{ [] }
	|	IF					{ [] }
	|	NEGEDGE					{ [] }
	|	POSEDGE					{ [] }
	|	ASCNUM					{ [] }
	|	TIMINGSPEC				{ [] }
	|	P_ANDAND				{ [] }
	|	P_GTE					{ [] }
	|	P_LTE					{ [] }
	|	P_EQUAL					{ [] }
	|	P_NOTEQUAL				{ [] }
	|	P_CASEEQUAL				{ [] }
	|	P_CASENOTEQUAL				{ [] }
	|	P_WILDEQUAL				{ [] }
	|	P_WILDNOTEQUAL				{ [] }
	|	P_XNOR					{ [] }
	|	P_NOR					{ [] }
	|	P_NAND					{ [] }
	|	P_OROR					{ [] }
	|	P_SLEFT					{ [] }
	|	P_SRIGHT				{ [] }
	|	P_SSRIGHT				{ [] }
	|	P_PLUSCOLON				{ [] }
	|	P_MINUSCOLON				{ [] }
	|	P_POW					{ [] }
	|	P_ORMINUSGT				{ [] }
	|	P_OREQGT				{ [] }
	|	P_EQGT					{ [] }
	|	P_ASTGT					{ [] }
	|	P_ANDANDAND				{ [] }
	|	P_POUNDPOUND				{ [] }
	|	P_DOTSTAR				{ [] }
	|	P_ATAT					{ [] }
	|	P_COLONCOLON				{ [] }
	|	P_COLONEQ				{ [] }
	|	P_COLONDIV				{ [] }
	|	P_PLUSEQ				{ [] }
	|	P_MINUSEQ				{ [] }
	|	P_TIMESEQ				{ [] }
	|	P_DIVEQ					{ [] }
	|	P_MODEQ					{ [] }
	|	P_ANDEQ					{ [] }
	|	P_OREQ					{ [] }
	|	P_XOREQ					{ [] }
	|	P_SLEFTEQ				{ [] }
	|	P_SRIGHTEQ				{ [] }
	|	P_SSRIGHTEQ				{ [] }
	|	P_MINUSGT				{ [] }
	|	error 					{ [] }
	;

//************************************************
// IDs

// VarRef to a Memory
varRefMem:
		idDotted				{ $1 }
	;

// VarRef to dotted, and/or arrayed, and/or bit-ranged variable
varRefDotBit:
		idDotted				{ $1 }
	;

idDotted:
		idArrayed 				{ $1 }
	|	idDotted DOT idArrayed	 	{ TRIPLE(DOT, $1, $3) }
	;

// Single component of dotted path, maybe [#].
// Due to lookahead constraints, we cant know if [:] or [+:] are valid (last dotted part),
// well assume so and cleanup later.
idArrayed:
		identifier				{ $1 }
	|	idArrayed LBRACK expr RBRACK		{ TRIPLE(BITSEL, $1, $3) }  // Or AstArraySel, dont know et.
	|	idArrayed LBRACK constExpr COLON constExpr RBRACK
							{ QUADRUPLE(PARTSEL, $1 , $3 , $5 ) }
	|	idArrayed LBRACK expr P_PLUSCOLON  constExpr RBRACK
							{ QUADRUPLE(P_PLUSCOLON, $1 , $3 , $5 ) }
	|	idArrayed LBRACK expr P_MINUSCOLON constExpr RBRACK
							{ QUADRUPLE(P_MINUSCOLON, $1, $3, $5 ) }
	;

// VarRef without any dots or vectorization
varRefBase:
		identifier				{ $1 }
	;

strAsInt:
		ASCNUM					{ ASCNUM $1 }
	;

strAsText:
		ASCNUM					{ ASCNUM $1 }
	;

floatnum:
		FLOATNUM				{ FLOATNUM $1 }
	;

concIdList:
		varRefDotBit				{ [ $1 ] }
	|	concIdList COMMA varRefDotBit		{ $1 @ [ $3 ] }
	;

endLabelE:	/* empty */				{ EMPTY }
	|	COLON identifier			{ DOUBLE (COLON, $2 ) }
	|	ENDOFFILE				{ EMPTY }
	;

//************************************************
// Asserts

labeledStmt:
		AssertStmt				{ $1 }
	;

clocking_declaration:		// IEEE: clocking_declaration  (INCOMPLETE)
		DEFAULT CLOCKING AT LPAREN senitemEdge RPAREN SEMICOLON ENDCLOCKING
							{ CLOCKING }
	;

concurrent_assertion_item:	// IEEE: concurrent_assertion_item  (complete)
		concurrent_assertion_statement		{ $1 }
	|	identifier COLON concurrent_assertion_statement
							{ $3 }
	;

concurrent_assertion_statement:	// IEEE: concurrent_assertion_statement  (INCOMPLETE)
		cover_property_statement		{ COVER }
	;

cover_property_statement:	// IEEE: cover_property_statement (complete)
		COVER PROPERTY LPAREN property_spec RPAREN stmtBlock
							{ COVER }
	;

property_spec:			// IEEE: property_spec
		AT LPAREN senitemEdge RPAREN property_spec_disable expr
							{ DISABLE }
	|	property_spec_disable expr	 	{ DISABLE }
	;

property_spec_disable:
		/* empty */				{ EMPTY }
	|	DISABLE IFF LPAREN expr RPAREN		{ DISABLE }
	;

AssertStmt:
		ASSERT LPAREN expr RPAREN stmtBlock %prec prLOWER_THAN_ELSE
							{ ASSERT }
	|	ASSERT LPAREN expr RPAREN           ELSE stmtBlock
							{ ASSERT }
	|	ASSERT LPAREN expr RPAREN stmtBlock ELSE stmtBlock
							{ ASSERT }
	;

//**********************************************************************

%%