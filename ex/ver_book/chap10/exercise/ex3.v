module Y (out, m, n, p, q);
output out;
input m, n, p, q;

wire e, f;

specify
(m => out) = 15;
(n => out) = 15;
(p => out) = 12;
(q => out) = 12;
endspecify

or  (e, m, n);
and (f, p, q);

or  (out, e, f);

endmodule

module stimulus;

reg M, N, P, Q;
wire OUT;

Y  y1(OUT, M, N, P, Q);

//stimulate the inputs

initial
begin
	$monitor($time, " OUT = %B, M = %B, N = %B, P = %B, Q = %B",
			OUT, M, N, P, Q);

	M = 1; N = 0; P = 1; Q = 0;

	#20 M = 0; N = 0; P = 1; Q = 0;

	#20 M = 0; N = 0; P = 1; Q = 1;

	#20 M = 0; N = 0; P = 0; Q = 0;

	#50 $finish;
end
endmodule
