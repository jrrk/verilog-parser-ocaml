module top;
wire OUT;
reg I0, I1, S;

mux2_to_1 my_mux(OUT, I0, I1, S); //Instantiate the module mux2_to_1

initial	//Apply Stimulus
begin
	I0=1'b0; I1=1'b1; S = 1'b0;
	$my_stop_finish(0); //Stop simulation. Do not print module instance name
	#5 I0=1'b1; I1=1'b1; S = 1'b1;
	$my_stop_finish(0,1); //Stop simulation. print module instance name
	#5 I0=1'b0; I1=1'b1; S = 1'bx;
	$my_stop_finish(2,1); //Pass bad arguments
	#5 I0=1'b1; I1=1'b1; S = 1'b1;
	$my_stop_finish(1,1); //Terminate simulation. print module instance name
end

endmodule

