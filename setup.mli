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

type tsigattr = Sigundef |
        Sigarray of tset array |
        Sigparam of Vparser.token |
        Sigtask of Vparser.token |
        Sigfunc of Vparser.token |
	Signamed of Vparser.token

and symtab = {
  symattr : tset;
  width : Vparser.token;
  path : string;
  sigattr : tsigattr;
  localsyms : shash;
}

and sentries = (string, symtab) Hashtbl.t

and symrec = { nxt : shash; syms: sentries; }
 
and shash = EndShash | Shash of symrec

type fmt = (out_channel*Format.formatter)

type logt = Closed | Open of fmt;;

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

val hsiz : int
val histcnt : int ref
type hist = { tok : Vparser.token; strt : int; stop : int; key : bool; }
val history : hist ref array
val psuccess : bool ref
val str_token : Vparser.token -> string
