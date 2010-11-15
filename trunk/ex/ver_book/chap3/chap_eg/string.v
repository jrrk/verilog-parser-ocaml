module string_storage;

reg [8*18:1] string_value; // Declare a variable which is 18 bytes wide
initial
	string_value = "Hello Verilog World"; // String can be stored in variable

endmodule


