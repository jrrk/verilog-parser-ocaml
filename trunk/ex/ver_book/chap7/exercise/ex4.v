module block;

reg a, b, c; 
reg [2:0] d;

initial	
begin
	$monitor($time," a = %b, b = %b c = %b d = %b",
					a, b, c, d);
	#100 $finish;
end

initial
begin
	a <= 1'b0;
	b <= #10 1'b1;
	c <= #5 1'b0;
	d <= #20 {a, b, c};
end
endmodule
