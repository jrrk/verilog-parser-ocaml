//Full Subtractor Module
module fullsub(B, D, x, y, z);

//Output and Input  ports
output B, D;
input x, y, z;

//Compute D and B

assign D = 	(~x & ~y & z) | (~x & y & ~z) |
		(x & ~y & ~z) | (x & y & z) ;	

assign B = 	(~x & y) | (~x & z) | (y & z);


endmodule

module stimulus;

reg x, y, z;
wire B, D;

//Instantiate the SUB module
fullsub SUB(B, D, x, y, z);

initial
	$monitor($time,"  x = %b, y = %b, z = %b, B = %b, D = %b",
			x, y, z, B, D);

//Stimulate the inputs
initial
begin
	x = 0; y = 0; z = 0;

	# 10 x = 0; y = 0; z = 1;

	# 10 x = 0; y = 1; z = 0;

	# 10 x = 0; y = 1; z = 1;

	# 10 x = 1; y = 0; z = 0;

	# 10 x = 1; y = 0; z = 1;

	# 10 x = 1; y = 1; z = 0;

	# 10 x = 1; y = 1; z = 1;
end
	
endmodule
