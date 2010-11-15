
module mux2_to_1(out, a, b, control);
output out;
input a, b, control;
tri out;
wire a, b, control;

//drives a when control = 0; z otherwise
bufif0  b1(out, a, control); 

//drives b when control = 1; z otherwise
bufif1 b2(out, b, control); 

endmodule

// Define the stimulus module (no ports)
module stimulus;

// Declare variables to be connected
// to inputs
reg IN0, IN1;
reg SEL;
 
// Declare output wire
wire OUTPUT;
 
// Instantiate the multiplexer
mux2_to_1 mymux(OUTPUT, IN0, IN1, SEL);
 
// Stimulate the inputs
initial
begin
        $monitor(" %d OUTPUT = %b IN0= %b, IN1= %b, SEL = %b\n", $time,
						OUTPUT, IN0,IN1,SEL);
        // set input lines
        IN0 = 1; IN1 = 0; 
 
        // choose IN0
	#10 SEL = 0;
 
        // choose IN1
        #10 SEL = 1;
 
        //  Set control to x
        #10 SEL = 1'bx;

        // Set control to z
        #10 SEL = 1'bz;
end
 
endmodule

