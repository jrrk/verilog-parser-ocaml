
module top;
wire SUM, C_OUT;
reg A, B, C_IN;

initial
begin
	$get_in_ports("top.FA");
end
	
fulladd FA(SUM, C_OUT, A, B, C_IN);

endmodule


// Define a 1-bit full adder
module fulladd(sum, c_out, a, b, c_in);

// I/O port declarations
output sum, c_out;
input a, b, c_in;

// Internal nets
wire s1, c1, c2;

// Instantiate logic gate primitives

xor  (s1, a, b);
and (c1, a, b);

xor (sum, s1, c_in);
and (c2, s1, c_in);

or  (c_out, c2, c1);

endmodule


