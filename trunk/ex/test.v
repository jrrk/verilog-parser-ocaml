/* hello */

`timescale 1ns/1ps

module test2(input a, input b, input c, input r, output [1:0] cc);

assign cc = a+b;

/* extended
       0:   0 @ P ` p     0:    (  2  <  F  P  Z  d   n   x
       1: ! 1 A Q a q     1:    )  3  =  G  Q  [  e   o   y
       2: " 2 B R b r     2:       4  >  H  R  \  f   p   z
       3: # 3 C S c s     3: !  +  5  ?  I  S  ]  g   q   {
       4: $ 4 D T d t     4: "  ,  6  @  J  T  ^  h   r   |
       5: % 5 E U e u     5: #  -  7  A  K  U  _  i   s   }
       6: & 6 F V f v     6: $  .  8  B  L  V  `  j   t   ~
       7: ' 7 G W g w     7: %  /  9  C  M  W  a  k   u  DEL
       8: ( 8 H X h x     8: &  0  :  D  N  X  b  l   v
       9: ) 9 I Y i y     9: '  1  ;  E  O  Y  c  m   w
       A:   : J Z j z
       B: + ; K [ k {
       C: , < L \ l |
       D: - = M ] m }
       E: . > N ^ n ~
       F: / ? O _ o DEL
comment */

always @(posedge c)
	if (r)
		c = 0;
	else
		c = c+1;

endmodule

module test1(clk, rst, cnt, cc);

input clk, rst;
input [7:0] cnt;
// reg [7:0] cnt;
output [1:0] cc;

test2 cct(.a(), .b(), .c(clk), .r(rst), .cc(cc));

endmodule

module test(clk, rst, count);

input clk, rst;
output [15:0] count;
wire [1:0] cc;

wire count_7, count_6, count_5, count_4, count_3, count_2, count_1, count_0;

assign count = {count_7, count_6, count_5, count_4, count_3, count_2, count_1, count_0};

test1 split(clk, rst, {count_7, count_6, count_5, count_4, count_3, count_2, count_1, count_0}, cc[1:0]);

// another comment

initial
	rst = 0;

final
	rst = 1;

endmodule
