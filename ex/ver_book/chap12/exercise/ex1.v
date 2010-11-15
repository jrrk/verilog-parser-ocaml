// 2-to-1 multiplexer. Define it as a primitive
primitive mux4_to_1 (out, i0, i1, s);

// Port declarations from the I/O diagram
output out;
input i0, i1; 
input s;


table
  //  i0  i1   s  :  out
      1   ?    0  :  1 ;
      0   ?    0  :  0 ;
      ?   1    1  :  1 ;
      ?   0    1  :  0 ;
      ?   ?    x  :  0 ;
endtable

endprimitive

// Define the stimulus module (no ports)
module stimulus;

// Declare variables to be connected
// to inputs
reg IN0, IN1;
reg S;

// Declare output wire
wire OUTPUT;

// Instantiate the multiplexer
mux4_to_1 mymux(OUTPUT, IN0, IN1, S);

// Stimulate the inputs
initial
begin
  // set input lines
  IN0 = 1; IN1 = 0; 
  #1 $display("IN0= %b, IN1= %b, \n",IN0,IN1);

 
  // choose IN0
  S = 0; 
  #1 $display("S = %b,  OUTPUT = %b \n", S, OUTPUT);
 
  // choose IN1
  S = 1; 
  #1 $display("S = %b,  OUTPUT = %b \n", S, OUTPUT);

  // set input lines
  IN0 = 0; IN1 = 1; 
  #1 $display("IN0= %b, IN1= %b, \n",IN0,IN1);
 
  // choose IN0
  S = 0; 
  #1 $display("S = %b,  OUTPUT = %b \n", S, OUTPUT);
 
  // choose IN1
  S = 1; 
  #1 $display("S = %b,  OUTPUT = %b \n", S, OUTPUT);

  // set select signal to x
  S = 1'bx; 
  #1 $display("S = %b,  OUTPUT = %b \n", S, OUTPUT);
end
 
endmodule
