////////////////////////////////////////////////////////////////////////////////
//   FileName:  "testdram.v" - testbench for dram.v model 
//   Author  :  Venkata Ramana Kalapatapu
//   Company :  Sand Microelectronics Inc.,
//   Profile :  Sand develops Simulation Models, Synthesizable Cores and
//              Performance Analysis Tools for Processors, Buses and Memory
//              products.  Sand's products include models for industry standard  
//              components and Custom developed models for specific  
//              simulation environments.       
//
//              For more information on Sand, contact us at (408)-441-7138 by
//              telephone, (408)-441-7538 by fax or email your specific needs
//              to sales@sandmicro.com 
////////////////////////////////////////////////////////////////////////////////

module testdram;


reg  [9:0] ma;
reg        ras;
reg        cas;
reg        uwe;
reg        lwe;
reg        oe;
reg  [15:0] data;
wire [15:0] DATA = data;

integer i;

defparam dm.infile = "ini_file";   // Specifiying the Initialization file.

                                   // DRAM Module Instantiation.
DRAM dm ( .DATA(DATA), .MA(ma), .RAS_N(ras), .CAS_N(cas), 
          .LWE_N(lwe), .UWE_N(uwe), .OE_N(oe) );

                                   // Including the Timing Parameter File.
`include "./dram.timing"

initial
begin

  ras = 1'b1;
  cas = 1'b1;
  ma  = 10'bx;
  lwe  = 1'bx;
  uwe  = 1'bx;
  oe  = 1'b1;
  data = 16'bz;
end


// This task does the CAS_N before RAS_N Self Refresh.
task cas_bef_ras_ref;
begin

   cas = #1 1'b0;
   # tCSR_min;
   ras = #1 1'b0;
   # tCHR_min;
   cas = #1 1'b1;
   # (tRAS_min - tCHR_min);
   ras = #1 1'b1;
   #10;
end
endtask

// This Task does the RAS_N Only Refresh.
task ras_only_ref;
begin
    ma = #1 0;
    ras = #1 1'b0;
    ma = #10 10'bx;
    # (tRAS_min - 10) ; 
    ras = #1 1'b1;
    #10;
    # (tRP_min ); 
    ma = #1 0;
    ras = #1 1'b0;
    ma = #10 10'bx;
    # (tRAS_min  - 10); 
    ras = #1 1'b1;
    #10;
    # (tRP_min ); 
    ma = #1 0;
    ras = #1 1'b0;
    ma = #10 10'bx;
    # (tRAS_min -10) ; 
    ras = #1 1'b1;
    #10;
end
endtask


// This Task does the Read Modify Write Cycle. Intially It reads from
// a specified location and modifies the data and writes both the 
// bytes back to the same location.
task word_read_modify_write;
input [17:0] address;
input [15:0] rd_data;
input [15:0] wr_data;
begin
  data = 16'bz;
  fork
    begin : ma_block
      ma <= address[17:8]; 
      ma <= #(tASR_min + tRAH_min) 10'bx;
      @(negedge ras);
      ma[7:0] <= #(tRAD_min) address[7:0];
      @(negedge cas);
      ma <= #(tCAH_min) 10'bx;
    end
    begin : ras_block
      ras <= 1'b1; 
      ras <= #(tASR_min) 1'b0;
      @(negedge uwe or negedge lwe);
      ras <= #(tRWL_min) 1'b1;
    end
    begin : cas_block
      cas <= 'b1;
      @(negedge ras); 
      cas <= #(tRCD_min) 1'b0; 
      @(negedge uwe or negedge lwe);
      cas <= #(tWP_min) 1'b1;
    end
    begin : uwe_block
      uwe <= 1'bx;    
      @(negedge cas);
      uwe <= 1'b1;
      uwe <= #(tRWD_min) 1'b0;
      uwe <= #(tRWD_min + tWP_min) 1'bx;
    end
    begin : lwe_block
      lwe <= 1'bx;    
      @(negedge cas);
      lwe <= 1'b1;
      lwe <= #(tRWD_min) 1'b0;
      lwe <= #(tRWD_min + tWP_min) 1'bx;
    end
    begin : oe_block
      oe  <= 1'b1;
      @(negedge cas);
      oe  = #10 1'b0;
      oe  = #10 1'b1;
      if(DATA !== rd_data)
          $display("READ ERROR at %0d : Expected Data = %h, Actual Data = %h", $time,rd_data, DATA);
    end
    begin : data_block
   
      @(negedge oe);
      @(posedge oe);
      data <= #(tOED_min) wr_data;
      @(negedge uwe or negedge lwe);
      data <= #(tOED_min) 16'bx;
    end
  join
#10;
end
endtask

// This task does the Read Only Cycle for a specified address location.
// After the Read is done,  the task compares the User given data as
// specified in the second argument and compares it with the read data
// and flags error if there is a mismatch.
task read_cyc;
input [17:0] address;
input [15:0] rd_data;
begin
  data = 16'bz;
  fork
    begin : ma_block
      ma <= address[17:8]; 
      ma <= #(tASR_min + tRAH_min) 10'bx;
      @(negedge ras);
      ma[7:0] <= #(tRAD_min) address[7:0];
      @(negedge cas);
      ma <= #(tCAH_min) 10'bx;
    end
    begin : ras_block
      ras <= 1'b1; 
      ras <= #(tASR_min) 1'b0;
      ras <= #(tASR_min + tRAS_min) 1'b1;
    end
    begin : cas_block
      cas <= 'b1;
      @(negedge ras); 
      cas <= #(tRCD_min) 1'b0; 
      cas <= #(tCSH_min) 1'b1; 
    end
    begin : we_block
      uwe = 1'bx;
      lwe = 1'bx;
      @(negedge cas);
      uwe = 1'b1;
      lwe = 1'b1;
      @(posedge cas);
      uwe = 1'bx;
      lwe = 1'bx;
    end
    begin : oe_blk
      oe <= 1'b1;
      @(negedge cas);
      oe <= #10 1'b0;
      @(posedge cas);
      if(DATA !== rd_data)
          $display("READ ERROR at %0d : Expected Data = %h, Actual Data = %h", $time,rd_data, DATA);
      oe = 1'bx;
    end
  join
  #10;
end
endtask

// This Task does the Word write to the specified address location.
task word_early_write;
input [17:0] address;
input [15:0] wr_data;
begin
  fork
    begin : ma_blk
      ma <= address[17:8]; 
      ma[7:0] <= #(tASR_min + tRAH_min) 9'bx;
      @(negedge ras);
      ma <= #(tRAD_min) address[7:0];
      @(negedge cas);
      ma <= #(tCAH_min) 10'bx;
    end
    begin : ras_blk 
      ras <= 1'b1; 
      ras <= #(tASR_min) 1'b0;
      ras <= #(tASR_min + tRAS_min) 1'b1;
    end
    begin : cas_blk
      cas <= 'b1;
      @(negedge ras); 
      cas <= #(tRCD_min) 1'b0; 
      cas <= #(tCSH_min) 1'b1; 
    end 
    begin : oe_blk
      oe <= 1'bx;
    end
    begin : uwe_blk
      uwe <= 1'bx;
      @(negedge ras);
      uwe <= #(tRAD_min) 1'b0;
      @(negedge cas);
      uwe <= #(tWCH_min) 1'bx; 
    end
    begin : lwe_blk
      lwe <= 1'bx;
      @(negedge ras);
      lwe <= #(tRAD_min) 1'b0;
      @(negedge cas);
      lwe <= #(tWCH_min) 1'bx; 
    end
    begin : data_blk
      data <= 16'bx; 
      @(negedge ras);
      data <= #(tRAD_min) wr_data;
      @(negedge cas);
      data <= #(tWCH_min) 16'bx;
    end
  join
#10;
end
endtask

// THis task writes the write only to the upper byte at the specified
// address location.
task ubyte_early_write;
input [17:0] address;
input [15:0] wr_data;
begin
  fork
    begin : ma_blk
      ma <= address[17:8]; 
      ma <= #(tASR_min + tRAH_min) 10'bx;
      @(negedge ras);
      ma[7:0] <= #(tRAD_min) address[7:0];
      @(negedge cas);
      ma <= #(tCAH_min) 10'bx;
    end
    begin : ras_blk 
      ras <= 1'b1; 
      ras <= #(tASR_min) 1'b0;
      ras <= #(tASR_min + tRAS_min) 1'b1;
    end
    begin : cas_blk
      cas <= 'b1;
      @(negedge ras); 
      cas <= #(tRCD_min) 1'b0; 
      cas <= #(tCSH_min) 1'b1; 
    end 
    begin : oe_blk
      oe <= 1'bx;
    end
    begin : uwe_blk
      uwe <= 1'bx;
      @(negedge ras);
      uwe <= #(tRAD_min) 1'b0;
      @(negedge cas);
      uwe <= #(tWCH_min) 1'bx; 
    end
    begin : lwe_blk
      lwe <= 1'bx;
      @(negedge ras);
      lwe <= #(tRAD_min) 1'b1;
      @(negedge cas);
      lwe <= #(tWCH_min) 1'bx; 
    end
    begin : data_blk
      data <= 16'bx; 
      @(negedge ras);
      data <= #(tRAD_min) wr_data;
      @(negedge cas);
      data <= #(tWCH_min) 16'bx;
    end
  join
#10;
end
endtask


// THis task writes the write only to the lower byte at the specified
// address location.
task lbyte_early_write;
input [17:0] address;
input [15:0] wr_data;
begin
  fork
    begin : ma_blk
      ma <= address[17:8]; 
      ma <= #(tASR_min + tRAH_min) 10'bx;
      @(negedge ras);
      ma[7:0] <= #(tRAD_min) address[7:0];
      @(negedge cas);
      ma <= #(tCAH_min) 10'bx;
    end
    begin : ras_blk 
      ras <= 1'b1; 
      ras <= #(tASR_min) 1'b0;
      ras <= #(tASR_min + tRAS_min) 1'b1;
    end
    begin : cas_blk
      cas <= 'b1;
      @(negedge ras); 
      cas <= #(tRCD_min) 1'b0; 
      cas <= #(tCSH_min) 1'b1; 
    end 
    begin : oe_blk
      oe <= 1'bx;
    end
    begin : uwe_blk
      uwe <= 1'bx;
      @(negedge ras);
      uwe <= #(tRAD_min) 1'b1;
      @(negedge cas);
      uwe <= #(tWCH_min) 1'bx; 
    end
    begin : lwe_blk
      lwe <= 1'bx;
      @(negedge ras);
      lwe <= #(tRAD_min) 1'b0;
      @(negedge cas);
      lwe <= #(tWCH_min) 1'bx; 
    end
    begin : data_blk
      data <= 16'bx; 
      @(negedge ras);
      data <= #(tRAD_min) wr_data;
      @(negedge cas);
      data <= #(tWCH_min) 16'bx;
    end
  join
#10;
end
endtask


reg [17:0] address;
reg [10:0]  row_add;
reg [8:0]  col_add;

initial
begin
  
   $dumpfile("./ut.dump");
   $dumpvars();

   #100

   word_early_write(255, 16'h5555);
   #100;
   read_cyc(255,16'h5555);
   #100;
   word_early_write(256, 16'h6666);
   #100;
   read_cyc(256,16'h6666);
   #100;



   #400;
  $stop;
end

endmodule
