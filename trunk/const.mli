(*val show_set : TokSet.t -> unit*)
val show_token : Vparser.token -> unit
val show_sym : string -> Setup.symtab -> unit
val maxwidth : Setup.fmt -> string -> Setup.shash -> Vparser.token -> int
val exprBoolean :
  Setup.fmt ->
  Setup.shash ->
  (int -> int -> bool) -> Vparser.token -> Vparser.token -> bool
val exprConst : Setup.fmt -> Setup.shash -> Vparser.token -> int
val iwidth :
  Setup.fmt -> Setup.shash -> Vparser.token -> int * int
val maxwidth :
  Setup.fmt -> Setup.shash -> Vparser.token -> int
val widthnum : int -> string -> int*int
val dump_sym : string -> string -> unit
val dump_syms : string -> unit
val my_syms : string -> unit
val shash_chain_mem : Setup.shash -> string -> bool
val shash_chain_find : Setup.shash -> string -> Setup.symtab
