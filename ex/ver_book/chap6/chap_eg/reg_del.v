module regular_delay (out, in1, in2);

output out; 
input in1, in2;

assign #10 out = in1 & in2; // Delay in a continuous assign

endmodule

module stimulus;

wire OUT;
reg IN1, IN2;
initial
begin
	IN1 = 0; IN2= 0;
	#20 IN1=1; IN2= 1;

	#40 IN1 = 0;

	#40 IN1 = 1;
	#5 IN1 = 0;
	#150 $stop;
end

initial
	$gr_waves("out", OUT, "in1", IN1, "in2", IN2);

regular_delay rd1(OUT, IN1, IN2);

endmodule
