val parse: unit -> unit
val push: string -> unit
val includes : (string*in_channel) Stack.t
val from_func : string->int->int
val from_special1 : string -> string
val from_special2 : string -> string
val from_blit : string -> string -> int -> int
val paste : string -> string -> int -> int
