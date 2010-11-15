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

//stimulus to test the gate
module  stimulus;
reg A, B;
wire OUT_OR, OUT_AND;

//instantiate the my_or module
my_or  o1(OUT_OR, A, B); 
my_and a1(OUT_AND, A, B); 

//Apply stimulus 
initial
begin
		//test all possible combinations
		A = 1'b0;  B = 1'b0;
		#5 A = 1'b0;  B = 1'b1;
		#5 A = 1'b1;  B = 1'b0;
		#5 A = 1'b1;  B = 1'b1;
end

//check results
initial
		$monitor($time, "  OUT_OR = %b, OUT_AND = %b, A = %b, B = %b", 
				OUT_OR, OUT_AND, A, B);

endmodule

