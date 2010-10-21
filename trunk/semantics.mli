
type exprtree = {
  entry : Vparser.token;
  symbol : Setup.symtab;
}

type exprt =
    DYADIC of (Vparser.token * exprtree * exprtree)
  | ASSIGNS of (exprtree * exprt)
  | UNHANDLED of Vparser.token

   val enter_a_sym : Setup.fmt -> string -> (string, Setup.symtab) Hashtbl.t -> string -> Vparser.token -> Vparser.token -> unit
(*   val iter_ :
  (string -> Globals.modtree -> unit) -> string ->
  (string, Setup.symtab) Hashtbl.t -> Vparser.token list -> unit *)
(*   val moditer : string -> Globals.modtree -> unit  *)
   val find_ident : Setup.fmt -> Vparser.token -> string -> (string, Setup.symtab) Hashtbl.t -> Vparser.token -> Setup.symtab
val not_found : Setup.fmt -> string -> (string, Setup.symtab) Hashtbl.t -> string -> unit
val connect : Setup.fmt ->
  string ->
  (string, Setup.symtab) Hashtbl.t ->
  string -> string -> Vparser.token -> Vparser.token -> unit
val fiter : Setup.fmt ->
  string ->
  (string, Setup.symtab) Hashtbl.t ->
  string -> string -> Vparser.token -> Vparser.token -> unit
(*
val find_glob : (string, Setup.symtab) Hashtbl.t -> string -> unit
val find_glob_substr : (string, 'a) Hashtbl.t -> string -> unit
val find_referrer : (string, Setup.symtab) Hashtbl.t -> string -> unit
*)
val enter_sym_attrs : Setup.fmt -> string -> (string, Setup.symtab) Hashtbl.t ->
  Vparser.token -> Setup.TokSet.elt list -> Vparser.token -> bool -> unit
val check_syms : Setup.fmt -> (string, Setup.symtab) Hashtbl.t -> unit
(*val prescan : Vparser.token -> Vparser.token*)
val endscan : unit -> unit
val subexp :
  Setup.fmt ->
  Setup.TokSet.elt ->
  string ->
  (string, Setup.symtab) Hashtbl.t -> Vparser.token -> unit
val enter_parameter :
  Setup.fmt ->
  string ->
  (string, Setup.symtab) Hashtbl.t ->
  string -> Vparser.token -> Vparser.token -> Vparser.token -> unit
val create_attr :
  Setup.fmt ->
  string ->
  (string, Setup.symtab) Hashtbl.t -> Vparser.token -> Setup.tsigattr
val stmtBlock : Setup.fmt ->
           string ->
           (string, Setup.symtab) Hashtbl.t -> Setup.TokSet.elt -> unit
val for_stmt : Setup.fmt ->
           string ->
           (string, Setup.symtab) Hashtbl.t ->
           string ->
           Vparser.token ->
           Vparser.token -> Vparser.token -> Setup.TokSet.elt -> unit
val shash_create : int -> (string, Setup.symtab) Hashtbl.t 
val shash_find : (string, Setup.symtab) Hashtbl.t -> string -> Setup.symtab
val shash_iter : (string -> Setup.symtab -> unit) -> (string, Setup.symtab) Hashtbl.t -> unit 
val shash_mem : (string, Setup.symtab) Hashtbl.t -> string -> bool 
val shash_remove : (string, Setup.symtab) Hashtbl.t -> string -> unit 
val shash_replace : (string, Setup.symtab) Hashtbl.t -> string -> Setup.symtab -> unit 

val enter_a_sig_attr :
  Setup.fmt ->
  string ->
  (string, Setup.symtab) Hashtbl.t ->
  Vparser.token -> Setup.TokSet.elt -> Vparser.token -> unit

val read_pragma : string -> string -> string -> unit
val moditemlist : Setup.fmt -> string -> Globals.modtree -> unit
val scan : Setup.fmt -> string -> Globals.modtree -> unit
val remove_from_pending : Setup.fmt -> string -> unit
val prescan : Setup.fmt -> Vparser.token -> unit
