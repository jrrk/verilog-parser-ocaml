(******************************************************************************
*
*    DESCRIPTION: Verilog parser program
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

let parse str =
  let ic = open_in str in
  try
    let lexbuf = Lexing.from_channel ic in
    while true do
      Grammar.start Lexer.token lexbuf
    done
    
  with End_of_file ->
    close_in_noerr ic
(*    Hashtbl.iter Semantics.moditer Globals.modprims  *)
