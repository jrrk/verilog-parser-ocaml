
module monitor_example;

reg clock, reset;

//setup reset signal
initial
begin
	reset = 1'b1;
	clock = 1'b0;
	#50 reset = 1'b0;
end

//Monitor time and value of the signals clock and reset
//Clock toggles every 5 time units and reset goes down at 10 time units
initial
begin
	$monitor( $time, "Value of signals clock = %b reset = %b", 
		  clock,reset);
end


//setup clock signal
always #5 clock = ~clock;

endmodule
