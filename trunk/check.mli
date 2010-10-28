val dotted : string -> bool
val erc_chk_sig : Setup.fmt -> Setup.tset -> Setup.TokSet.t -> string -> string
val erc_chk : Setup.fmt -> (string, string list) Hashtbl.t -> (unit->unit) -> Setup.sentries -> string -> Setup.symtab -> unit
