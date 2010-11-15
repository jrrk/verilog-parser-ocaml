module test_trireg;

trireg (large) out;
reg a, control;

//instantiate bufif 1
bufif1 (out, a, control); //trireg net out should hold value
			  //instead of going to z when control 
			  //is deasserted 

initial
begin
	$monitor($time," out = %b, a = %b, control = %b", out, a, control);

	#5 a = 1; control = 1;
	#5 control = 0;
	#5 a = 0;
	#5 control = 1;
	#5 control = 0;
	#5 a = 1;
	#5 control = 1;
end
endmodule
