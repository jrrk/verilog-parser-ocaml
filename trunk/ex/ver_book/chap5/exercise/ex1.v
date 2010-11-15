module my_or(out, in1, in2);

output out;
input in1, in2;
wire a, b;

//implementation out = (in1' . in2')'
nand (a, in1, in1);
nand (b, in2, in2);

nand (out, a, b);

endmodule

module my_and(out, in1, in2);
output out;
input in1, in2;

wire a;

//implementation out = ((in1.in2)')'
nand (a, in1, in2);

nand (out, a, a);

endmodule

module my_not(out, in);
output out;
input in;

nand (out, in, in);

endmodule


module stimulus;

wire OUT_OR, OUT_AND, OUT_NOT;

reg IN1, IN2;

initial
	$monitor($time, " OUT_OR = %b, OUT_AND = %b, OUT_NOT = %b, IN1 = %b, IN2 = %b",
				OUT_OR, OUT_AND, OUT_NOT, IN1, IN2);

initial
begin
	IN1 = 1'B1; IN2 = 1'B1;
	#5 IN1 = 1'B1; IN2 = 1'B0;
	#5 IN1 = 1'B0; IN2 = 1'B1;
	#5 IN1 = 1'B0; IN2 = 1'B0;
end


my_or o1(OUT_OR, IN1, IN2);
my_and a1(OUT_AND, IN1, IN2);
my_not n1(OUT_NOT, IN1);
endmodule
