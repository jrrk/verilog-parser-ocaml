module fulladd1 (sum, c_out, a, b, c_in);

output sum, c_out;
input a, b, c_in;

wire a_bar, b_bar, c_in_bar;
wire s1, s2, s3, s4;
wire c1, c2, c3;

//compute complements of signals
not (a_bar, a);
not (b_bar, b);
not (c_in_bar, c_in);

//compute sum
and (s1, a, b, c_in);
and (s2, a_bar, b, c_in_bar);
and (s3, a, b_bar, c_in_bar);
and (s4, a_bar, b_bar, c_in);

or  (sum, s1, s2, s3, s4);


//compute carry
and (c1, a, b);
and (c2, b, c_in);
and (c3, a, c_in);

or  (c_out, c1, c2, c3);

endmodule

// Define the stimulus (top level module)
module stimulus;

// Set up variables
reg A, B;
reg C_IN;
wire SUM;
wire C_OUT;
 
// Instantiate the 1-bit full adder. call it FA
fulladd1 FA(SUM, C_OUT, A, B, C_IN);
 
 
// Setup the monitoring for the signal values
initial
begin
        $monitor($time," A= %b, B=%b, C_IN= %b,, C_OUT= %b, SUM= %b\n",
        
                        A, B, C_IN, C_OUT, SUM);
end
 
// Stimulate inputs
initial
begin
        A = 1'b0; B = 1'b0; C_IN = 1'b0;
        #5 A = 1'b0; B = 1'b0; C_IN = 1'b1;
        #5 A = 1'b0; B = 1'b1; C_IN = 1'b0;
        #5 A = 1'b0; B = 1'b1; C_IN = 1'b1;
        #5 A = 1'b1; B = 1'b0; C_IN = 1'b0;
        #5 A = 1'b1; B = 1'b0; C_IN = 1'b1;
        #5 A = 1'b1; B = 1'b1; C_IN = 1'b0;
        #5 A = 1'b1; B = 1'b1; C_IN = 1'b1;
 
end

initial
begin
	#15 force stimulus.FA.sum = A & B & C_IN;
	#20 release stimulus.FA.sum ;
end
 
endmodule

