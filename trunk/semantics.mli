
type exprtree = {
  entry : Vparser.token;
  symbol : Setup.symtab;
}

type exprt =
    DYADIC of (Vparser.token * exprtree * exprtree)
  | ASSIGNS of (exprtree * exprt)
  | UNHANDLED of Vparser.token

type uptr = UPTR of (out_channel -> Vparser.token -> unit) | UNIL
   val unhand_list : Vparser.token list ref
   val unhandled_dflt : out_channel -> Vparser.token -> unit
   val unhandled_ptr : uptr ref
   val unhandled : out_channel -> Vparser.token -> unit

val stk : Vparser.token Stack.t

   val semantics : out_channel -> string -> Globals.modtree -> unit
   val enter_a_sym : out_channel -> (string, Setup.symtab) Hashtbl.t -> string -> Vparser.token -> Vparser.token -> unit
(*   val iter_ :
  (string -> Globals.modtree -> unit) -> string ->
  (string, Setup.symtab) Hashtbl.t -> Vparser.token list -> unit *)
(*   val moditer : string -> Globals.modtree -> unit  *)
   val find_ident : out_channel -> Vparser.token -> string -> (string, Setup.symtab) Hashtbl.t -> Vparser.token -> Setup.symtab
val not_found : out_channel -> (string, Setup.symtab) Hashtbl.t -> string -> unit
val widthnum : int -> string -> int*int
val connect : out_channel ->
  string ->
  (string, Setup.symtab) Hashtbl.t ->
  string -> string -> Vparser.token -> Vparser.token -> unit
val fiter : out_channel ->
  string ->
  (string, Setup.symtab) Hashtbl.t ->
  string -> string -> Vparser.token -> Vparser.token -> unit
(*
val find_glob : (string, Setup.symtab) Hashtbl.t -> string -> unit
val find_glob_substr : (string, 'a) Hashtbl.t -> string -> unit
val find_referrer : (string, Setup.symtab) Hashtbl.t -> string -> unit
*)
val check_syms : out_channel -> (string, Setup.symtab) Hashtbl.t -> unit
val prescan : string -> string -> Globals.modtree -> unit
val endscan : int -> unit
val subexp :
  out_channel ->
  Setup.TokSet.elt ->
  string ->
  (string, Setup.symtab) Hashtbl.t -> Vparser.token -> unit
