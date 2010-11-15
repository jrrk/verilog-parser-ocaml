module factorial;

reg [3:0] N;

initial
begin
	N = 3;
	$display(" Factorial of N = %d is %d", N, factorial(N) );

	N = 4;
	$display(" Factorial of N = %d is %d", N, factorial(N) );

	N = 5;
	$display(" Factorial of N = %d is %d", N, factorial(N) );

	N = 10;
	$display(" Factorial of N = %d is %d", N, factorial(N) );
end

function [31:0] factorial;
input [3:0] n;
integer i;

begin
	factorial = 1;
	for (i = n; i > 0; i = i - 1)
	   factorial = factorial * i;
end
endfunction

endmodule
	
