module Y (out, m, n, p, q);
output out;
input m, n, p, q;

wire e, f;

or #11 (e, m, n);
and #8 (f, p, q);

or #4  (out, e, f);

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
