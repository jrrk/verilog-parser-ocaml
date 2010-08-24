//*****************************************************************************
//
//    DESCRIPTION: Verilog parser main program
//
//*****************************************************************************
//
// Copyright 2010 by Jonathan Kimmitt.  This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// General Public License or the Perl Artistic License.
//
// This code is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
//*****************************************************************************
// Based on verilator parser code by Paul Wasson, Duane Galbi and Wilson Snyder
//*****************************************************************************

let main () =
  try
    let lexbuf = Lexing.from_channel stdin in
    while true do
      Grammar.start Lexer.token lexbuf
    done
    
  with End_of_file ->
    close_in_noerr stdin;
    Hashtbl.iter Dump.moditer Globals.modules;
    exit 0
     
let _ = Printexc.print main ()
