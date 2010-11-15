// Positive edge triggered D flipflop with asynchronous clear and preset
module edge_dff(q, qbar, d, clk, clear, preset);

// Inputs and outputs
output q,qbar;
input d, clk, clear,preset;    
reg q, qbar; //declare q and qbar are registers

always @(posedge clk) //assign value of q and qbar at active edge of clock
begin
        q = d;
        qbar = ~d;
end

always @(clear or preset) 
        if(clear) 
        begin   
                assign q = 1'b0;
                assign qbar = 1'b1;
        end
        else if(preset) 
        begin   
                assign q = 1'b1;
                assign qbar = 1'b0;
	end
        else
        begin   
                deassign q; 
                deassign qbar; 
        end 
 
endmodule 

module stimulus;

reg CLEAR, PRESET, CLK, D;
wire Q;


edge_dff d1(Q,, D, CLK, CLEAR, PRESET);

initial
        $monitor($time, " Q = %B, CLEAR = %B PRESET = %B, CLK = %B, D = %B",
                                Q, CLEAR, PRESET, CLK, D);

initial
        $gr_waves("Q", Q, "CLEAR", CLEAR, "PRESET", PRESET, "CLK", CLK, "D", D);

always #5 CLK = ~CLK;
 
initial
begin
        CLK = 1'b0;
	CLEAR = 0; PRESET = 0;
        #12 CLEAR = 1;
        #20 CLEAR = 0;
	#200 PRESET = 1;
	#50 PRESET = 0;
        #200 CLEAR = 1;
        #50 CLEAR = 0;
end

initial
begin
        D = 1'b0;
        #3 forever #10 D = ~D;
end
        
endmodule

