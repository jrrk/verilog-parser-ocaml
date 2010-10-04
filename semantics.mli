
type exprtree = {
  entry : Vparser.token;
  symbol : Setup.symtab;
}

type exprt =
    DYADIC of (Vparser.token * exprtree * exprtree)
  | ASSIGNS of (exprtree * exprt)
  | UNHANDLED of Vparser.token

val stmts : exprt list ref

   val semantics : out_channel -> (string, Setup.symtab) Hashtbl.t -> string -> Globals.modtree -> unit
   val enter_a_sym : (string, Setup.symtab) Hashtbl.t -> string -> Vparser.token -> Vparser.token -> string -> unit
(*   val iter_ :
  (string -> Globals.modtree -> unit) -> string ->
  (string, Setup.symtab) Hashtbl.t -> Vparser.token list -> unit *)
(*   val moditer : string -> Globals.modtree -> unit  *)
   val find_ident : out_channel -> (string, Setup.symtab) Hashtbl.t -> Vparser.token -> string -> (string, Setup.symtab) Hashtbl.t -> Vparser.token -> Setup.symtab
val check_glob : out_channel -> (string, Setup.symtab) Hashtbl.t -> unit
val not_found : (string, Setup.symtab) Hashtbl.t -> string -> unit
val widthnum : int -> string -> int*int
val connect : out_channel ->
  (string, Setup.symtab) Hashtbl.t ->
  string ->
  (string, Setup.symtab) Hashtbl.t ->
  string -> string -> Vparser.token -> Vparser.token -> unit
val fiter : out_channel ->
  (string, Setup.symtab) Hashtbl.t ->
  string ->
  (string, Setup.symtab) Hashtbl.t ->
  string -> string -> Vparser.token -> Vparser.token -> unit
val find_glob : (string, Setup.symtab) Hashtbl.t -> string -> unit
val find_glob_substr : (string, 'a) Hashtbl.t -> string -> unit
val find_referrer : (string, Setup.symtab) Hashtbl.t -> string -> unit
