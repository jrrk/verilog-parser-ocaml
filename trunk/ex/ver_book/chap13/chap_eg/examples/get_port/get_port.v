
module top;
wire OUT;
reg I0, I1, S;

initial
begin
	$get_ports("top.my_mux");
end
	
mux2_to_1 my_mux(OUT, I0, I1, S);

endmodule

