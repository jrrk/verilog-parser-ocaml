(******************************************************************************
*
*    DESCRIPTION: Verilog parser ocamlyacc grammar file
*
******************************************************************************
*
* Copyright 2010 by Jonathan Kimmitt.  This program is free software; you can
* redistribute it and/or modify it under the terms of either the GNU
* General Public License or the Perl Artistic License.
*
* This code is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
******************************************************************************
* Based on verilator parser code by Paul Wasson, Duane Galbi and Wilson Snyder
*******************************************************************************)

open Grammar_sysver;;

type uptr = UPTR of (Setup.fmt -> int -> Grammar_sysver.token -> unit) | UNIL;;

type modtree = {
tree: token;
symbols: Setup.shash;
mutable unresolved: string list;
 };;

let modprims = Hashtbl.create 256;;
let pending = Hashtbl.create 256;;
let black_box = Hashtbl.create 256;;
let env_cache = Hashtbl.create 256;;

let tmpnam = "report."^(string_of_int(Unix.getpid()))^"."^Unix.gethostname()^".report";;
let unresolved_list = ref [];;
let stk = Stack.create();;
let logfile = ref Setup.Closed;;
let trace_file = ref Setup.Closed;;

let (unhand_list:(int*token) list ref) = ref [];;
let (implicit_params:string list ref) = ref [];;
let (implicit_wires:string list ref) = ref [];;

let unhandled_dflt out_chan ln argt = let arg = (ln,argt) in if (List.mem arg !unhand_list == false) then begin
unhand_list := arg :: !unhand_list;
Printf.fprintf (fst out_chan) "\n\n**** Unhandled %d ****\n" (List.length !unhand_list);
end

let unhandled_ptr = ref (UPTR unhandled_dflt);;

let unhandled out_chan ln arg = match !unhandled_ptr with UPTR fn -> fn out_chan ln arg | UNIL -> ();;

let last_mod = ref "";;

let get_table (m:string) = Hashtbl.find modprims m;;
let get_syms (r:modtree) = r.symbols;;

let tsymbols = Hashtbl.create 256;;

let mygetenv str = if Hashtbl.mem env_cache str then Hashtbl.find env_cache str else
        try let env = Sys.getenv str in Hashtbl.add env_cache str env; env; with Not_found -> (); ""

let mygetenv_int str = try int_of_string (mygetenv str) with Failure("int_of_string") -> 0;;

let verbose = mygetenv_int "VCHK_VERBOSE"

let yesno cond = if cond then "true" else "false"

let rec quicksort = function
          | (x::xs) -> 
              (quicksort (List.filter (fun i -> i < x) xs))
              @ [x] @ 
              (quicksort (List.filter (fun i -> i >= x) xs))
          | [] -> []
        ;;

let rec qsort = function
   | [] -> []
   | pivot :: rest ->
       let is_less x = x < pivot in
       let left, right = List.partition is_less rest in
       qsort left @ [pivot] @ qsort right

let grdbg_chan = open_out "grdbg_logfile"

let grdbg key ktok:token = begin
Printf.fprintf grdbg_chan "Grammar %s => %s\n" key (Setup.str_token ktok);
ktok
end
