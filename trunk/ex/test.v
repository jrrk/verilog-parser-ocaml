/* hello */

`timescale 1ns/1ps

module test1(clk, rst, cnt, cc, cnt0, cnt1, cnt2, cnt3, cnt4, cnt5, cnt6, cnt7);

input clk, rst;
output [14:7] cnt;
output [1:0] cc;
output cnt0, cnt1, cnt2, cnt3, cnt4, cnt5, cnt6, cnt7;

test2 cct(.a(cnt[0]), .b(cnt[7]), .cc(cc), .c(clk), .r(rst), .cnt(cnt));
test2 cct2(.a(cnt[0]), .b(cnt[7]), .cc(cc), .c(clk), .r(rst), .cnt({cnt0,cnt1,cnt2,cnt3,cnt4,cnt5,cnt6,cnt7}));

endmodule

module test2(input [3:0] a, input [0:3] b, output [3:0] cc, input c, input r, output [0:7] cnt);

reg [0:7] cnt;

assign cc = a*b;

always @(posedge c)
	if (r)
		cnt = 0;
	else
		cnt = cnt + 1;

endmodule
