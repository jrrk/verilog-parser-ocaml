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

%{ open Vparser %}

// Generic void
%token EMPTY
// Generic double
%token<token * token list > DOUBLE
// Generic triple
%token<token * token list * token list > TRIPLE
// Generic quadruple
%token<token * token list * token list * token list > QUADRUPLE
// Generic quintuple
%token<token * token list * token list * token list * token list > QUINTUPLE
// Generic sextuple
%token<token * token list * token list * token list * token list * token list > SEXTUPLE
// Generic septuple
%token<token * token list * token list * token list * token list * token list * token list > SEPTUPLE

// non-keyword tokens
%token ARGS
%token BODY
%token BITSEL
%token PARTSEL
%token IOPORT
%token SUBMODULE
%token SUBCCT
%token<token list * token list > RANGE

// pre-proc tokens
(*
%token<string> TIMESCALE
%token<string> INLINE
%token<string> PORTCOERCE
*)
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
%token<nativeint>	INTNUM	// "INTEGER NUMBER"
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
%token AUTOMATIC	// "automatic"
%token BEGIN		// "begin"
%token BUF		// "buf"
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
%token WHILE		// "while"
%token WIRE		// "wire"
%token XNOR		// "xnor"
%token XOR		// "xor"

%token D_ATTRIBUTE	// "$attribute"
%token D_BITS		// "$bits"
%token D_C		// "$c"
%token D_CLOG2	// "$clog2"
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

%type <token list> Anyrange
%type <token list> AssertStmt
%type <token list> AssignList
%type <token list> AssignOne
%type <token list> beginNamed
%type <token list> caseAttrE
%type <token list> caseCondList
%type <token list> caseList
%type <token list> caseListE
%type <token> case
%type <token list> cateList
%type <token list> cellpinItemE
%type <token list> cellpinItList
%type <token list> cellpinList
%type <token list> commaEListE
%type <token list> commaVRDListE
%type <token list> concIdList
%type <token list> constExpr
%type <token list> cStrList
%type <token list> defpList
%type <token list> defpOne
%type <token list> delay
%type <token list> delayE
%type <token list> delayrange
%type <token list> delayStrength
%type <token list> dlyTerm
%type <token list> endLabelE
%type <token list> eventControl
%type <token list> expr
%type <token list> exprList
%type <token list> exprNoStr
%type <token list> exprStrText
%type <token list> funcBody
%type <token list> funcDecl
%type <token list> funcGuts
%type <token list> funcRef
%type <token list> funcTypeE
%type <token list> funcVar
%type <token list> funcVarList
%type <token list> gateAnd
%type <token list> gateAndList
%type <token list> gateAndPinList
%type <token list> gateBuf
%type <token list> gateBufList
%type <token list> gateDecl
%type <token> gateIdE
%type <token list> gateNand
%type <token list> gateNandList
%type <token list> gateNor
%type <token list> gateNorList
%type <token list> gateNot
%type <token list> gateNotList
%type <token list> gateOr
%type <token list> gateOrList
%type <token list> gateOrPinList
%type <token list> gateXnor
%type <token list> gateXnorList
%type <token list> gateXor
%type <token list> gateXorList
%type <token list> gateXorPinList
%type <token list> genCaseList
%type <token list> genCaseListE
%type <token list> generateRegion
%type <token list> genItem
%type <token list> genItemBegin
%type <token list> genItemBlock
%type <token list> genItemList
%type <token list> genTopBlock
%type <token list> idArrayed
%type <token list> idDotted
%type <token list> instDecl
%type <token list> instnameList
%type <token list> instnameParen
%type <token list> instparamListE
%type <token list> instRangeE
%type <token list> labeledStmt
%type <token list> lifetimeE
%type <token list> minTypMax
%type <token list> modItem
%type <token list> modItemList
%type <token list> modItemListE
%type <token list> modOrGenItem
%type <token list> modParArgs
%type <token list> modParDecl
%type <token list> modParE
%type <token list> modParList
%type <token list> modParSecond
%type <token list> modPortsE
%type <unit> moduleDecl
%type <token list> netSig
%type <token list> netSigList
%type <token list> param
%type <token list> paramList
%type <token list> parenE
%type <token list> Port
%type <token list> PortDecl
%type <token>      PortDirection
%type <token list> PortList
%type <token list> PortRangeE
%type <token list> RangeList
%type <token list> RangeListE
%type <token list> regrangeE
%type <token list> regsig
%type <token list> regsigList
%type <token list> senitem
%type <token list> senitemEdge
%type <token list> senitemVar
%type <token list> senList
%type <token list> sigAndAttr
%type <token list> sigAttrListE
%type <token> sigId
%type <token list> signingE
%type <token list> specifyJunk
%type <token list> specifyJunkList
%type <unit>       start
%type <token list> stateCaseForIf
%type <token list> stmt
%type <token list> stmtBlock
%type <token list> stmtList
%type <token list> strAsInt
%type <token list> strAsText
%type <token list> taskDecl
%type <token list> taskRef
%type <token list> v2kVarDeclE
%type <token list> varDecl
%type <token list> varDeclList
%type <token>      varGenVar
%type <token>      varGParam
%type <token>      varLParam
%type <token>      varNet
%type <token list> varRefBase
%type <token list> varRefDotBit
%type <token list> varRefMem
%type <token>      varReg
%type <token list> vrdList
%type <string> identifier

%%

identifier:	ID	{ (* Printf.fprintf Pervasives.stderr "%s\n" $1; *) $1 }

//**********************************************************************
// Files

start:		ENDOFFILE				{ raise End_of_file }
	|	primDecl start				{ }
	|	PREPROC					{ (* Printf.fprintf Pervasives.stderr "%s\n" $1 *) }
	|	commentDecl				{ }
	|	moduleDecl start			{ }
	;

commentDecl:	COMMENT_BEGIN specifyJunkList COMMENT_END { (* Printf.fprintf Pervasives.stderr "%s\n" *) $1 }	// placeholder

//**********************************************************************
// Module headers

// IEEE: module_declaration:
moduleDecl:	MODULE identifier modParE modPortsE SEMICOLON modItemListE ENDMODULE
			{
			Hashtbl.add Globals.modprims $2
				{ Globals.tree=QUINTUPLE ( MODULE, [ID $2], $3, $4, $6 );
				  symbols=Hashtbl.create 256}
			}
	;

// IEEE: primitive_declaration:
primDecl:	PRIMITIVE identifier modParE modPortsE SEMICOLON primItemList ENDPRIMITIVE
			{
			Hashtbl.add Globals.modprims $2
				{ Globals.tree=QUINTUPLE ( PRIMITIVE, [ID $2], $3, $4, $6 );
				  symbols=Hashtbl.create 256}
			}
	;

primItemList:
		primItem				{ $1 }
	|	primItem primItemList			{ $1 @ $2 }
	;

primItem:
		PortDecl 				{ $1 }
	|	varDecl 				{ $1 }
	|	tableDecl				{ $1 }
	;

modParE:
		/* empty */				{ [] }
	|	HASH LPAREN RPAREN			{ [] }
	|	HASH LPAREN modParArgs RPAREN		{ $3; }
	;

modParArgs:
		modParDecl				{ $1; }
	|	modParDecl COMMA modParList		{ $1 @ $3; }
	;

modParList:
		modParSecond				{ $1; }
	|	modParList COMMA modParSecond 		{ $1 @ $3; }
	;

// Called only after a comma in a v2k list, to allow parsing "parameter a,b, parameter x"
modParSecond:
		modParDecl				{ $1  }
	|	param					{ $1  }
	;

modPortsE:
		/* empty */				{ [] }
	|	LPAREN RPAREN				{ [] }
	|	LPAREN PortList RPAREN			{ $2; }
	|	LPAREN PortV2kArgs RPAREN		{ $2; }
	;

PortList:
		Port				       	{ $1 }
	|	Port COMMA PortList	  	   	{ $1 @ $3 }
	;

Port:
		identifier PortRangeE		       	{ [ ID $1 ] }
	|	DOT identifier LPAREN expr RPAREN	{ [ DOUBLE( DOT, [ID $2 ] ) ] }
	;

PortV2kArgs:
		PortV2kDecl				{ $1 }
	|	PortV2kDecl COMMA PortV2kList		{ $1 @ $3 }
	;

PortV2kList:
		PortV2kSecond				{ $1 }
	|	PortV2kSecond COMMA PortV2kList		{ $1 @ $3 }
	;

// Called only after a comma in a v2k list, to allow parsing "input a,b"
PortV2kSecond:
		PortV2kDecl				{ $1 }
	|	PortV2kInit				{ $1 }
	;

PortV2kInit:
		PortV2kSig				{ $1 }
	|	PortV2kSig EQUALS expr			{ [ TRIPLE (EQUALS, $1, $3) ] }
	;

PortV2kSig:
		sigAndAttr				{ $1 }
	;

//************************************************
// Variable Declarations

varDeclList:
		varDecl					{ $1 }
	|	varDecl varDeclList			{ $1 @ $2 }
	;

regsigList:
		regsig  				{ $1 }
	|	regsigList COMMA regsig		       	{ $1 @ $3 }
	;

PortV2kDecl:
		PortDirection v2kVarDeclE signingE regrangeE PortV2kInit
			{ [ QUINTUPLE ( $1 , $2 , $3 , $4 , $5 ) ] }
	;

// IEEE: Port_declaration - plus SEMICOLON
PortDecl:
		PortDirection v2kVarDeclE signingE regrangeE regsigList SEMICOLON
			{ [ QUINTUPLE ( $1, $2, $3, $4, $5 ) ] }
	;

varDecl:
		varReg     signingE regrangeE  regsigList SEMICOLON
			{ [ QUADRUPLE ($1, $2, $3, $4 ) ] }
	|	varGParam  signingE regrangeE  paramList SEMICOLON
			{ [ QUADRUPLE ($1, $2, $3, $4 ) ] }
	|	varLParam  signingE regrangeE  paramList SEMICOLON
			{ [ QUADRUPLE ($1, $2, $3, $4 ) ] }
	|	varNet     signingE delayrange netSigList SEMICOLON
			{ [ QUADRUPLE ($1, $2, $3, $4 ) ] }
	|	varGenVar  signingE            regsigList SEMICOLON
			{ [ TRIPLE ($1, $2, $3 ) ] }
	;

modParDecl:
		varGParam  signingE regrangeE   param
		 	{ [ QUADRUPLE ($1, $2, $3, $4 ) ] }
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
signingE:	/*empty*/ 				{ [] }
	|	SIGNED					{ [ SIGNED ] }
	|	UNSIGNED				{ [ UNSIGNED ] }
	;

v2kVarDeclE:	/*empty*/ 				{ [] }
	|	varNet 					{ [ $1 ] }
	|	varReg 					{ [ $1 ] }
	;

//************************************************
// Module Items

modItemListE:
		/* empty */				{ [] }
	|	modItemList				{ $1 }
	;

modItemList:
		modItem					{ $1 }
	|	modItem modItemList			{ $1 @ $2 }
	;

modItem:
		modOrGenItem 				{ $1 }
	|	generateRegion				{ $1 }
	|	SPECIFY specifyJunkList ENDSPECIFY	{ [SPECIFY] }
	|	SPECIFY ENDSPECIFY			{ [SPECIFY] }
	|	PREPROC					{ (* Printf.fprintf Pervasives.stderr "%s\n" $1 *) [PREPROC $1 ] }
	;

// IEEE: generate_region
generateRegion:
		GENERATE genTopBlock ENDGENERATE	{ [ DOUBLE (GENERATE, $2) ] }
	;

modOrGenItem:
		ALWAYS stmtBlock			{ [ DOUBLE (ALWAYS, $2) ] }
	|	FINAL stmtBlock				{ [ DOUBLE (FINAL, $2 ) ] }
	|	INITIAL stmtBlock			{ [ DOUBLE ( INITIAL, $2 ) ] }
	|	ASSIGN delayStrength AssignList SEMICOLON	{ [ TRIPLE ( ASSIGN, $2, $3 ) ] }
	|	DEFPARAM defpList SEMICOLON		{ [ DOUBLE (DEFPARAM, $2 ) ] }
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
		genItemList				{ $1 }
	|	genItemBegin				{ $1 }
	;

genItemBegin:
		BEGIN genItemList END			{ $2 }
	|	BEGIN END				{ [] }
	|	BEGIN COLON identifier genItemList END endLabelE	{ [ TRIPLE (ID $3, $4, $6) ] }
	|	BEGIN COLON identifier 	           END endLabelE	{ [ TRIPLE (ID $3, [], $5) ] }
	;

genItemList:
		genItem					{ $1 }
	|	genItem genItemList			{ $1 @ $2 }
	;

genItem:
		modOrGenItem 				{ $1 }
	|	CASE  LPAREN expr RPAREN genCaseListE ENDCASE	{ [ TRIPLE (CASE, $3, $5) ] }
	|	IF LPAREN expr RPAREN genItemBlock	%prec prLOWER_THAN_ELSE
			{ [ TRIPLE (IF, $3, $5) ] }
	|	IF LPAREN expr RPAREN genItemBlock ELSE genItemBlock
			{ [ QUADRUPLE (IF, $3, $5, $7) ] }
	|	FOR LPAREN varRefBase EQUALS expr SEMICOLON
			expr SEMICOLON varRefBase EQUALS expr RPAREN genItemBlock
			{ [ SEPTUPLE (FOR, $3, $5, $7, $9, $11, $13) ] }
	;

genCaseListE:
		/* empty */				{ [] }
	|	genCaseList				{ $1 }
	;

genCaseList:
		caseCondList COLON genItemBlock		{ [ TRIPLE (COLON, $1, $3 ) ] }
	|	DEFAULT COLON genItemBlock		{ [ DOUBLE (DEFAULT, $3) ] }
	|	DEFAULT genItemBlock			{ [ DOUBLE (DEFAULT, $2) ] }
	|	genCaseList caseCondList COLON genItemBlock	{ $1 @ [TRIPLE (COLON, $2, $4) ] }
	|       genCaseList DEFAULT genItemBlock		{ $1 @ [DOUBLE (DEFAULT, $3) ] }
	|	genCaseList DEFAULT COLON genItemBlock		{ $1 @ [DOUBLE (DEFAULT, $4) ] }
	;

//************************************************
// Assignments and register declarations

AssignList:
		AssignOne				{ $1 }
	|	AssignList COMMA AssignOne		{ $1 @ $3 }
	;

AssignOne:
		varRefDotBit EQUALS expr			{ [ TRIPLE (EQUALS, $1, $3) ] }
	|	LCURLY concIdList RCURLY EQUALS expr		{ [ TRIPLE (EQUALS, $2, $5) ] }
	;

delayE:		/* empty */				{ [] }
	|	delay					{ $1 } /* ignored */
	;

delayStrength:		/* empty */				{ [] }
	|	delay					{ $1 } /* ignored */
	|	LPAREN strengthList RPAREN		{ $2 }
	;

strengthList:
		WEAK 					{ [ WEAK $1 ] }
	|	WEAK COMMA strengthList			{ WEAK $1 :: $3 }

delay:
		HASH dlyTerm
			{ [ DOUBLE (HASH, $2) ] } /* ignored */
	|	HASH LPAREN minTypMax RPAREN
			{ [ DOUBLE (HASH, $3) ] } /* ignored */
	|	HASH LPAREN minTypMax COMMA minTypMax RPAREN
			{ [ TRIPLE (HASH, $3, $5) ] } /* ignored */
	|	HASH LPAREN minTypMax COMMA minTypMax COMMA minTypMax RPAREN
			{ [ QUADRUPLE (HASH, $3, $5, $7) ] } /* ignored */
	;

dlyTerm:
		identifier 				{ [ID $1] }
	|	INTNUM 					{ [INTNUM $1] }
	|	FLOATNUM 				{ [FLOATNUM $1] }
	;

// IEEE: mintypmax_expression and constant_mintypmax_expression
minTypMax:
		dlyTerm					{ $1 } /* ignored */
	|	dlyTerm COLON dlyTerm COLON dlyTerm	{ [ QUADRUPLE(COLON, $1, $3, $5) ] } /* ignored */
	;

sigAndAttr:
		sigId sigAttrListE			{ [ DOUBLE ( $1, $2 ) ] }
	;

netSigList:
		netSig  				{ $1 }
	|	netSigList COMMA netSig		       	{ $1 @ $3 }
	;

netSig:
		sigId sigAttrListE			{ [ DOUBLE ( $1, $2 ) ] }
	|	sigId sigAttrListE EQUALS expr		{ [ TRIPLE ($1, $2, $4 ) ] }
	|	identifier RangeList sigAttrListE	{ [ TRIPLE ( ID $1, $2, $2 ) ] }
	;

regsig:
		identifier RangeListE sigAttrListE			{ [ TRIPLE (ID $1, $2, $3 ) ] }
	|	identifier RangeListE EQUALS constExpr sigAttrListE	{ [ QUADRUPLE (ID $1, $2, $4, $5 ) ] }
	;

sigId:	identifier					{ ID $1 }
	;

sigAttrListE:	/* empty */				{ [] }
	;

RangeListE:
		/* empty */    		               	{ [] }
	|	RangeList 				{ $1 }
	;

RangeList:
		Anyrange				{ $1 }
        |	RangeList Anyrange			{ $1 @ $2 }
	;

regrangeE:
		/* empty */    		               	{ [] }
	|	Anyrange 				{ $1 }
	;

Anyrange:
		LBRACK constExpr COLON constExpr RBRACK	{ [ RANGE( $2, $4) ] }
	;

delayrange:
		regrangeE delayE 			{ [ TRIPLE (EMPTY, $1, $2) ] }
	|	SCALARED regrangeE delayE 		{ [ TRIPLE (SCALARED, $2, $3) ] }
	|	VECTORED regrangeE delayE 		{ [ TRIPLE (VECTORED, $2, $3) ] }
	;

PortRangeE:
		/* empty */	                   	{ [] }
	|	LBRACK constExpr RBRACK              	{ $2 }
	|	LBRACK constExpr COLON constExpr RBRACK	{ [ RANGE ($2, $4) ] }
	;

//************************************************
// Parameters

param:
		sigId sigAttrListE EQUALS expr		{ [ TRIPLE ( $1, $2, $4 ) ] }
	;

paramList:
		param					{ $1 }
	|	paramList COMMA param			{ $1 @ $3 }
	;

// IEEE: list_of_defparam_assignments
defpList:
		defpOne					{ $1 }
	|	defpList COMMA defpOne			{ $1 @ $3 }
	;

defpOne:
		identifier DOT identifier EQUALS expr { [ TRIPLE (ID $1, [ ID $3 ], $5 ) ] }
	;

//************************************************
// Instances

instDecl:
	identifier instparamListE instnameList SEMICOLON  { [ TRIPLE (ID $1, $2, $3 ) ] }

instparamListE:
		/* empty */				{ [] }
	|	HASH LPAREN cellpinList RPAREN		{ $3 }
	;

instnameList:
		instnameParen				{ $1 }
	|	instnameList COMMA instnameParen	{ $1 @ $3 }
	;

instnameParen:
		identifier instRangeE LPAREN cellpinList RPAREN	{ [ TRIPLE (ID $1, $2, $4 ) ] }
	|	instRangeE LPAREN cellpinList RPAREN	{ [ TRIPLE (EMPTY, $1, $3 ) ] }
	|	identifier instRangeE 			{ [ DOUBLE ( ID $1, $2 ) ] }
	;

instRangeE:
		/* empty */				{ [] }
	|	LBRACK constExpr COLON constExpr RBRACK	{ [ RANGE ($2, $4) ] }
	;

cellpinList:
		cellpinItList				{ $1 }
	;

cellpinItList:
		cellpinItemE				{ $1 }
	|	cellpinItList COMMA cellpinItemE	{ $1 @ $3 }
	;

cellpinItemE:
		/* empty: ',,' is legal */		{ [] }
	|	P_DOTSTAR				{ [P_DOTSTAR] }
	|	DOT identifier			{ [ DOUBLE (DOT, [ID $2]) ] }
	|	DOT identifier LPAREN RPAREN		{ [ DOUBLE (DOT, [ID $2]) ] }
	|	DOT identifier LPAREN expr RPAREN	{ [ TRIPLE (DOT, [ID $2], $4) ] }
	|	expr					{ $1 }
	;

//************************************************
// EventControl lists

// IEEE: event_control
eventControl:
		AT LPAREN senList RPAREN		{ [ DOUBLE ( AT, $3 ) ] }
	|	AT senitemVar				{ [ DOUBLE ( AT, $2 ) ] }
	|	AT LPAREN TIMES RPAREN			{ [AT] }  /* Verilog 2001 */
	|	AT TIMES				{ [AT] }  /* Verilog 2001 */
	|	delay					{ $1 }
	;

// IEEE: event_expression - split over several
senList:
		senitem					{ $1 }
	|	senList OR senitem			{ $1 @ $3 }
	|	senList COMMA senitem			{ $1 @ $3 }	/* Verilog 2001 */
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
		POSEDGE varRefDotBit			{ [ DOUBLE ( POSEDGE, $2 ) ] }
	|	NEGEDGE varRefDotBit			{ [ DOUBLE ( NEGEDGE, $2 ) ] }
	|	POSEDGE LPAREN varRefDotBit RPAREN	{ [ DOUBLE ( POSEDGE, $3 ) ] }
	|	NEGEDGE LPAREN varRefDotBit RPAREN	{ [ DOUBLE ( NEGEDGE, $3 ) ] }
	;

//************************************************
// Statements

stmtBlock:
		stmt					{ $1 }
	|	BEGIN stmtList END			{ $2 }
	|	BEGIN END				{ [] }
	|	beginNamed stmtList END endLabelE	{ [ TRIPLE (BEGIN, $2, $4) ] }
	|	beginNamed 	    END endLabelE	{ [] }
	;

beginNamed:
		BEGIN COLON identifier varDeclList	{ [ TRIPLE (COLON, [ ID $3 ], $4 ) ] }
	|	BEGIN COLON identifier 			{ [ DOUBLE (COLON, [ ID $3 ] ) ] }
	;

stmtList:
		stmtBlock				{ $1 }
	|	stmtList stmtBlock			{ $1 @ $2 }
	;

stmt:
		SEMICOLON				{ [] }
	|	labeledStmt				{ $1 }
	|	identifier COLON labeledStmt		{ [ DOUBLE (ID $1, $3 ) ] }

	|	eventControl stmtBlock			{ $1 @ $2 }

	|	varRefDotBit P_LTE delayE expr SEMICOLON
			{ [ QUADRUPLE (P_LTE, $1, $3, $4 ) ] }
	|	varRefDotBit EQUALS delayE expr SEMICOLON
			{ [ QUADRUPLE ( EQUALS, $1, $3, $4 ) ] }
	|	varRefDotBit EQUALS D_FOPEN LPAREN expr RPAREN SEMICOLON
			{ [ TRIPLE (D_FOPEN, $1, $5) ] }
	|	ASSIGN varRefDotBit EQUALS delayStrength expr SEMICOLON
			{ [ QUADRUPLE (ASSIGN, $2, $4, $5 ) ] }
	|	LCURLY concIdList RCURLY P_LTE delayE expr SEMICOLON
			{ [ QUADRUPLE (P_LTE, $2, $5, $6 ) ] }
	|	LCURLY concIdList RCURLY EQUALS delayE expr SEMICOLON
			{ [ QUADRUPLE (EQUALS, $2, $5, $6 ) ] }
	|	D_C LPAREN cStrList RPAREN SEMICOLON
			{ $3 }
	|	D_FCLOSE LPAREN varRefDotBit RPAREN SEMICOLON
			{ $3 }
	|	D_FFLUSH SEMICOLON
			{ [D_FFLUSH] }
	|	D_FFLUSH LPAREN RPAREN SEMICOLON
			{ [D_FFLUSH] }
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
		 	{ [ TRIPLE ( D_FDISPLAY, $3, $6 ) ] }
	|	D_FWRITE   LPAREN varRefDotBit COMMA ASCNUM commaEListE RPAREN SEMICOLON
			{ [ TRIPLE ( D_FWRITE, $3, $6 ) ] }
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
			{ [ TRIPLE ( D_FATAL, $3, $6 ) ] }
	|	readmem LPAREN expr COMMA varRefMem RPAREN SEMICOLON
			{ [ TRIPLE ( D_READMEMB, $3, $5 ) ] }
	|	readmem LPAREN expr COMMA varRefMem COMMA expr RPAREN SEMICOLON
			{ [ QUADRUPLE ( D_READMEMB, $3, $5, $7 ) ] }
	|	readmem LPAREN expr COMMA varRefMem COMMA expr COMMA expr RPAREN SEMICOLON
			{ [ QUINTUPLE ( D_READMEMB, $3, $5, $7, $9 ) ] }
	|	PREPROC					{ (* Printf.fprintf Pervasives.stderr "%s\n" $1 *) [PREPROC $1 ] }

;

//************************************************
// Case/If

stateCaseForIf:
		case LPAREN expr RPAREN caseAttrE caseListE ENDCASE
			{ [ QUADRUPLE ($1, $3, $5, $6) ] }
	|	IF LPAREN expr RPAREN stmtBlock	%prec prLOWER_THAN_ELSE
			{ [ TRIPLE (IF, $3, $5 ) ] }
	|	IF LPAREN expr RPAREN stmtBlock ELSE stmtBlock
			{ [ QUADRUPLE (IF, $3, $5, $7 ) ] }
	|	FOR LPAREN varRefBase EQUALS expr SEMICOLON
			expr SEMICOLON varRefBase EQUALS expr RPAREN stmtBlock
			{ [ SEPTUPLE ( FOR, $3, $5, $7, $9, $11, $13 ) ] }
	|	WHILE LPAREN expr RPAREN stmtBlock
			{ [ TRIPLE (WHILE, $3, $5 ) ] }
	|	DO stmtBlock WHILE LPAREN expr RPAREN
			{ [ TRIPLE (DO, $2, $5 ) ] }
	;

case:
	 	CASE		{ CASE }
	|	CASEX		{ CASEX }
	|	CASEZ		{ CASEZ }
	;

caseAttrE: 	/*empty*/				{ [] }
	;

caseListE:
		/* empty */				{ [] }
	|	caseList				{ $1 }
	;

caseList:
		caseCondList COLON stmtBlock		{ [ TRIPLE (COLON, $1, $3 ) ] }
	|	DEFAULT COLON stmtBlock			{ [ DOUBLE (DEFAULT, $3 ) ] }
	|	DEFAULT stmtBlock			{ [ DOUBLE (DEFAULT, $2 ) ] }
	|	caseList caseCondList COLON stmtBlock	{ $1 @ [TRIPLE (COLON, $2, $4) ] }
	|       caseList DEFAULT stmtBlock		{ $1 @ [DOUBLE (DEFAULT, $3) ] }
	|	caseList DEFAULT COLON stmtBlock	{ $1 @ [DOUBLE (DEFAULT, $4) ] }
	;

caseCondList:
		expr 					{ $1 }
	|	caseCondList COMMA expr			{ $1 @ $3 }
	;

//************************************************
// Functions/tasks

taskRef:
		idDotted		 		{ $1 }
	|	idDotted LPAREN exprList RPAREN		{ [ TRIPLE (DOT, $1, $3) ] }
	;

funcRef:
		idDotted LPAREN exprList RPAREN		{ [ TRIPLE (FUNCTION, $1, $3) ] }
	;

taskDecl:
		TASK lifetimeE identifier funcGuts ENDTASK endLabelE
			{ [ QUINTUPLE ( TASK, $2, [ ID $3 ], $4, $6 ) ] }
	;

funcDecl:
	 	FUNCTION lifetimeE        funcTypeE
			identifier                        funcGuts ENDFUNCTION endLabelE
			{ [ SEXTUPLE (FUNCTION, $2, $3, [ID $4], $5, $7 ) ] }
	|	FUNCTION lifetimeE SIGNED funcTypeE
			identifier                        funcGuts ENDFUNCTION endLabelE
			{ [ SEXTUPLE (FUNCTION, $2, $4, [ID $5], $6, $8) ] }
	;

// IEEE: lifetime - plus empty
lifetimeE:	/* empty */		 		{ [] }
	|	STATIC			 		{ [STATIC] }
	|	AUTOMATIC		 		{ [AUTOMATIC] }
	;

funcGuts:
		LPAREN PortV2kArgs RPAREN SEMICOLON funcBody	{ [ TRIPLE (ARGS, $2, $5) ] }
	|	SEMICOLON funcBody				{ [ DOUBLE (BODY, $2) ] }
	;

funcBody:
		funcVarList stmtBlock			{ $1 @ $2 }
	|	stmtBlock				{ $1 }
	;

funcTypeE:
		/* empty */				{ [] }
	|	INTEGER					{ [INTEGER] }
	|	LBRACK constExpr COLON constExpr RBRACK	{ [ RANGE ( $2, $4 ) ] }
	;

funcVarList:
		funcVar					{ $1 }
	|	funcVarList funcVar			{ $1 @ $2 }
	;

funcVar:
		PortDecl				{ $1 }
	|	varDecl 				{ $1 }
	;

parenE:		/* empty */				{ [] }
	|	LPAREN RPAREN				{ [] }
	;

//************************************************
// Expressions

constExpr:
		expr					{ $1 }
	;

exprNoStr:
		expr P_OROR expr			{ [ TRIPLE( P_OROR, $1, $3 ) ] }
	|	expr P_ANDAND expr			{ [ TRIPLE( P_ANDAND, $1, $3 ) ] }
	|	expr AMPERSAND expr			{ [ TRIPLE( AMPERSAND, $1, $3 ) ] }
	|	expr VBAR expr				{ [ TRIPLE( VBAR, $1, $3 ) ] }
	|	expr P_NAND expr			{ [ TRIPLE( P_NAND, $1, $3 ) ] }
	|	expr P_NOR expr				{ [ TRIPLE( P_NOR, $1, $3 ) ] }
	|	expr CARET expr				{ [ TRIPLE( CARET, $1, $3 ) ] }
	|	expr P_XNOR expr			{ [ TRIPLE( P_XNOR, $1, $3 ) ] }
	|	expr P_EQUAL expr			{ [ TRIPLE( P_EQUAL, $1, $3 ) ] }
	|	expr P_NOTEQUAL expr			{ [ TRIPLE( P_NOTEQUAL, $1, $3 ) ] }
	|	expr P_CASEEQUAL expr			{ [ TRIPLE( P_CASEEQUAL, $1, $3 ) ] }
	|	expr P_CASENOTEQUAL expr		{ [ TRIPLE( P_CASENOTEQUAL, $1, $3 ) ] }
	|	expr P_WILDEQUAL expr			{ [ TRIPLE( P_WILDEQUAL, $1, $3 ) ] }
	|	expr P_WILDNOTEQUAL expr		{ [ TRIPLE( P_WILDNOTEQUAL, $1, $3 ) ] }
	|	expr GREATER expr			{ [ TRIPLE( GREATER, $1, $3 ) ] }
	|	expr LESS expr				{ [ TRIPLE( LESS, $1, $3 ) ] }
	|	expr P_GTE expr				{ [ TRIPLE( P_GTE, $1, $3 ) ] }
	|	expr P_LTE expr				{ [ TRIPLE( P_LTE, $1, $3 ) ] }
	|	expr P_SLEFT expr			{ [ TRIPLE( P_SLEFT, $1, $3 ) ] }
	|	expr P_SRIGHT expr			{ [ TRIPLE( P_SRIGHT, $1, $3 ) ] }
	|	expr P_SSRIGHT expr			{ [ TRIPLE( P_SSRIGHT, $1, $3 ) ] }
	|	expr PLUS expr				{ [ TRIPLE( PLUS, $1, $3 ) ] }
	|	expr MINUS expr				{ [ TRIPLE( MINUS, $1, $3 ) ] }
	|	expr TIMES expr				{ [ TRIPLE( TIMES, $1, $3 ) ] }
	|	expr DIVIDE expr			{ [ TRIPLE( DIVIDE, $1, $3 ) ] }
	|	expr MODULO expr			{ [ TRIPLE( MODULO, $1, $3 ) ] }
	|	expr P_POW expr				{ [ TRIPLE( P_POW, $1, $3 ) ] }

	|	MINUS expr	%prec prUNARYARITH	{ [ DOUBLE (MINUS, $2) ] }
	|	PLUS expr	%prec prUNARYARITH	{ [ DOUBLE (PLUS, $2) ] }
	|	AMPERSAND expr	%prec prREDUCTION	{ [ DOUBLE (AMPERSAND, $2) ] }
	|	VBAR expr	%prec prREDUCTION	{ [ DOUBLE (VBAR, $2) ] }
	|	CARET expr	%prec prREDUCTION	{ [ DOUBLE (CARET, $2) ] }
	|	P_XNOR expr	%prec prREDUCTION	{ [ DOUBLE (P_XNOR, $2) ] }
	|	P_NAND expr	%prec prREDUCTION	{ [ DOUBLE (P_NAND, $2) ] }
	|	P_NOR expr	%prec prREDUCTION	{ [ DOUBLE (P_NOR, $2) ] }
	|	PLING expr	%prec prNEGATION	{ [ DOUBLE (PLING, $2) ] }
	|	TILDE expr	%prec prNEGATION	{ [ DOUBLE (TILDE, $2) ] }

	|	expr QUERY expr COLON expr		{ [ QUADRUPLE (QUERY, $1, $3, $5 ) ] }
	|	LPAREN expr RPAREN			{ $2 }
	|	LCURLY cateList RCURLY			{ $2 }
	|	LCURLY constExpr LCURLY cateList RCURLY RCURLY
							{ [ TRIPLE (LCURLY, $2, $4) ] }
	|	D_BITS LPAREN expr RPAREN		{ [ DOUBLE (D_BITS, $3 ) ] }
	|	D_C LPAREN cStrList RPAREN		{ [ DOUBLE (D_C, $3 ) ] }
	|	D_CLOG2 LPAREN expr RPAREN		{ [ DOUBLE (D_CLOG2, $3 ) ] }
	|	D_COUNTONES LPAREN expr RPAREN		{ [ DOUBLE (D_COUNTONES, $3 ) ] }
	|	D_FEOF LPAREN expr RPAREN		{ [ DOUBLE (D_FEOF, $3 ) ] }
	|	D_FGETC LPAREN expr RPAREN		{ [ DOUBLE (D_FGETC, $3 ) ] }
	|	D_FGETS LPAREN varRefDotBit COMMA expr RPAREN
							{ [ TRIPLE (D_FGETS, $3, $5) ] }
	|	D_FSCANF LPAREN expr COMMA ASCNUM commaVRDListE RPAREN
							{ [ TRIPLE (D_FSCANF, $3, $6) ]  }
	|	D_SSCANF LPAREN expr COMMA ASCNUM commaVRDListE RPAREN
							{ [ TRIPLE (D_SSCANF, $3, $6) ]  }
	|	D_ISUNKNOWN LPAREN expr RPAREN		{ [ DOUBLE (D_ISUNKNOWN, $3 ) ] }
	|	D_ONEHOT LPAREN expr RPAREN		{ [ DOUBLE (D_ONEHOT, $3 ) ] }
	|	D_ONEHOT0 LPAREN expr RPAREN		{ [ DOUBLE (D_ONEHOT0, $3 ) ] }
	|	D_RANDOM LPAREN expr RPAREN		{ [ DOUBLE (D_RANDOM, $3 ) ] }
	|	D_RANDOM LPAREN RPAREN			{ [D_RANDOM] }
	|	D_RANDOM				{ [D_RANDOM] }
	|	D_SIGNED LPAREN expr RPAREN		{ [ DOUBLE (D_SIGNED, $3 ) ] }
	|	D_STIME					{ [D_STIME] }
	|	D_TIME					{ [D_TIME] }
	|	D_UNSIGNED LPAREN expr RPAREN		{ [ DOUBLE (D_UNSIGNED, $3 ) ] }
	|	funcRef					{ $1 }
	|	INTNUM				{ [INTNUM $1] }
	|	BINNUM				{ [BINNUM $1] }
	|	DECNUM				{ [DECNUM $1] }
	|	HEXNUM				{ [HEXNUM $1] }
	|	varRefDotBit	  			{ $1 }
	;

// Generic expressions
expr:
		exprNoStr				{ $1 }
	|	strAsInt				{ $1 }
	|	floatnum				{ $1 }
	;

// PLI calls exclude "" as integers, they're strings
// For $c("foo","bar") we want "bar" as a string, not a Verilog integer.
exprStrText:
		exprNoStr				{ $1 }
	|	strAsText				{ $1 }
	;

cStrList:
		exprStrText				{ $1 }
	|	exprStrText COMMA cStrList		{ $1 @ $3 }
	;

cateList:
		expr					{ $1 }
	|	cateList COMMA expr			{ $1 @ $3 }
	;

exprList:
		expr					{ $1 }
	|	exprList COMMA expr			{ $1 @ $3 }
	;

commaEListE:
		/* empty */				{ [] }
	|	COMMA exprList				{ [ DOUBLE (COMMA, $2) ] }
	;

vrdList:
		varRefDotBit				{ $1 }
	|	vrdList COMMA varRefDotBit		{ $1 @ $3 }
	;

commaVRDListE:
		/* empty */				{ [] }
	|	COMMA vrdList				{ [ DOUBLE (COMMA, $2) ] }
	;

attrDecl:
		D_ATTRIBUTE LPAREN exprList RPAREN SEMICOLON	{ [ DOUBLE (D_ATTRIBUTE, $3) ] }

//************************************************
// Gate declarations

gateDecl:
		BUF  delayE gateBufList SEMICOLON		{ [ TRIPLE (BUF, $2, $3 ) ] }
	|	NOT  delayE gateNotList SEMICOLON		{ [ TRIPLE (NOT, $2, $3 ) ] }
	|	AND  delayE gateAndList SEMICOLON		{ [ TRIPLE (AND, $2, $3 ) ] }
	|	NAND delayE gateNandList SEMICOLON		{ [ TRIPLE (NAND, $2, $3 ) ] }
	|	OR   delayE gateOrList SEMICOLON		{ [ TRIPLE (OR, $2, $3 ) ] }
	|	NOR  delayE gateNorList SEMICOLON		{ [ TRIPLE (NOR, $2, $3 ) ] }
	|	XOR  delayE gateXorList SEMICOLON		{ [ TRIPLE (XOR, $2, $3 ) ] }
	|	XNOR delayE gateXnorList SEMICOLON		{ [ TRIPLE (XNOR, $2, $3 ) ] }
	;

gateBufList:
		gateBuf 				{ $1 }
	|	gateBufList COMMA gateBuf		{ $1 @ $3 }
	;
gateNotList:
		gateNot 				{ $1 }
	|	gateNotList COMMA gateNot		{ $1 @ $3 }
	;
gateAndList:
		gateAnd 				{ $1 }
	|	gateAndList COMMA gateAnd		{ $1 @ $3 }
	;
gateNandList:
		gateNand 				{ $1 }
	|	gateNandList COMMA gateNand		{ $1 @ $3 }
	;
gateOrList:
		gateOr 					{ $1 }
	|	gateOrList COMMA gateOr			{ $1 @ $3 }
	;
gateNorList:
		gateNor 				{ $1 }
	|	gateNorList COMMA gateNor		{ $1 @ $3 }
	;
gateXorList:
		gateXor 				{ $1 }
	|	gateXorList COMMA gateXor		{ $1 @ $3 }
	;
gateXnorList:
		gateXnor 				{ $1 }
	|	gateXnorList COMMA gateXnor		{ $1 @ $3 }
	;

gateBuf:	gateIdE instRangeE LPAREN varRefDotBit COMMA expr RPAREN
							{ [ QUADRUPLE ($1, $2, $4, $6) ] }
	;
gateNot:	gateIdE instRangeE LPAREN varRefDotBit COMMA expr RPAREN
							{ [ QUADRUPLE ($1 , $2, $4 , $6 ) ] }
	;
gateAnd:	gateIdE instRangeE LPAREN varRefDotBit COMMA gateAndPinList RPAREN
							{ [ QUADRUPLE ($1 , $2, $4 , $6 ) ] }
	;
gateNand:	gateIdE instRangeE LPAREN varRefDotBit COMMA gateAndPinList RPAREN
							{ [ QUADRUPLE ($1 , $2, $4 , $6 ) ] }
	;
gateOr:		gateIdE instRangeE LPAREN varRefDotBit COMMA gateOrPinList RPAREN
							{ [ QUADRUPLE ($1 , $2, $4 , $6 ) ] }
	;
gateNor:	gateIdE instRangeE LPAREN varRefDotBit COMMA gateOrPinList RPAREN
							{ [ QUADRUPLE ($1 , $2, $4 , $6 ) ] }
	;
gateXor:	gateIdE instRangeE LPAREN varRefDotBit COMMA gateXorPinList RPAREN
							{ [ QUADRUPLE ($1 , $2, $4 , $6 ) ] }
	;
gateXnor:	gateIdE instRangeE LPAREN varRefDotBit COMMA gateXorPinList RPAREN
							{ [ QUADRUPLE ($1 , $2, $4 , $6 ) ] }
	;

gateIdE:	/*empty*/				{ EMPTY }
	|	identifier				{ ID $1 }
	;

gateAndPinList:
		expr 					{ $1 }
	|	gateAndPinList COMMA expr		{ $1 @ $3 }
	;
gateOrPinList:
		expr 					{ $1 }
	|	gateOrPinList COMMA expr		{ $1 @ $3 }
	;
gateXorPinList:
		expr 					{ $1 }
	|	gateXorPinList COMMA expr		{ $1 @ $3 }
	;

//************************************************
// Tables
// Not supported

tableDecl:	TABLE specifyJunkList ENDTABLE { [] }	// placeholder

//************************************************
// Specify

specifyJunkList:	ENDOFFILE 			{ [] } /* ignored */
	|	specifyJunk 				{ [] } /* ignored */
	|	specifyJunkList specifyJunk		{ [] } /* ignored */
	;

specifyJunk:	dlyTerm 				{ [] } /* ignored */
	|	ARGS					{ [] }
	|	BITSEL					{ [] }
	|	BODY					{ [] }
	|	COMMENT_BEGIN				{ [] }
	|	EMPTY					{ [] }
	|	EOF					{ [] }
	|	ILLEGAL					{ [] }
	|	PARTSEL					{ [] }
	|	RANGE					{ [] }
	|	IOPORT					{ [] }
	|	SUBCCT					{ [] }
	|	SUBMODULE				{ [] }
	|	DOUBLE					{ [] }
	|	TRIPLE					{ [] }
	|	QUADRUPLE				{ [] }
	|	QUINTUPLE				{ [] }
	|	SEXTUPLE				{ [] }
	|	SEPTUPLE				{ [] }
	|	PLING					{ [] }
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
	|	idDotted DOT idArrayed	 	{ [ TRIPLE(DOT, $1, $3) ] }
	;

// Single component of dotted path, maybe [#].
// Due to lookahead constraints, we cant know if [:] or [+:] are valid (last dotted part),
// well assume so and cleanup later.
idArrayed:
		identifier				{ [ID $1] }
	|	idArrayed LBRACK expr RBRACK		{ [TRIPLE(BITSEL, $1, $3)] }  // Or AstArraySel, dont know et.
	|	idArrayed LBRACK constExpr COLON constExpr RBRACK
							{ [QUADRUPLE(PARTSEL, $1 , $3 , $5 ) ] }
	|	idArrayed LBRACK expr P_PLUSCOLON  constExpr RBRACK
							{ [QUADRUPLE(P_PLUSCOLON, $1 , $3 , $5 ) ] }
	|	idArrayed LBRACK expr P_MINUSCOLON constExpr RBRACK
							{ [QUADRUPLE(P_MINUSCOLON, $1, $3, $5 ) ] }
	;

// VarRef without any dots or vectorization
varRefBase:
		identifier				{ [ID $1] }
	;

strAsInt:
		ASCNUM					{ [ASCNUM $1] }
	;

strAsText:
		ASCNUM					{ [ASCNUM $1] }
	;

floatnum:
		FLOATNUM				{ [FLOATNUM $1] }
	;

concIdList:
		varRefDotBit				{ $1 }
	|	concIdList COMMA varRefDotBit		{ $1 @ $3 }
	;

endLabelE:	/* empty */				{ [] }
	|	COLON identifier			{ [ DOUBLE (COLON, [ID $2] ) ] }
	|	ENDOFFILE				{ [] }
	;

//************************************************
// Asserts

labeledStmt:
		AssertStmt				{ $1 }
	;

clocking_declaration:		// IEEE: clocking_declaration  (INCOMPLETE)
		DEFAULT CLOCKING AT LPAREN senitemEdge RPAREN SEMICOLON ENDCLOCKING
							{ [CLOCKING] }
	;

concurrent_assertion_item:	// IEEE: concurrent_assertion_item  (complete)
		concurrent_assertion_statement		{ $1 }
	|	identifier COLON concurrent_assertion_statement
							{ $3 }
	;

concurrent_assertion_statement:	// IEEE: concurrent_assertion_statement  (INCOMPLETE)
		cover_property_statement		{ [COVER] }
	;

cover_property_statement:	// IEEE: cover_property_statement (complete)
		COVER PROPERTY LPAREN property_spec RPAREN stmtBlock
							{ [COVER] }
	;

property_spec:			// IEEE: property_spec
		AT LPAREN senitemEdge RPAREN property_spec_disable expr
							{ [DISABLE] }
	|	property_spec_disable expr	 	{ [DISABLE] }
	;

property_spec_disable:
		/* empty */				{ [] }
	|	DISABLE IFF LPAREN expr RPAREN		{ [DISABLE] }
	;

AssertStmt:
		ASSERT LPAREN expr RPAREN stmtBlock %prec prLOWER_THAN_ELSE
							{ [ASSERT] }
	|	ASSERT LPAREN expr RPAREN           ELSE stmtBlock
							{ [ASSERT] }
	|	ASSERT LPAREN expr RPAREN stmtBlock ELSE stmtBlock
							{ [ASSERT] }
	;

//**********************************************************************

%%
