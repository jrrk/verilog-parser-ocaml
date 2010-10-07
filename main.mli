val vparser : string array -> unit
val dump_sym : string -> string -> unit
val dump_all_syms : (string, Setup.symtab) Hashtbl.t -> unit
val dump_text : out_channel -> string -> unit
val my_syms : string -> unit
