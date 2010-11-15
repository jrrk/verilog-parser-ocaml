module MEM;

//no interface or internals

endmodule


module SC;

//no interface or internals

endmodule


module Xbar;

//no interface or internals

endmodule


module IS;

	//instantiate the modules

	MEM mem1();
	
	SC sc1();
	
	Xbar xbar1();

endmodule



module Top;

	//Top level block instantiates module IS

	IS is1();

endmodule
