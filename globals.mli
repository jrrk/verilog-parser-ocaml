type modtree = {
  tree : Vparser.token;
  symbols : (string, Setup.symtab) Hashtbl.t;
  mutable unresolved : string list;
(*  gsyms : (string, Setup.symtab) Hashtbl.t;	*)
}

type uptr = UPTR of (Setup.fmt -> int -> Vparser.token -> unit) | UNIL

val unhand_list : (int * Vparser.token) list ref
val unhandled_dflt : Setup.fmt -> int -> Vparser.token -> unit
val unhandled_ptr : uptr ref
val unhandled : Setup.fmt -> int -> Vparser.token -> unit
val last_mod : string ref
val tmpnam : string

(*val gsyms : (string, Set.Make(Setup.OrdTok).t) Hashtbl.t*)
val modprims: (string, modtree) Hashtbl.t
val pending: (string, modtree) Hashtbl.t
val black_box: (string, string) Hashtbl.t
val tsymbols : (string, Vparser.token) Hashtbl.t

val get_table : string -> modtree
val get_syms : modtree -> (string, Setup.symtab) Hashtbl.t
(*
val show_syms : ('a -> 'b -> unit) -> ('a, 'b) Hashtbl.t -> unit
val show_table : string -> unit
*)
val unresolved_list : string list ref
val stk : (string * int * Vparser.token) Stack.t
val logfile : Setup.logt ref
val trace_file : Setup.logt ref
