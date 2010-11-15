module dummy;

reg oscillate;

initial
begin
	oscillate = 1'b0;
	forever #30 oscillate = ~oscillate;

end

initial
	#3000 $finish;

endmodule
