//Define a 2-to-1 mux using switches 
module my_mux (out, s, i0, i1);

output out;
input s, i0, i1;

//internal wire
wire sbar; //complement of s

//create the complement of s
my_nor nt(sbar, s, s); //equivalent to a not gate

//instantiate cmos switches
cmos (out, i0, sbar, s);
cmos (out, i1, s, sbar);

endmodule


//module my_nor defined earlier
module my_nor(out, a, b);

output out;
input a, b;

//internal wires
wire c;

//set up power and ground lines
supply1 pwr;   	//pwr is connected to Vdd
supply0 gnd;	//gnd is connected to Vss(ground)

//instantiate pmos  switches
pmos	(c, pwr, b); 
pmos  (out, c, a);

//instantiate nmos switches
nmos  (out, gnd, a);
nmos  (out, gnd, b);

endmodule

//Define an inverter using MOS switches
module my_not(out, in);

output out;
input in;

//define power and ground
supply1 pwr;
supply0 gnd;

//instantiate nmos and pmos switches
pmos  (out, pwr, in);
nmos  (out, gnd, in);

endmodule

module my_xor(out, in1, in2);

output out;
input in1, in2;
wire in1_bar, in2_bar;
wire a, c, d;
wire out_bar;

supply1 pwr;
supply0 gnd;

//create inverted signals
my_not n1(in1_bar, in1);
my_not n2(in2_bar, in2);

//pmos logic
pmos (a, pwr, in1);
pmos (a, pwr, in2_bar);
pmos (out_bar, a, in1_bar);
pmos (out_bar, a, in2 );

//nmos logic
nmos (out_bar, c, in1);
nmos (c, gnd, in2_bar);
nmos (out_bar, d, in1_bar);
nmos (d, gnd, in2);

//invert the result to get correct output
my_not n3(out , out_bar);

endmodule

//Define our own or gate, my_or
module my_or(out, a, b);

output out;
input a, b;
wire out_bar;

wire c;

//set up power and ground lines
supply1 pwr;    //pwr is connected to Vdd
supply0 gnd;    //gnd is connected to Vss(ground)

//instantiate pmos  switches
pmos    (c, pwr, b);
pmos  (out_bar, c, a);

//instantiate nmos switches
nmos  (out_bar, gnd, a);
nmos  (out_bar, gnd, b);

//invert the output
pmos  (out, pwr, out_bar);
nmos  (out, gnd, out_bar);

endmodule

//Define our own and gate, my_and
module my_and(out, a, b);

output out;
input a, b;
wire out_bar;

wire c;

//set up power and ground lines
supply1 pwr;   	//pwr is connected to Vdd
supply0 gnd;	//gnd is connected to Vss(ground)

//instantiate pmos  switches
pmos  (out_bar, pwr, b); 
pmos  (out_bar, pwr, a);

//instantiate nmos switches
nmos  (out_bar, c , a);
nmos  (c, gnd, b);

//invert the output
pmos  (out, pwr, out_bar);
nmos  (out, gnd, out_bar);

endmodule

//Define a CMOS latch
module my_latch ( q, qbar, d, clk);

output q, qbar;
input d, clk;

//internal nets
wire e;
wire nclk; //complement of clock

//instantiate the inverter
my_not nt(nclk, clk);

//instantiate CMOS switches
cmos  (e, d, clk, nclk); //switch C1; e = d when clk = 1.
cmos  (e, q, nclk, clk); //switch C2; e = q when clk = 0.


//instantiate the inverters
my_not nt1(qbar, e);
my_not nt2(q, qbar);

endmodule
 
//Define a CMOS flipflop
module my_flipflop ( q, qbar, d, clk);

output q, qbar;
input d, clk;

//internal nets
wire e1,e2,q1;
wire nclk; //complement of clock

//instantiate the inverter
my_not nt(nclk, clk);

//instantiate CMOS switches
cmos  (e2, q1, clk, nclk); //switch C1; e = d when clk = 1.
cmos  (e2, q, nclk, clk); //switch C2; e = q when clk = 0.


//instantiate CMOS switches
cmos  (e1, d, nclk, clk); //switch C1; e = d when clk = 0.
cmos  (e1, q1, clk, nclk); //switch C2; e = q when clk = 1.


//instantiate the inverters
my_not nt1(q1bar, e1);
my_not nt2(q2bar, e2);
my_not nt3(q1, q1bar);
my_not nt4(q, q2bar);

endmodule

module testff();

reg   clk, d;
wire  q, qbar;

integer  cnt;

my_flipflop ff(q, qbar, d, clk);

initial
   begin
   cnt = 3;
   clk = 0;
   d = 0;
   forever
      begin
      cnt = cnt * 7;
      #100  clk = ~clk;
      #100  d = cnt/11;
      end
   end

endmodule
