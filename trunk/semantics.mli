
type exprtree = {
  entry : Vparser.token;
  symbol : Setup.symtab;
}

type exprt =
    DYADIC of (Vparser.token * exprtree * exprtree)
  | ASSIGNS of (exprtree * exprt)
  | UNHANDLED of Vparser.token

type uptr = UPTR of (out_channel -> int -> Vparser.token -> unit) | UNIL

val unhand_list : (int * Vparser.token) list ref
val unhandled_dflt : out_channel -> int -> Vparser.token -> unit
val unhandled_ptr : uptr ref
val unhandled : out_channel -> int -> Vparser.token -> unit
val stk : (string * int * Vparser.token) Stack.t
val last_mod : string ref

   val enter_a_sym : out_channel -> string -> (string, Setup.symtab) Hashtbl.t -> string -> Vparser.token -> Vparser.token -> unit
(*   val iter_ :
  (string -> Globals.modtree -> unit) -> string ->
  (string, Setup.symtab) Hashtbl.t -> Vparser.token list -> unit *)
(*   val moditer : string -> Globals.modtree -> unit  *)
   val find_ident : out_channel -> Vparser.token -> string -> (string, Setup.symtab) Hashtbl.t -> Vparser.token -> Setup.symtab
val not_found : out_channel -> string -> (string, Setup.symtab) Hashtbl.t -> string -> unit
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
val enter_sym_attrs : out_channel -> string -> (string, Setup.symtab) Hashtbl.t ->
  Vparser.token -> Setup.TokSet.elt list -> Vparser.token -> bool -> unit
val check_syms : out_channel -> (string, Setup.symtab) Hashtbl.t -> unit
val prescan : Vparser.token -> Vparser.token
val endscan : unit -> unit
val subexp :
  out_channel ->
  Setup.TokSet.elt ->
  string ->
  (string, Setup.symtab) Hashtbl.t -> Vparser.token -> unit
val exprConst : out_channel -> string -> (string, Setup.symtab) Hashtbl.t -> Vparser.token -> int
val enter_parameter :
  out_channel ->
  string ->
  (string, Setup.symtab) Hashtbl.t ->
  string -> Vparser.token -> Vparser.token -> Vparser.token -> unit
val exprConst :
  out_channel ->
  string -> (string, Setup.symtab) Hashtbl.t -> Vparser.token -> int
val iwidth :
  out_channel ->
  string -> (string, Setup.symtab) Hashtbl.t -> Vparser.token -> int * int
val maxwidth :
  out_channel ->
  string -> (string, Setup.symtab) Hashtbl.t -> Vparser.token -> int
val create_attr :
  out_channel ->
  string ->
  (string, Setup.symtab) Hashtbl.t -> Vparser.token -> Setup.tsigattr
val stmtBlock :out_channel ->
           string ->
           (string, Setup.symtab) Hashtbl.t -> Setup.TokSet.elt -> unit
val for_stmt : out_channel ->
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
  out_channel ->
  string ->
  (string, Setup.symtab) Hashtbl.t ->
  Vparser.token -> Setup.TokSet.elt -> Vparser.token -> unit

val read_pragma : string -> string -> string -> unit
val black_box : (string, string) Hashtbl.t
