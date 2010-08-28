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
| Vparser. SUBMODULE ->     18   
| Vparser. SUBCCT ->     19   
| Vparser. STATIC ->     20   
| Vparser. SPECIFY ->     21   
| Vparser. SIGNED ->     22   
| Vparser. SEXTUPLE arg  ->     23   
| Vparser. SEPTUPLE arg  ->     24   
| Vparser. SEMICOLON ->     25   
| Vparser. SCALARED ->     26   
| Vparser. RPAREN ->     27   
| Vparser. REG ->     28   
| Vparser. RCURLY ->     29   
| Vparser. RBRACK ->     30   
| Vparser. RANGE arg  ->     31   
| Vparser. QUINTUPLE arg  ->     32   
| Vparser. QUERY ->     33   
| Vparser. QUADRUPLE arg  ->     34   
| Vparser. P_XOREQ ->     35   
| Vparser. P_XNOR ->     36   
| Vparser. P_WILDNOTEQUAL ->     37   
| Vparser. P_WILDEQUAL ->     38   
| Vparser. P_TIMESEQ ->     39   
| Vparser. P_SSRIGHTEQ ->     40   
| Vparser. P_SSRIGHT ->     41   
| Vparser. P_SRIGHTEQ ->     42   
| Vparser. P_SRIGHT ->     43   
| Vparser. P_SLEFTEQ ->     44   
| Vparser. P_SLEFT ->     45   
| Vparser. P_POW ->     46   
| Vparser. P_POUNDPOUND ->     47   
| Vparser. P_PLUSEQ ->     48   
| Vparser. P_PLUSCOLON ->     49   
| Vparser. P_OROR ->     50   
| Vparser. P_ORMINUSGT ->     51   
| Vparser. P_OREQGT ->     52   
| Vparser. P_OREQ ->     53   
| Vparser. P_NOTEQUAL ->     54   
| Vparser. P_NOR ->     55   
| Vparser. P_NAND ->     56   
| Vparser. P_MODEQ ->     57   
| Vparser. P_MINUSEQ ->     58   
| Vparser. P_MINUSCOLON ->     59   
| Vparser. P_LTE ->     60   
| Vparser. P_GTE ->     61   
| Vparser. P_EQUAL ->     62   
| Vparser. P_EQGT ->     63   
| Vparser. P_DOTSTAR ->     64   
| Vparser. P_DIVEQ ->     65   
| Vparser. P_COLONEQ ->     66   
| Vparser. P_COLONDIV ->     67   
| Vparser. P_COLONCOLON ->     68   
| Vparser. P_CASENOTEQUAL ->     69   
| Vparser. P_CASEEQUAL ->     70   
| Vparser. P_ATAT ->     71   
| Vparser. P_ASTGT ->     72   
| Vparser. P_ANDEQ ->     73   
| Vparser. P_ANDANDAND ->     74   
| Vparser. P_ANDAND ->     75   
| Vparser. PROPERTY ->     76   
| Vparser. PRIMITIVE ->     77   
| Vparser. PREPROC arg  ->     78   
| Vparser. POSEDGE ->     79   
| Vparser. PLUS ->     80   
| Vparser. PLING ->     81   
| Vparser. PARTSEL ->     82   
| Vparser. PARAMETER ->     83   
| Vparser. OUTPUT ->     84   
| Vparser. OR ->     85   
| Vparser. NOT ->     86   
| Vparser. NOR ->     87   
| Vparser. NEGEDGE ->     88   
| Vparser. NAND ->     89   
| Vparser. MODULO ->     90   
| Vparser. MODULE ->     91   
| Vparser. MINUS ->     92   
| Vparser. LPAREN ->     93   
| Vparser. LOCALPARAM ->     94   
| Vparser. LESS ->     95   
| Vparser. LCURLY ->     96   
| Vparser. LBRACK ->     97   
| Vparser. IOPORT ->     98   
| Vparser. INTNUM arg  ->     99   
| Vparser. INTEGER ->    100   
| Vparser. INPUT ->    101   
| Vparser. INOUT ->    102   
| Vparser. INITIAL ->    103   
| Vparser. ILLEGAL arg  ->    104   
| Vparser. IFF ->    105   
| Vparser. IF ->    106   
| Vparser. ID arg  ->    107   
| Vparser. HEXNUM arg  ->    108   
| Vparser. HASH ->    109   
| Vparser. GREATER ->    110   
| Vparser. GENVAR ->    111   
| Vparser. GENERATE ->    112   
| Vparser. FUNCTION ->    113   
| Vparser. FOR ->    114   
| Vparser. FLOATNUM arg  ->    115   
| Vparser. FINAL ->    116   
| Vparser. EQUALS ->    117   
| Vparser. EOF ->    118   
| Vparser. ENDTASK ->    119   
| Vparser. ENDTABLE ->    120   
| Vparser. ENDSPECIFY ->    121   
| Vparser. ENDPRIMITIVE ->    122   
| Vparser. ENDOFFILE ->    123   
| Vparser. ENDMODULE ->    124   
| Vparser. ENDGENERATE ->    125   
| Vparser. ENDFUNCTION ->    126   
| Vparser. ENDCLOCKING ->    127   
| Vparser. ENDCASE ->    128   
| Vparser. END ->    129   
| Vparser. EMPTY ->    130   
| Vparser. ELSE ->    131   
| Vparser. D_WRITE ->    132   
| Vparser. D_WARNING ->    133   
| Vparser. D_UNSIGNED ->    134   
| Vparser. D_TIME ->    135   
| Vparser. D_STOP ->    136   
| Vparser. D_STIME ->    137   
| Vparser. D_SSCANF ->    138   
| Vparser. D_SIGNED ->    139   
| Vparser. D_READMEMH ->    140   
| Vparser. D_READMEMB ->    141   
| Vparser. D_RANDOM ->    142   
| Vparser. D_ONEHOT0 ->    143   
| Vparser. D_ONEHOT ->    144   
| Vparser. D_ISUNKNOWN ->    145   
| Vparser. D_INFO ->    146   
| Vparser. D_FWRITE ->    147   
| Vparser. D_FSCANF ->    148   
| Vparser. D_FOPEN ->    149   
| Vparser. D_FINISH ->    150   
| Vparser. D_FGETS ->    151   
| Vparser. D_FGETC ->    152   
| Vparser. D_FFLUSH ->    153   
| Vparser. D_FEOF ->    154   
| Vparser. D_FDISPLAY ->    155   
| Vparser. D_FCLOSE ->    156   
| Vparser. D_FATAL ->    157   
| Vparser. D_ERROR ->    158   
| Vparser. D_DISPLAY ->    159   
| Vparser. D_COUNTONES ->    160   
| Vparser. D_CLOG2 ->    161   
| Vparser. D_C ->    162   
| Vparser. D_BITS ->    163   
| Vparser. D_ATTRIBUTE ->    164   
| Vparser. DOUBLE arg  ->    165   
| Vparser. DOT ->    166   
| Vparser. DOLLAR ->    167   
| Vparser. DO ->    168   
| Vparser. DIVIDE ->    169   
| Vparser. DISABLE ->    170   
| Vparser. DEFPARAM ->    171   
| Vparser. DEFAULT ->    172   
| Vparser. DECNUM arg  ->    173   
| Vparser. COVER ->    174   
| Vparser. COMMENT_END ->    175   
| Vparser. COMMENT_BEGIN arg  ->    176   
| Vparser. COMMA ->    177   
| Vparser. COLON ->    178   
| Vparser. CLOCKING ->    179   
| Vparser. CASEZ ->    180   
| Vparser. CASEX ->    181   
| Vparser. CASE ->    182   
| Vparser. CARET ->    183   
| Vparser. BUF ->    184   
| Vparser. BODY ->    185   
| Vparser. BITSEL ->    186   
| Vparser. BINNUM arg  ->    187   
| Vparser. BEGIN ->    188   
| Vparser. AUTOMATIC ->    189   
| Vparser. AT ->    190   
| Vparser. ASSIGN ->    191   
| Vparser. ASSERT ->    192   
| Vparser. ASCNUM arg  ->    193   
| Vparser. ARGS ->    194   
| Vparser. AND ->    195   
| Vparser. AMPERSAND ->    196   
| Vparser. ALWAYS ->    197   
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
  | Vparser. SUBMODULE -> " SUBMODULE"
  | Vparser. SUBCCT -> " SUBCCT"
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
