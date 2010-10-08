//
// Copyright (c) 1999 Steven Wilson (stevew@home.com)
//
//    This source code is free software; you can redistribute it
//    and/or modify it in source code form under the terms of the GNU
//    General Public License as published by the Free Software
//    Foundation; either version 2 of the License, or (at your option)
//    any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program; if not, write to the Free Software
//    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
//
//
//

module main ();
 
   reg [7:0] array [7:0];
   reg 	     error ;
   reg [3:0] count;
   
   initial
     begin
	
	for(count = 0; count <= 7; count = count + 1)
	  begin
	     array[count] = 1 << count;
	  end

	$writememh("work/writememh2.dat", array, 6, 1);
	
	for(count = 0; count <= 7; count = count + 1)
	  begin
	     array[count] = 'bx;
	  end
	
	error = 0;
	
	$readmemh("work/writememh2.dat", array);
	
	for(count = 0; count <= 5; count = count + 1)
	  begin
	     if(array[count] !== (1<<(6-count)))
               begin
		  error = 1;
		  $display("FAILED - array[count] == %h, s/b %h",
			   array[count], 1 << count);
               end
	  end 
	
	if(error == 0) 
	  $display("PASSED\n"); 
	$finish ;
     end
endmodule
