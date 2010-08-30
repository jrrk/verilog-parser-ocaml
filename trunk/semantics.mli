
type exprtree = {
  entry : Vparser.token;
  symbol : Set.Make(Setup.OrdTok).t;
}

type exprt =
    DYADIC of (Vparser.token * exprtree * exprtree)
  | ASSIGNMENT of (exprtree * exprt)
  | UNHANDLED of Vparser.token

val stmts : exprt list ref

   val semantics : Globals.modtree -> unit
   val enter_a_sym : (string, Set.Make(Setup.OrdTok).t) Hashtbl.t -> string -> Vparser.token -> unit
   val iter_ :
  (Globals.modtree -> unit) ->
  (string, Set.Make(Setup.OrdTok).t) Hashtbl.t -> Vparser.token list -> unit
   val moditer : string -> Globals.modtree -> unit
   val unhand_str : string
   val unhandled : (string, Set.Make(Setup.OrdTok).t) Hashtbl.t -> Vparser.token -> unit
   val find_ident : (string, Set.Make(Setup.OrdTok).t) Hashtbl.t -> string -> bool
