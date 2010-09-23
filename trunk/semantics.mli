
type exprtree = {
  entry : Vparser.token;
  symbol : Set.Make(Setup.OrdTok).t;
}

type exprt =
    DYADIC of (Vparser.token * exprtree * exprtree)
  | ASSIGNMENT of (exprtree * exprt)
  | UNHANDLED of Vparser.token

val stmts : exprt list ref

   val semantics : (string, Setup.TokSet.t) Hashtbl.t -> string -> Globals.modtree -> unit
   val enter_a_sym : (string, Set.Make(Setup.OrdTok).t) Hashtbl.t -> string -> Vparser.token -> unit
(*   val iter_ :
  (string -> Globals.modtree -> unit) -> string ->
  (string, Set.Make(Setup.OrdTok).t) Hashtbl.t -> Vparser.token list -> unit *)
(*   val moditer : string -> Globals.modtree -> unit  *)
   val unhandled : Vparser.token -> unit
   val find_ident : (string, Setup.TokSet.t) Hashtbl.t -> Vparser.token -> string -> (string, Setup.TokSet.t) Hashtbl.t -> Vparser.token -> Setup.TokSet.t
val check_glob : (string, Setup.TokSet.t) Hashtbl.t -> unit
val unhand_list : Vparser.token list ref
