val vparser : (string, Setup.TokSet.t) Hashtbl.t -> string array -> unit
val dump_sym : string -> string -> unit
val dump_gsyms : (string, Setup.TokSet.t) Hashtbl.t -> unit
val dump_gsym : ('a, Setup.TokSet.t) Hashtbl.t -> 'a -> unit
val dump_text : string -> unit
val my_syms : string -> unit
