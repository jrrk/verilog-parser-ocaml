type modtree = {
  tree : Vparser.token;
  symbols : (string, Set.Make(Setup.OrdTok).t) Hashtbl.t;
}
val modprims: (string, modtree) Hashtbl.t
val get_table : string -> modtree
val get_syms : modtree -> (string, Set.Make(Setup.OrdTok).t) Hashtbl.t
val show_syms : ('a -> 'b -> unit) -> ('a, 'b) Hashtbl.t -> unit
val show_table : string -> unit
val show_unhandled : string -> unit
