type modtree = {
  tree : Grammar_sysver.token;
  symbols : Setup.shash;
  mutable unresolved : string list;
(*  gsyms : (string, Setup.symtab) Hashtbl.t;	*)
}

type uptr = UPTR of (Setup.fmt -> int -> Grammar_sysver.token -> unit) | UNIL

val unhand_list : (int * Grammar_sysver.token) list ref
val implicit_params : string list ref
val implicit_wires : string list ref
val unhandled_dflt : Setup.fmt -> int -> Grammar_sysver.token -> unit
val unhandled_ptr : uptr ref
val unhandled : Setup.fmt -> int -> Grammar_sysver.token -> unit
val last_mod : string ref
val tmpnam : string

(*val gsyms : (string, Set.Make(Setup.OrdTok).t) Hashtbl.t*)
val modprims: (string, modtree) Hashtbl.t
val pending: (string, modtree) Hashtbl.t
val black_box: (string, string) Hashtbl.t
val tsymbols : (string, Grammar_sysver.token) Hashtbl.t

val get_table : string -> modtree
(*
val get_syms : modtree -> (string, Setup.symtab) Hashtbl.t

val show_syms : ('a -> 'b -> unit) -> ('a, 'b) Hashtbl.t -> unit
val show_table : string -> unit
*)
val unresolved_list : string list ref
val stk : (int * Grammar_sysver.token) Stack.t
val logfile : Setup.logt ref
val trace_file : Setup.logt ref
val mygetenv : string -> string
val mygetenv_int : string -> int
val verbose : int
val yesno : bool -> string
val quicksort : 'a list -> 'a list
val qsort : 'a list -> 'a list
val grdbg : string -> Grammar_sysver.token -> Grammar_sysver.token
