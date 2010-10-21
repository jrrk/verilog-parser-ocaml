val parse: string -> unit
val includes : (string*in_channel) Stack.t
val from_func : Setup.fmt -> string -> int -> int
val from_special1 : Setup.fmt -> string -> string
val from_special2 : Setup.fmt -> string -> string
val from_blit : Setup.fmt -> string -> string -> int -> int
val paste : Setup.fmt -> string -> string -> int -> int
