
module top;
wire OUT;
reg I0, I1, S;

mux2_to_1 my_mux(OUT, I0, I1, S); //Instantiate the module mux2_to_1

initial	//Add nets to the monitoring list
begin
	$my_monitor("top.my_mux.sbar");
	$my_monitor("top.my_mux.y1");
end

initial	//Apply Stimulus
begin
	I0=1'b0; I1=1'b1; S = 1'b0;
	#5 I0=1'b1; I1=1'b1; S = 1'b1;
	#5 I0=1'b0; I1=1'b1; S = 1'bx;
	#5 I0=1'b1; I1=1'b1; S = 1'b1;
end

endmodule

