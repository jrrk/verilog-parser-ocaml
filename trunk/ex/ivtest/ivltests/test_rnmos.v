/*
 * Copyright (c) 2000 Intrinsity, Inc.
 *
 *    This source code is free software; you can redistribute it
 *    and/or modify it in source code form under the terms of the GNU
 *    General Public License as published by the Free Software
 *    Foundation; either version 2 of the License, or (at your option)
 *    any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
 */
module test_rnmos ();

reg gnd, vdd, x, z;
wire t0, t1, t2, t3, t4, t5, t6, t7,
     t8, t9, ta, tb, tc, td, te, tf;

wire StH, StL;

assign (strong1, highz0)  StH = 1'bx;
assign (highz1,  strong0) StL = 1'bx;

reg failed;


rnmos n0 ( t0,  gnd,  gnd);
rnmos n1 ( t1,  gnd,  vdd);
rnmos n2 ( t2,  gnd,  x);
rnmos n3 ( t3,  gnd,  z);

rnmos n4 ( t4,  vdd,  gnd);
rnmos n5 ( t5,  vdd,  vdd);
rnmos n6 ( t6,  vdd,  x);
rnmos n7 ( t7,  vdd,  z);

rnmos n8 ( t8,  x,  gnd);
rnmos n9 ( t9,  x,  vdd);
rnmos na ( ta,  x,  x);
rnmos nb ( tb,  x,  z);

rnmos nc ( tc,  z,  gnd);
rnmos nd ( td,  z,  vdd);
rnmos ne ( te,  z,  x);
rnmos nf ( tf,  z,  z);

initial begin

  assign gnd = 1'b1;
  assign vdd = 1'b0;
  assign x = 1'b0;
  assign z = 1'b0;
  #10;

  assign gnd = 1'b0;
  assign vdd = 1'b1;
  assign x = 1'b1;
  assign z = 1'b1;
  #10;

  assign gnd = 1'b0;
  assign vdd = 1'b1;
  assign x = 1'bx;
  assign z = 1'bz;
  #10;

  failed = 0;

  if (t0 !== z) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:z", gnd, gnd, t0 );
  end

  if (t1 !== 0) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:0", gnd, vdd, t1 );
  end
  if (t2 !== StL) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:StL", gnd, x, t2 );
  end
  if (t3 !== StL) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:StL", gnd, z, t3 );
  end

  if (t4 !== 1'bz) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:z", vdd, gnd, t4 );
  end
  if (t5 !== 1) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:0", vdd, vdd, t5 );
  end
  if (t6 !== StH) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:StH", vdd, x, t6 );
  end
  if (t7 !== StH) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:StH", vdd, z, t7 );
  end

  if (t8 !== 1'bz) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:z", x, gnd, t8 );
  end
  if (t9 !== 1'bx) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:x", x, vdd, t9 );
  end
  if (ta !== 1'bx) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:x", x, x, ta );
  end
  if (tb !== 1'bx) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:x", x, z, tb );
  end

  if (tc !== 1'bz) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:z", z, gnd, tc );
  end
  if (td !== 1'bz) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:z", z, vdd, td );
  end
  if (te !== 1'bz) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:z", z, x, te );
  end
  if (tf !== 1'bz) 
  begin 
      failed = 1;
      $display ("FAILED: rnmos s:%d g:%d d:%d expected:z", z, z, tf );
  end

  if (failed == 0) 
      $display ("PASSED");
end
endmodule

