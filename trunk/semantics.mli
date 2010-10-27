
type exprtree = {
  entry : Vparser.token;
  symbol : Setup.symtab;
}

type exprt =
    DYADIC of (Vparser.token * exprtree * exprtree)
  | ASSIGNS of (exprtree * exprt)
  | UNHANDLED of Vparser.token

type declmode = Create | SizeOnly | AttrOnly

val enter_a_sym : Setup.fmt -> Setup.shash -> string -> Vparser.token -> Vparser.token -> declmode -> unit
val find_ident : Setup.fmt -> Vparser.token -> Setup.shash -> Vparser.token -> Setup.symtab
val not_found : Setup.fmt -> Setup.shash -> string -> unit
val connect : Setup.fmt -> Setup.shash -> string -> string -> Vparser.token -> Vparser.token -> unit
val fiter : Setup.fmt -> Setup.shash -> string -> string -> Vparser.token -> Vparser.token -> unit
val enter_sym_attrs : Setup.fmt -> Setup.shash -> Vparser.token -> Setup.TokSet.elt list -> Vparser.token -> declmode -> unit
val check_syms : Setup.fmt -> string -> Setup.shash -> unit
val endscan : unit -> unit
val subexp : Setup.fmt -> Setup.TokSet.elt -> Setup.shash -> Vparser.token -> unit
val enter_parameter : Setup.fmt -> Setup.shash -> string -> Vparser.token -> Vparser.token -> Vparser.token -> unit
val create_attr : Setup.fmt -> Setup.shash -> Vparser.token -> Setup.tsigattr
val stmtBlock : Setup.fmt -> Setup.shash -> Setup.TokSet.elt -> unit
val for_stmt : Setup.fmt -> Setup.shash -> string -> Vparser.token -> Vparser.token -> Vparser.token -> Setup.TokSet.elt -> unit
val shash_create : Setup.shash -> int -> Setup.shash 
val shash_iter : (string -> Setup.symtab -> unit) -> Setup.shash -> unit 
val shash_remove : Setup.shash -> string -> unit 
val shash_replace : Setup.shash -> string -> Setup.symtab -> unit 
val enter_a_sig_attr : Setup.fmt -> Setup.shash -> Vparser.token -> Setup.TokSet.elt -> Vparser.token -> Setup.symtab -> unit
val sig_attr_extract : Setup.fmt -> Setup.shash -> Setup.symtab -> int * int * Setup.tset array
val moditemlist : Setup.fmt -> Globals.modtree -> unit
val scan : Setup.fmt -> string -> Globals.modtree -> unit
val remove_from_pending : Setup.fmt -> string -> unit
val prescan : Setup.fmt -> Vparser.token -> unit
val chk_inner_attr : Setup.fmt -> Setup.symtab -> Setup.TokSet.t array -> Vparser.token -> int -> bool
val enter_range :
  Setup.fmt ->
  Setup.shash ->
  string ->
  Setup.symtab ->
  Setup.TokSet.elt ->
  Vparser.token ->
  Setup.symtab ->
  int -> int -> Setup.TokSet.t array -> Setup.TokSet.t array -> unit
