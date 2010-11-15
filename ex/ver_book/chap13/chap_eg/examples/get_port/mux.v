
module mux2_to_1(out, i0, i1, s);

output out; //output port
input i0, i1; //input ports
input s;

wire sbar, y1, y2; //internal nets

//Gate Instantiations
not n1(sbar, s);
and a1(y1, i0, sbar);
and a2(y2, i1, s);
or o1(out, y1, y2);

endmodule


