   val semantics : Globals.modtree -> unit
   val enter_a_sym : (string, Set.Make(Setup.OrdTok).t) Hashtbl.t -> string -> Vparser.token -> unit
   val iter_ :
  (Globals.modtree -> unit) ->
  (string, Set.Make(Setup.OrdTok).t) Hashtbl.t -> Vparser.token list -> unit
   val moditer : string -> Globals.modtree -> unit
