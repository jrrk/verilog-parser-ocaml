module stimulus;

reg [3:0] N;
reg [31:0] fact;

initial
begin
	N = 3;
	factorial(fact, N);
	$display($time, " Factorial of N = %d is %d", N, fact );

	N = 4;
	factorial(fact, N);
	$display($time, " Factorial of N = %d is %d", N, fact );

	N = 5;
	factorial(fact, N);
	$display($time, " Factorial of N = %d is %d", N, fact );

	N = 10;
	factorial(fact, N);
	$display($time, " Factorial of N = %d is %d", N, fact );
end

task factorial;
output [31:0] out;
input [3:0] n;
integer i;
reg [31:0] reg_out;

begin
	reg_out = 1;
	for (i = n; i > 0; i = i - 1)
	   reg_out = reg_out * i;
	#10 out = reg_out; //timing constructs allowed in tasks.
end
endtask

endmodule
	
