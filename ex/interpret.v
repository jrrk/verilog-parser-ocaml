
module interpret;

	parameter		NOP		= 0;
	parameter		ACONST_NULL	= 1;
	parameter		ICONST_M1	= 2;
	parameter		ICONST_0	= 3;
	parameter		ICONST_1	= 4;
	parameter		ICONST_2	= 5;
	parameter		ICONST_3	= 6;
	parameter		ICONST_4	= 7;
	parameter		ICONST_5	= 8;
	parameter		LCONST_0	= 9;
	parameter		LCONST_1	= 10;
	parameter		FCONST_0	= 11;
	parameter		FCONST_1	= 12;
	parameter		FCONST_2	= 13;
	parameter		DCONST_0	= 14;
	parameter		DCONST_1	= 15;
	parameter		BIPUSH		= 16;
	parameter		SIPUSH		= 17;
	parameter		LDC1		= 18;
	parameter		LDC2		= 19;
	parameter		LDC2W		= 20;
	parameter		ILOAD		= 21;
	parameter		LLOAD		= 22;
	parameter		FLOAD		= 23;
	parameter		DLOAD		= 24;
	parameter		ALOAD		= 25;
	parameter		ILOAD_0		= 26;
	parameter		ILOAD_1		= 27;
	parameter		ILOAD_2		= 28;
	parameter		ILOAD_3		= 29;
	parameter		LLOAD_0		= 30;
	parameter		LLOAD_1		= 31;
	parameter		LLOAD_2		= 32;
	parameter		LLOAD_3		= 33;
	parameter		FLOAD_0		= 34;
	parameter		FLOAD_1		= 35;
	parameter		FLOAD_2		= 36;
	parameter		FLOAD_3		= 37;
	parameter		DLOAD_0		= 38;
	parameter		DLOAD_1		= 39;
	parameter		DLOAD_2		= 40;
	parameter		DLOAD_3		= 41;
	parameter		ALOAD_0		= 42;
	parameter		ALOAD_1		= 43;
	parameter		ALOAD_2		= 44;
	parameter		ALOAD_3		= 45;
	parameter		IALOAD		= 46;
	parameter		LALOAD		= 47;
	parameter		FALOAD		= 48;
	parameter		DALOAD		= 49;
	parameter		AALOAD		= 50;
	parameter		BALOAD		= 51;
	parameter		CALOAD		= 52;
	parameter		SALOAD		= 53;
	parameter		ISTORE		= 54;
	parameter		LSTORE		= 55;
	parameter		FSTORE		= 56;
	parameter		DSTORE		= 57;
	parameter		ASTORE		= 58;
	parameter		ISTORE_0	= 59;
	parameter		ISTORE_1	= 60;
	parameter		ISTORE_2	= 61;
	parameter		ISTORE_3	= 62;
	parameter		LSTORE_0	= 63;
	parameter		LSTORE_1	= 64;
	parameter		LSTORE_2	= 65;
	parameter		LSTORE_3	= 66;
	parameter		FSTORE_0	= 67;
	parameter		FSTORE_1	= 68;
	parameter		FSTORE_2	= 69;
	parameter		FSTORE_3	= 70;
	parameter		DSTORE_0	= 71;
	parameter		DSTORE_1	= 72;
	parameter		DSTORE_2	= 73;
	parameter		DSTORE_3	= 74;
	parameter		ASTORE_0	= 75;
	parameter		ASTORE_1	= 76;
	parameter		ASTORE_2	= 77;
	parameter		ASTORE_3	= 78;
	parameter		IASTORE		= 79;
	parameter		LASTORE		= 80;
	parameter		FASTORE		= 81;
	parameter		DASTORE		= 82;
	parameter		AASTORE		= 83;
	parameter		BASTORE		= 84;
	parameter		CASTORE		= 85;
	parameter		SASTORE		= 86;
	parameter		POP		= 87;
	parameter		POP2		= 88;
	parameter		DUP		= 89;
	parameter		DUP_X1		= 90;
	parameter		DUP_X2		= 91;
	parameter		DUP2		= 92;
	parameter		DUP2_X1		= 93;
	parameter		DUP2_X2		= 94;
	parameter		SWAP		= 95;
	parameter		IADD		= 96;
	parameter		LADD		= 97;
	parameter		FADD		= 98;
	parameter		DADD		= 99;
	parameter		ISUB		= 100;
	parameter		LSUB		= 101;
	parameter		FSUB		= 102;
	parameter		DSUB		= 103;
	parameter		IMUL		= 104;
	parameter		LMUL		= 105;
	parameter		FMUL		= 106;
	parameter		DMUL		= 107;
	parameter		IDIV		= 108;
	parameter		LDIV		= 109;
	parameter		FDIV		= 110;
	parameter		DDIV		= 111;
	parameter		IREM		= 112;
	parameter		LREM		= 113;
	parameter		FREM		= 114;
	parameter		DREM		= 115;
	parameter		INEG		= 116;
	parameter		LNEG		= 117;
	parameter		FNEG		= 118;
	parameter		DNEG		= 119;
	parameter		ISHL		= 120;
	parameter		LSHL		= 121;
	parameter		ISHR		= 122;
	parameter		LSHR		= 123;
	parameter		IUSHR		= 124;
	parameter		LUSHR		= 125;
	parameter		IAND		= 126;
	parameter		LAND		= 127;
	parameter		IOR		= 128;
	parameter		LOR		= 129;
	parameter		IXOR		= 130;
	parameter		LXOR		= 131;
	parameter		IINC		= 132;
	parameter		I2L		= 133;
	parameter		I2F		= 134;
	parameter		I2D		= 135;
	parameter		L2I		= 136;
	parameter		L2F		= 137;
	parameter		L2D		= 138;
	parameter		F2I		= 139;
	parameter		F2L		= 140;
	parameter		F2D		= 141;
	parameter		D2I		= 142;
	parameter		D2L		= 143;
	parameter		D2F		= 144;
	parameter		INT2BYTE	= 145;
	parameter		INT2CHAR	= 146;
	parameter		INT2SHORT	= 147;
	parameter		LCMP		= 148;
	parameter		FCMPL		= 149;
	parameter		FCMPG		= 150;
	parameter		DCMPL		= 151;
	parameter		DCMPG		= 152;
	parameter		IFEQ		= 153;
	parameter		IFNE		= 154;
	parameter		IFLT		= 155;
	parameter		IFGE		= 156;
	parameter		IFGT		= 157;
	parameter		IFLE		= 158;
	parameter		IF_ICMPEQ	= 159;
	parameter		IF_ICMPNE	= 160;
	parameter		IF_ICMPLT	= 161;
	parameter		IF_ICMPGE	= 162;
	parameter		IF_ICMPGT	= 163;
	parameter		IF_ICMPLE	= 164;
	parameter		IF_ACMPEQ	= 165;
	parameter		IF_ACMPNE	= 166;
	parameter		GOTO		= 167;
	parameter		JSR		= 168;
	parameter		RET		= 169;
	parameter		TABLESWITCH	= 170;
	parameter		LOOKUPSWITCH	= 171;
	parameter		IRETURN		= 172;
	parameter		LRETURN		= 173;
	parameter		FRETURN		= 174;
	parameter		DRETURN		= 175;
	parameter		ARETURN		= 176;
	parameter		RETURN		= 177;
	parameter		GETSTATIC	= 178;
	parameter		PUTSTATIC	= 179;
	parameter		GETFIELD	= 180;
	parameter		PUTFIELD	= 181;
	parameter		INVOKEVIRTUAL	= 182;
	parameter		INVOKESPECIAL	= 183;
	parameter		INVOKESTATIC	= 184;
	parameter		INVOKEINTERFACE	= 185;
	parameter		NEW		= 187;
	parameter		NEWARRAY	= 188;
	parameter		ANEWARRAY	= 189;
	parameter		ARRAYLENGTH	= 190;
	parameter		ATHROW		= 191;
	parameter		CHECKCAST	= 192;
	parameter		INSTANCEOF	= 193;
	parameter		MONITORENTER	= 194;
	parameter		MONITOREXIT	= 195;
	parameter		WIDE		= 196;
	parameter		MULTIANEWARRAY	= 197;
	parameter		IFNULL		= 198;
	parameter		IFNONNULL	= 199;
	parameter		GOTO_W		= 200;
	parameter		JSR_W		= 201;
	parameter		BREAKPOINT	= 202;
	parameter		CHECKCAST_FAST	= 254;
	parameter		INSTANCEOF_FAST	= 255;
	parameter		CONSTANT_Class	= 7;
	parameter		CONSTANT_Fieldref
						= 9;
	parameter		CONSTANT_Methodref
						= 10;
	parameter		CONSTANT_InterfaceMethodref
						= 11;
	parameter		CONSTANT_String	= 8;
	parameter		CONSTANT_Integer
						= 3;
	parameter		CONSTANT_Float	= 4;
	parameter		CONSTANT_Long	= 5;
	parameter		CONSTANT_Double	= 6;
	parameter		CONSTANT_NameAndType
						= 12;
	parameter		CONSTANT_Utf8	= 1;
	parameter		CONSTANT_Unicode
						= 2;
	parameter		CONSTANT_LongC	= 129;
	parameter		CONSTANT_DoubleC
						= 130;
	parameter		CONSTANT_Unknown
						= 0;
	parameter		CONSTANT_ResolvedString
						= (16 + CONSTANT_String);
	parameter		CONSTANT_ResolvedClass
						= (16 + CONSTANT_Class);
	parameter		CONSTANT_Linked	= 255;
	parameter		ACCESS_Public	= 1;
	parameter		ACCESS_Private	= 2;
	parameter		ACCESS_Protected
						= 4;
	parameter		ACCESS_Static	= 8;
	parameter		ACCESS_Final	= 16;
	parameter		ACCESS_Synchronized
						= 32;
	parameter		ACCESS_Volatile	= 64;
	parameter		ACCESS_Transient
						= 128;
	parameter		ACCESS_Native	= 256;
	parameter		ACCESS_512	= 512;
	parameter		ACCESS_Abstract	= 1024;
	parameter		SHIFT_jchar	= 0;
	parameter		SHIFT_jbyte	= 0;
	parameter		SHIFT_jshort	= 0;
	parameter		SHIFT_jint	= 0;
	parameter		SHIFT_jlong	= 1;
	parameter		SHIFT_jfloat	= 0;
	parameter		SHIFT_jdouble	= 1;
	parameter		SHIFT_jref	= 0;
	parameter		JAVAMAGIC	= 32'hcafebabe;
	parameter		MAJOR_VERSION	= 45;
	parameter		MINOR_VERSION	= 3;
	parameter		false		= 0;
	parameter		true		= 1;
	parameter		mem_width	= 20;
	parameter		object_array_offset
						= 1;
	parameter		object_array_length
						= 0;

	reg	[7:0]		TRACE;
	reg	[7:0]		DEBUG;

	reg	[31:0]		mem[1048575:0];
	reg	[7:0]		code[1500000:0];
	reg	[31:0]		sp;
	reg	[31:0]		mem_reads;
	reg	[31:0]		mem_writes;
	reg	[31:0]		code_reads;
	reg	[31:0]		code_writes;
	reg	[31:0]		str_init;
	reg	[31:0]		find_init;
	reg	[31:0]		bool_int_int_int_void;
	reg	[31:0]		java_io_fileoutputstream;
	reg	[31:0]		java_io_open;
	reg	[31:0]		java_io_close;
	reg	[31:0]		java_io_write;
	reg	[31:0]		static_chain_ptr;
	reg	[31:0]		hash_size;
	reg			skip;
	reg			wide;
	reg			void;
	reg			looping;
	reg	[15:0]		class_string;
	reg	[15:0]		class_object;
	reg	[15:0]		class_main;
	reg	[31:0]		low;
	reg	[31:0]		idx;
	reg	[31:0]		tmp;
	reg	[31:0]		pc;
	reg	[31:0]		npc;
	reg	[31:0]		tmp2;
	reg	[31:0]		high;
	reg	[31:0]		casetable_shift;
	reg	[31:0]		brk;
	reg	[31:0]		codestart;
	reg	[31:0]		mtable;
	reg	[31:0]		casepair_size;
	reg	[31:0]		casepair_addr;
	reg	[31:0]		field;
	reg	[31:0]		codelen;
	reg	[31:0]		method_dtable_offset;
	reg	[31:0]		cinfo_method;
	reg	[31:0]		local;
	reg	[31:0]		info_size;
	reg	[31:0]		info_data;
	reg	[31:0]		info_tags;
	reg	[15:0]		classfile_count;
	reg	[31:0]		const_idx;
	reg	[31:0]		filename;
	reg	[31:0]		filestart;
	reg	[31:0]		filelen;
	reg	[31:0]		static_chain;
	reg	[31:0]		field_base;
	reg	[31:0]		field_size;
	reg	[15:0]		methods_count;
	reg	[31:0]		old_access_flags;
	reg	[31:0]		tot_class;
	reg	[31:0]		zipf_size;
	reg	[31:0]		fp;
	reg	[31:0]		len;
	reg	[31:0]		oldclass;
	reg	[31:0]		newclass;
	reg	[31:0]		param_size;
	integer			i;
	integer			j;
	integer			k;
	integer			zipidx;

	task read_u_char;

	output reg
		[7:0]		ch;
	inout reg
		[31:0]		fp;
	begin
	  ch = getcode(fp);
	  fp = (fp + 1);
	end
	endtask

	task read_u_short;

	output reg
		[15:0]		shrt;
	inout reg
		[31:0]		fp;
	begin
	  shrt[15:8] = getcode(fp);
	  fp = (fp + 1);
	  shrt[7:0] = getcode(fp);
	  fp = (fp + 1);
	end
	endtask

	task read_u_long;

	output reg
		[31:0]		lng;
	inout reg
		[31:0]		fp;
	begin
	  lng[31:24] = getcode(fp);
	  fp = (fp + 1);
	  lng[23:16] = getcode(fp);
	  fp = (fp + 1);
	  lng[15:8] = getcode(fp);
	  fp = (fp + 1);
	  lng[7:0] = getcode(fp);
	  fp = (fp + 1);
	end
	endtask

	task showclass;

	input reg
		[15:0]		class;

	reg	[31:0]		tmp;
	reg	[31:0]		i;
	reg	[31:0]		len;
	begin
	  if (class) begin
	    tmp = getmem((filename + class));
	    len = length(tmp);
	    for (i = 0; (i < len); i = (i + 1))
	      $write("%c", getcode((tmp + i)));
	    $write(" ");
	  end
	  else begin
	    $write("VERILOG ");
	  end
	end
	endtask

	task setpool;

	input reg
		[15:0]		class;
	input reg
		[15:0]		idx;
	input reg
		[31:0]		data;

	reg	[95:0]		old;
	begin
	  void = setmem((getmem((const_idx + class)) + idx), data);
	end
	endtask

	task show_access;

	input reg
		[15:0]		access_flags;
	begin
	  if (access_flags & ACCESS_Public) begin
	    $display("  Public");
	  end
	  if (access_flags & ACCESS_Private) begin
	    $display("  Private");
	  end
	  if (access_flags & ACCESS_Protected) begin
	    $display("  Protected");
	  end
	  if (access_flags & ACCESS_Static) begin
	    $display("  Static");
	  end
	  if (access_flags & ACCESS_Final) begin
	    $display("  Final");
	  end
	  if (access_flags & ACCESS_Synchronized) begin
	    $display("  Synchronized");
	  end
	  if (access_flags & ACCESS_Volatile) begin
	    $display("  Volatile");
	  end
	  if (access_flags & ACCESS_Transient) begin
	    $display("  Transient");
	  end
	  if (access_flags & ACCESS_Native) begin
	    $display("  Native");
	  end
	  if (access_flags & ACCESS_Abstract) begin
	    $display("  Abstract");
	  end
	end
	endtask

	task understand_class_file;

	input reg
		[31:0]		class;

	reg	[31:0]		fp;
	reg	[31:0]		code_siz;
	reg	[15:0]		cnt;
	reg	[15:0]		access_flags;
	reg	[15:0]		name_index;
	reg	[15:0]		signature_index;
	reg	[15:0]		c_max_stack;
	reg	[15:0]		c_max_locals;
	reg	[15:0]		c_code_length;
	reg	[15:0]		this_class;
	reg	[15:0]		prev_class;
	reg	[15:0]		super_class;
	reg	[15:0]		interfaces_count;
	reg	[15:0]		fields_count;
	reg	[63:0]		tmpl;
	reg	[63:0]		pool;
	reg	[15:0]		minor_version;
	reg	[15:0]		major_version;
	reg	[31:0]		magic;
	reg	[7:0]		type;
	reg	[15:0]		len;
	reg	[15:0]		c_handlers;
	reg	[15:0]		start_pc;
	reg	[15:0]		end_pc;
	reg	[15:0]		handler_pc;
	reg	[15:0]		catch_type;
	reg	[15:0]		attr_cnt;
	reg	[15:0]		c_throws_count;
	reg	[15:0]		d2;
	reg	[15:0]		d2b;
	reg	[15:0]		unit;
	reg	[15:0]		field_offset;
	reg	[31:0]		d4;
	reg	[31:0]		d4b;
	reg	[31:0]		fp1;
	reg			error;
	reg	[31:0]		i;
	reg	[31:0]		j;
	reg	[31:0]		k;
	reg	[31:0]		m;
	reg	[31:0]		n;
	reg	[31:0]		end_params;
	reg	[31:0]		i2;
	reg	[31:0]		inc;
	begin
	  void = setmem((field_size + class), 1);
	  $write("Reading class %d ", class[9:0]);
	  showclass(class);
	  $display;
	  fp = getmem((filestart + class));
	  code_siz = getmem((filelen + class));
	  if (DEBUG > 1) begin
	    $display("Memory size = %d", code_siz);
	  end
	  read_u_long(magic, fp);
	  if (magic != JAVAMAGIC) begin
	    $display("Bad magic %x in class", magic);
	    $finish;
	  end
	  if (DEBUG > 1) begin
	    $display("Magic = %x", magic);
	  end
	  read_u_short(minor_version, fp);
	  read_u_short(major_version, fp);
	  if (DEBUG > 1) begin
	    $display("major=%d, minor=%d", major_version, minor_version);
	  end
	  if (major_version != MAJOR_VERSION) begin
	    if (DEBUG > 1) begin
	      $display("Warning: Major version number mismatch.");
	    end
	  end
	  if (minor_version != MINOR_VERSION) begin
	    if (DEBUG > 1) begin
	      $display("Warning: Minor version number mismatch.");
	    end
	  end
	  read_u_short(i, fp);
	  info_size = i;
	  if (DEBUG > 1) begin
	    $display("constant_pool_count=%d", info_size);
	  end
	  void = setmem((const_idx + class), alloc((info_size + 1)));
	  error = false;
	  setpool(class, 0, 0);
	  prev_class = 0;
	  for (i = 1; (i < info_size); i = (i + 1)) begin
	    read_u_char(type, fp);
	    if (DEBUG > 1) begin
	      $display("tags[%d] = %d \n", i, type);
	    end
	    case (type)
	      CONSTANT_Utf8: begin
		read_u_short(len, fp);
		setpool(class, i, fp);
		pool = getpool(class, i);
		if (DEBUG > 1) begin
		  $display("%X,%X,%X", fp, len, pool);
		end
		if (DEBUG > 1) begin
		  $display("%s", dispstr(pool, length(pool)));
		end
		fp = (fp + len);
	      end
	      CONSTANT_Class: begin
		read_u_short(d2, fp);
		if (DEBUG > 1) begin
		  $display("%d", d2);
		end
		d4[15:0] = d2;
		d4[31:16] = prev_class;
		prev_class = i;
		setpool(class, i, d4);
	      end
	      CONSTANT_String: begin
		read_u_short(d2, fp);
		if (DEBUG > 1) begin
		  $display("%d", d2);
		end
		setpool(class, i, d2);
	      end
	      CONSTANT_Fieldref, CONSTANT_Methodref, 
		      CONSTANT_InterfaceMethodref, CONSTANT_NameAndType: begin
		read_u_short(d2, fp);
		read_u_short(d2b, fp);
		if (DEBUG > 1) begin
		  $display("%d,%d", d2, d2b);
		end
		setpool(class, i, ((d2b << 16) | d2));
	      end
	      CONSTANT_Integer: begin
		read_u_long(d4, fp);
		if (DEBUG > 1) begin
		  $display("%d", d2);
		end
		setpool(class, i, d4);
	      end
	      CONSTANT_Float: begin
		read_u_long(d4, fp);
		if (DEBUG > 1) begin
		  $display("%f", d2);
		end
		setpool(class, i, d4);
	      end
	      CONSTANT_Long: begin
		read_u_long(d4, fp);
		read_u_long(d4b, fp);
		if (DEBUG > 1) begin
		  $display("%8X%8X", d4, d4b);
		end
		setpool(class, i, d4);
		i = (i + 1);
		setpool(class, i, d4b);
	      end
	      CONSTANT_Double: begin
		read_u_long(d4, fp);
		read_u_long(d4b, fp);
		setpool(class, i, d4);
		i = (i + 1);
		setpool(class, i, d4b);
	      end
	      default: begin
		$display("ClassFormatError");
		$finish;
	      end
	    endcase
	  end
	  read_u_short(access_flags, fp);
	  read_u_short(this_class, fp);
	  read_u_short(super_class, fp);
	  while (prev_class) begin
	    i = getpool(class, prev_class);
	    d2 = i[15:0];
	    d4 = getpool(class, d2);
	    if (DEBUG > 1) begin
	      $display("Class %d => %d => %s", prev_class, d2, dispstr(d4,
		      length(d4)));
	    end
	    pool = hashstr(d4, length(d4), 0);
	    if (pool[63:32] == 0) begin
	      $display("Could not find in zipfile class %s", dispstr(d4,
		      length(d4)));
	      $finish;
	    end
	    setpool(class, d2, pool[31:0]);
	    if (getmem((filename + pool[63:32])) != pool[31:0]) begin
	      $display("Invalid class ref");
	      $finish;
	    end
	    setpool(class, prev_class, pool[63:32]);
	    if (prev_class == super_class) begin
	      setpool(class, 0, pool[63:32]);
	    end
	    if (needed(pool[63:32]) == 0) begin
	      if (TRACE) begin
		$display("Class referenced: %s", dispstr(pool[31:0],
			length(pool)));
	      end
	      void = setmem((field_size + pool[63:32]), 1);
	    end
	    prev_class = i[31:16];
	  end
	  read_u_short(interfaces_count, fp);
	  if (DEBUG > 1) begin
	    $display("interfaces_count=%d", interfaces_count);
	  end
	  fp = (fp + (interfaces_count * 2));
	  read_u_short(fields_count, fp);
	  field_offset = (super_class ? 0 : 1);
	  if (fields_count && (DEBUG > 0)) begin
	    $display("fields_count=%d", fields_count);
	  end
	  for (i = 0; (i < fields_count); i = (i + 1)) begin
	    read_u_short(access_flags, fp);
	    read_u_short(name_index, fp);
	    read_u_short(signature_index, fp);
	    pool = getpool(class, name_index);
	    if (DEBUG > 1) begin
	      $display("%d,%d,%d,%X", access_flags, name_index, signature_index,
		      pool);
	    end
	    tmp = alloc(7);
	    pool = hashstr(pool, length(pool), tmp);
	    if (DEBUG > 1) begin
	      $display("%X %X %s", tmp, pool[63:32], dispstr(pool[31:0],
		      length(pool[31:0])));
	    end
	    if (tmp != pool[63:32]) begin
	      tmp2 = getmem(pool[63:32]);
	      void = setmem(pool[63:32], tmp);
	      void = setmem(tmp, tmp2);
	    end
	    void = setmem((tmp + 1), (fp - 6));
	    void = setmem((tmp + 2), access_flags);
	    setpool(class, name_index, pool[31:0]);
	    void = setmem((tmp + 3), pool[63:32]);
	    pool = getpool(class, this_class);
	    void = setmem((tmp + 4), pool);
	    if (DEBUG > 1) begin
	      $display("%X %s", pool, dispstr(getmem((filename + pool)),
		      length(getmem((filename + pool)))));
	    end
	    pool = getpool(class, signature_index);
	    if (DEBUG > 0) begin
	      $display("%s", dispstr(pool, length(pool)));
	    end
	    case (getcode(pool))
	      "[":
		unit = 1;
	      "B":
		unit = 1;
	      "C":
		unit = 1;
	      "D":
		unit = 2;
	      "F":
		unit = 1;
	      "I":
		unit = 1;
	      "J":
		unit = 2;
	      "S":
		unit = 1;
	      "Z":
		unit = 1;
	      "L":
		unit = 1;
	      default: begin
		$display("Size unknown");
		$display("%s", dispstr(pool, length(pool)));
		$finish;
	      end
	    endcase
	    tmp2[31:26] = unit;
	    tmp2[25:0] = field_offset;
	    pool = hashstr(pool, length(pool), unit);
	    setpool(class, signature_index, pool[31:0]);
	    void = setmem((tmp + 5), pool[31:0]);
	    void = setmem((tmp + 6), tmp2);
	    if (DEBUG > 0) begin
	      j = pool;
	      len = length(pool);
	      if (getcode(j) == "[") begin
		$display("Array of");
		j = (j + 1);
		len = (len - 1);
	      end
	      case (getcode(j))
		"B":
		  $display("Byte");
		"C":
		  $display("Character");
		"D":
		  $display("Double");
		"F":
		  $display("Float");
		"I":
		  $display("Int");
		"J":
		  $display("Long");
		"S":
		  $display("Short");
		"Z":
		  $display("Boolean");
		"L": begin
		  $display("Class");
		  $display("%s", dispstr((j + 1), (len - 2)));
		end
		default:
		  $display("%s", dispstr(j, len));
	      endcase
	      show_access(access_flags);
	    end
	    read_u_short(cnt, fp);
	    if (DEBUG > 1) begin
	      $display("attributes_count=%d", cnt);
	    end
	    for (j = 0; (j < cnt); j = (j + 1)) begin
	      read_u_short(idx, fp);
	      read_u_long(len, fp);
	      pool = getpool(class, idx);
	      if (DEBUG > 1) begin
		$display("%s", dispstr(pool, length(pool)));
	      end
	      case (getcode(pool))
		"C":
		  if (len == 2) begin
		    read_u_short(i2, fp);
		  end
		  else begin
		    fp = (fp + len);
		  end
		default:
		  fp = (fp + len);
	      endcase
	    end
	    field_offset = (field_offset + unit);
	  end
	  void = setmem((field_size + class), field_offset);
	  read_u_short(methods_count, fp);
	  if (DEBUG > 0) begin
	    $display("methods_count=%d", methods_count);
	  end
	  for (i = 0; (i < methods_count); i = (i + 1)) begin
	    read_u_short(access_flags, fp);
	    read_u_short(name_index, fp);
	    read_u_short(signature_index, fp);
	    pool = getpool(class, name_index);
	    tmp = alloc(7);
	    pool = hashstr(pool, length(pool), tmp);
	    if (tmp != pool[63:32]) begin
	      tmp2 = getmem(pool[63:32]);
	      void = setmem(pool[63:32], tmp);
	      void = setmem(tmp, tmp2);
	    end
	    void = setmem((tmp + 2), access_flags);
	    setpool(class, name_index, pool[31:0]);
	    void = setmem((tmp + 3), pool[63:32]);
	    pool = getpool(class, this_class);
	    void = setmem((tmp + 4), pool);
	    pool = getpool(class, signature_index);
	    void = setmem((tmp + 1), (fp - 6));
	    field_offset = 0;
	    m = pool;
	    n = (length(pool) - 1);
	    end_params = 0;
	    if (getcode(m) == "(") begin
	      while (n) begin
		m = (m + 1);
		case (getcode(m))
		  ")":
		    end_params = 1;
		  "[":
		    unit = 1;
		  "B":
		    unit = 1;
		  "C":
		    unit = 1;
		  "D":
		    unit = 2;
		  "F":
		    unit = 1;
		  "I":
		    unit = 1;
		  "J":
		    unit = 2;
		  "S":
		    unit = 1;
		  "V":
		    unit = 0;
		  "Z":
		    unit = 1;
		  "L": begin
		    unit = 1;
		    m = (m + 1);
		    n = (n - 1);
		    while ((getcode(m) != ";")) begin
		      m = (m + 1);
		      n = (n - 1);
		    end
		  end
		  default: begin
		    $display("Size unknown");
		    $display("%s", dispstr(m, n));
		    $finish;
		  end
		endcase
		n = (n - 1);
		if (!end_params) begin
		  field_offset = (field_offset + unit);
		end
	      end
	    end
	    if (!end_params) begin
	      $display("Malformed param list");
	      $display("%s", dispstr(tmpl, length(tmpl)));
	      $finish;
	    end
	    tmp2[30:26] = unit;
	    tmp2[25:0] = field_offset;
	    pool = hashstr(pool, length(pool), tmp2);
	    setpool(class, signature_index, pool[31:0]);
	    void = setmem((tmp + 5), pool[31:0]);
	    void = setmem((tmp + 6), tmp2);
	    if (DEBUG > 1) begin
	      $display("%d,%d,%d", access_flags, name_index, signature_index);
	    end
	    pool = getpool(class, name_index);
	    pool = pool[31:0];
	    if (DEBUG > 0) begin
	      $display("%s", dispstr(pool, length(pool)));
	    end
	    pool = getpool(class, signature_index);
	    if (DEBUG > 1) begin
	      $display("%s", dispstr(pool, length(pool)));
	    end
	    if (DEBUG > 0) begin
	      show_access(access_flags);
	    end
	    read_u_short(attr_cnt, fp);
	    if (DEBUG > 1) begin
	      $display("Method attributes_count=%d", attr_cnt);
	    end
	    for (j = 0; (j < attr_cnt); j = (j + 1)) begin
	      read_u_short(idx, fp);
	      read_u_long(len, fp);
	      fp1 = (fp + len);
	      pool = getpool(class, idx);
	      if (DEBUG > 1) begin
		$display("%s", dispstr(pool, length(pool)));
	      end
	      case (getcode(pool))
		"C": begin
		  if (j) begin
		    $display("Code attribute is not first");
		  end
		  read_u_short(c_max_stack, fp);
		  read_u_short(c_max_locals, fp);
		  read_u_long(c_code_length, fp);
		  if (DEBUG > 1) begin
		    $display("Max stack = %d", c_max_stack);
		  end
		  if (DEBUG > 1) begin
		    $display("Max locals = %d", c_max_locals);
		  end
		  if (DEBUG > 1) begin
		    $display("Code length = %d", c_code_length);
		  end
		  fp = (fp + c_code_length);
		  read_u_short(c_handlers, fp);
		  if (DEBUG > 1) begin
		    $display("Handlers = %d", c_handlers);
		  end
		  for (k = 0; (k < c_handlers); k = (k + 1)) begin
		    read_u_short(start_pc, fp);
		    read_u_short(end_pc, fp);
		    read_u_short(handler_pc, fp);
		    read_u_short(catch_type, fp);
		    if (DEBUG > 1) begin
		      $display("%d %d %d %d", start_pc, end_pc, handler_pc, 
			      catch_type);
		    end
		    if (catch_type) begin
		      tmp = getpool(class, catch_type);
		      if (DEBUG > 1) begin
			$display("%X", tmp);
		      end
		    end
		  end
		  read_u_short(cnt, fp);
		  if (DEBUG > 1) begin
		    $display("attributes_count=%d", cnt);
		  end
		  for (k = 0; (k < cnt); k = (k + 1)) begin
		    read_u_short(idx, fp);
		    read_u_long(len, fp);
		    fp = (fp + len);
		    pool = getpool(class, idx);
		    if (DEBUG > 1) begin
		      $display("%s", dispstr(pool, length(pool)));
		    end
		  end
		end
		"E": begin
		  read_u_short(c_throws_count, fp);
		  for (k = 0; (k < c_throws_count); k = (k + 1)) begin
		    read_u_short(i2, fp);
		  end
		end
		default: begin
		  $display("Invalid method attribute");
		  fp = (fp + len);
		end
	      endcase
	      if (fp1 != fp) begin
		$display("Inconsistent method attribute length");
		$display("Discrepancy = %d bytes", (fp - fp1));
		$finish;
	      end
	    end
	  end
	  read_u_short(cnt, fp);
	  if (DEBUG > 1) begin
	    $display("attributes_count=%d", cnt);
	  end
	  for (i = 0; (i < cnt); i = (i + 1)) begin
	    read_u_short(idx, fp);
	    read_u_long(len, fp);
	    pool = getpool(class, idx);
	    if (DEBUG > 1) begin
	      $display("%s", dispstr(pool, length(pool)));
	    end
	    case (getcode(pool))
	      "S":
		if (len == 2) begin
		  read_u_short(i2, fp);
		  pool = getpool(class, i2);
		  if (DEBUG > 1) begin
		    $display("%s", dispstr(pool, length(pool)));
		  end
		end
		else begin
		  fp = (fp + len);
		end
	      default:
		fp = (fp + len);
	    endcase
	  end
	  if (fp != (getmem((filestart + class)) + code_siz)) begin
	    $display("Final file pointer = %d", fp);
	    $finish;
	  end
	end
	endtask

	task size_class_files;
	begin
	  for (i = 1; (i <= tot_class); i = (i + 1))
	    if (needed(i)) begin
	      if (TRACE) begin
		$display("Sizing %s", dispstr(getmem((filename + i)),
			length(getmem((filename + i)))));
	      end
	      oldclass = i;
	      j = getpool(oldclass, 0);
	      k = 0;
	      while (j) begin
		if (TRACE) begin
		  $display("Super = %s", dispstr(getmem((filename + j)),
			  length(getmem((filename + j)))));
		end
		oldclass = j;
		k = (k + getmem((field_size + oldclass)));
		j = getpool(oldclass, 0);
	      end
	      if (TRACE) begin
		$display("Base = %d, Total size = %d words", k, (k +
			getmem((field_size + i))));
	      end
	      void = setmem((field_base + i), k);
	    end
	  for (i = 1; (i <= tot_class); i = (i + 1))
	    if (needed(i)) begin
	      void = setmem((field_size + i), (getmem((field_size + i)) +
		      getmem((field_base + i))));
	    end
	end
	endtask

	task link_class_file;

	input reg
		[31:0]		class;

	reg	[31:0]		fp;
	reg	[31:0]		code_siz;
	reg	[15:0]		cnt;
	reg	[15:0]		access_flags;
	reg	[15:0]		name_index;
	reg	[15:0]		signature_index;
	reg	[15:0]		c_max_stack;
	reg	[15:0]		c_max_locals;
	reg	[15:0]		c_code_length;
	reg	[15:0]		this_class;
	reg	[15:0]		super_class;
	reg	[15:0]		interfaces_count;
	reg	[15:0]		fields_count;
	reg	[63:0]		tmpl;
	reg	[63:0]		pool;
	reg	[15:0]		minor_version;
	reg	[15:0]		major_version;
	reg	[31:0]		magic;
	reg	[7:0]		type;
	reg	[15:0]		len;
	reg	[15:0]		unit;
	reg	[15:0]		prev_string;
	reg	[15:0]		d2;
	reg	[15:0]		d2b;
	reg	[31:0]		d4;
	reg	[31:0]		d4b;
	reg	[31:0]		refclass;
	reg	[31:0]		ref_count;
	reg	[31:0]		reffp;
	reg	[31:0]		ref_access_flags;
	reg	[31:0]		ref_name_index;
	reg	[31:0]		ref_signature_index;
	reg	[31:0]		field_offset;
	reg			error;
	reg	[31:0]		i;
	reg	[31:0]		j;
	reg	[31:0]		k;
	reg	[31:0]		i2;
	reg	[31:0]		inc;
	reg	[31:0]		m;
	reg	[31:0]		n;
	reg	[31:0]		end_params;
	reg	[31:0]		name_type;
	reg	[63:0]		mname;
	reg	[63:0]		mtype;
	begin
	  fp = getmem((filestart + class));
	  code_siz = getmem((filelen + class));
	  read_u_long(magic, fp);
	  if (magic != JAVAMAGIC) begin
	    $display("Bad magic %x in class", magic);
	    $finish;
	  end
	  read_u_short(minor_version, fp);
	  read_u_short(major_version, fp);
	  if (major_version != MAJOR_VERSION) begin
	    if (DEBUG > 1) begin
	      $display("Warning: Major version number mismatch.");
	    end
	  end
	  if (minor_version != MINOR_VERSION) begin
	    if (DEBUG > 1) begin
	      $display("Warning: Minor version number mismatch.");
	    end
	  end
	  $write("Linking class %d ", class[9:0]);
	  showclass(class);
	  $display;
	  read_u_short(info_size, fp);
	  error = false;
	  prev_string = 0;
	  for (i = 1; (i < info_size); i = (i + 1)) begin
	    read_u_char(type, fp);
	    tmpl = getpool(class, i);
	    case (type)
	      CONSTANT_Utf8: begin
		read_u_short(len, fp);
		if (fp != tmpl) begin
		  pool = hashstr(fp, len, 0);
		  if (tmpl != pool[31:0]) begin
		    $display("Utf Error %x,%x,%x,%x", fp, len, tmpl, pool);
		    $display("%s", dispstr(fp, len));
		    $display("%s", dispstr(tmpl, length(tmpl)));
		    $display("%s", dispstr(pool, length(pool)));
		    $finish;
		  end
		end
		fp = (fp + len);
	      end
	      CONSTANT_Class: begin
		read_u_short(d2, fp);
		d4 = getpool(class, d2);
		if (d4 != getmem((filename + tmpl))) begin
		  $display("Class ref error %d, %d", d2, tmpl, dispstr(d4,
			  length(d4)));
		  $finish;
		end
	      end
	      CONSTANT_String: begin
		read_u_short(d2, fp);
		if (d2 != tmpl) begin
		  $display("%d", d2);
		end
		d4[15:0] = d2;
		d4[31:16] = prev_string;
		prev_string = i;
		setpool(class, i, d4);
	      end
	      CONSTANT_NameAndType: begin
		read_u_short(name_index, fp);
		read_u_short(signature_index, fp);
		tmp = ((signature_index << 16) | name_index);
		if (tmp != tmpl) begin
		  $display("%d,%d", name_index, signature_index);
		  $finish;
		end
	      end
	      CONSTANT_Fieldref, CONSTANT_Methodref, CONSTANT_InterfaceMethodref
		      : begin
		read_u_short(d2, fp);
		read_u_short(d2b, fp);
		tmp = ((d2b << 16) | d2);
		if (tmp != tmpl) begin
		  $display("%d,%d", d2, d2b);
		  $finish;
		end
		zipidx = getpool(class, d2);
		if (DEBUG > 1) begin
		  $display("Method %d %d,%d => %s", i, d2, zipidx, 
			  dispstr(getmem((filename + zipidx)),
			  length(getmem((filename + zipidx)))));
		end
		refclass = zipidx;
		name_type = getpool(class, d2b);
		if (DEBUG > 1) begin
		  $display("Name and type %d,%d", name_type[15:0], 
			  name_type[31:16]);
		end
		mname = getpool(class, name_type[15:0]);
		pool = hashstr(mname, length(mname), 0);
		mname = pool[31:0];
		tmp = pool[63:32];
		setpool(class, name_type[15:0], mname);
		mtype = getpool(class, name_type[31:16]);
		pool = hashstr(mtype, length(mtype), 0);
		mtype = pool[31:0];
		setpool(class, name_type[31:16], mtype);
		tmp2 = 0;
		error = (((class == refclass) && (class == class_string)) && (
			mname == find_init));
		while ((tmp != 0)) begin
		  if (DEBUG > 1) begin
		    $display("Method Name %s", dispstr(mname, length(mname)));
		    $display("Method Type %s", dispstr(mtype, length(mtype)));
		    $display("Code address = %X", getmem((tmp + 1)));
		    $display("Access flags = %X", getmem((tmp + 2)));
		    $display("Hash = %X", getmem((tmp + 3)));
		    $display("Class no = %d", getmem((tmp + 4)));
		    $display("Type = %s", dispstr(getmem((tmp + 5)),
			    length(getmem((tmp + 5)))));
		    $display("Size = %d", getmem((tmp + 6)));
		  end
		  if (error && (getmem((tmp + 5)) == bool_int_int_int_void)) 
			  begin
		    if (TRACE) begin
		      $display("String initializer found");
		    end
		    str_init = tmp;
		    if (getmem((tmp + 6)) != 5) begin
		      $display("Interface to String(<init>) has changed %d", 
			      getmem((tmp2 + 6)));
		      $finish;
		    end
		  end
		  if ((zipidx == getmem((tmp + 4))) && (mtype == getmem((tmp +
			  5)))) begin
		    tmp2 = tmp;
		    setpool(class, i, tmp2);
		    if (DEBUG > 1) begin
		      $display(
			      "Class %d Method/Field %d Linked to class %d, fp %d",
			      class[9:0], i, getmem((tmp2 + 4)), getmem((tmp2 +
			      1)));
		    end
		  end
		  tmp = getmem(tmp);
		end
		if (tmp2 == 0) begin
		  $display("Method not hashed");
		  $finish;
		end
	      end
	      CONSTANT_Integer, CONSTANT_Float: begin
		read_u_long(d4, fp);
		if (d4 != tmpl) begin
		  $display("Expected %x, Actual %x", d4, tmpl);
		  $finish;
		end
	      end
	      CONSTANT_Long, CONSTANT_Double: begin
		read_u_long(d4, fp);
		if (d4 != tmpl) begin
		  $display("Expected %x, Actual %x", d4, tmpl);
		  $finish;
		end
		i = (i + 1);
		read_u_long(d4b, fp);
		tmpl = getpool(class, i);
	      end
	      default: begin
		$display("ClassFormatError");
		$finish;
	      end
	    endcase
	  end
	  read_u_short(access_flags, fp);
	  read_u_short(this_class, fp);
	  read_u_short(super_class, fp);
	  while (prev_string) begin
	    i = getpool(class, prev_string);
	    setpool(class, prev_string, i[15:0]);
	    build_string(class, prev_string);
	    prev_string = i[31:16];
	  end
	  read_u_short(interfaces_count, fp);
	  fp = (fp + (interfaces_count * 2));
	  read_u_short(fields_count, fp);
	  if (getmem((field_size + class))) begin
	    void = setmem((static_chain + class), alloc(getmem((field_size +
		    class))));
	    void = setmem(getmem((static_chain + class)), class);
	  end
	  else begin
	    void = setmem((static_chain + class), 0);
	  end
	  field_offset = (getmem((static_chain + class)) + getmem((field_base +
		  class)));
	  for (i = 0; (i < fields_count); i = (i + 1)) begin
	    void = setmem(field_offset, 0);
	    void = setmem((field_offset + 1), 0);
	    read_u_short(access_flags, fp);
	    read_u_short(name_index, fp);
	    read_u_short(signature_index, fp);
	    if (DEBUG > 1) begin
	      $display("%d,%d,%d", access_flags, name_index, signature_index);
	    end
	    pool = getpool(class, name_index);
	    if (DEBUG > 1) begin
	      $display("%s", dispstr(pool, length(pool)));
	    end
	    pool = getpool(class, signature_index);
	    case (getcode(pool))
	      "[":
		unit = 1;
	      "B":
		unit = 1;
	      "C":
		unit = 1;
	      "D":
		unit = 2;
	      "F":
		unit = 1;
	      "I":
		unit = 1;
	      "J":
		unit = 2;
	      "S":
		unit = 1;
	      "Z":
		unit = 1;
	      "L":
		unit = 1;
	      default: begin
		$display("Size unknown");
		$display("%s", dispstr(pool, length(pool)));
		$finish;
	      end
	    endcase
	    read_u_short(cnt, fp);
	    if (DEBUG > 1) begin
	      $display("attributes_count=%d", cnt);
	    end
	    for (j = 0; (j < cnt); j = (j + 1)) begin
	      read_u_short(idx, fp);
	      read_u_long(len, fp);
	      pool = getpool(class, idx);
	      if (DEBUG > 1) begin
		$display("%s", dispstr(pool, length(pool)));
	      end
	      case (getcode(pool))
		"C":
		  if (len == 2) begin
		    read_u_short(i2, fp);
		    void = setmem(field_offset, getpool(class, i2));
		    if (TRACE) begin
		      $display("Initializer %X", getmem(field_offset));
		    end
		    if (unit > 1) begin
		      void = setmem((field_offset + 1), getpool(class, (i2 + 1))
			      );
		    end
		  end
		  else begin
		    fp = (fp + len);
		  end
		default:
		  fp = (fp + len);
	      endcase
	    end
	    field_offset = (field_offset + unit);
	  end
	  read_u_short(methods_count, fp);
	  for (i = 0; (i < methods_count); i = (i + 1)) begin
	    read_u_short(access_flags, fp);
	    read_u_short(name_index, fp);
	    read_u_short(signature_index, fp);
	    read_u_short(cnt, fp);
	    for (j = 0; (j < cnt); j = (j + 1)) begin
	      read_u_short(idx, fp);
	      read_u_long(len, fp);
	      read_u_short(c_max_stack, fp);
	      read_u_short(c_max_locals, fp);
	      read_u_long(c_code_length, fp);
	      fp = ((fp + len) - 8);
	    end
	  end
	  read_u_short(cnt, fp);
	  for (i = 0; (i < cnt); i = (i + 1)) begin
	    read_u_short(idx, fp);
	    read_u_long(len, fp);
	    fp = (fp + len);
	  end
	  if (fp != (getmem((filestart + class)) + code_siz)) begin
	    $display("Final file pointer = %d", fp);
	    $finish;
	  end
	end
	endtask

	task build_string;

	input reg
		[15:0]		classidx;
	input reg
		[15:0]		stridx;

	reg	[31:0]		bytearray;
	reg	[(8 * 80):1]	dstr;
	reg	[63:0]		tmpl;
	reg	[63:0]		pool;
	begin
	  tmp = getpool(classidx, stridx);
	  pool = getpool(classidx, tmp);
	  len = length(pool);
	  if (TRACE) begin
	    $display("String %s", dispstr(pool, len));
	  end
	  bytearray = softnewarray(len, 8);
	  tmp = alloc(getmem((field_size + class_string)));
	  void = setmem(tmp, class_string);
	  setpool(classidx, stridx, tmp);
	  sp = ((1 << mem_width) - 5);
	  void = setmem((sp + 4), tmp);
	  void = setmem((sp + 3), bytearray);
	  void = setmem((sp + 2), 32'b0);
	  void = setmem((sp + 1), 32'b0);
	  void = setmem((sp + 0), length(pool));
	  for (j = 0; (j < len); j = (j + 1))
	    void = setmem(((bytearray + 1) + j), getcode((pool + j)));
	  call_method_chain(str_init, 0);
	  tmp = getpool(classidx, stridx);
	  if (TRACE > 1) begin
	    for (j = 0; (j < getmem((field_size + class_string))); j = (j + 1))
	      $display("getmem(%X) = %X", (tmp + j), getmem((tmp + j)));
	  end
	  tmp = getmem((tmp + getmem((field_base + class_string))));
	  if (TRACE) begin
	    $write("Created string ");
	    for (j = 1; (j <= getmem(tmp)); j = (j + 1))
	      $write("%c", getmem((tmp + j)));
	    $display;
	  end
	end
	endtask

	task static_init;

	reg	[31:0]		static_size;
	reg	[31:0]		sort;
	reg	[63:0]		tmpl;
	reg	[63:0]		pool;
	integer			i;
	integer			j;
	integer			k;
	begin
	  static_size = brk;
	  tmp = findstr("<clinit>");
	  pool = hashstr(tmp, length(tmp), 0);
	  if (tmp == pool[31:0]) begin
	    $display("Method Name %s", dispstr(tmp, length(tmp)));
	    i = 0;
	    static_chain_ptr = pool[63:32];
	    while ((static_chain_ptr != 0)) begin
	      static_chain_ptr = getmem(static_chain_ptr);
	      i = (i + 1);
	    end
	    $display("%d static classes found", i);
	    sort = alloc((i * 2));
	    j = 0;
	    static_chain_ptr = pool[63:32];
	    while ((static_chain_ptr != 0)) begin
	      tmpl[63:32] = getmem((field_size + getmem((static_chain_ptr + 4)))
		      );
	      tmpl[31:0] = static_chain_ptr;
	      void = setmem_long((sort + (2 * j)), tmpl);
	      static_chain_ptr = getmem(static_chain_ptr);
	      j = (j + 1);
	    end
	    for (j = 0; (j < i); j = (j + 1))
	      for (k = (j + 1); (k < i); k = (k + 1)) begin
		pool = getmem_long((sort + (2 * j)));
		tmpl = getmem_long((sort + (2 * k)));
		if (pool[63:32] > tmpl[63:32]) begin
		  void = setmem_long((sort + (2 * j)), tmpl);
		  void = setmem_long((sort + (2 * k)), pool);
		end
	      end
	    for (j = 0; (j < i); j = (j + 1)) begin
	      pool = getmem_long((sort + (2 * j)));
	      static_chain_ptr = pool[31:0];
	      if (TRACE) begin
		$display("Initializing class %s", dispstr(getmem((filename +
			getmem((static_chain_ptr + 4)))),
			length(getmem((filename + getmem((static_chain_ptr +
			4)))))));
		$display("Field size = %d words", pool[63:32]);
		$display("Code address = %X", getmem((static_chain_ptr + 1)));
		$display("Access flags = %X", getmem((static_chain_ptr + 2)));
		$display("Hash = %X", getmem((static_chain_ptr + 3)));
		$display("Class no = %d", getmem((static_chain_ptr + 4)));
		$display("Type = %s", dispstr(getmem((static_chain_ptr + 5)),
			length(getmem((static_chain_ptr + 5)))));
		$display("Size = %d", getmem((static_chain_ptr + 6)));
	      end
	      sp = ((1 << mem_width) - 1);
	      void = setmem(sp, 0);
	      call_method_chain(static_chain_ptr, 1);
	    end
	  end
	  else begin
	    $display("No static initializers found");
	  end
	  $display("Static classes initialized using %d words", (brk -
		  static_size));
	end
	endtask

	task call_main;

	reg	[63:0]		tmpl;
	reg	[63:0]		pool;
	begin
	  tmp = findstr("main");
	  pool = hashstr(tmp, length(tmp), 0);
	  if (tmp == pool[31:0]) begin
	    $write("Main class ");
	    showclass(class_main);
	    $display;
	    sp = ((1 << mem_width) - 3);
	    void = setmem((sp + 2), 0);
	    void = setmem((sp + 1), 0);
	    void = setmem((sp + 0), 0);
	    call_method_chain(pool[63:32], 1);
	  end
	  else begin
	    $display("Could not find main program");
	  end
	end
	endtask

	task check_zip_file_entry;

	input reg
		[31:0]		start;
	input reg
		[31:0]		size;
	input reg
		[31:0]		name;
	input reg
		[31:0]		namelen;

	reg	[31:0]		code_siz;
	reg	[15:0]		cnt;
	reg	[15:0]		access_flags;
	reg	[15:0]		name_index;
	reg	[15:0]		signature_index;
	reg	[15:0]		c_max_stack;
	reg	[15:0]		c_max_locals;
	reg	[15:0]		c_code_length;
	reg	[15:0]		this_class;
	reg	[15:0]		super_class;
	reg	[15:0]		interfaces_count;
	reg	[15:0]		fields_count;
	reg	[15:0]		minor_version;
	reg	[15:0]		major_version;
	reg	[31:0]		magic;
	reg	[7:0]		type;
	reg	[15:0]		len;
	reg	[15:0]		d2;
	reg	[15:0]		d2b;
	reg	[31:0]		d4;
	reg	[31:0]		d4b;
	reg	[31:0]		fp;
	reg	[31:0]		i;
	reg	[31:0]		k;
	reg	[31:0]		i2;
	reg	[31:0]		inc;
	reg			error;
	begin
	  fp = start;
	  read_u_long(magic, fp);
	  if (magic == JAVAMAGIC) begin
	    read_u_short(minor_version, fp);
	    read_u_short(major_version, fp);
	    read_u_short(i, fp);
	    info_size = i;
	    local = sp;
	    sp = ((local - info_size) - 2);
	    for (i = 1; (i < info_size); i = (i + 1)) begin
	      read_u_char(type, fp);
	      case (type)
		CONSTANT_Utf8: begin
		  read_u_short(len, fp);
		  void = setmem((sp + i), fp);
		  fp = (fp + len);
		end
		CONSTANT_Class, CONSTANT_String: begin
		  read_u_short(d2, fp);
		  void = setmem((sp + i), d2);
		end
		CONSTANT_Fieldref, CONSTANT_Methodref, 
			CONSTANT_InterfaceMethodref, CONSTANT_NameAndType, 
			CONSTANT_Integer, CONSTANT_Float: begin
		  read_u_long(d4, fp);
		end
		CONSTANT_Long, CONSTANT_Double: begin
		  read_u_long(d4, fp);
		  read_u_long(d4b, fp);
		  i = (i + 1);
		end
		default: begin
		  $display("ClassFormatError");
		  $finish;
		end
	      endcase
	    end
	    read_u_short(access_flags, fp);
	    read_u_short(this_class, fp);
	    read_u_short(super_class, fp);
	    read_u_short(interfaces_count, fp);
	    fp = (fp + (interfaces_count * 2));
	    read_u_short(fields_count, fp);
	    for (i = 0; (i < fields_count); i = (i + 1)) begin
	      read_u_short(access_flags, fp);
	      read_u_short(name_index, fp);
	      read_u_short(signature_index, fp);
	      read_u_short(cnt, fp);
	      for (j = 0; (j < cnt); j = (j + 1)) begin
		read_u_short(idx, fp);
		read_u_long(len, fp);
		fp = (fp + len);
	      end
	    end
	    d2 = getmem((sp + this_class));
	    d4 = getmem((sp + d2));
	    d4b = hashstr(d4, length(d4), (tot_class + 1));
	    error = (class_main != 0);
	    for (i = 0; (i < length(d4b)); i = (i + 1))
	      if (getcode((d4b + i)) == "/") begin
		error = 1;
	      end
	    read_u_short(methods_count, fp);
	    for (i = 0; (i < methods_count); i = (i + 1)) begin
	      read_u_short(access_flags, fp);
	      read_u_short(name_index, fp);
	      read_u_short(signature_index, fp);
	      read_u_short(cnt, fp);
	      for (j = 0; (j < cnt); j = (j + 1)) begin
		read_u_short(idx, fp);
		read_u_long(len, fp);
		fp = (fp + len);
	      end
	      d4 = getmem((sp + name_index));
	      if (!error) begin
		if (equalstr(d4, length(d4), (zipf_size + 2), length((zipf_size
			+ 2)))) begin
		  class_main = (tot_class + 1);
		  if (DEBUG) begin
		    $display("Class %s", dispstr(d4b, length(d4b)));
		    $display("Name %s", dispstr(d4, length(d4)));
		    d4 = getmem((sp + signature_index));
		    $display("Type %s", dispstr(d4, length(d4)));
		  end
		end
	      end
	    end
	    sp = local;
	    read_u_short(cnt, fp);
	    for (i = 0; (i < cnt); i = (i + 1)) begin
	      read_u_short(idx, fp);
	      read_u_long(len, fp);
	      fp = (fp + len);
	    end
	    d4 = hashstr(name, namelen, 0);
	    len = length(d4b);
	    if (((d4 == d4b) && (len == namelen)) && (fp == (start + size))) 
		    begin
	      tot_class = (tot_class + 1);
	      void = setmem((filestart + tot_class), start);
	      void = setmem((filelen + tot_class), size);
	      void = setmem((filename + tot_class), d4);
	    end
	    else if (class_main == (tot_class + 1)) begin
	      $display("Class %s", dispstr(d4b, length(d4b)));
	      $display("containing main() is invalid");
	      $finish;
	    end
	  end
	end
	endtask

	task alloc_arrays;

	input reg
		[31:0]		siz;
	begin
	  $display("class slots = %d", siz);
	  const_idx = alloc(siz);
	  filename = alloc(siz);
	  filestart = alloc(siz);
	  filelen = alloc(siz);
	  static_chain = alloc(siz);
	  field_base = alloc(siz);
	  field_size = alloc(siz);
	end
	endtask

	task check_zip_file;

	integer			dir_last_pad;
	integer			dir_ptr;
	integer			zipf_count;
	integer			zipf_dir_size;
	integer			uncompressed_size;
	integer			filename_length;
	integer			extra_field_length;
	integer			file_comment_length;
	integer			record_length;
	integer			start;
	integer			unpadded_direntry_length;
	integer			i;
	integer			k;
	integer			name;
	begin
	  zipf_count = makeword(((zipf_size - 22) + 10));
	  alloc_arrays((zipf_count + 1));
	  zipf_dir_size = makelong(((zipf_size - 22) + 12));
	  dir_last_pad = 0;
	  dir_ptr = (zipf_size - (zipf_dir_size + 22));
	  for (i = 0; (i < zipf_count); i = (i + 1)) begin
	    uncompressed_size = makelong((dir_ptr + 24));
	    filename_length = makeword((dir_ptr + 28));
	    extra_field_length = makeword((dir_ptr + 30));
	    file_comment_length = makeword((dir_ptr + 32));
	    name = (dir_ptr + 46);
	    record_length = ((filename_length + extra_field_length) + 
		    file_comment_length);
	    if (((((name - zipf_size) + zipf_dir_size) + 22) + record_length) > 
		    zipf_dir_size) begin
	      $finish;
	    end
	    start = ((makelong((dir_ptr + 42)) + 30) + record_length);
	    if (record_length != filename_length) begin
	      start = (start + 4);
	    end
	    if ((uncompressed_size > 4) && (filename_length > 6)) begin
	      k = name;
	      filename_length = (filename_length - 6);
	      while (((getcode(k) > 0) && (getcode(k) != ".")))
		k = (k + 1);
	      if ((getcode(k) == ".") && (k == (name + filename_length))) begin
		check_zip_file_entry(start, uncompressed_size, name, 
			filename_length);
	      end
	    end
	    unpadded_direntry_length = ((46 - dir_last_pad) + record_length);
	    dir_ptr = ((dir_ptr + dir_last_pad) + unpadded_direntry_length);
	    dir_last_pad = (((unpadded_direntry_length & (-4)) + 4) - 
		    unpadded_direntry_length);
	  end
	  $display("zipfile_count = %d, classfile_count = %d", zipf_count, 
		  tot_class);
	end
	endtask

	task call_method_chain;

	input reg
		[31:0]		chain;
	input reg
		[31:0]		extras;
	begin
	  oldclass = 0;
	  call(chain, extras);
	  while ((sp[(mem_width - 1)] === 1))
	    interpret_instruction;
	end
	endtask

	task statistics;
	begin
	  $display("Code reads/writes = %d/%d", code_reads, code_writes);
	  $display("Memory reads/writes = %d/%d", mem_reads, mem_writes);
	end
	endtask

	task SOFT_ADDREFERENCE_STATIC;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task add_ref_const;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  arg1 = (arg2 + arg3);
	end
	endtask

	task breakpoint;

	input reg
		[31:0]		arg1;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task call;

	input reg
		[31:0]		tmp2;
	input reg
		[31:0]		extras;

	reg	[(8 * 80):1]	dstr;
	reg	[15:0]		cnt;
	reg	[15:0]		access_flags;
	reg	[15:0]		name_index;
	reg	[15:0]		signature_index;
	reg	[15:0]		class;
	reg	[15:0]		c_max_stack;
	reg	[15:0]		c_max_locals;
	reg	[15:0]		c_code_length;
	reg	[15:0]		ref_name_index;
	reg	[15:0]		ref_signature_index;
	reg	[15:0]		ref_access_flags;
	reg	[31:0]		reffp;
	reg	[31:0]		refclass;
	reg	[31:0]		offset;
	reg	[31:0]		repeats;
	reg	[31:0]		notified;
	reg	[63:0]		pool;
	reg	[63:0]		tmpl;
	reg	[15:0]		i;
	reg	[15:0]		j;
	reg			error;
	begin
	  class = getmem((tmp2 + 4));
	  offset = getmem((tmp2 + 6));
	  reffp = getmem((tmp2 + 1));
	  if (TRACE > 1) begin
	    $display("Memptr = %d, size = %d, reffp = %X", tmp2, offset, reffp);
	  end
	  if (reffp) begin
	    refclass = class;
	    read_u_short(access_flags, reffp);
	    read_u_short(name_index, reffp);
	    read_u_short(signature_index, reffp);
	    read_u_short(cnt, reffp);
	    if (TRACE > 1) begin
	      $display("Call Code ref = %x", reffp);
	      $display("Calling from class %d to class %d", oldclass, refclass);
	      showclass(oldclass);
	      showclass(refclass);
	      pool = getpool(refclass, name_index);
	      $write("\n%s ", dispstr(pool, length(pool)));
	      pool = getpool(refclass, signature_index);
	      $display("%s", dispstr(pool, length(pool)));
	    end
	    if (cnt && (!(access_flags & (ACCESS_Native | ACCESS_Abstract)))) 
		    begin
	      read_u_short(idx, reffp);
	      read_u_long(len, reffp);
	      read_u_short(c_max_stack, reffp);
	      read_u_short(c_max_locals, reffp);
	      read_u_long(c_code_length, reffp);
	      push((7 + c_max_locals));
	      void = setmem((sp + 0), npc);
	      void = setmem((sp + 1), oldclass);
	      void = setmem((sp + 2), codelen);
	      void = setmem((sp + 3), codestart);
	      void = setmem((sp + 4), old_access_flags);
	      void = setmem((sp + 5), param_size);
	      void = setmem((sp + 6), local);
	      old_access_flags = access_flags;
	      param_size = (offset[25:0] + extras);
	      local = (((sp + 6) + c_max_locals) + param_size);
	      if (TRACE > 1) begin
		$display("Stack = %X, Local = %X", sp, local);
		$display("Flags = %d", old_access_flags);
		$display("Parameter size = %d", param_size);
		$display("Max stack = %d", c_max_stack);
		$display("Max locals = %d", c_max_locals);
		$display("Code length = %d", c_code_length);
	      end
	      push(0);
	      codelen = c_code_length;
	      codestart = reffp;
	      oldclass = refclass;
	      npc = codestart;
	      wide = 0;
	    end
	    else
	      begin
		if (access_flags & ACCESS_Abstract) begin
		  $write("Tried to call abstract method ");
		  pool = getpool(refclass, name_index);
		  $write("%s type", dispstr(pool, length(pool)));
		  pool = getpool(refclass, signature_index);
		  $write(" %s class ", dispstr(pool, length(pool)));
		  showclass(refclass);
		  $finish;
		end
		else if (access_flags & ACCESS_Native) begin
		  error = 1;
		  reffp = getmem((filename + class));
		  if (reffp == java_io_fileoutputstream) begin
		    pool = getpool(refclass, name_index);
		    if (pool == java_io_open) begin
		      tmp = getmem((sp + 1));
		      if (TRACE) begin
			$display("Open channel %X", tmp);
		      end
		      tmp = getmem((tmp + getmem((field_base + refclass))));
		      if (TRACE) begin
			$display("Open channel %X", tmp);
		      end
		      tmp2 = (tmp + getmem((field_size + class_object)));
		      tmp = getmem(tmp2);
		      if (TRACE) begin
			$display("Open channel %X", tmp);
		      end
		      tmp = getmem(sp);
		      tmp = getmem((tmp + getmem((field_base + class_string))));
		      for (j = 1; (j <= 80); j = (j + 1))
			dstr[j] = 0;
		      for (j = 1; (j <= getmem(tmp)); j = (j + 1)) begin
			dstr = (dstr << 8);
			dstr[8:1] = getmem((tmp + j));
		      end
		      tmp = $fopen(dstr);
		      if (TRACE) begin
			$display("%d = open(%s)", tmp, dstr);
		      end
		      void = setmem(tmp2, tmp);
		      error = 0;
		      pop(((offset[25:0] + extras) - offset[31:26]));
		    end
		    else if (pool == java_io_close) begin
		      tmp = getmem(sp);
		      if (TRACE) begin
			$display("Close channel %X", tmp);
		      end
		      tmp = getmem((tmp + getmem((field_base + refclass))));
		      if (TRACE) begin
			$display("Close channel %X", tmp);
		      end
		      tmp2 = (tmp + getmem((field_size + class_object)));
		      tmp = getmem(tmp2);
		      if (TRACE) begin
			$display("Close channel %X", tmp);
		      end
		      if (TRACE) begin
			$display("close(%d)", tmp);
		      end
		      $fclose(tmp);
		      error = 0;
		      pop(((offset[25:0] + extras) - offset[31:26]));
		    end
		    else if (pool == java_io_write) begin
		      tmp = getmem((sp + 1));
		      if (TRACE) begin
			$display("Write channel %X", tmp);
		      end
		      tmp = getmem((tmp + getmem((field_base + refclass))));
		      if (TRACE) begin
			$display("Write channel %X", tmp);
		      end
		      tmp2 = (tmp + getmem((field_size + class_object)));
		      tmp = getmem(tmp2);
		      if (TRACE) begin
			$display("Write channel %X", tmp);
		      end
		      if (TRACE) begin
			$display("Write to channel %d", tmp);
		      end
		      $fwrite(tmp, "%c", getmem(sp));
		      error = 0;
		      pop(((offset[25:0] + extras) - offset[31:26]));
		    end
		  end
		  if (notified === tmp2) begin
		    repeats = (repeats + 1);
		  end
		  else if (error) begin
		    if (repeats > 0) begin
		      $display("Last method called %d times", repeats);
		    end
		    repeats = 0;
		    $display("Native method");
		    $display("Calling from class %d to class %d (idx=%d)", 
			    oldclass, refclass, idx);
		    showclass(oldclass);
		    showclass(refclass);
		    pool = getpool(refclass, name_index);
		    $display("%s", dispstr(pool, length(pool)));
		    pool = getpool(refclass, signature_index);
		    $display("%s", dispstr(pool, length(pool)));
		  end
		  notified = tmp2;
		  if (error) begin
		    for (i = 0; (i < offset[25:0]); i = (i + 1)) begin
		      $display("arg[%d] = %X (%c)", i, getmem((sp + i)), 
			      getmem((sp + i)));
		    end
		    pop((offset[25:0] + extras));
		    for (i = 0; (i < offset[31:26]); i = (i + 1)) begin
		      push(1);
		      void = setmem(sp, 0);
		    end
		  end
		end
		else
		  begin
		    $display("No code segment");
		    $finish;
		  end
	      end
	  end
	  else
	    begin
	      pop(1);
	      $display("Unresolved reference");
	      $finish;
	    end
	end
	endtask

	task check_pcwidx;

	input reg
		[31:0]		arg1;
	begin
	  if (TRACE > 1) begin
	    $display("Unimplemented check_pcwidx");
	  end
	  $finish;
	end
	endtask

	task check_stack_array;

	input reg
		[31:0]		arg1;
	begin
	  if (TRACE > 1) begin
	    $display("Unimplemented check_stack_array");
	  end
	end
	endtask

	task get_class_info;

	input reg
		[31:0]		arg1;
	begin
	  if (TRACE) begin
	    $display("Class info %d", getpool(oldclass, arg1));
	  end
	end
	endtask

	task get_field_info;

	input reg
		[31:0]		arg1;

	reg	[15:0]		size;
	reg	[15:0]		ref_name_index;
	reg	[15:0]		ref_signature_index;
	reg	[15:0]		ref_access_flags;
	reg	[31:0]		offset;
	reg	[31:0]		reffp;
	reg	[31:0]		refclass;
	reg	[63:0]		pool;
	reg	[63:0]		tmpl;
	begin
	  if (TRACE > 1) begin
	    $display("Getfield %d (class %d)", idx, oldclass);
	  end
	  tmp2 = getpool(oldclass, idx);
	  offset = getmem((tmp2 + 6));
	  reffp = getmem((tmp2 + 1));
	  size = offset[31:26];
	  reffp = reffp;
	  refclass = getmem((tmp2 + 4));
	  offset = (offset[25:0] + getmem((field_base + refclass)));
	  if (TRACE > 1) begin
	    $display("Size = %d", size);
	  end
	  if (TRACE > 1) begin
	    $display("Offset = %d", offset);
	  end
	  if (TRACE > 1) begin
	    $display("Code ref = %x", reffp);
	  end
	  if (TRACE > 1) begin
	    $display("Ref class = %d", refclass);
	  end
	  if (TRACE > 1) begin
	    showclass(refclass);
	  end
	  read_u_short(ref_access_flags, reffp);
	  read_u_short(ref_name_index, reffp);
	  read_u_short(ref_signature_index, reffp);
	  pool = getpool(refclass, ref_name_index);
	  if (TRACE > 1) begin
	    $display("%s", dispstr(pool, length(pool)));
	  end
	  tmpl = getpool(refclass, ref_signature_index);
	  if (TRACE > 1) begin
	    $display("%s", dispstr(tmpl, length(tmpl)));
	  end
	  tmp = getmem(sp);
	  pop(1);
	  if (TRACE > 1) begin
	    $display("Field address = %X", (tmp + offset));
	  end
	  if (TRACE > 1) begin
	    $display("Field object = %X", getmem((tmp + offset)));
	  end
	  push(size);
	  void = setmem(sp, getmem((tmp + offset)));
	  if (size > 1) begin
	    void = setmem((sp + 1), getmem(((tmp + offset) + 1)));
	  end
	end
	endtask

	task put_field_info;

	input reg
		[31:0]		arg1;

	reg	[15:0]		size;
	reg	[15:0]		ref_name_index;
	reg	[15:0]		ref_signature_index;
	reg	[15:0]		ref_access_flags;
	reg	[31:0]		offset;
	reg	[31:0]		reffp;
	reg	[31:0]		refclass;
	reg	[63:0]		pool;
	reg	[63:0]		tmpl;
	begin
	  if (TRACE > 1) begin
	    $display("Putfield %d (class %d)", idx, oldclass);
	  end
	  tmp2 = getpool(oldclass, idx);
	  offset = getmem((tmp2 + 6));
	  reffp = getmem((tmp2 + 1));
	  size = offset[31:26];
	  reffp = reffp;
	  refclass = getmem((tmp2 + 4));
	  offset = (offset[25:0] + getmem((field_base + refclass)));
	  if (TRACE > 1) begin
	    $display("Size = %d", size);
	  end
	  if (TRACE > 1) begin
	    $display("Offset = %d", offset);
	  end
	  if (TRACE > 1) begin
	    $display("Code ref = %x", reffp);
	  end
	  if (TRACE > 1) begin
	    $display("Ref class = %d", refclass);
	  end
	  if (TRACE > 1) begin
	    showclass(refclass);
	  end
	  read_u_short(ref_access_flags, reffp);
	  read_u_short(ref_name_index, reffp);
	  read_u_short(ref_signature_index, reffp);
	  pool = getpool(refclass, ref_name_index);
	  if (TRACE > 1) begin
	    $display("%s", dispstr(pool, length(pool)));
	  end
	  tmpl = getpool(refclass, ref_signature_index);
	  if (TRACE > 1) begin
	    $display("%s", dispstr(tmpl, length(tmpl)));
	  end
	  tmp = getmem((sp + size));
	  if (TRACE > 1) begin
	    $display("Field address = %X", (tmp + offset));
	  end
	  if (TRACE > 1) begin
	    $display("Field object = %X", getmem((tmp + offset)));
	  end
	  void = setmem((tmp + offset), getmem(sp));
	  if (size > 1) begin
	    void = setmem(((tmp + offset) + 1), getmem((sp + 1)));
	  end
	  pop((size + 1));
	end
	endtask

	task get_method_info;

	input reg
		[31:0]		arg1;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task get_static_field_info;

	input reg
		[31:0]		idx;

	reg	[15:0]		size;
	reg	[15:0]		ref_name_index;
	reg	[15:0]		ref_signature_index;
	reg	[15:0]		ref_access_flags;
	reg	[31:0]		offset;
	reg	[31:0]		reffp;
	reg	[31:0]		refclass;
	reg	[63:0]		pool;
	reg	[63:0]		tmpl;
	begin
	  if (TRACE > 1) begin
	    $display("Getstatic %d (class %d)", idx, oldclass);
	  end
	  tmp2 = getpool(oldclass, idx);
	  offset = getmem((tmp2 + 6));
	  reffp = getmem((tmp2 + 1));
	  size = offset[31:26];
	  refclass = getmem((tmp2 + 4));
	  offset = (offset[25:0] + getmem((field_base + refclass)));
	  if (TRACE > 1) begin
	    $display("Size = %d", size);
	  end
	  if (TRACE > 1) begin
	    $display("Offset = %d", offset);
	  end
	  if (TRACE > 1) begin
	    $display("Code ref = %x", reffp);
	  end
	  if (TRACE > 1) begin
	    $display("Ref class = %d", refclass);
	  end
	  if (TRACE > 1) begin
	    showclass(refclass);
	  end
	  read_u_short(ref_access_flags, reffp);
	  read_u_short(ref_name_index, reffp);
	  read_u_short(ref_signature_index, reffp);
	  pool = getpool(refclass, ref_name_index);
	  if (TRACE > 1) begin
	    $display("%s", dispstr(pool, length(pool)));
	  end
	  tmpl = getpool(refclass, ref_signature_index);
	  if (TRACE > 1) begin
	    $display("%s", dispstr(tmpl, length(tmpl)));
	  end
	  if (TRACE > 1) begin
	    $display("Static address = %X", (getmem((static_chain + refclass)) +
		    offset));
	  end
	  if (TRACE > 1) begin
	    $display("Static object = %X", getmem((getmem((static_chain +
		    refclass)) + offset)));
	  end
	  push(size);
	  void = setmem(sp, getmem((getmem((static_chain + refclass)) + offset))
		  );
	  if (size > 1) begin
	    void = setmem((sp + 1), getmem(((getmem((static_chain + refclass)) +
		    offset) + 1)));
	  end
	end
	endtask

	task put_static_field_info;

	input reg
		[31:0]		idx;

	reg	[15:0]		size;
	reg	[15:0]		ref_name_index;
	reg	[15:0]		ref_signature_index;
	reg	[15:0]		ref_access_flags;
	reg	[31:0]		offset;
	reg	[31:0]		reffp;
	reg	[31:0]		refclass;
	reg	[63:0]		pool;
	reg	[63:0]		tmpl;
	begin
	  if (TRACE > 1) begin
	    $display("Putstatic %d (class %d)", idx, oldclass);
	  end
	  tmp2 = getpool(oldclass, idx);
	  offset = getmem((tmp2 + 6));
	  reffp = getmem((tmp2 + 1));
	  size = offset[31:26];
	  refclass = getmem((tmp2 + 4));
	  offset = (offset[25:0] + getmem((field_base + refclass)));
	  if (TRACE > 1) begin
	    $display("Size = %d", size);
	  end
	  if (TRACE > 1) begin
	    $display("Offset = %d", offset);
	  end
	  if (TRACE > 1) begin
	    $display("Code ref = %x", reffp);
	  end
	  if (TRACE > 1) begin
	    $display("Ref class = %d", refclass);
	  end
	  if (TRACE > 1) begin
	    showclass(refclass);
	  end
	  read_u_short(ref_access_flags, reffp);
	  read_u_short(ref_name_index, reffp);
	  read_u_short(ref_signature_index, reffp);
	  pool = getpool(refclass, ref_name_index);
	  if (TRACE > 1) begin
	    $display("%s", dispstr(pool, length(pool)));
	  end
	  tmpl = getpool(refclass, ref_signature_index);
	  if (TRACE > 1) begin
	    $display("%s", dispstr(tmpl, length(tmpl)));
	  end
	  if (TRACE > 1) begin
	    $display("Static address = %X", (getmem((static_chain + refclass)) +
		    offset));
	  end
	  if (TRACE > 1) begin
	    $display("Static object = %X", getmem((getmem((static_chain +
		    refclass)) + offset)));
	  end
	  void = setmem((getmem((static_chain + refclass)) + offset), getmem(sp)
		  );
	  if (size > 1) begin
	    void = setmem(((getmem((static_chain + refclass)) + offset) + 1), 
		    getmem((sp + 1)));
	  end
	  pop(size);
	end
	endtask

	task load_int;

	inout reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  arg1 = getmem(arg2);
	end
	endtask

	task load_key;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task load_ref;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task ret;

	input reg
		[31:0]		arg1;

	reg	[31:0]		old_param_size;
	reg	[31:0]		old_local;
	begin
	  if (TRACE > 1) begin
	    $display("Return size=%d (parameters size=%d)", arg1, param_size);
	  end
	  old_param_size = param_size;
	  move_any(npc, getmem((sp + arg1)));
	  move_any(oldclass, getmem(((sp + 1) + arg1)));
	  move_any(codelen, getmem(((sp + 2) + arg1)));
	  move_any(codestart, getmem(((sp + 3) + arg1)));
	  move_any(old_access_flags, getmem(((sp + 4) + arg1)));
	  move_any(param_size, getmem(((sp + 5) + arg1)));
	  move_any(old_local, getmem(((sp + 6) + arg1)));
	  if (arg1 > 0) begin
	    void = setmem(local, getmem(sp));
	  end
	  if (arg1 > 1) begin
	    void = setmem((local - 1), getmem((sp + 1)));
	  end
	  sp = ((local + 1) - arg1);
	  local = old_local;
	  push(0);
	  if (TRACE > 1) begin
	    $write("Return to class ");
	    showclass(oldclass);
	    $display;
	  end
	end
	endtask

	task softanewarray;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task softathrow;

	input reg
		[31:0]		arg1;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task softcheckcast;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task softget_method_code;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task softget_method_code_const;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task softinitialise_class;

	input reg
		[31:0]		arg1;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task softinstanceof;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task softlookupmethod;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task softmonitorenter;

	input reg
		[31:0]		arg1;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task softmonitorexit;

	input reg
		[31:0]		arg1;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task softmultianewarray;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task softnew;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task start_basic_block;

	input reg
		[31:0]		arg1;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task store_int;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  void = setmem(arg1, arg2);
	end
	endtask

	task store_ref;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  void = setmem(arg1, arg2);
	end
	endtask

	task push;

	input reg
		[31:0]		count;

	reg	[31:0]		i;
	begin
	  if (TRACE > 1) begin
	    $display("push (old = %X, new = %X, frame = %X)", sp, (sp - count), 
		    local);
	  end
	  sp = (sp - count);
	  if (TRACE > 2) begin
	    for (i = 0; (i <= 5); i = (i + 1))
	      if ((sp + i) < (1 << mem_width)) begin
		$display("getmem(sp+%d) = %X", i, getmem((sp + i)));
	      end
	    for (i = 0; (i <= 5); i = (i + 1))
	      $display("getmem(local-%d) = %X", i, getmem((local - i)));
	  end
	end
	endtask

	task move_ref_const;

	inout reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  if (TRACE > 1) begin
	    $display("%X <= %X", arg1, arg2);
	  end
	  arg1 = arg2;
	end
	endtask

	task move_int_const;

	inout reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  if (TRACE > 1) begin
	    $display("%X <= %X", arg1, arg2);
	  end
	  arg1 = arg2;
	end
	endtask

	task move_long_const;

	input reg
		[31:0]		wstack;
	input reg
		[31:0]		value;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task move_float_const;

	inout reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  if (TRACE > 1) begin
	    $display("%X <= %X", arg1, arg2);
	  end
	  arg1 = arg2;
	end
	endtask

	task move_double_const;

	input reg
		[31:0]		wstack;
	input reg
		[31:0]		value;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task check_pc;

	input reg
		[31:0]		value;
	begin
	end
	endtask

	task check_pcidx;

	input reg
		[31:0]		value;
	begin
	end
	endtask

	task CHECK_NULL;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  if (TRACE > 1) begin
	    $display("Unimplemented CHECK_NULL");
	  end
	end
	endtask

	task SOFT_ADDREFERENCE;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  if (TRACE > 1) begin
	    $display("Unimplemented SOFT_ADDREFERENCE");
	  end
	end
	endtask

	task add_int_const;

	inout reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  arg1 = (arg2 + arg3);
	  if (TRACE > 1) begin
	    $display("%X <= %X + %X", arg1, arg2, arg3);
	  end
	end
	endtask

	task branch_indirect;

	input reg
		[31:0]		arg1;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task cbranch_ref_const_eq;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  if (arg1 == arg2) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_ref_const_ne;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  if (arg1 != arg2) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_int_const_eq;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			diff;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  diff = (arg1 - arg2);
	  if (diff == 0) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_int_const_ge;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			diff;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  if (TRACE > 1) begin
	    $display("if (%X >= %X)", arg1, arg2);
	  end
	  diff = (arg1 - arg2);
	  if (diff >= 0) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_int_const_gt;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			diff;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  diff = (arg1 - arg2);
	  if (diff > 0) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_int_const_le;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			diff;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  diff = (arg1 - arg2);
	  if (diff <= 0) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_int_const_lt;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			diff;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  diff = (arg1 - arg2);
	  if (diff < 0) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_int_const_ne;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			diff;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  diff = (arg1 - arg2);
	  if (diff != 0) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_int_eq;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			diff;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  diff = (arg1 - arg2);
	  if (diff == 0) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_int_ge;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			diff;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  diff = (arg1 - arg2);
	  if (diff >= 0) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_int_gt;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			diff;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  diff = (arg1 - arg2);
	  if (diff > 0) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_int_le;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			diff;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  diff = (arg1 - arg2);
	  if (diff <= 0) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_int_lt;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			diff;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  diff = (arg1 - arg2);
	  if (diff < 0) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_int_ne;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			diff;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  diff = (arg1 - arg2);
	  if (diff != 0) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_int_ult;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  if (arg1 < arg2) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task cbranch_ref_ne;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  arg3[31:15] = (-arg3[31:15]);
	  if (arg1 != arg2) begin
	    npc = (pc + arg3);
	  end
	end
	endtask

	task check_local_double;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_local_float;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_local_int;

	input reg
		[31:0]		idx;
	begin
	end
	endtask

	task check_local_long;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_local_ref;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_stack_bytearray;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_stack_chararray;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_stack_double;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_stack_doublearray;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_stack_float;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_stack_floatarray;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_stack_int;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_stack_intarray;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_stack_long;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_stack_longarray;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_stack_ref;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_stack_refarray;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task check_stack_shortarray;

	input reg
		[31:0]		arg1;
	begin
	end
	endtask

	task end_basic_block;

	input reg
		[31:0]		arg1;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task move_any;

	inout reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  if (TRACE > 1) begin
	    $display("%X <= %X", arg1, arg2);
	  end
	  arg1 = arg2;
	end
	endtask

	task move_double;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task move_float;

	inout reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  arg1 = arg2;
	end
	endtask

	task move_int;

	inout reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  if (TRACE > 1) begin
	    $display("%X <= %X", arg1, arg2);
	  end
	  arg1 = arg2;
	end
	endtask

	task move_label_const;

	inout reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  arg1 = arg2;
	end
	endtask

	task move_long;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task move_ref;

	inout reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  if (TRACE > 1) begin
	    $display("%X <= %X", arg1, arg2);
	  end
	  arg1 = arg2;
	end
	endtask

	task pop;

	input reg
		[31:0]		arg1;
	begin
	  if (TRACE > 1) begin
	    $display("pop (old = %X, new = %X)", sp, (sp + arg1));
	  end
	  while ((arg1 > 0)) begin
	    void = setmem(sp, 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
	    sp = (sp + 1);
	    arg1 = (arg1 - 1);
	  end
	end
	endtask

	task softbadarrayindex;

	input reg
		[31:0]		arg1;
	begin
	  $display("Bad array index %d", arg1);
	  $finish;
	end
	endtask

	task softcheckarraystore;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  if (TRACE > 1) begin
	    $display("Unimplemented checkarraystore");
	  end
	end
	endtask

	task store_byte;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  if (TRACE > 1) begin
	    $display("getmem(%X) <= %X", arg1, arg2);
	  end
	  void = setmem(arg1, arg2);
	end
	endtask

	task store_char;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  if (TRACE > 1) begin
	    $display("getmem(%X) <= %X", arg1, arg2);
	  end
	  void = setmem(arg1, arg2);
	end
	endtask

	task store_double;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endtask

	task store_float;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  if (TRACE > 1) begin
	    $display("getmem(%X) <= %X", arg1, arg2);
	  end
	  void = setmem(arg1, arg2);
	end
	endtask

	task store_long;

	input reg
		[31:0]		arg1;
	input reg
		[63:0]		arg2;
	begin
	  void = setmem_long(arg1, arg2);
	end
	endtask

	task store_offset_int;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  if (TRACE > 1) begin
	    $display("getmem(%X+%X) <= %X", arg1, arg2, arg3);
	  end
	  void = setmem((arg1 + arg2), arg3);
	end
	endtask

	task store_offset_ref;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  if (TRACE > 1) begin
	    $display("getmem(%X+%X) <= %X", arg1, arg2, arg3);
	  end
	  void = setmem((arg1 + arg2), arg3);
	end
	endtask

	task store_short;

	input reg
		[31:0]		arg1;
	input reg
		[31:0]		arg2;
	begin
	  if (TRACE > 1) begin
	    $display("getmem(%X) <= %X", arg1, arg2);
	  end
	  void = setmem(arg1, arg2);
	end
	endtask

	task interpret_instruction;
	begin
	  if ((npc < codestart) || (npc >= (codestart + codelen))) begin
	    $finish;
	  end
	  pc = npc;
	  npc = (pc + 1);
	  case (TRACE)
	    0: begin
	    end
	    1:
	      $write("%.6X: ", pc);
	    default: begin
	      showclass(oldclass);
	      low = (pc - codestart);
	      $write("%5d: ", low[15:0]);
	    end
	  endcase
	  case (getcode(pc))
	    NOP: begin
	      if (TRACE) begin
		$display("NOP");
	      end
	    end
	    ACONST_NULL: begin
	      if (TRACE) begin
		$display("ACONST_NULL");
	      end
	      push(1);
	      void = setmem(sp, 0);
	    end
	    ICONST_M1: begin
	      if (TRACE) begin
		$display("ICONST_M1");
	      end
	      push(1);
	      void = setmem(sp, (-1));
	    end
	    ICONST_0: begin
	      if (TRACE) begin
		$display("ICONST_0");
	      end
	      push(1);
	      void = setmem(sp, 0);
	    end
	    ICONST_1: begin
	      if (TRACE) begin
		$display("ICONST_1");
	      end
	      push(1);
	      void = setmem(sp, 1);
	    end
	    ICONST_2: begin
	      if (TRACE) begin
		$display("ICONST_2");
	      end
	      push(1);
	      void = setmem(sp, 2);
	    end
	    ICONST_3: begin
	      if (TRACE) begin
		$display("ICONST_3");
	      end
	      push(1);
	      void = setmem(sp, 3);
	    end
	    ICONST_4: begin
	      if (TRACE) begin
		$display("ICONST_4");
	      end
	      push(1);
	      void = setmem(sp, 4);
	    end
	    ICONST_5: begin
	      if (TRACE) begin
		$display("ICONST_5");
	      end
	      push(1);
	      void = setmem(sp, 5);
	    end
	    LCONST_0: begin
	      if (TRACE) begin
		$display("LCONST_0");
	      end
	      push(2);
	      void = setmem_long(sp, 0);
	    end
	    LCONST_1: begin
	      if (TRACE) begin
		$display("LCONST_1");
	      end
	      push(2);
	      void = setmem_long(sp, 1);
	    end
	    FCONST_0: begin
	      if (TRACE) begin
		$display("FCONST_0");
	      end
	      push(1);
	      void = setmem(sp, 0.0000000000000000);
	    end
	    FCONST_1: begin
	      if (TRACE) begin
		$display("FCONST_1");
	      end
	      push(1);
	      void = setmem(sp, 1.0000000000000000);
	    end
	    FCONST_2: begin
	      if (TRACE) begin
		$display("FCONST_2");
	      end
	      push(1);
	      void = setmem(sp, 2.0000000000000000);
	    end
	    DCONST_0: begin
	      if (TRACE) begin
		$display("DCONST_0");
	      end
	      push(2);
	      void = setmem_long(sp, 0.0000000000000000);
	    end
	    DCONST_1: begin
	      if (TRACE) begin
		$display("DCONST_1");
	      end
	      push(2);
	      void = setmem_long(sp, 1.0000000000000000);
	    end
	    BIPUSH: begin
	      if (TRACE) begin
		$display("BIPUSH");
	      end
	      check_pc(0);
	      low = getpc(0);
	      low[31:7] = (-low[31:7]);
	      push(1);
	      void = setmem(sp, low);
	    end
	    SIPUSH: begin
	      if (TRACE) begin
		$display("SIPUSH");
	      end
	      check_pcidx(0);
	      low = ((getpc(0) << 8) | getpc(1));
	      low[31:15] = (-low[31:15]);
	      push(1);
	      void = setmem(sp, low);
	    end
	    LDC1: begin
	      check_pc(0);
	      idx = getpc(0);
	      if (TRACE) begin
		$display("LDC1 %5d", idx[15:0]);
	      end
	      push(1);
	      void = setmem(sp, getpool(oldclass, idx));
	    end
	    LDC2: begin
	      check_pcidx(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("LDC2 %5d", idx[15:0]);
	      end
	      push(1);
	      void = setmem(sp, getpool(oldclass, idx));
	    end
	    LDC2W: begin
	      check_pcidx(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("LDC2W %5d", idx[15:0]);
	      end
	      push(2);
	      void = setmem((sp + 1), getpool(oldclass, (idx + 1)));
	      void = setmem(sp, getpool(oldclass, idx));
	    end
	    ILOAD: begin
	      if (wide) begin
		npc = (npc + 1);
		check_pcidx(0);
		idx = ((getpc(0) << 8) | getpc(1));
	      end
	      else
		begin
		  check_pc(0);
		  idx = getpc(0);
		end
	      if (TRACE) begin
		$display("ILOAD %5d", idx[15:0]);
	      end
	      wide = 0;
	      check_local_int(idx);
	      push(1);
	      void = setmem(sp, getmem((local - idx)));
	    end
	    LLOAD: begin
	      if (wide) begin
		npc = (npc + 1);
		check_pcidx(0);
		idx = ((getpc(0) << 8) | getpc(1));
	      end
	      else
		begin
		  check_pc(0);
		  idx = getpc(0);
		end
	      if (TRACE) begin
		$display("LLOAD %5d", idx[15:0]);
	      end
	      wide = 0;
	      check_local_long((idx + 1));
	      push(2);
	      void = setmem_long(sp, getmem((local - idx)));
	    end
	    FLOAD: begin
	      if (wide) begin
		npc = (npc + 1);
		check_pcidx(0);
		idx = ((getpc(0) << 8) | getpc(1));
	      end
	      else
		begin
		  check_pc(0);
		  idx = getpc(0);
		end
	      if (TRACE) begin
		$display("FLOAD %5d", idx[15:0]);
	      end
	      wide = 0;
	      check_local_float(idx);
	      push(1);
	      void = setmem(sp, getmem((local - idx)));
	    end
	    DLOAD: begin
	      if (wide) begin
		npc = (npc + 1);
		check_pcidx(0);
		idx = ((getpc(0) << 8) | getpc(1));
	      end
	      else
		begin
		  check_pc(0);
		  idx = getpc(0);
		end
	      if (TRACE) begin
		$display("DLOAD %5d", idx[15:0]);
	      end
	      wide = 0;
	      check_local_double((idx + 1));
	      push(2);
	      void = setmem_long(sp, getmem((local - idx)));
	    end
	    ALOAD: begin
	      if (wide) begin
		npc = (npc + 1);
		check_pcidx(0);
		idx = ((getpc(0) << 8) | getpc(1));
	      end
	      else
		begin
		  check_pc(0);
		  idx = getpc(0);
		end
	      if (TRACE) begin
		$display("ALOAD %5d", idx[15:0]);
	      end
	      wide = 0;
	      check_local_ref(idx);
	      push(1);
	      void = setmem(sp, getmem((local - idx)));
	    end
	    ILOAD_0: begin
	      if (TRACE) begin
		$display("ILOAD_0");
	      end
	      check_local_int(0);
	      push(1);
	      void = setmem(sp, getmem((local - 0)));
	    end
	    ILOAD_1: begin
	      if (TRACE) begin
		$display("ILOAD_1");
	      end
	      check_local_int(1);
	      push(1);
	      void = setmem(sp, getmem((local - 1)));
	    end
	    ILOAD_2: begin
	      if (TRACE) begin
		$display("ILOAD_2");
	      end
	      check_local_int(2);
	      push(1);
	      void = setmem(sp, getmem((local - 2)));
	    end
	    ILOAD_3: begin
	      if (TRACE) begin
		$display("ILOAD_3");
	      end
	      check_local_int(3);
	      push(1);
	      void = setmem(sp, getmem((local - 3)));
	    end
	    LLOAD_0: begin
	      if (TRACE) begin
		$display("LLOAD_0");
	      end
	      check_local_long((0 + 1));
	      push(2);
	      void = setmem_long(sp, getmem(local));
	    end
	    LLOAD_1: begin
	      if (TRACE) begin
		$display("LLOAD_1");
	      end
	      check_local_long((1 + 1));
	      push(2);
	      void = setmem_long(sp, getmem((local - 1)));
	    end
	    LLOAD_2: begin
	      if (TRACE) begin
		$display("LLOAD_2");
	      end
	      check_local_long((2 + 1));
	      push(2);
	      void = setmem_long(sp, getmem((local - 2)));
	    end
	    LLOAD_3: begin
	      if (TRACE) begin
		$display("LLOAD_3");
	      end
	      check_local_long((3 + 1));
	      push(2);
	      void = setmem_long(sp, getmem((local - 3)));
	    end
	    FLOAD_0: begin
	      if (TRACE) begin
		$display("FLOAD_0");
	      end
	      check_local_float(0);
	      push(1);
	      void = setmem(sp, getmem(local));
	    end
	    FLOAD_1: begin
	      if (TRACE) begin
		$display("FLOAD_1");
	      end
	      check_local_float(1);
	      push(1);
	      void = setmem(sp, getmem((local - 1)));
	    end
	    FLOAD_2: begin
	      if (TRACE) begin
		$display("FLOAD_2");
	      end
	      check_local_float(2);
	      push(1);
	      void = setmem(sp, getmem((local - 2)));
	    end
	    FLOAD_3: begin
	      if (TRACE) begin
		$display("FLOAD_3");
	      end
	      check_local_float(3);
	      push(1);
	      void = setmem(sp, getmem((local - 3)));
	    end
	    DLOAD_0: begin
	      if (TRACE) begin
		$display("DLOAD_0");
	      end
	      check_local_double((0 + 1));
	      push(2);
	      void = setmem_long(sp, getmem(local));
	    end
	    DLOAD_1: begin
	      if (TRACE) begin
		$display("DLOAD_1");
	      end
	      check_local_double((1 + 1));
	      push(2);
	      void = setmem_long(sp, getmem((local - 1)));
	    end
	    DLOAD_2: begin
	      if (TRACE) begin
		$display("DLOAD_2");
	      end
	      check_local_double((2 + 1));
	      push(2);
	      void = setmem_long(sp, getmem((local - 2)));
	    end
	    DLOAD_3: begin
	      if (TRACE) begin
		$display("DLOAD_3");
	      end
	      check_local_double((3 + 1));
	      push(2);
	      void = setmem_long(sp, getmem((local - 3)));
	    end
	    ALOAD_0: begin
	      if (TRACE) begin
		$display("ALOAD_0");
	      end
	      check_local_ref(0);
	      push(1);
	      void = setmem(sp, getmem((local - 0)));
	    end
	    ALOAD_1: begin
	      if (TRACE) begin
		$display("ALOAD_1");
	      end
	      check_local_ref(1);
	      push(1);
	      void = setmem(sp, getmem((local - 1)));
	    end
	    ALOAD_2: begin
	      if (TRACE) begin
		$display("ALOAD_2");
	      end
	      check_local_ref(2);
	      push(1);
	      void = setmem(sp, getmem((local - 2)));
	    end
	    ALOAD_3: begin
	      if (TRACE) begin
		$display("ALOAD_3");
	      end
	      check_local_ref(3);
	      push(1);
	      void = setmem(sp, getmem((local - 3)));
	    end
	    IALOAD: begin
	      if (TRACE) begin
		$display("IALOAD");
	      end
	      check_stack_int(0);
	      check_stack_intarray(1);
	      tmp = load_offset_int(getmem((sp + 1)), object_array_length);
	      if (getmem(sp) >= tmp) begin
		softbadarrayindex(getmem(sp));
	      end
	      void = setmem(sp, lshl_int_const(getmem(sp), SHIFT_jint));
	      void = setmem(sp, add_ref(getmem((sp + 1)), getmem(sp)));
	      void = setmem((sp + 1), load_offset_int(getmem(sp),
		      object_array_offset));
	      pop(1);
	    end
	    LALOAD: begin
	      if (TRACE) begin
		$display("LALOAD");
	      end
	      check_stack_int(0);
	      check_stack_longarray(1);
	      tmp = load_offset_int(getmem((sp + 1)), object_array_length);
	      if (getmem(sp) >= tmp) begin
		softbadarrayindex(getmem(sp));
	      end
	      tmp = lshl_int_const(getmem(sp), SHIFT_jlong);
	      if (object_array_offset != 0) begin
		add_int_const(tmp, tmp, object_array_offset);
	      end
	      tmp = add_ref(getmem((sp + 1)), tmp);
	      void = setmem(sp, load_long(tmp));
	    end
	    FALOAD: begin
	      if (TRACE) begin
		$display("FALOAD");
	      end
	      check_stack_int(0);
	      check_stack_floatarray(1);
	      tmp = load_offset_int(getmem((sp + 1)), object_array_length);
	      if (getmem(sp) >= tmp) begin
		softbadarrayindex(getmem(sp));
	      end
	      tmp = lshl_int_const(getmem(sp), SHIFT_jfloat);
	      if (object_array_offset != 0) begin
		add_int_const(tmp, tmp, object_array_offset);
	      end
	      tmp = add_ref(getmem((sp + 1)), tmp);
	      void = setmem((sp + 1), load_float(tmp));
	      pop(1);
	    end
	    DALOAD: begin
	      if (TRACE) begin
		$display("DALOAD");
	      end
	      check_stack_int(0);
	      check_stack_doublearray(1);
	      tmp = load_offset_int(getmem((sp + 1)), object_array_length);
	      if (getmem(sp) >= tmp) begin
		softbadarrayindex(getmem(sp));
	      end
	      tmp = lshl_int_const(getmem(sp), SHIFT_jdouble);
	      if (object_array_offset != 0) begin
		add_int_const(tmp, tmp, object_array_offset);
	      end
	      tmp = add_ref(getmem((sp + 1)), tmp);
	      void = setmem(sp, load_double(tmp));
	    end
	    AALOAD: begin
	      if (TRACE) begin
		$display("AALOAD");
	      end
	      check_stack_int(0);
	      check_stack_refarray(1);
	      CHECK_NULL(AALOAD, getmem((sp + 1)));
	      if (TRACE) begin
		$display("CHECK_NULL(AALOAD, getmem(sp+1))");
	      end
	      tmp = load_offset_int(getmem((sp + 1)), object_array_length);
	      if (getmem(sp) >= tmp) begin
		softbadarrayindex(getmem(sp));
	      end
	      void = setmem(sp, lshl_int_const(getmem(sp), SHIFT_jref));
	      void = setmem(sp, add_ref(getmem((sp + 1)), getmem(sp)));
	      void = setmem((sp + 1), load_offset_ref(getmem(sp),
		      object_array_offset));
	      pop(1);
	    end
	    BALOAD: begin
	      if (TRACE) begin
		$display("BALOAD");
	      end
	      check_stack_int(0);
	      check_stack_bytearray(1);
	      tmp = load_offset_int(getmem((sp + 1)), object_array_length);
	      if (getmem(sp) >= tmp) begin
		softbadarrayindex(getmem(sp));
	      end
	      if (SHIFT_jbyte > 0) begin
		tmp = lshl_int_const(getmem(sp), SHIFT_jbyte);
	      end
	      else
		begin
		  move_int(tmp, getmem(sp));
		end
	      if (object_array_offset != 0) begin
		add_int_const(tmp, tmp, object_array_offset);
	      end
	      tmp = add_ref(getmem((sp + 1)), tmp);
	      void = setmem((sp + 1), load_byte(tmp));
	      pop(1);
	    end
	    CALOAD: begin
	      if (TRACE) begin
		$display("CALOAD");
	      end
	      check_stack_int(0);
	      check_stack_chararray(1);
	      tmp = load_offset_int(getmem((sp + 1)), object_array_length);
	      if (getmem(sp) >= tmp) begin
		softbadarrayindex(getmem(sp));
	      end
	      tmp = lshl_int_const(getmem(sp), SHIFT_jchar);
	      if (object_array_offset != 0) begin
		add_int_const(tmp, tmp, object_array_offset);
	      end
	      tmp = add_ref(getmem((sp + 1)), tmp);
	      void = setmem((sp + 1), load_char(tmp));
	      pop(1);
	    end
	    SALOAD: begin
	      if (TRACE) begin
		$display("SALOAD");
	      end
	      check_stack_int(0);
	      check_stack_shortarray(1);
	      tmp = load_offset_int(getmem((sp + 1)), object_array_length);
	      if (getmem(sp) >= tmp) begin
		softbadarrayindex(getmem(sp));
	      end
	      tmp = lshl_int_const(getmem(sp), SHIFT_jshort);
	      if (object_array_offset != 0) begin
		add_int_const(tmp, tmp, object_array_offset);
	      end
	      tmp = add_ref(getmem((sp + 1)), tmp);
	      void = setmem((sp + 1), load_short(tmp));
	      pop(1);
	    end
	    ISTORE: begin
	      if (wide) begin
		npc = (npc + 1);
		check_pcidx(0);
		idx = ((getpc(0) << 8) | getpc(1));
	      end
	      else
		begin
		  check_pc(0);
		  idx = getpc(0);
		end
	      if (TRACE) begin
		$display("ISTORE %5d", idx[15:0]);
	      end
	      wide = 0;
	      check_stack_int(0);
	      void = setmem((local - idx), getmem(sp));
	      pop(1);
	    end
	    LSTORE: begin
	      if (wide) begin
		npc = (npc + 1);
		check_pcidx(0);
		idx = ((getpc(0) << 8) | getpc(1));
	      end
	      else
		begin
		  check_pc(0);
		  idx = getpc(0);
		end
	      if (TRACE) begin
		$display("LSTORE %5d", idx[15:0]);
	      end
	      wide = 0;
	      check_stack_long(0);
	      void = setmem_long((local - idx), getmem(sp));
	      pop(2);
	    end
	    FSTORE: begin
	      if (wide) begin
		npc = (npc + 1);
		check_pcidx(0);
		idx = ((getpc(0) << 8) | getpc(1));
	      end
	      else
		begin
		  check_pc(0);
		  idx = getpc(0);
		end
	      if (TRACE) begin
		$display("FSTORE %5d", idx[15:0]);
	      end
	      wide = 0;
	      check_stack_float(0);
	      void = setmem((local - idx), getmem(sp));
	      pop(1);
	    end
	    DSTORE: begin
	      if (wide) begin
		npc = (npc + 1);
		check_pcidx(0);
		idx = ((getpc(0) << 8) | getpc(1));
	      end
	      else
		begin
		  check_pc(0);
		  idx = getpc(0);
		end
	      if (TRACE) begin
		$display("DSTORE %5d", idx[15:0]);
	      end
	      wide = 0;
	      check_stack_double(0);
	      void = setmem_long((local - idx), getmem(sp));
	      pop(2);
	    end
	    ASTORE: begin
	      if (wide) begin
		npc = (npc + 1);
		check_pcidx(0);
		idx = ((getpc(0) << 8) | getpc(1));
	      end
	      else
		begin
		  check_pc(0);
		  idx = getpc(0);
		end
	      if (TRACE) begin
		$display("ASTORE %5d", idx[15:0]);
	      end
	      wide = 0;
	      check_stack_ref(0);
	      void = setmem((local - idx), getmem(sp));
	      pop(1);
	    end
	    ISTORE_0: begin
	      if (TRACE) begin
		$display("ISTORE_0");
	      end
	      check_stack_int(0);
	      void = setmem(local, getmem(sp));
	      pop(1);
	    end
	    ISTORE_1: begin
	      if (TRACE) begin
		$display("ISTORE_1");
	      end
	      check_stack_int(0);
	      void = setmem((local - 1), getmem(sp));
	      pop(1);
	    end
	    ISTORE_2: begin
	      if (TRACE) begin
		$display("ISTORE_2");
	      end
	      check_stack_int(0);
	      void = setmem((local - 2), getmem(sp));
	      pop(1);
	    end
	    ISTORE_3: begin
	      if (TRACE) begin
		$display("ISTORE_3");
	      end
	      check_stack_int(0);
	      void = setmem((local - 3), getmem(sp));
	      pop(1);
	    end
	    LSTORE_0: begin
	      if (TRACE) begin
		$display("LSTORE_0");
	      end
	      check_stack_long(0);
	      void = setmem_long(local, getmem(sp));
	      pop(2);
	    end
	    LSTORE_1: begin
	      if (TRACE) begin
		$display("LSTORE_1");
	      end
	      check_stack_long(0);
	      void = setmem_long((local - 1), getmem(sp));
	      pop(2);
	    end
	    LSTORE_2: begin
	      if (TRACE) begin
		$display("LSTORE_2");
	      end
	      check_stack_long(0);
	      void = setmem_long((local - 2), getmem(sp));
	      pop(2);
	    end
	    LSTORE_3: begin
	      if (TRACE) begin
		$display("LSTORE_3");
	      end
	      check_stack_long(0);
	      void = setmem_long((local - 3), getmem(sp));
	      pop(2);
	    end
	    FSTORE_0: begin
	      if (TRACE) begin
		$display("FSTORE_0");
	      end
	      check_stack_float(0);
	      void = setmem(local, getmem(sp));
	      pop(1);
	    end
	    FSTORE_1: begin
	      if (TRACE) begin
		$display("FSTORE_1");
	      end
	      check_stack_float(0);
	      void = setmem((local - 1), getmem(sp));
	      pop(1);
	    end
	    FSTORE_2: begin
	      if (TRACE) begin
		$display("FSTORE_2");
	      end
	      check_stack_float(0);
	      void = setmem((local - 2), getmem(sp));
	      pop(1);
	    end
	    FSTORE_3: begin
	      if (TRACE) begin
		$display("FSTORE_3");
	      end
	      check_stack_float(0);
	      void = setmem((local - 3), getmem(sp));
	      pop(1);
	    end
	    DSTORE_0: begin
	      if (TRACE) begin
		$display("DSTORE_0");
	      end
	      check_stack_double(0);
	      void = setmem_long(local, getmem(sp));
	      pop(2);
	    end
	    DSTORE_1: begin
	      if (TRACE) begin
		$display("DSTORE_1");
	      end
	      check_stack_double(0);
	      void = setmem_long((local - 1), getmem(sp));
	      pop(2);
	    end
	    DSTORE_2: begin
	      if (TRACE) begin
		$display("DSTORE_2");
	      end
	      check_stack_double(0);
	      void = setmem_long((local - 2), getmem(sp));
	      pop(2);
	    end
	    DSTORE_3: begin
	      if (TRACE) begin
		$display("DSTORE_3");
	      end
	      check_stack_double(0);
	      void = setmem_long((local - 3), getmem(sp));
	      pop(2);
	    end
	    ASTORE_0: begin
	      if (TRACE) begin
		$display("ASTORE_0");
	      end
	      check_stack_ref(0);
	      void = setmem(local, getmem(sp));
	      pop(1);
	    end
	    ASTORE_1: begin
	      if (TRACE) begin
		$display("ASTORE_1");
	      end
	      check_stack_ref(0);
	      void = setmem((local - 1), getmem(sp));
	      pop(1);
	    end
	    ASTORE_2: begin
	      if (TRACE) begin
		$display("ASTORE_2");
	      end
	      check_stack_ref(0);
	      void = setmem((local - 2), getmem(sp));
	      pop(1);
	    end
	    ASTORE_3: begin
	      if (TRACE) begin
		$display("ASTORE_3");
	      end
	      check_stack_ref(0);
	      void = setmem((local - 3), getmem(sp));
	      pop(1);
	    end
	    IASTORE: begin
	      if (TRACE) begin
		$display("IASTORE");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      check_stack_intarray(2);
	      tmp = load_offset_int(getmem((sp + 2)), object_array_length);
	      if (getmem((sp + 1)) >= tmp) begin
		softbadarrayindex(getmem((sp + 1)));
	      end
	      void = setmem((sp + 1), lshl_int_const(getmem((sp + 1)),
		      SHIFT_jint));
	      void = setmem((sp + 1), add_ref(getmem((sp + 2)), getmem((sp +
		      1))));
	      store_offset_int(getmem((sp + 1)), object_array_offset, getmem(sp)
		      );
	      pop(3);
	    end
	    LASTORE: begin
	      if (TRACE) begin
		$display("LASTORE");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      check_stack_longarray(2);
	      tmp = load_offset_int(getmem((sp + 3)), object_array_length);
	      if (getmem((sp + 2)) >= tmp) begin
		softbadarrayindex(getmem((sp + 2)));
	      end
	      tmp = lshl_int_const(getmem((sp + 2)), SHIFT_jlong);
	      if (object_array_offset != 0) begin
		add_int_const(tmp, tmp, object_array_offset);
	      end
	      tmp = add_ref(getmem((sp + 3)), tmp);
	      store_long(tmp, {getmem(sp), getmem((sp + 1))});
	      pop(4);
	    end
	    FASTORE: begin
	      if (TRACE) begin
		$display("FASTORE");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      check_stack_floatarray(2);
	      tmp = load_offset_int(getmem((sp + 2)), object_array_length);
	      if (getmem((sp + 1)) >= tmp) begin
		softbadarrayindex(getmem((sp + 1)));
	      end
	      tmp = lshl_int_const(getmem((sp + 1)), SHIFT_jfloat);
	      if (object_array_offset != 0) begin
		add_int_const(tmp, tmp, object_array_offset);
	      end
	      tmp = add_ref(getmem((sp + 2)), tmp);
	      store_float(tmp, getmem(sp));
	      pop(3);
	    end
	    DASTORE: begin
	      if (TRACE) begin
		$display("DASTORE");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      check_stack_doublearray(2);
	      tmp = load_offset_int(getmem((sp + 3)), object_array_length);
	      if (getmem((sp + 2)) >= tmp) begin
		softbadarrayindex(getmem((sp + 2)));
	      end
	      tmp = lshl_int_const(getmem((sp + 2)), SHIFT_jdouble);
	      if (object_array_offset != 0) begin
		add_int_const(tmp, tmp, object_array_offset);
	      end
	      tmp = add_ref(getmem((sp + 3)), tmp);
	      store_double(tmp, getmem(sp));
	      pop(4);
	    end
	    AASTORE: begin
	      if (TRACE) begin
		$display("AASTORE");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      check_stack_refarray(2);
	      CHECK_NULL(AASTORE, getmem((sp + 2)));
	      if (TRACE) begin
		$display("CHECK_NULL(AASTORE, getmem(sp+2))");
	      end
	      tmp = load_offset_int(getmem((sp + 2)), object_array_length);
	      if (getmem((sp + 1)) >= tmp) begin
		softbadarrayindex(getmem((sp + 1)));
	      end
	      softcheckarraystore(getmem((sp + 2)), getmem(sp));
	      SOFT_ADDREFERENCE(getmem((sp + 2)), getmem(sp));
	      if (TRACE) begin
		$display("SOFT_ADDREFERENCE(getmem(sp+2), getmem(sp))");
	      end
	      void = setmem((sp + 1), lshl_int_const(getmem((sp + 1)),
		      SHIFT_jref));
	      void = setmem((sp + 1), add_ref(getmem((sp + 2)), getmem((sp +
		      1))));
	      store_offset_ref(getmem((sp + 1)), object_array_offset, getmem(sp)
		      );
	      pop(3);
	    end
	    BASTORE: begin
	      if (TRACE) begin
		$display("BASTORE");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      check_stack_bytearray(2);
	      tmp = load_offset_int(getmem((sp + 2)), object_array_length);
	      if (getmem((sp + 1)) >= tmp) begin
		softbadarrayindex(getmem((sp + 1)));
	      end
	      if (SHIFT_jbyte > 0) begin
		tmp = lshl_int_const(getmem((sp + 1)), SHIFT_jbyte);
	      end
	      else
		begin
		  move_int(tmp, getmem((sp + 1)));
		end
	      if (object_array_offset != 0) begin
		add_int_const(tmp, tmp, object_array_offset);
	      end
	      tmp = add_ref(getmem((sp + 2)), tmp);
	      store_byte(tmp, getmem(sp));
	      pop(3);
	    end
	    CASTORE: begin
	      if (TRACE) begin
		$display("CASTORE");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      check_stack_chararray(2);
	      tmp = load_offset_int(getmem((sp + 2)), object_array_length);
	      if (getmem((sp + 1)) >= tmp) begin
		softbadarrayindex(getmem((sp + 1)));
	      end
	      tmp = lshl_int_const(getmem((sp + 1)), SHIFT_jchar);
	      if (object_array_offset != 0) begin
		add_int_const(tmp, tmp, object_array_offset);
	      end
	      tmp = add_ref(getmem((sp + 2)), tmp);
	      store_char(tmp, getmem(sp));
	      pop(3);
	    end
	    SASTORE: begin
	      if (TRACE) begin
		$display("SASTORE");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      check_stack_shortarray(2);
	      tmp = load_offset_int(getmem((sp + 2)), object_array_length);
	      if (getmem((sp + 1)) >= tmp) begin
		softbadarrayindex(getmem((sp + 1)));
	      end
	      tmp = lshl_int_const(getmem((sp + 1)), SHIFT_jshort);
	      if (object_array_offset != 0) begin
		add_int_const(tmp, tmp, object_array_offset);
	      end
	      tmp = add_ref(getmem((sp + 2)), tmp);
	      store_short(tmp, getmem(sp));
	      pop(3);
	    end
	    POP: begin
	      if (TRACE) begin
		$display("POP");
	      end
	      pop(1);
	    end
	    POP2: begin
	      if (TRACE) begin
		$display("POP2");
	      end
	      pop(2);
	    end
	    DUP: begin
	      if (TRACE) begin
		$display("DUP");
	      end
	      push(1);
	      void = setmem(sp, getmem((sp + 1)));
	    end
	    DUP_X1: begin
	      if (TRACE) begin
		$display("DUP_X1");
	      end
	      push(1);
	      void = setmem(sp, getmem((sp + 1)));
	      void = setmem((sp + 1), getmem((sp + 2)));
	      void = setmem((sp + 2), getmem(sp));
	    end
	    DUP_X2: begin
	      if (TRACE) begin
		$display("DUP_X2");
	      end
	      push(1);
	      void = setmem(sp, getmem((sp + 1)));
	      void = setmem((sp + 1), getmem((sp + 2)));
	      void = setmem((sp + 2), getmem((sp + 3)));
	      void = setmem((sp + 3), getmem(sp));
	    end
	    DUP2: begin
	      if (TRACE) begin
		$display("DUP2");
	      end
	      push(2);
	      void = setmem(sp, getmem((sp + 2)));
	      void = setmem((sp + 1), getmem((sp + 3)));
	    end
	    DUP2_X1: begin
	      if (TRACE) begin
		$display("DUP2_X1");
	      end
	      push(2);
	      void = setmem(sp, getmem((sp + 2)));
	      void = setmem((sp + 1), getmem((sp + 3)));
	      void = setmem((sp + 2), getmem((sp + 4)));
	      void = setmem((sp + 3), getmem(sp));
	      void = setmem((sp + 4), getmem((sp + 1)));
	    end
	    DUP2_X2: begin
	      if (TRACE) begin
		$display("DUP2_X2");
	      end
	      push(2);
	      void = setmem(sp, getmem((sp + 2)));
	      void = setmem((sp + 1), getmem((sp + 3)));
	      void = setmem((sp + 2), getmem((sp + 4)));
	      void = setmem((sp + 3), getmem((sp + 5)));
	      void = setmem((sp + 4), getmem(sp));
	      void = setmem((sp + 5), getmem((sp + 1)));
	    end
	    SWAP: begin
	      if (TRACE) begin
		$display("SWAP");
	      end
	      tmp = getmem(sp);
	      void = setmem(sp, getmem((sp + 1)));
	      void = setmem((sp + 1), tmp);
	    end
	    IADD: begin
	      if (TRACE) begin
		$display("IADD");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      void = setmem((sp + 1), add_int(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    LADD: begin
	      if (TRACE) begin
		$display("LADD");
	      end
	      check_stack_long(0);
	      check_stack_long(2);
	      void = setmem_long((sp + 2), add_long(getmem_long((sp + 2)),
		      getmem_long(sp)));
	      pop(2);
	    end
	    FADD: begin
	      if (TRACE) begin
		$display("FADD");
	      end
	      check_stack_float(0);
	      check_stack_float(1);
	      void = setmem((sp + 1), add_float(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    DADD: begin
	      if (TRACE) begin
		$display("DADD");
	      end
	      check_stack_double(0);
	      check_stack_double(2);
	      void = setmem_long((sp + 2), add_double(getmem_long((sp + 2)),
		      getmem_long(sp)));
	      pop(2);
	    end
	    ISUB: begin
	      if (TRACE) begin
		$display("ISUB");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      void = setmem((sp + 1), sub_int(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    LSUB: begin
	      if (TRACE) begin
		$display("LSUB");
	      end
	      check_stack_long(0);
	      check_stack_long(2);
	      void = setmem_long((sp + 2), sub_long(getmem_long((sp + 2)),
		      getmem_long(sp)));
	      pop(2);
	    end
	    FSUB: begin
	      if (TRACE) begin
		$display("FSUB");
	      end
	      check_stack_float(0);
	      check_stack_float(1);
	      void = setmem((sp + 1), sub_float(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    DSUB: begin
	      if (TRACE) begin
		$display("DSUB");
	      end
	      check_stack_double(0);
	      check_stack_double(2);
	      void = setmem_long((sp + 2), sub_double(getmem_long((sp + 2)),
		      getmem_long(sp)));
	      pop(2);
	    end
	    IMUL: begin
	      if (TRACE) begin
		$display("IMUL");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      void = setmem((sp + 1), mul_int(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    LMUL: begin
	      if (TRACE) begin
		$display("LMUL");
	      end
	      check_stack_long(0);
	      check_stack_long(2);
	      void = setmem((sp + 2), mul_long(getmem((sp + 2)), getmem(sp)));
	      pop(2);
	    end
	    FMUL: begin
	      if (TRACE) begin
		$display("FMUL");
	      end
	      check_stack_float(0);
	      check_stack_float(1);
	      void = setmem((sp + 1), mul_float(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    DMUL: begin
	      if (TRACE) begin
		$display("DMUL");
	      end
	      check_stack_double(0);
	      check_stack_double(2);
	      void = setmem((sp + 2), mul_double(getmem((sp + 2)), getmem(sp)));
	      pop(2);
	    end
	    IDIV: begin
	      if (TRACE) begin
		$display("IDIV");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      void = setmem((sp + 1), div_int(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    LDIV: begin
	      if (TRACE) begin
		$display("LDIV");
	      end
	      check_stack_long(0);
	      check_stack_long(2);
	      void = setmem((sp + 2), div_long(getmem((sp + 2)), getmem(sp)));
	      pop(2);
	    end
	    FDIV: begin
	      if (TRACE) begin
		$display("FDIV");
	      end
	      check_stack_float(0);
	      check_stack_float(1);
	      void = setmem((sp + 1), div_float(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    DDIV: begin
	      if (TRACE) begin
		$display("DDIV");
	      end
	      check_stack_double(0);
	      check_stack_double(2);
	      void = setmem_long((sp + 2), div_double(getmem_long((sp + 2)),
		      getmem_long(sp)));
	      pop(2);
	    end
	    IREM: begin
	      if (TRACE) begin
		$display("IREM");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      void = setmem((sp + 1), rem_int(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    LREM: begin
	      if (TRACE) begin
		$display("LREM");
	      end
	      check_stack_long(0);
	      check_stack_long(2);
	      void = setmem_long((sp + 2), rem_long(getmem_long((sp + 2)),
		      getmem_long(sp)));
	      pop(2);
	    end
	    FREM: begin
	      if (TRACE) begin
		$display("FREM");
	      end
	      check_stack_float(0);
	      check_stack_float(1);
	      void = setmem((sp + 1), rem_float(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    DREM: begin
	      if (TRACE) begin
		$display("DREM");
	      end
	      check_stack_double(0);
	      check_stack_double(2);
	      void = setmem_long((sp + 2), rem_double(getmem_long((sp + 2)),
		      getmem_long(sp)));
	      pop(2);
	    end
	    INEG: begin
	      if (TRACE) begin
		$display("INEG");
	      end
	      check_stack_int(0);
	      void = setmem(sp, neg_int(getmem(sp)));
	    end
	    LNEG: begin
	      if (TRACE) begin
		$display("LNEG");
	      end
	      check_stack_long(0);
	      void = setmem_long(sp, neg_long(getmem_long(sp)));
	    end
	    FNEG: begin
	      if (TRACE) begin
		$display("FNEG");
	      end
	      check_stack_float(0);
	      void = setmem(sp, neg_float(getmem(sp)));
	    end
	    DNEG: begin
	      if (TRACE) begin
		$display("DNEG");
	      end
	      check_stack_double(0);
	      void = setmem_long(sp, neg_double(getmem_long(sp)));
	    end
	    ISHL: begin
	      if (TRACE) begin
		$display("ISHL");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      void = setmem((sp + 1), lshl_int(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    LSHL: begin
	      if (TRACE) begin
		$display("LSHL");
	      end
	      check_stack_int(0);
	      check_stack_long(1);
	      void = setmem_long((sp + 1), lshl_long(getmem_long((sp + 1)),
		      getmem(sp)));
	      pop(1);
	    end
	    ISHR: begin
	      if (TRACE) begin
		$display("ISHR");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      void = setmem((sp + 1), ashr_int(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    LSHR: begin
	      if (TRACE) begin
		$display("LSHR");
	      end
	      check_stack_int(0);
	      check_stack_long(1);
	      void = setmem_long((sp + 1), ashr_long(getmem_long((sp + 1)),
		      getmem_long(sp)));
	      pop(1);
	    end
	    IUSHR: begin
	      if (TRACE) begin
		$display("IUSHR");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      void = setmem((sp + 1), lshr_int(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    LUSHR: begin
	      if (TRACE) begin
		$display("LUSHR");
	      end
	      check_stack_int(0);
	      check_stack_long(1);
	      void = setmem_long((sp + 1), lshr_long(getmem_long((sp + 1)),
		      getmem(sp)));
	      pop(1);
	    end
	    IAND: begin
	      if (TRACE) begin
		$display("IAND");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      void = setmem((sp + 1), and_int(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    LAND: begin
	      if (TRACE) begin
		$display("LAND");
	      end
	      check_stack_long(0);
	      check_stack_long(2);
	      void = setmem_long((sp + 2), and_long(getmem_long((sp + 2)),
		      getmem_long(sp)));
	      pop(2);
	    end
	    IOR: begin
	      if (TRACE) begin
		$display("IOR");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      void = setmem((sp + 1), or_int(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    LOR: begin
	      if (TRACE) begin
		$display("LOR");
	      end
	      check_stack_long(0);
	      check_stack_long(2);
	      void = setmem_long((sp + 2), or_long(getmem_long((sp + 2)),
		      getmem_long(sp)));
	      pop(2);
	    end
	    IXOR: begin
	      if (TRACE) begin
		$display("IXOR");
	      end
	      check_stack_int(0);
	      check_stack_int(1);
	      void = setmem((sp + 1), xor_int(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    LXOR: begin
	      if (TRACE) begin
		$display("LXOR");
	      end
	      check_stack_long(0);
	      check_stack_long(2);
	      void = setmem_long((sp + 2), xor_long(getmem_long((sp + 2)),
		      getmem_long(sp)));
	      pop(2);
	    end
	    IINC: begin
	      if (wide) begin
		npc = (npc + 2);
		check_pcidx(0);
		check_pcidx(2);
		idx = ((getpc(0) << 8) | getpc(1));
		low = ((getpc(2) << 8) | getpc(3));
		low[31:15] = (-low[31:15]);
	      end
	      else
		begin
		  check_pc(0);
		  check_pc(1);
		  idx = getpc(0);
		  low = getpc(1);
		  low[31:7] = (-low[31:7]);
		end
	      if (TRACE) begin
		$display("IINC %5d,%5d", idx, low[15:0]);
	      end
	      wide = 0;
	      check_local_int(idx);
	      void = setmem((local - idx), (getmem((local - idx)) + low));
	    end
	    I2L: begin
	      if (TRACE) begin
		$display("I2L");
	      end
	      check_stack_int(0);
	      push(1);
	      void = setmem_long(sp, cvt_int_long(getmem((sp + 1))));
	    end
	    I2F: begin
	      if (TRACE) begin
		$display("I2F");
	      end
	      check_stack_int(0);
	      void = setmem(sp, cvt_int_float(getmem(sp)));
	    end
	    I2D: begin
	      if (TRACE) begin
		$display("I2D");
	      end
	      check_stack_int(0);
	      push(1);
	      void = setmem_long(sp, cvt_int_double(getmem((sp + 1))));
	    end
	    L2I: begin
	      if (TRACE) begin
		$display("L2I");
	      end
	      check_stack_long(0);
	      void = setmem((sp + 1), cvt_long_int(getmem_long(sp)));
	      pop(1);
	    end
	    L2F: begin
	      if (TRACE) begin
		$display("L2F");
	      end
	      check_stack_long(0);
	      void = setmem((sp + 1), cvt_long_float(getmem_long(sp)));
	      pop(1);
	    end
	    L2D: begin
	      if (TRACE) begin
		$display("L2D");
	      end
	      check_stack_long(0);
	      void = setmem_long(sp, cvt_long_double(getmem_long(sp)));
	    end
	    F2I: begin
	      if (TRACE) begin
		$display("F2I");
	      end
	      check_stack_float(0);
	      void = setmem(sp, cvt_float_int(getmem(sp)));
	    end
	    F2L: begin
	      if (TRACE) begin
		$display("F2L");
	      end
	      check_stack_float(0);
	      push(1);
	      void = setmem_long(sp, cvt_float_long(getmem((sp + 1))));
	    end
	    F2D: begin
	      if (TRACE) begin
		$display("F2D");
	      end
	      check_stack_float(0);
	      push(1);
	      void = setmem_long(sp, cvt_float_double(getmem((sp + 1))));
	    end
	    D2I: begin
	      if (TRACE) begin
		$display("D2I");
	      end
	      check_stack_double(0);
	      void = setmem((sp + 1), cvt_double_int(getmem_long(sp)));
	      pop(1);
	    end
	    D2L: begin
	      if (TRACE) begin
		$display("D2L");
	      end
	      check_stack_double(0);
	      void = setmem_long(sp, cvt_double_long(getmem_long(sp)));
	    end
	    D2F: begin
	      if (TRACE) begin
		$display("D2F");
	      end
	      check_stack_double(0);
	      void = setmem((sp + 1), cvt_double_float(getmem_long(sp)));
	      pop(1);
	    end
	    INT2BYTE: begin
	      if (TRACE) begin
		$display("INT2BYTE");
	      end
	      check_stack_int(0);
	      void = setmem(sp, cvt_int_byte(getmem(sp)));
	    end
	    INT2CHAR: begin
	      if (TRACE) begin
		$display("INT2CHAR");
	      end
	      check_stack_int(0);
	      void = setmem(sp, cvt_int_char(getmem(sp)));
	    end
	    INT2SHORT: begin
	      if (TRACE) begin
		$display("INT2SHORT");
	      end
	      check_stack_int(0);
	      void = setmem(sp, cvt_int_short(getmem(sp)));
	    end
	    LCMP: begin
	      if (TRACE) begin
		$display("LCMP");
	      end
	      check_stack_long(0);
	      check_stack_long(2);
	      void = setmem((sp + 3), lcmp(getmem_long(sp), getmem_long((sp +
		      2))));
	      pop(3);
	    end
	    FCMPL: begin
	      if (TRACE) begin
		$display("FCMPL");
	      end
	      check_stack_float(0);
	      check_stack_float(1);
	      void = setmem((sp + 1), cmpl_float(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    FCMPG: begin
	      if (TRACE) begin
		$display("FCMPG");
	      end
	      check_stack_float(0);
	      check_stack_float(1);
	      void = setmem((sp + 1), cmpg_float(getmem((sp + 1)), getmem(sp)));
	      pop(1);
	    end
	    DCMPL: begin
	      if (TRACE) begin
		$display("DCMPL");
	      end
	      check_stack_double(0);
	      check_stack_double(2);
	      void = setmem((sp + 3), cmpl_double(getmem_long((sp + 2)),
		      getmem_long(sp)));
	      pop(3);
	    end
	    DCMPG: begin
	      if (TRACE) begin
		$display("DCMPG");
	      end
	      check_stack_double(0);
	      check_stack_double(2);
	      void = setmem((sp + 3), cmpg_double(getmem_long((sp + 2)),
		      getmem_long(sp)));
	      pop(3);
	    end
	    IFEQ: begin
	      check_pcidx(0);
	      check_stack_int(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IFEQ %5d", idx[15:0]);
	      end
	      cbranch_int_const_eq(getmem(sp), 0, idx);
	      pop(1);
	    end
	    IFNE: begin
	      check_pcidx(0);
	      check_stack_int(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IFNE %5d", idx[15:0]);
	      end
	      cbranch_int_const_ne(getmem(sp), 0, idx);
	      pop(1);
	    end
	    IFLT: begin
	      check_pcidx(0);
	      check_stack_int(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IFLT %5d", idx[15:0]);
	      end
	      cbranch_int_const_lt(getmem(sp), 0, idx);
	      pop(1);
	    end
	    IFGE: begin
	      check_pcidx(0);
	      check_stack_int(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IFGE %5d", idx[15:0]);
	      end
	      cbranch_int_const_ge(getmem(sp), 0, idx);
	      pop(1);
	    end
	    IFGT: begin
	      check_pcidx(0);
	      check_stack_int(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IFGT %5d", idx[15:0]);
	      end
	      cbranch_int_const_gt(getmem(sp), 0, idx);
	      pop(1);
	    end
	    IFLE: begin
	      check_pcidx(0);
	      check_stack_int(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IFLE %5d", idx[15:0]);
	      end
	      cbranch_int_const_le(getmem(sp), 0, idx);
	      pop(1);
	    end
	    IF_ICMPEQ: begin
	      check_pcidx(0);
	      check_stack_int(0);
	      check_stack_int(1);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IF_ICMPEQ %5d", idx[15:0]);
	      end
	      cbranch_int_eq(getmem((sp + 1)), getmem(sp), idx);
	      pop(2);
	    end
	    IF_ICMPNE: begin
	      check_pcidx(0);
	      check_stack_int(0);
	      check_stack_int(1);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IF_ICMPNE %5d", idx[15:0]);
	      end
	      cbranch_int_ne(getmem((sp + 1)), getmem(sp), idx);
	      pop(2);
	    end
	    IF_ICMPLT: begin
	      check_pcidx(0);
	      check_stack_int(0);
	      check_stack_int(1);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IF_ICMPLT %5d", idx[15:0]);
	      end
	      cbranch_int_lt(getmem((sp + 1)), getmem(sp), idx);
	      pop(2);
	    end
	    IF_ICMPGE: begin
	      check_pcidx(0);
	      check_stack_int(0);
	      check_stack_int(1);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IF_ICMPGE %5d", idx[15:0]);
	      end
	      cbranch_int_ge(getmem((sp + 1)), getmem(sp), idx);
	      pop(2);
	    end
	    IF_ICMPGT: begin
	      check_pcidx(0);
	      check_stack_int(0);
	      check_stack_int(1);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IF_ICMPGT %5d", idx[15:0]);
	      end
	      cbranch_int_gt(getmem((sp + 1)), getmem(sp), idx);
	      pop(2);
	    end
	    IF_ICMPLE: begin
	      check_pcidx(0);
	      check_stack_int(0);
	      check_stack_int(1);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IF_ICMPLE %5d", idx[15:0]);
	      end
	      cbranch_int_le(getmem((sp + 1)), getmem(sp), idx);
	      pop(2);
	    end
	    IF_ACMPEQ: begin
	      check_pcidx(0);
	      check_stack_ref(0);
	      check_stack_ref(1);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IF_ACMPEQ %5d", idx[15:0]);
	      end
	      cbranch_int_eq(getmem((sp + 1)), getmem(sp), idx);
	      pop(2);
	    end
	    IF_ACMPNE: begin
	      check_pcidx(0);
	      check_stack_ref(0);
	      check_stack_ref(1);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IF_ACMPNE %5d", idx[15:0]);
	      end
	      cbranch_ref_ne(getmem((sp + 1)), getmem(sp), idx);
	      pop(2);
	    end
	    GOTO: begin
	      check_pcidx(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      idx[31:15] = (-idx[31:15]);
	      if (TRACE) begin
		$display("GOTO %5d", idx[15:0]);
	      end
	      npc = (pc + idx);
	    end
	    JSR: begin
	      check_pcidx(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      idx[31:15] = (-idx[31:15]);
	      if (TRACE) begin
		$display("JSR %5d", idx[15:0]);
	      end
	      push(1);
	      void = setmem(sp, npc);
	      npc = (pc + idx);
	    end
	    RET: begin
	      check_pc(0);
	      idx = getpc(0);
	      if (TRACE) begin
		$display("RET %5d", idx[15:0]);
	      end
	      check_local_ref(idx);
	      npc = getmem((local - idx));
	    end
	    TABLESWITCH: begin
	      if (TRACE) begin
		$display("TABLESWITCH");
	      end
	      check_stack_int(0);
	      npc = (((pc + 1) + 3) & (-4));
	      low = ((((getcode((npc + 4)) << 24) | (getcode((npc + 5)) << 16)) 
		      | (getcode((npc + 6)) << 8)) | getcode((npc + 7)));
	      high = ((((getcode((npc + 8)) << 24) | (getcode((npc + 9)) << 16))
		      | (getcode((npc + 10)) << 8)) | getcode((npc + 11)));
	      npc = (npc + 12);
	      if (getmem(sp) >= low) begin
		if (low != 0) begin
		  void = setmem(sp, sub_int_const(getmem(sp), low));
		end
		if (getmem(sp) >= (high - low)) begin
		  void = setmem(sp, (-3));
		end
		else begin
		  void = setmem(sp, (-3));
		end
	      end
	      void = setmem(sp, lshl_int_const(getmem(sp), casetable_shift));
	      move_label_const(tmp2, reference_table_label(9));
	      void = setmem(sp, add_ref(tmp2, getmem(sp)));
	      void = setmem(sp, load_code_ref(getmem(sp)));
	      npc = (pc + getmem((sp + 0)));
	      pop(1);
	    end
	    LOOKUPSWITCH: begin
	      check_stack_int(0);
	      npc = (((pc + 1) + 3) & (-4));
	      idx = ((((getcode((npc + 4)) << 24) | (getcode((npc + 5)) << 16)) 
		      | (getcode((npc + 6)) << 8)) | getcode((npc + 7)));
	      if (TRACE) begin
		$display("LOOKUPSWITCH %5d", idx);
	      end
	      move_label_const(tmp2, reference_table_label(7));
	      move_ref(tmp, tmp2);
	      add_ref_const(tmp, tmp, (idx * casepair_size));
	      skip = 0;
	      while (((!skip) && (tmp != tmp2))) begin
		load_key(mtable, tmp);
		skip = (mtable != getmem(sp));
		if (!skip) begin
		  add_ref_const(tmp, tmp, (-casepair_size));
		end
	      end
	      if (!skip) begin
		add_ref_const(tmp, tmp, (-casepair_addr));
	      end
	      add_ref_const(tmp, tmp, casepair_addr);
	      tmp = load_code_ref(tmp);
	      npc = (pc + tmp);
	      pop(1);
	    end
	    IRETURN: begin
	      if (TRACE) begin
		$display("IRETURN");
	      end
	      check_stack_int(0);
	      ret(1);
	    end
	    LRETURN: begin
	      if (TRACE) begin
		$display("LRETURN");
	      end
	      check_stack_long(0);
	      ret(2);
	    end
	    FRETURN: begin
	      if (TRACE) begin
		$display("FRETURN");
	      end
	      check_stack_float(0);
	      ret(1);
	    end
	    DRETURN: begin
	      if (TRACE) begin
		$display("DRETURN");
	      end
	      check_stack_double(0);
	      ret(2);
	    end
	    ARETURN: begin
	      if (TRACE) begin
		$display("ARETURN");
	      end
	      check_stack_ref(0);
	      ret(1);
	    end
	    RETURN: begin
	      if (TRACE) begin
		$display("RETURN");
	      end
	      ret(0);
	    end
	    GETSTATIC: begin
	      check_pcidx(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("GETSTATIC %5d", idx[15:0]);
	      end
	      get_static_field_info(idx);
	    end
	    PUTSTATIC: begin
	      check_pcidx(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("PUTSTATIC %5d", idx[15:0]);
	      end
	      put_static_field_info(idx);
	    end
	    GETFIELD: begin
	      check_pcidx(0);
	      check_stack_ref(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("GETFIELD %5d", idx[15:0]);
	      end
	      get_field_info(idx);
	    end
	    PUTFIELD: begin
	      check_pcidx(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("PUTFIELD %5d", idx[15:0]);
	      end
	      put_field_info(idx);
	    end
	    INVOKEVIRTUAL: begin
	      check_pcidx(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("INVOKEVIRTUAL %5d", idx[15:0]);
	      end
	      if (old_access_flags & ACCESS_Static) begin
		tmp = oldclass;
	      end
	      else
		begin
		  tmp = getmem(local);
		  tmp = getmem(tmp);
		end
	      if (TRACE > 1) begin
		$display("Invoking class %d", tmp);
	      end
	      tmp2 = getpool(oldclass, idx);
	      low = getmem((tmp2 + 5));
	      if (TRACE > 1) begin
		$display("Hash = %X", getmem((tmp2 + 3)));
		$display("Type = %s", dispstr(low, length(low)));
		$display("Class no = %d", getmem((tmp2 + 4)));
	      end
	      while ((getmem((tmp2 + 4)) != tmp)) begin
		tmp2 = getmem((tmp2 + 3));
		while ((tmp2 != 0)) begin
		  if (TRACE > 1) begin
		    $display("Class no = %d", getmem((tmp2 + 4)));
		  end
		  if ((getmem((tmp2 + 4)) == tmp) && (getmem((tmp2 + 5)) == low)
			  ) begin
		    if (TRACE > 1) begin
		      $display("Matched class %d", getmem((tmp2 + 4)));
		    end
		    call(tmp2, 1);
		    tmp2 = 0;
		    low = 0;
		  end
		  else begin
		    tmp2 = getmem(tmp2);
		  end
		end
		if (low) begin
		  tmp2 = getpool(oldclass, idx);
		  tmp = getpool(tmp, 0);
		  if (!tmp) begin
		    tmp = getmem((tmp2 + 4));
		  end
		end
	      end
	      if (low) begin
		call(tmp2, 1);
	      end
	    end
	    INVOKESPECIAL: begin
	      check_pcidx(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("INVOKESPECIAL %5d", idx[15:0]);
	      end
	      tmp2 = getpool(oldclass, idx);
	      call(tmp2, 1);
	    end
	    INVOKESTATIC: begin
	      check_pcidx(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("INVOKESTATIC %5d", idx[15:0]);
	      end
	      tmp2 = getpool(oldclass, idx);
	      call(tmp2, 0);
	    end
	    INVOKEINTERFACE: begin
	      check_pcidx(0);
	      check_pc(2);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("INVOKEINTERFACE %5d", idx[15:0]);
	      end
	      tmp = (getpc(2) - 1);
	      tmp2 = getpool(oldclass, idx);
	      call(tmp2, 1);
	    end
	    NEW: begin
	      check_pcidx(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("NEW %5d", idx[15:0]);
	      end
	      tmp = getpool(oldclass, idx);
	      push(1);
	      tmp2 = alloc(getmem((field_size + tmp)));
	      void = setmem(sp, tmp2);
	      if (TRACE) begin
		$display("New object of type %d (size %d words)", tmp, 
			getmem((field_size + tmp)));
	      end
	      void = setmem(tmp2, tmp);
	    end
	    NEWARRAY: begin
	      if (TRACE) begin
		$display("NEWARRAY");
	      end
	      check_pc(0);
	      check_stack_int(0);
	      low = getpc(0);
	      void = setmem(sp, softnewarray(getmem(sp), low));
	    end
	    ANEWARRAY: begin
	      check_pcidx(0);
	      check_stack_int(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("ANEWARRAY %5d", idx[15:0]);
	      end
	      get_class_info(idx);
	      void = setmem(sp, softnewarray(getmem(sp), 0));
	    end
	    ARRAYLENGTH: begin
	      check_stack_array(0);
	      void = setmem(sp, getmem(getmem(sp)));
	      if (TRACE) begin
		$display("ARRAYLENGTH %5d units", getmem(sp));
	      end
	    end
	    ATHROW: begin
	      if (TRACE) begin
		$display("ATHROW");
	      end
	      check_stack_ref(0);
	      softathrow(getmem(sp));
	    end
	    CHECKCAST: begin
	      check_pcidx(0);
	      check_stack_ref(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("CHECKCAST %5d", idx[15:0]);
	      end
	      get_class_info(idx);
	      tmp = getmem(sp);
	      if (tmp) begin
		if (getmem(tmp) !== getpool(oldclass, idx)) begin
		  $display("Check cast failure");
		  $finish;
		end
	      end
	    end
	    INSTANCEOF: begin
	      check_pcidx(0);
	      check_stack_ref(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("INSTANCEOF %5d", idx[15:0]);
	      end
	      get_class_info(idx);
	      softinstanceof(getmem(sp), getmem(sp));
	    end
	    MONITORENTER: begin
	      if (TRACE) begin
		$display("MONITORENTER");
	      end
	      check_stack_ref(0);
	      softmonitorenter(getmem(sp));
	      pop(1);
	    end
	    MONITOREXIT: begin
	      if (TRACE) begin
		$display("MONITOREXIT");
	      end
	      check_stack_ref(0);
	      softmonitorexit(getmem(sp));
	      pop(1);
	    end
	    WIDE: begin
	      if (TRACE) begin
		$display("WIDE");
	      end
	      if (wide) begin
		breakpoint(0);
	      end
	      wide = 1;
	    end
	    MULTIANEWARRAY: begin
	      check_pcidx(0);
	      check_pc(2);
	      idx = ((getpc(0) << 8) | getpc(1));
	      low = getpc(2);
	      if (TRACE) begin
		$display("MULTIANEWARRAY %5d,%5d", idx, low);
	      end
	      for (high = 0; (high < low); high = (high + 1)) begin
		check_stack_int(high);
	      end
	      get_class_info(idx);
	      softmultianewarray(getmem(((sp + low) - 1)), low, getmem(sp));
	      pop((low - 1));
	    end
	    IFNULL: begin
	      check_pcidx(0);
	      check_stack_ref(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IFNULL %5d", idx[15:0]);
	      end
	      cbranch_ref_const_eq(getmem(sp), 0, idx);
	      pop(1);
	    end
	    IFNONNULL: begin
	      check_pcidx(0);
	      check_stack_ref(0);
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("IFNONNULL %5d", idx[15:0]);
	      end
	      cbranch_ref_const_ne(getmem(sp), 0, idx);
	      pop(1);
	    end
	    GOTO_W: begin
	      check_pcwidx(0);
	      idx = ((((getpc(0) << 24) | (getpc(1) << 16)) | (getpc(2) << 8)) |
		      getpc(3));
	      if (TRACE) begin
		$display("GOTO_W %5d", idx);
	      end
	      npc = (pc + idx);
	    end
	    JSR_W: begin
	      check_pcwidx(0);
	      idx = ((((getpc(0) << 24) | (getpc(1) << 16)) | (getpc(2) << 8)) |
		      getpc(3));
	      if (TRACE) begin
		$display("JSR_W %5d", idx);
	      end
	      push(1);
	      void = setmem(sp, npc);
	      npc = (pc + idx);
	    end
	    BREAKPOINT: begin
	      if (TRACE) begin
		$display("BREAKPOINT");
	      end
	      breakpoint(0);
	    end
	    CHECKCAST_FAST: begin
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("CHECKCAST_FAST %5d", idx[15:0]);
	      end
	    end
	    INSTANCEOF_FAST: begin
	      idx = ((getpc(0) << 8) | getpc(1));
	      if (TRACE) begin
		$display("INSTANCEOF_FAST %5d", idx[15:0]);
	      end
	    end
	    default: begin
	      $display("Illegal instruction");
	      $finish;
	    end
	  endcase
	  if (wide && (getcode(pc) != WIDE)) begin
	    $display("Error: wide preceeded a non-wide instruction");
	    $finish;
	  end
	end
	endtask

	function needed;

	input reg
		[31:0]		class;
	begin
	  needed = (getmem((field_size + class)) != 0);
	end
	endfunction

	function loaded;

	input reg
		[31:0]		class;
	begin
	  loaded = (getmem((const_idx + class)) != 0);
	end
	endfunction

	function equalstr;

	input reg
		[31:0]		fp;
	input reg
		[15:0]		len;
	input reg
		[31:0]		filep;
	input reg
		[15:0]		len2;

	reg	[8:1]		cd;
	reg	[8:1]		cd1;
	reg	[8:1]		cd2;
	integer			i;
	begin
	  i = 0;
	  cd = (len == len2);
	  while (((i < len) && cd)) begin
	    cd1 = getcode((fp + i));
	    cd2 = getcode((filep + i));
	    if (cd1 !== cd2) begin
	      cd = 0;
	    end
	    i = (i + 1);
	  end
	  equalstr = cd;
	end
	endfunction

	function [31:0] getcode;

	input reg
		[31:0]		offset;
	begin
	  code_reads = (code_reads + 1);
	  getcode = code[offset];
	end
	endfunction

	function setcode;

	input reg
		[31:0]		offset;
	input reg
		[7:0]		data;
	begin
	  code_writes = (code_writes + 1);
	  code[offset] = data;
	end
	endfunction

	function [31:0] getmem;

	input reg
		[31:0]		addr;
	begin
	  if ((^addr) === 'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx) begin
	    $display("Fatal: addr in getmem was X");
	    $finish;
	  end
	  if (((addr < hash_size) || ((addr > brk) && (addr < sp))) || (addr > (
		  1 << mem_width))) begin
	    $display("Attempt to read unallocated memory at addr %X", addr);
	    getmem = 'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
	  end
	  else
	    begin
	      mem_reads = (mem_reads + 1);
	      getmem = mem[addr];
	    end
	end
	endfunction

	function setmem;

	input reg
		[31:0]		addr;
	input reg
		[31:0]		data;
	begin
	  if ((^addr) === 'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx) begin
	    $display("Fatal: addr in setmem was X");
	    $finish;
	  end
	  if (((addr < hash_size) || ((addr > brk) && (addr < sp))) || (addr > (
		  1 << mem_width))) begin
	    $display("Attempt to write to unallocated memory at addr %X", addr);
	    $finish;
	  end
	  else
	    begin
	      if (data && (TRACE > 1)) begin
		$display("mem[%X] <= %X", addr, data);
	      end
	      mem_writes = (mem_writes + 1);
	      mem[addr] = data;
	    end
	end
	endfunction

	function setmem_long;

	input reg
		[31:0]		addr;
	input reg
		[63:0]		data;
	begin
	  setmem_long = setmem(addr, data[63:32]);
	  setmem_long = setmem((addr + 1), data[31:0]);
	end
	endfunction

	function [63:0] getmem_long;

	input reg
		[31:0]		addr;
	begin
	  getmem_long[63:32] = getmem(addr);
	  getmem_long[31:0] = getmem((addr + 1));
	end
	endfunction

	function [31:0] findstr;

	input reg
		[(8 * 80):1]	d;

	reg	[8:1]		cd;
	reg	[15:0]		j;
	integer			i;
	begin
	  i = 0;
	  j = 0;
	  while ((i < 80)) begin
	    cd = d[(8 * 40):((8 * 39) + 1)];
	    d = (d << 8);
	    if (cd) begin
	      void = setcode(((zipf_size + 2) + j), cd);
	      j = (j + 1);
	    end
	    i = (i + 1);
	  end
	  void = setcode(zipf_size, j[15:8]);
	  void = setcode((zipf_size + 1), j[7:0]);
	  findstr = hashstr((zipf_size + 2), j, 0);
	end
	endfunction

	function [(mem_width - 1):0] alloc;

	input reg
		[31:0]		siz;
	begin
	  if ((^siz) === 'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx) begin
	    $display("Fatal: attempt to allocate block of unknown size");
	    $finish;
	  end
	  if (TRACE) begin
	    $display("Allocating %d bytes at address %X", siz, brk);
	  end
	  alloc = brk;
	  while ((siz > 0)) begin
	    if (brk == sp) begin
	      $display("Memory overflow");
	      $finish;
	    end
	    void = setmem(brk, 0);
	    brk = (brk + 1);
	    siz = (siz - 1);
	  end
	end
	endfunction

	function [63:0] hashstr;

	input reg
		[31:0]		fp;
	input reg
		[15:0]		len;
	input reg
		[31:0]		user;

	reg			done;
	reg	[31:0]		i;
	reg	[31:0]		addr;
	reg	[15:0]		hash;
	reg	[63:0]		tmpl;
	begin
	  if (user && (TRACE > 1)) begin
	    $display("Hashed a user value %X (%s)", user, dispstr(fp, len));
	  end
	  hashstr[31:0] = ((fp < zipf_size) ? fp : 0);
	  hashstr[63:32] = user;
	  hash = 0;
	  for (i = 0; (i < len); i = (i + 1)) begin
	    hash = (((hash << 5) ^ hash[15:10]) ^ getcode((fp + i)));
	  end
	  hash = (hash[14:0] << 1);
	  hash_size = 0;
	  tmpl = getmem_long(hash);
	  if (tmpl == 0) begin
	    void = setmem_long(hash, hashstr);
	    hash_size = (1 << 16);
	    if ((user == 0) && hashstr) begin
	      $display("Hashed a zero user value (%s)", dispstr(fp, len));
	    end
	  end
	  else if (tmpl[31] == 0) begin
	    hash_size = (1 << 16);
	    if (!equalstr(fp, len, tmpl[31:0], length(tmpl[31:0]))) begin
	      addr = alloc(256);
	      void = setmem_long(addr, tmpl);
	      void = setmem_long((addr + 2), hashstr);
	      if ((user == 0) && hashstr) begin
		$display("Hashed a zero user value (%s)", dispstr(fp, len));
	      end
	      hash_size = 0;
	      void = setmem_long(hash, (~addr));
	      hash_size = (1 << 16);
	    end
	    else
	      begin
		hashstr = tmpl;
	      end
	  end
	  else
	    begin
	      hash_size = (1 << 16);
	      i = (~tmpl[31:0]);
	      addr = (256 + i);
	      done = 0;
	      while (((i < addr) && (!done))) begin
		tmpl = getmem_long(i);
		if (tmpl) begin
		  if (equalstr(fp, len, tmpl[31:0], length(tmpl[31:0]))) begin
		    done = 1;
		    hashstr = tmpl;
		  end
		end
		else
		  begin
		    void = setmem_long(i, hashstr);
		    if ((user == 0) && hashstr) begin
		      $display("Hashed a zero user value (%s)", dispstr(fp, len)
			      );
		    end
		    done = 1;
		  end
		i = (i + 2);
	      end
	      if (!done) begin
		$display("Hash table full");
		$finish;
	      end
	    end
	  if ((TRACE > 1) && (!user)) begin
	    $display("Returned a hash value %X (%s)", hashstr[63:32], 
		    dispstr(fp, len));
	  end
	end
	endfunction

	function [(8 * 80):1] dispstr;

	input reg
		[31:0]		fp;
	input reg
		[15:0]		len;

	reg	[(8 * 80):1]	d;
	integer			i;
	begin
	  i = 0;
	  while ((i < 79)) begin
	    d[8:1] = ((i < len) ? getcode((fp + i)) : 0);
	    d = (d << 8);
	    i = (i + 1);
	  end
	  dispstr = d;
	end
	endfunction

	function [15:0] length;

	input reg
		[31:0]		fp;
	begin
	  length[15:8] = getcode((fp - 2));
	  length[7:0] = getcode((fp - 1));
	end
	endfunction

	function [31:0] getpool;

	input reg
		[15:0]		class;
	input reg
		[15:0]		idx;
	begin
	  getpool = getmem((getmem((const_idx + class)) + idx));
	end
	endfunction

	function [15:0] makeword;

	input reg
		[31:0]		idx;

	reg	[15:0]		word;
	begin
	  word[7:0] = getcode(idx);
	  word[15:8] = getcode((idx + 1));
	  makeword = word;
	end
	endfunction

	function [31:0] makelong;

	input reg
		[31:0]		idx;

	reg	[31:0]		long;
	begin
	  long[7:0] = getcode(idx);
	  long[15:8] = getcode((idx + 1));
	  long[23:16] = getcode((idx + 2));
	  long[31:24] = getcode((idx + 3));
	  makelong = long;
	end
	endfunction

	function [15:0] find_class_file;

	input reg
		[31:0]		offset;

	reg	[63:0]		cd;
	begin
	  find_class_file = (-1);
	  cd = hashstr(offset, length(offset), 0);
	  if (getmem((filename + cd[63:32])) == cd[31:0]) begin
	    find_class_file = cd[63:32];
	  end
	end
	endfunction

	function [31:0] load_code_ref;

	input reg
		[31:0]		arg2;
	begin
	  load_code_ref = arg2;
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [31:0] softnewarray;

	input reg
		[31:0]		size;
	input reg
		[31:0]		type;

	reg	[31:0]		unit;
	reg	[31:0]		new;
	begin
	  case (type)
	    4:
	      unit = 1;
	    5:
	      unit = 1;
	    6:
	      unit = 1;
	    7:
	      unit = 2;
	    8:
	      unit = 1;
	    9:
	      unit = 1;
	    10:
	      unit = 1;
	    11:
	      unit = 2;
	    default:
	      unit = 1;
	  endcase
	  new = alloc(((size * unit) + 1));
	  if (TRACE > 1) begin
	    $display("Creating array width %d size %d addr = %X", unit, size, 
		    new);
	  end
	  void = setmem(new, size);
	  softnewarray = new;
	end
	endfunction

	function [31:0] sub_int_const;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  sub_int_const = (arg2 - arg3);
	end
	endfunction

	function [63:0] add_double;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [31:0] add_float;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [31:0] add_int;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  add_int = (arg2 + arg3);
	end
	endfunction

	function [63:0] add_long;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;
	begin
	  add_long = (arg2 + arg3);
	end
	endfunction

	function [31:0] add_ref;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  add_ref = (arg2 + arg3);
	  if (TRACE > 1) begin
	    $display("%X <= %X + %X", add_ref, arg2, arg3);
	  end
	end
	endfunction

	function [31:0] and_int;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  and_int = (arg2 & arg3);
	  if (TRACE > 1) begin
	    $display("%X <= %X & %X", and_int, arg2, arg3);
	  end
	end
	endfunction

	function [63:0] and_long;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;
	begin
	  and_long = (arg2 & arg3);
	end
	endfunction

	function [31:0] ashr_int;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [63:0] ashr_long;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [31:0] cmpg_double;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;
	begin
	end
	endfunction

	function [31:0] cmpl_double;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;
	begin
	  $finish;
	end
	endfunction

	function [31:0] cmpg_float;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  cmpg_float = cmpg_double(cvt_float_double(arg2), 
		  cvt_float_double(arg3));
	end
	endfunction

	function [31:0] cmpl_float;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  cmpl_float = cmpl_double(cvt_float_double(arg2), 
		  cvt_float_double(arg3));
	end
	endfunction

	function [31:0] cvt_double_float;

	input reg
		[63:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [31:0] cvt_double_int;

	input reg
		[63:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [63:0] cvt_double_long;

	input reg
		[63:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [63:0] cvt_float_double;

	input reg
		[31:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [31:0] cvt_float_int;

	input reg
		[31:0]		arg2;
	begin
	  cvt_float_int = cvt_double_int(cvt_float_double(arg2));
	end
	endfunction

	function [63:0] cvt_float_long;

	input reg
		[31:0]		arg2;
	begin
	  cvt_float_long = cvt_double_long(cvt_float_double(arg2));
	end
	endfunction

	function [31:0] cvt_int_byte;

	input reg
		[31:0]		arg2;
	begin
	  cvt_int_byte = arg2[7:0];
	end
	endfunction

	function [31:0] cvt_int_char;

	input reg
		[31:0]		arg2;
	begin
	  cvt_int_char = arg2[15:0];
	end
	endfunction

	function [63:0] cvt_int_double;

	input reg
		[31:0]		arg2;
	begin
	  $finish;
	end
	endfunction

	function [31:0] cvt_int_float;

	input reg
		[31:0]		arg2;
	begin
	  cvt_int_float = cvt_double_float(cvt_int_double(arg2));
	end
	endfunction

	function [63:0] cvt_int_long;

	input reg
		[31:0]		arg2;
	begin
	  cvt_int_long = arg2;
	  cvt_int_long[63:31] = (-cvt_int_long[63:31]);
	end
	endfunction

	function [31:0] cvt_int_short;

	input reg
		[31:0]		arg2;
	begin
	  cvt_int_short = arg2[15:0];
	end
	endfunction

	function [63:0] cvt_long_double;

	input reg
		[63:0]		arg2;
	begin
	  $finish;
	end
	endfunction

	function [31:0] cvt_long_float;

	input reg
		[63:0]		arg2;
	begin
	  cvt_long_float = cvt_double_float(cvt_long_double(arg2));
	end
	endfunction

	function [31:0] cvt_long_int;

	input reg
		[63:0]		arg2;
	begin
	  cvt_long_int = arg2[31:0];
	end
	endfunction

	function [63:0] div_double;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;
	begin
	  $finish;
	end
	endfunction

	function [31:0] div_float;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [31:0] div_int;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			x;
	integer			y;
	integer			z;
	begin
	  x = arg2;
	  y = arg3;
	  z = (arg2 / arg3);
	  div_int = z;
	end
	endfunction

	function [63:0] div_long;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;

	integer			x;
	integer			y;
	integer			z;
	begin
	  x = arg2;
	  y = arg3;
	  z = (arg2 / arg3);
	  div_long = z;
	end
	endfunction

	function [31:0] lcmp;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;

	reg	[63:0]		cmp;
	begin
	  cmp = (arg2 - arg3);
	  if (cmp == 0) begin
	    lcmp = 0;
	  end
	  else if (cmp[63] == 1) begin
	    lcmp = (-1);
	  end
	  else begin
	    lcmp = 1;
	  end
	end
	endfunction

	function [31:0] load_byte;

	input reg
		[31:0]		arg2;
	begin
	  load_byte = getmem(arg2);
	  load_byte[31:8] = 0;
	  load_byte[31:7] = (-load_byte[31:7]);
	end
	endfunction

	function [31:0] load_char;

	input reg
		[31:0]		arg2;
	begin
	  load_char = getmem(arg2);
	  load_char[31:16] = 0;
	  load_char[31:15] = (-load_char[31:15]);
	end
	endfunction

	function [63:0] load_double;

	input reg
		[31:0]		arg2;
	begin
	  load_double[63:32] = getmem(arg2);
	  load_double[31:0] = getmem((arg2 + 1));
	end
	endfunction

	function [31:0] load_float;

	input reg
		[31:0]		arg2;
	begin
	  load_float = getmem(arg2);
	  if (TRACE > 1) begin
	    $display("%X <= %X", load_float, arg2);
	  end
	end
	endfunction

	function [63:0] load_long;

	input reg
		[31:0]		arg2;
	begin
	  load_long[63:32] = getmem(arg2);
	  load_long[31:0] = getmem((arg2 + 1));
	end
	endfunction

	function [31:0] load_offset_int;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  load_offset_int = getmem((arg2 + arg3));
	end
	endfunction

	function [31:0] load_offset_ref;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  load_offset_ref = getmem((arg2 + arg3));
	end
	endfunction

	function [31:0] load_short;

	input reg
		[31:0]		arg2;
	begin
	  load_short = getmem(arg2);
	  load_short[31:16] = 0;
	  load_short[31:15] = (-load_short[31:15]);
	end
	endfunction

	function [31:0] lshl_int;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  lshl_int = (arg2 << arg3);
	  if (TRACE > 1) begin
	    $display("%X <= %X << %X", lshl_int, arg2, arg3);
	  end
	end
	endfunction

	function [31:0] lshl_int_const;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  lshl_int_const = (arg2 << arg3);
	end
	endfunction

	function [63:0] lshl_long;

	input reg
		[63:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  lshl_long = (arg2 << arg3);
	  if (TRACE > 1) begin
	    $display("%X <= %X << %X", lshl_long, arg2, arg3);
	  end
	end
	endfunction

	function [31:0] lshr_int;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  lshr_int = (arg2 >> arg3);
	end
	endfunction

	function [63:0] lshr_long;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;
	begin
	  lshr_long = (arg2 >> arg3);
	end
	endfunction

	function [63:0] mul_double;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;
	begin
	  $finish;
	end
	endfunction

	function [31:0] mul_float;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [31:0] mul_int;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  mul_int = (arg2 * arg3);
	end
	endfunction

	function [63:0] mul_long;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;
	begin
	  mul_long = (arg2 * arg3);
	end
	endfunction

	function [63:0] neg_double;

	input reg
		[63:0]		arg2;
	begin
	  $finish;
	end
	endfunction

	function [31:0] neg_float;

	input reg
		[31:0]		arg2;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [31:0] neg_int;

	input reg
		[31:0]		arg2;
	begin
	  neg_int = (-arg2);
	end
	endfunction

	function [63:0] neg_long;

	input reg
		[63:0]		arg2;
	begin
	  neg_long = (-arg2);
	end
	endfunction

	function [31:0] or_int;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  or_int = (arg2 | arg3);
	end
	endfunction

	function [63:0] or_long;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;
	begin
	  or_long = (arg2 | arg3);
	end
	endfunction

	function [63:0] rem_double;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;
	begin
	  $finish;
	end
	endfunction

	function [31:0] rem_float;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [31:0] rem_int;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;

	integer			x;
	integer			y;
	integer			z;
	begin
	  x = arg2;
	  y = arg3;
	  z = (x - ((x / y) * y));
	  if (z < 0) begin
	    z = (z + x);
	  end
	  rem_int = z;
	end
	endfunction

	function [63:0] rem_long;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;

	integer			x;
	integer			y;
	integer			z;
	begin
	  x = arg2;
	  y = arg3;
	  z = (x - ((x / y) * y));
	  if (z < 0) begin
	    z = (z + x);
	  end
	  rem_long = z;
	  $display("Incorrect instruction");
	  $finish;
	end
	endfunction

	function [63:0] sub_double;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [31:0] sub_float;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  $display("Unimplemented instruction");
	  $finish;
	end
	endfunction

	function [31:0] sub_int;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  sub_int = (arg2 - arg3);
	end
	endfunction

	function [63:0] sub_long;

	input reg
		[63:0]		arg2;
	input reg
		[63:0]		arg3;
	begin
	  sub_long = (arg2 - arg3);
	end
	endfunction

	function [31:0] xor_int;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  xor_int = (arg2 ^ arg3);
	end
	endfunction

	function [63:0] xor_long;

	input reg
		[31:0]		arg2;
	input reg
		[31:0]		arg3;
	begin
	  xor_long = (arg2 ^ arg3);
	end
	endfunction

	function method_method;

	input reg
		[31:0]		arg1;
	begin
	  method_method = cinfo_method;
	end
	endfunction

	function [31:0] field_class;

	input reg
		[31:0]		offset;
	begin
	  field_class = offset;
	end
	endfunction

	function [31:0] FIELD_OFFSET;

	input reg
		[31:0]		offset;
	begin
	  FIELD_OFFSET = offset;
	end
	endfunction

	function [31:0] FIELD_ISREF;

	input reg
		[31:0]		offset;
	begin
	  FIELD_ISREF = offset;
	end
	endfunction

	function [31:0] field_statics;

	input reg
		[31:0]		offset;
	begin
	  field_statics = offset;
	end
	endfunction

	function [31:0] field_data;

	input reg
		[31:0]		offset;
	begin
	  field_data = offset;
	end
	endfunction

	function [31:0] method_nargs;

	input reg
		[31:0]		offset;
	begin
	  method_nargs = offset;
	end
	endfunction

	function [31:0] method_idx;

	input reg
		[31:0]		offset;
	begin
	  method_idx = offset;
	end
	endfunction

	function [31:0] CLASS_PRIM_SIG;

	input reg
		[31:0]		offset;
	begin
	  CLASS_PRIM_SIG = offset;
	end
	endfunction

	function [31:0] FIELD_TYPE;

	input reg
		[31:0]		offset;
	begin
	  FIELD_TYPE = offset;
	end
	endfunction

	function [31:0] method_returntype;

	input reg
		[31:0]		offset;
	begin
	  method_returntype = offset;
	end
	endfunction

	function [31:0] field_class_state;

	input reg
		[31:0]		offset;
	begin
	  field_class_state = offset;
	end
	endfunction

	function [31:0] table_code_label;

	input reg
		[31:0]		offset;
	begin
	  table_code_label = offset;
	end
	endfunction

	function [31:0] reference_table_label;

	input reg
		[31:0]		offset;
	begin
	  reference_table_label = offset;
	end
	endfunction

	function [31:0] stored_code_label;

	input reg
		[31:0]		offset;
	begin
	  stored_code_label = offset;
	end
	endfunction

	function [31:0] getpc;

	input reg
		[31:0]		n;

	reg	[31:0]		nxt;
	begin
	  nxt = ((pc + 1) + n);
	  getpc = getcode(nxt);
	  npc = (nxt + 1);
	end
	endfunction

	initial begin
	  TRACE = 0;
	  DEBUG = 0;
	  sp = (1 << mem_width);
	  mem_writes = 0;
	  mem_reads = 0;
	  brk = 0;
	  hash_size = 0;
	  void = alloc((1 << 16));
	  hash_size = (1 << 16);
	  classfile_count = 0;
	  $readmemh("hello.mem", code);
	  zipf_size = 0;
	  while ((getcode(zipf_size) !== 8'bxxxxxxxx))
	    zipf_size = (zipf_size + 1);
	  $display("Read %d bytes from zip file", zipf_size);
	  code_writes = zipf_size;
	  code_reads = 0;
	  tot_class = 0;
	  class_main = 0;
	  void = findstr("main");
	  check_zip_file;
	  statistics;
	  if (class_main == 0) begin
	    $display("No toplevel class containing main() found");
	    $finish;
	  end
	  class_string = find_class_file(findstr("java/lang/String"));
	  class_object = find_class_file(findstr("java/lang/Object"));
	  void = setmem((field_size + class_string), 1);
	  void = setmem((field_size + class_object), 1);
	  void = setmem((field_size + class_main), 1);
	  looping = 1;
	  while (looping) begin
	    looping = 0;
	    for (i = 1; (i <= tot_class); i = (i + 1)) begin
	      if (needed(i) && (!loaded(i))) begin
		understand_class_file(i);
		classfile_count = (classfile_count + 1);
		looping = 1;
	      end
	    end
	  end
	  $display("Read %d class files", classfile_count);
	  statistics;
	  size_class_files;
	  find_init = findstr("<init>");
	  bool_int_int_int_void = findstr("([BIII)V");
	  link_class_file(class_string);
	  for (i = 1; (i <= tot_class); i = (i + 1))
	    if (needed(i)) begin
	      if (i != class_string) begin
		link_class_file(i);
	      end
	    end
	  java_io_fileoutputstream = findstr("java/io/FileOutputStream");
	  java_io_open = findstr("open");
	  java_io_close = findstr("close");
	  java_io_write = findstr("write");
	  $display("Class records = %d words", (brk - hash_size));
	  statistics;
	  static_init;
	  statistics;
	  call_main;
	  $display("Final memory usage = %d words", (brk - hash_size));
	  statistics;
	end
endmodule
