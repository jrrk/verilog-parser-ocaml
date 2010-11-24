type modtree = {
  tree : Liberty_parser.token;
  symbols : Setup.shash;
  mutable unresolved : string list;
(*  gsyms : (string, Setup.symtab) Hashtbl.t;	*)
}

type uptr = UPTR of (Setup.fmt -> int -> Liberty_parser.token -> unit) | UNIL

val unhand_list : (int * Liberty_parser.token) list ref
val implicit_params : string list ref
val implicit_wires : string list ref
val unhandled_dflt : Setup.fmt -> int -> Liberty_parser.token -> unit
val unhandled_ptr : uptr ref
val unhandled : Setup.fmt -> int -> Liberty_parser.token -> unit
val last_mod : string ref
val tmpnam : string

val libraries: (string, Liberty_parser.token list) Hashtbl.t
val tsymbols : (string, Liberty_parser.token) Hashtbl.t

val get_table : string -> Liberty_parser.token list

val unresolved_list : string list ref
val stk : (int * Liberty_parser.token) Stack.t
val logfile : Setup.logt ref
val trace_file : Setup.logt ref
val mygetenv : string -> string
val mygetenv_int : string -> int
val verbose : int
val yesno : bool -> string
val quicksort : 'a list -> 'a list
val qsort : 'a list -> 'a list
val grdbg : string -> Liberty_parser.token -> Liberty_parser.token
