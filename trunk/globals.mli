type modtree = {
  tree : Vparser.token;
  symbols : (string, Set.Make(Setup.OrdTok).t) Hashtbl.t;
}
val modules: (string, modtree) Hashtbl.t
val primitives: (string, Vparser.token) Hashtbl.t
(*val symbols: (string, Set.Make(Setup.OrdTok).t) Hashtbl.t*)
