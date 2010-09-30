module type Ordered =
  sig
    type t
    val compare : Vparser.token -> Vparser.token -> int
  end

module OrdTok :
  sig
    type t = Vparser.token
    val compare : Vparser.token -> Vparser.token -> int
  end

type tset = Set.Make(OrdTok).t

type refer = Nil | Referrer of symtab

and symtab = {
  symattr : tset;
  width : Vparser.token;
  referrer : refer;
  path : string;
}

module TokSet :
  sig
    type elt = OrdTok.t
    type t = tset
    val empty : t
    val is_empty : t -> bool
    val mem : elt -> t -> bool
    val add : elt -> t -> t
    val singleton : elt -> t
    val remove : elt -> t -> t
    val union : t -> t -> t
    val inter : t -> t -> t
    val diff : t -> t -> t
    val compare : t -> t -> int
    val equal : t -> t -> bool
    val subset : t -> t -> bool
    val iter : (elt -> unit) -> t -> unit
    val fold : (elt -> 'a -> 'a) -> t -> 'a -> 'a
    val for_all : (elt -> bool) -> t -> bool
    val exists : (elt -> bool) -> t -> bool
    val filter : (elt -> bool) -> t -> t
    val partition : (elt -> bool) -> t -> t * t
    val cardinal : t -> int
    val elements : t -> elt list
    val min_elt : t -> elt
    val max_elt : t -> elt
    val choose : t -> elt
    val split : elt -> t -> t * bool * t
  end

val show_set : TokSet.t -> unit
val str_token : Vparser.token -> string
val show_token : Vparser.token -> unit
val show_sym : string -> symtab -> unit

