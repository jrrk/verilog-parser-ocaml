module dummy;

reg clock;

initial
	clock = 1'b0;

always
begin
	#30 clock = 1'b1;
	#10 clock = 1'b0;
end

initial
	#3000 $finish;

endmodule
