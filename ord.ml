let ord tok = match tok with
| Vparser. XOR ->      1   
| Vparser. XNOR ->      2   
| Vparser. WIRE ->      3   
| Vparser. WHILE ->      4   
| Vparser. WEAK arg  ->      5   
| Vparser. VECTORED ->      6   
| Vparser. VBAR ->      7   
| Vparser. UNSIGNED ->      8   
| Vparser. TRIPLE arg  ->      9   
| Vparser. TRI arg  ->     10   
| Vparser. TIMINGSPEC ->     11   
| Vparser. TIMES ->     12   
| Vparser. TILDE ->     13   
| Vparser. TASK ->     14   
| Vparser. TABLE ->     15   
| Vparser. SUPPLY1 ->     16   
| Vparser. SUPPLY0 ->     17   
| Vparser. STATIC ->     18   
| Vparser. SPECIFY ->     19   
| Vparser. SIGNED ->     20   
| Vparser. SEXTUPLE arg  ->     21   
| Vparser. SEPTUPLE arg  ->     22   
| Vparser. SEMICOLON ->     23   
| Vparser. SCALARED ->     24   
| Vparser. RPAREN ->     25   
| Vparser. REG ->     26   
| Vparser. RCURLY ->     27   
| Vparser. RBRACK ->     28   
| Vparser. RANGE arg  ->     29   
| Vparser. QUINTUPLE arg  ->     30   
| Vparser. QUERY ->     31   
| Vparser. QUADRUPLE arg  ->     32   
| Vparser. P_XOREQ ->     33   
| Vparser. P_XNOR ->     34   
| Vparser. P_WILDNOTEQUAL ->     35   
| Vparser. P_WILDEQUAL ->     36   
| Vparser. P_TIMESEQ ->     37   
| Vparser. P_SSRIGHTEQ ->     38   
| Vparser. P_SSRIGHT ->     39   
| Vparser. P_SRIGHTEQ ->     40   
| Vparser. P_SRIGHT ->     41   
| Vparser. P_SLEFTEQ ->     42   
| Vparser. P_SLEFT ->     43   
| Vparser. P_POW ->     44   
| Vparser. P_POUNDPOUND ->     45   
| Vparser. P_PLUSEQ ->     46   
| Vparser. P_PLUSCOLON ->     47   
| Vparser. P_OROR ->     48   
| Vparser. P_ORMINUSGT ->     49   
| Vparser. P_OREQGT ->     50   
| Vparser. P_OREQ ->     51   
| Vparser. P_NOTEQUAL ->     52   
| Vparser. P_NOR ->     53   
| Vparser. P_NAND ->     54   
| Vparser. P_MODEQ ->     55   
| Vparser. P_MINUSEQ ->     56   
| Vparser. P_MINUSCOLON ->     57   
| Vparser. P_LTE ->     58   
| Vparser. P_GTE ->     59   
| Vparser. P_EQUAL ->     60   
| Vparser. P_EQGT ->     61   
| Vparser. P_DOTSTAR ->     62   
| Vparser. P_DIVEQ ->     63   
| Vparser. P_COLONEQ ->     64   
| Vparser. P_COLONDIV ->     65   
| Vparser. P_COLONCOLON ->     66   
| Vparser. P_CASENOTEQUAL ->     67   
| Vparser. P_CASEEQUAL ->     68   
| Vparser. P_ATAT ->     69   
| Vparser. P_ASTGT ->     70   
| Vparser. P_ANDEQ ->     71   
| Vparser. P_ANDANDAND ->     72   
| Vparser. P_ANDAND ->     73   
| Vparser. PROPERTY ->     74   
| Vparser. PRIMITIVE ->     75   
| Vparser. PREPROC arg  ->     76   
| Vparser. POSEDGE ->     77   
| Vparser. PLUS ->     78   
| Vparser. PLING ->     79   
| Vparser. PARTSEL ->     80   
| Vparser. PARAMETER ->     81   
| Vparser. OUTPUT ->     82   
| Vparser. OR ->     83   
| Vparser. NOT ->     84   
| Vparser. NOR ->     85   
| Vparser. NEGEDGE ->     86   
| Vparser. NAND ->     87   
| Vparser. MODULO ->     88   
| Vparser. MODULE ->     89   
| Vparser. MINUS ->     90   
| Vparser. LPAREN ->     91   
| Vparser. LOCALPARAM ->     92   
| Vparser. LESS ->     93   
| Vparser. LCURLY ->     94   
| Vparser. LBRACK ->     95   
| Vparser. IOPORT ->     96   
| Vparser. INTNUM arg  ->     97   
| Vparser. INTEGER ->     98   
| Vparser. INPUT ->     99   
| Vparser. INOUT ->    100   
| Vparser. INITIAL ->    101   
| Vparser. ILLEGAL arg  ->    102   
| Vparser. IFF ->    103   
| Vparser. IF ->    104   
| Vparser. ID arg  ->    105   
| Vparser. HEXNUM arg  ->    106   
| Vparser. HASH ->    107   
| Vparser. GREATER ->    108   
| Vparser. GENVAR ->    109   
| Vparser. GENERATE ->    110   
| Vparser. FUNCTION ->    111   
| Vparser. FOR ->    112   
| Vparser. FLOATNUM arg  ->    113   
| Vparser. FINAL ->    114   
| Vparser. EQUALS ->    115   
| Vparser. EOF ->    116   
| Vparser. ENDTASK ->    117   
| Vparser. ENDTABLE ->    118   
| Vparser. ENDSPECIFY ->    119   
| Vparser. ENDPRIMITIVE ->    120   
| Vparser. ENDOFFILE ->    121   
| Vparser. ENDMODULE ->    122   
| Vparser. ENDGENERATE ->    123   
| Vparser. ENDFUNCTION ->    124   
| Vparser. ENDCLOCKING ->    125   
| Vparser. ENDCASE ->    126   
| Vparser. END ->    127   
| Vparser. EMPTY ->    128   
| Vparser. ELSE ->    129   
| Vparser. D_WRITE ->    130   
| Vparser. D_WARNING ->    131   
| Vparser. D_UNSIGNED ->    132   
| Vparser. D_TIME ->    133   
| Vparser. D_STOP ->    134   
| Vparser. D_STIME ->    135   
| Vparser. D_SSCANF ->    136   
| Vparser. D_SIGNED ->    137   
| Vparser. D_READMEMH ->    138   
| Vparser. D_READMEMB ->    139   
| Vparser. D_RANDOM ->    140   
| Vparser. D_ONEHOT0 ->    141   
| Vparser. D_ONEHOT ->    142   
| Vparser. D_ISUNKNOWN ->    143   
| Vparser. D_INFO ->    144   
| Vparser. D_FWRITE ->    145   
| Vparser. D_FSCANF ->    146   
| Vparser. D_FOPEN ->    147   
| Vparser. D_FINISH ->    148   
| Vparser. D_FGETS ->    149   
| Vparser. D_FGETC ->    150   
| Vparser. D_FFLUSH ->    151   
| Vparser. D_FEOF ->    152   
| Vparser. D_FDISPLAY ->    153   
| Vparser. D_FCLOSE ->    154   
| Vparser. D_FATAL ->    155   
| Vparser. D_ERROR ->    156   
| Vparser. D_DISPLAY ->    157   
| Vparser. D_COUNTONES ->    158   
| Vparser. D_CLOG2 ->    159   
| Vparser. D_C ->    160   
| Vparser. D_BITS ->    161   
| Vparser. D_ATTRIBUTE ->    162   
| Vparser. DOUBLE arg  ->    163   
| Vparser. DOT ->    164   
| Vparser. DOLLAR ->    165   
| Vparser. DO ->    166   
| Vparser. DIVIDE ->    167   
| Vparser. DISABLE ->    168   
| Vparser. DEFPARAM ->    169   
| Vparser. DEFAULT ->    170   
| Vparser. DECNUM arg  ->    171   
| Vparser. COVER ->    172   
| Vparser. COMMENT_END ->    173   
| Vparser. COMMENT_BEGIN arg  ->    174   
| Vparser. COMMA ->    175   
| Vparser. COLON ->    176   
| Vparser. CLOCKING ->    177   
| Vparser. CASEZ ->    178   
| Vparser. CASEX ->    179   
| Vparser. CASE ->    180   
| Vparser. CARET ->    181   
| Vparser. BUF ->    182   
| Vparser. BODY ->    183   
| Vparser. BITSEL ->    184   
| Vparser. BINNUM arg  ->    185   
| Vparser. BEGIN ->    186   
| Vparser. AUTOMATIC ->    187   
| Vparser. AT ->    188   
| Vparser. ASSIGN ->    189   
| Vparser. ASSERT ->    190   
| Vparser. ASCNUM arg  ->    191   
| Vparser. ARGS ->    192   
| Vparser. AND ->    193   
| Vparser. AMPERSAND ->    194   
| Vparser. ALWAYS ->    195   
let getstr tok = match tok with
  | Vparser. XOR -> " XOR"
  | Vparser. XNOR -> " XNOR"
  | Vparser. WIRE -> " WIRE"
  | Vparser. WHILE -> " WHILE"
  | Vparser. WEAK arg  -> " WEAK of "
  | Vparser. VECTORED -> " VECTORED"
  | Vparser. VBAR -> " VBAR"
  | Vparser. UNSIGNED -> " UNSIGNED"
  | Vparser. TRIPLE arg  -> " TRIPLE of "
  | Vparser. TRI arg  -> " TRI of "
  | Vparser. TIMINGSPEC -> " TIMINGSPEC"
  | Vparser. TIMES -> " TIMES"
  | Vparser. TILDE -> " TILDE"
  | Vparser. TASK -> " TASK"
  | Vparser. TABLE -> " TABLE"
  | Vparser. SUPPLY1 -> " SUPPLY1"
  | Vparser. SUPPLY0 -> " SUPPLY0"
  | Vparser. STATIC -> " STATIC"
  | Vparser. SPECIFY -> " SPECIFY"
  | Vparser. SIGNED -> " SIGNED"
  | Vparser. SEXTUPLE arg  -> " SEXTUPLE of "
  | Vparser. SEPTUPLE arg  -> " SEPTUPLE of "
  | Vparser. SEMICOLON -> " SEMICOLON"
  | Vparser. SCALARED -> " SCALARED"
  | Vparser. RPAREN -> " RPAREN"
  | Vparser. REG -> " REG"
  | Vparser. RCURLY -> " RCURLY"
  | Vparser. RBRACK -> " RBRACK"
  | Vparser. RANGE arg  -> " RANGE of "
  | Vparser. QUINTUPLE arg  -> " QUINTUPLE of "
  | Vparser. QUERY -> " QUERY"
  | Vparser. QUADRUPLE arg  -> " QUADRUPLE of "
  | Vparser. P_XOREQ -> " P_XOREQ"
  | Vparser. P_XNOR -> " P_XNOR"
  | Vparser. P_WILDNOTEQUAL -> " P_WILDNOTEQUAL"
  | Vparser. P_WILDEQUAL -> " P_WILDEQUAL"
  | Vparser. P_TIMESEQ -> " P_TIMESEQ"
  | Vparser. P_SSRIGHTEQ -> " P_SSRIGHTEQ"
  | Vparser. P_SSRIGHT -> " P_SSRIGHT"
  | Vparser. P_SRIGHTEQ -> " P_SRIGHTEQ"
  | Vparser. P_SRIGHT -> " P_SRIGHT"
  | Vparser. P_SLEFTEQ -> " P_SLEFTEQ"
  | Vparser. P_SLEFT -> " P_SLEFT"
  | Vparser. P_POW -> " P_POW"
  | Vparser. P_POUNDPOUND -> " P_POUNDPOUND"
  | Vparser. P_PLUSEQ -> " P_PLUSEQ"
  | Vparser. P_PLUSCOLON -> " P_PLUSCOLON"
  | Vparser. P_OROR -> " P_OROR"
  | Vparser. P_ORMINUSGT -> " P_ORMINUSGT"
  | Vparser. P_OREQGT -> " P_OREQGT"
  | Vparser. P_OREQ -> " P_OREQ"
  | Vparser. P_NOTEQUAL -> " P_NOTEQUAL"
  | Vparser. P_NOR -> " P_NOR"
  | Vparser. P_NAND -> " P_NAND"
  | Vparser. P_MODEQ -> " P_MODEQ"
  | Vparser. P_MINUSEQ -> " P_MINUSEQ"
  | Vparser. P_MINUSCOLON -> " P_MINUSCOLON"
  | Vparser. P_LTE -> " P_LTE"
  | Vparser. P_GTE -> " P_GTE"
  | Vparser. P_EQUAL -> " P_EQUAL"
  | Vparser. P_EQGT -> " P_EQGT"
  | Vparser. P_DOTSTAR -> " P_DOTSTAR"
  | Vparser. P_DIVEQ -> " P_DIVEQ"
  | Vparser. P_COLONEQ -> " P_COLONEQ"
  | Vparser. P_COLONDIV -> " P_COLONDIV"
  | Vparser. P_COLONCOLON -> " P_COLONCOLON"
  | Vparser. P_CASENOTEQUAL -> " P_CASENOTEQUAL"
  | Vparser. P_CASEEQUAL -> " P_CASEEQUAL"
  | Vparser. P_ATAT -> " P_ATAT"
  | Vparser. P_ASTGT -> " P_ASTGT"
  | Vparser. P_ANDEQ -> " P_ANDEQ"
  | Vparser. P_ANDANDAND -> " P_ANDANDAND"
  | Vparser. P_ANDAND -> " P_ANDAND"
  | Vparser. PROPERTY -> " PROPERTY"
  | Vparser. PRIMITIVE -> " PRIMITIVE"
  | Vparser. PREPROC arg  -> " PREPROC of "
  | Vparser. POSEDGE -> " POSEDGE"
  | Vparser. PLUS -> " PLUS"
  | Vparser. PLING -> " PLING"
  | Vparser. PARTSEL -> " PARTSEL"
  | Vparser. PARAMETER -> " PARAMETER"
  | Vparser. OUTPUT -> " OUTPUT"
  | Vparser. OR -> " OR"
  | Vparser. NOT -> " NOT"
  | Vparser. NOR -> " NOR"
  | Vparser. NEGEDGE -> " NEGEDGE"
  | Vparser. NAND -> " NAND"
  | Vparser. MODULO -> " MODULO"
  | Vparser. MODULE -> " MODULE"
  | Vparser. MINUS -> " MINUS"
  | Vparser. LPAREN -> " LPAREN"
  | Vparser. LOCALPARAM -> " LOCALPARAM"
  | Vparser. LESS -> " LESS"
  | Vparser. LCURLY -> " LCURLY"
  | Vparser. LBRACK -> " LBRACK"
  | Vparser. IOPORT -> " IOPORT"
  | Vparser. INTNUM arg  -> " INTNUM of "
  | Vparser. INTEGER -> " INTEGER"
  | Vparser. INPUT -> " INPUT"
  | Vparser. INOUT -> " INOUT"
  | Vparser. INITIAL -> " INITIAL"
  | Vparser. ILLEGAL arg  -> " ILLEGAL of "
  | Vparser. IFF -> " IFF"
  | Vparser. IF -> " IF"
  | Vparser. ID arg  -> " ID of "
  | Vparser. HEXNUM arg  -> " HEXNUM of "
  | Vparser. HASH -> " HASH"
  | Vparser. GREATER -> " GREATER"
  | Vparser. GENVAR -> " GENVAR"
  | Vparser. GENERATE -> " GENERATE"
  | Vparser. FUNCTION -> " FUNCTION"
  | Vparser. FOR -> " FOR"
  | Vparser. FLOATNUM arg  -> " FLOATNUM of "
  | Vparser. FINAL -> " FINAL"
  | Vparser. EQUALS -> " EQUALS"
  | Vparser. EOF -> " EOF"
  | Vparser. ENDTASK -> " ENDTASK"
  | Vparser. ENDTABLE -> " ENDTABLE"
  | Vparser. ENDSPECIFY -> " ENDSPECIFY"
  | Vparser. ENDPRIMITIVE -> " ENDPRIMITIVE"
  | Vparser. ENDOFFILE -> " ENDOFFILE"
  | Vparser. ENDMODULE -> " ENDMODULE"
  | Vparser. ENDGENERATE -> " ENDGENERATE"
  | Vparser. ENDFUNCTION -> " ENDFUNCTION"
  | Vparser. ENDCLOCKING -> " ENDCLOCKING"
  | Vparser. ENDCASE -> " ENDCASE"
  | Vparser. END -> " END"
  | Vparser. EMPTY -> " EMPTY"
  | Vparser. ELSE -> " ELSE"
  | Vparser. D_WRITE -> " D_WRITE"
  | Vparser. D_WARNING -> " D_WARNING"
  | Vparser. D_UNSIGNED -> " D_UNSIGNED"
  | Vparser. D_TIME -> " D_TIME"
  | Vparser. D_STOP -> " D_STOP"
  | Vparser. D_STIME -> " D_STIME"
  | Vparser. D_SSCANF -> " D_SSCANF"
  | Vparser. D_SIGNED -> " D_SIGNED"
  | Vparser. D_READMEMH -> " D_READMEMH"
  | Vparser. D_READMEMB -> " D_READMEMB"
  | Vparser. D_RANDOM -> " D_RANDOM"
  | Vparser. D_ONEHOT0 -> " D_ONEHOT0"
  | Vparser. D_ONEHOT -> " D_ONEHOT"
  | Vparser. D_ISUNKNOWN -> " D_ISUNKNOWN"
  | Vparser. D_INFO -> " D_INFO"
  | Vparser. D_FWRITE -> " D_FWRITE"
  | Vparser. D_FSCANF -> " D_FSCANF"
  | Vparser. D_FOPEN -> " D_FOPEN"
  | Vparser. D_FINISH -> " D_FINISH"
  | Vparser. D_FGETS -> " D_FGETS"
  | Vparser. D_FGETC -> " D_FGETC"
  | Vparser. D_FFLUSH -> " D_FFLUSH"
  | Vparser. D_FEOF -> " D_FEOF"
  | Vparser. D_FDISPLAY -> " D_FDISPLAY"
  | Vparser. D_FCLOSE -> " D_FCLOSE"
  | Vparser. D_FATAL -> " D_FATAL"
  | Vparser. D_ERROR -> " D_ERROR"
  | Vparser. D_DISPLAY -> " D_DISPLAY"
  | Vparser. D_COUNTONES -> " D_COUNTONES"
  | Vparser. D_CLOG2 -> " D_CLOG2"
  | Vparser. D_C -> " D_C"
  | Vparser. D_BITS -> " D_BITS"
  | Vparser. D_ATTRIBUTE -> " D_ATTRIBUTE"
  | Vparser. DOUBLE arg  -> " DOUBLE of "
  | Vparser. DOT -> " DOT"
  | Vparser. DOLLAR -> " DOLLAR"
  | Vparser. DO -> " DO"
  | Vparser. DIVIDE -> " DIVIDE"
  | Vparser. DISABLE -> " DISABLE"
  | Vparser. DEFPARAM -> " DEFPARAM"
  | Vparser. DEFAULT -> " DEFAULT"
  | Vparser. DECNUM arg  -> " DECNUM of "
  | Vparser. COVER -> " COVER"
  | Vparser. COMMENT_END -> " COMMENT_END"
  | Vparser. COMMENT_BEGIN arg  -> " COMMENT_BEGIN of "
  | Vparser. COMMA -> " COMMA"
  | Vparser. COLON -> " COLON"
  | Vparser. CLOCKING -> " CLOCKING"
  | Vparser. CASEZ -> " CASEZ"
  | Vparser. CASEX -> " CASEX"
  | Vparser. CASE -> " CASE"
  | Vparser. CARET -> " CARET"
  | Vparser. BUF -> " BUF"
  | Vparser. BODY -> " BODY"
  | Vparser. BITSEL -> " BITSEL"
  | Vparser. BINNUM arg  -> " BINNUM of "
  | Vparser. BEGIN -> " BEGIN"
  | Vparser. AUTOMATIC -> " AUTOMATIC"
  | Vparser. AT -> " AT"
  | Vparser. ASSIGN -> " ASSIGN"
  | Vparser. ASSERT -> " ASSERT"
  | Vparser. ASCNUM arg  -> " ASCNUM of "
  | Vparser. ARGS -> " ARGS"
  | Vparser. AND -> " AND"
  | Vparser. AMPERSAND -> " AMPERSAND"
  | Vparser. ALWAYS -> " ALWAYS"
