(*val show_set : TokSet.t -> unit*)
val show_token : Vparser.token -> unit
val show_sym : string -> Setup.symtab -> unit
val maxwidth : Setup.fmt -> string -> (string, Setup.symtab) Hashtbl.t -> Vparser.token -> int
val exprConst : Setup.fmt -> string -> (string, Setup.symtab) Hashtbl.t -> Vparser.token -> int
val iwidth :
  Setup.fmt ->
  string -> (string, Setup.symtab) Hashtbl.t -> Vparser.token -> int * int
val maxwidth :
  Setup.fmt ->
  string -> (string, Setup.symtab) Hashtbl.t -> Vparser.token -> int
val widthnum : int -> string -> int*int
val dump_sym : string -> string -> unit
val dump_syms : string -> unit
val my_syms : string -> unit
