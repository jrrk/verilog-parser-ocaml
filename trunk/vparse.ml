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

open Setup;;

let parse str = begin
  let ic = open_in str in
  try
    let lexbuf = Lexing.from_channel ic in
    while true do
      Grammar.start Vlexer.token lexbuf
    done
    
  with End_of_file ->
    close_in_noerr ic;
    | Parsing.Parse_error
    | Grammar.Error ->
    begin
    close_in_noerr ic;
    psuccess := false;
    Printf.fprintf stderr "Parse Error in %s\n" str;
    for i = 1 to hsiz do let idx = (hsiz-i+(!histcnt))mod hsiz in let item = !(history.(idx)) in
        Printf.fprintf stderr "Backtrace %d : %s (%d-%d)\n"  i (str_token (item.tok)) item.strt item.stop;
    done;
    end;
  end
