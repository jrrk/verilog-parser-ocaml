
// Define the top level module called ripple carry
// counter. It is illegal to define the module T_FF inside this module.
module ripple_carry_counter(q, clk, reset);
output [3:0] q;
input clk, reset;

	module T_FF(q, clock, reset);// ILLEGAL MODULE NESTING
	:
	<module T_FF internals>
	:
	endmodule // END OF ILLEGAL MODULE NESTING

endmodule


