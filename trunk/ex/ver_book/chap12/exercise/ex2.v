primitive LOGIC (y, a, b, c, d);

output y;
input a,b,c,d;

table
	// 	a	b	c	d	:	y;
		
		0	0	0	0	:	0 ;
		0	0	0	1	:	1 ;
		0	0	1	0	:	1 ;
		0	0	1	1	:	0 ;
		0	1	0	0	:	0 ;
		0	1	0	1	:	1 ;
		0	1	1	0	:	1 ;
		0	1	1	1	:	0 ;
		1	0	0	0	:	0 ;
		1	0	0	1	:	1 ;
		1	0	1	0	:	1 ;
		1	0	1	1	:	0 ;
		1	1	0	0	:	1 ;
		1	1	0	1	:	1 ;
		1	1	1	0	:	1 ;
		1	1	1	1	:	1 ;
endtable
endprimitive

/*
module LOGIC (y, a, b, c, d);

output y;
input a,b,c,d;

assign y = (a & b) | (c ^ d);
endmodule
*/

module stimulus;

reg A, B, C, D;
wire Y;

LOGIC L1(Y, A, B, C, D);

initial
	$monitor($time, "  Y = %b , A = %B B = %B C = %B D = %B", 
					Y, A, B, C, D);

initial
begin
	#1 A = 0; B = 0; C = 0; D = 0;	
	#1 A = 0; B = 0; C = 0; D = 1;	
	#1 A = 0; B = 0; C = 1; D = 0;	
	#1 A = 0; B = 0; C = 1; D = 1;	
	#1 A = 0; B = 1; C = 0; D = 0;	
	#1 A = 0; B = 1; C = 0; D = 1;	
	#1 A = 0; B = 1; C = 1; D = 0;	
	#1 A = 0; B = 1; C = 1; D = 1;	
	#1 A = 1; B = 0; C = 0; D = 0;	
	#1 A = 1; B = 0; C = 0; D = 1;	
	#1 A = 1; B = 0; C = 1; D = 0;	
	#1 A = 1; B = 0; C = 1; D = 1;	
	#1 A = 1; B = 1; C = 0; D = 0;	
	#1 A = 1; B = 1; C = 0; D = 1;	
	#1 A = 1; B = 1; C = 1; D = 0;	
	#1 A = 1; B = 1; C = 1; D = 1;	
end
endmodule
