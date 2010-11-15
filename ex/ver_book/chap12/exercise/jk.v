//Working model of Master Slave JK flip flop.
//Capture data at posedge, Clock to slave at negedge.
module MS_ff(q, qbar, j, k, clock,clear);

//I/O declarations
output q, qbar;
input j,k, clock,clear;

//Internal declarations
wire a,b,c,d,e;
wire y,ybar;
wire cbar = ~clock;


//Master FF
assign a = ~(clear & qbar & clock & j);
assign b = ~(clock & k & q);
assign  y = ~(ybar & a);
assign  ybar = ~(y & clear & b);

//Slave FF
assign  c = ~(y & cbar);
assign  d = ~(ybar & cbar);
assign  q = ~(c & qbar);
assign  qbar = ~(d & q & clear); 

endmodule

	
module stimulus;

reg CLOCK, J,K, CLEAR; 
wire Q, Qbar;

// instantiate the edge triggered D-flipflop
MS_ff	ff1( Q, Qbar, J, K, CLOCK, CLEAR);

initial
	$gr_waves("Clk", CLOCK,
						"J",	 J,
						"K",	 K,
						"Q",   Q,
						"Qbar", Qbar
						); 

// Setup monitor to display output changes of DFF 
initial 
	$monitor($time, " J = %b, K= %b, Q = %b \n", J, K, Q); 

initial
begin
	CLEAR = 1'b0;
	#2 CLEAR = 1'b1;
end

// Setup the clock to toggle every 10 time units 
initial 
begin 
	CLOCK = 1'b0;
	forever #10 CLOCK = ~CLOCK;
end

// Setup J to toggle every 20 time units
initial
begin
	J = 1'b0;
	forever #20 J = ~J;
end

// Setup K to toggle every 20 time units
initial
begin
	K = 1'b0; #5;
	forever #40 K = ~K;
end

// Finish the simulation at time 200
initial
begin
	#200 $stop;
end

endmodule
