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

module stimulus;

wire OUT_XOR;

reg IN1, IN2;

initial
	$monitor($time, " OUT_XOR = %b,  IN1 = %b, IN2 = %b",
				OUT_XOR, IN1, IN2);

initial
begin
	IN1 = 1'B1; IN2 = 1'B1;
	#5 IN1 = 1'B1; IN2 = 1'B0;
	#5 IN1 = 1'B0; IN2 = 1'B1;
	#5 IN1 = 1'B0; IN2 = 1'B0;
end


my_xor o1(OUT_XOR, IN1, IN2);

endmodule
