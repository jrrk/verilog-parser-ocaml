
///////////////////////////////////////////////////////////////////////
// FileName:  "Fifo.v"
// Author  :  Venkata Ramana Kalapatapu
// Company :  Sand Microelectronics Inc.,
// Profile :  Sand develops Simulation Models, Synthesizable Cores and
//            Performance Analysis Tools for Processors, Buses and Memory
//            products.  Sand's products include models for industry
//            standard components and Custom developed models for specific
//            simulation environments.
//
//            For more information on Sand, contact us at (408)-441-7138 by
//            telephone, (408)-441-7538 by fax or email your specific needs
//            to sales@sandmicro.com
////////////////////////////////////////////////////////////////////////


`define  FWIDTH     32           // Width of the FIFO.
`define  FDEPTH     4            // Depth of the FIFO.
`define  FCWIDTH    2            // Counter Width of the FIFO 2 to power 
                                 // FCWIDTH = FDEPTH.
module FIFO(  Clk,
              RstN,
              Data_In,
              FClrN,
              FInN,
              FOutN,

              F_Data,
              F_FullN,
              F_LastN,
              F_SLastN,
              F_FirstN,
              F_EmptyN
           );



input                       Clk;      // CLK Signal.
input                       RstN;     // Low Asserted Reset signal.
input [(`FWIDTH-1):0]       Data_In;  // Data Into FIFO.
input                       FInN;     // Write into FIFO Signal.
input                       FClrN;    // Clear Signal to FIFO.
input                       FOutN;    // Read From FIFO Signal.

output [(`FWIDTH-1):0]      F_Data;   // FIFO Data out.
output                      F_FullN;  // FIFO Full indicating signal.
output                      F_EmptyN; // FIFO Empty indicating signal.
output                      F_LastN;  // FIFO Last But One Signal.
output                      F_SLastN; // FIFO SLast But One Signal.
output                      F_FirstN; // Signal indicating only one word inFIFO.


reg                F_FullN;
reg                F_EmptyN;
reg                F_LastN;
reg                F_SLastN;
reg                F_FirstN;

reg    [`FCWIDTH:0]       fcounter;    // counter indicates num of data in FIFO
reg    [(`FCWIDTH-1):0]   rd_ptr;      // current read pointer.
reg    [(`FCWIDTH-1):0]   wr_ptr;      // current write pointer.
wire   [(`FWIDTH-1):0]    FIFODataOut; // Data Out from the FIFO MemBlk
wire   [(`FWIDTH-1):0]    FIFODataIn;  // Data into the FIFO MemBlk

wire   ReadN  = FOutN;
wire   WriteN = FInN;

assign F_Data     = FIFODataOut;  
assign FIFODataIn = Data_In;     


    FIFO_MEM_BLK memblk(.clk(Clk),
                        .writeN(WriteN),
                        .rd_addr(rd_ptr),
                        .wr_addr(wr_ptr),
                        .data_in(FIFODataIn),
                        .data_out(FIFODataOut)
                       ); 



    // Control circuitry for FIFO. If reset or clr signal is asserted
    // all the counters are set to 0. IF write only the write counter
    // is incremented else if read only read counter is incremented
    // else if both, read and write counters are incremented.
    // fcounter indicates the num of items in the fifo. Write only
    // increments  the fcounter, read only decrements the counter and
    // read && write doen't change the counter value.
    always @(posedge Clk or negedge RstN)
    begin

       if(!RstN) begin
           fcounter    <= 0;
           rd_ptr      <= 0;
           wr_ptr      <= 0;
       end
       else begin

           if(~FClrN ) begin
               fcounter    <= 0;
               rd_ptr      <= 0;
               wr_ptr      <= 0;
           end
           else begin

               if(~WriteN) 
                   wr_ptr <= wr_ptr + 1;

               if(~ReadN)
                   rd_ptr <= rd_ptr + 1;
 
               if(~WriteN && ReadN && F_FullN) 
                   fcounter <= fcounter + 1;
    
               else if(WriteN && ~ReadN && F_EmptyN)
                   fcounter <= fcounter - 1;
          end
       end
    end


 
    // All the FIFO status signals depends on the value of fcounter.
    // If the fcounter is equal to afdepth, indicates FIFO is full.
    // If the fcounter is equal to zero, indicates the FIFO is empty.



    // F_EmptyN signal indicates FIFO Empty Status. By Defualt it is 
    // asserted indicating the FIFO is empty. After the First Data is
    // put into the FIFO the signal is deasserted.
    always @(posedge Clk or negedge RstN)
    begin

       if(!RstN)
          F_EmptyN <= 1'b0;

       else begin
          if(FClrN==1'b1) begin

             if(F_EmptyN==1'b0 && WriteN==1'b0)

                 F_EmptyN <= 1'b1;
 
             else if(F_FirstN==1'b0 && ReadN==1'b0 && WriteN==1'b1)
 
                 F_EmptyN <= 1'b0;
          end
          else
             F_EmptyN <= 1'b0;
       end
    end
 
    // F_FirstN signal indicates that there is only one data sitting in the
    // FIFO. When the FIFO isempty and a write to FIFO occurs, this signal
    // gets asserted.
    always @(posedge Clk or negedge RstN)
    begin
 
       if(!RstN)
 
          F_FirstN <= 1'b1;
 
       else begin
          if(FClrN==1'b1) begin
 
             if((F_EmptyN==1'b0 && WriteN==1'b0) ||
                (fcounter==2 && ReadN==1'b0 && WriteN==1'b1))
 
                 F_FirstN <= 1'b0;
  
             else if (F_FirstN==1'b0 && (WriteN ^ ReadN))
                 F_FirstN <= 1'b1;
          end
          else begin
 
             F_FirstN <= 1'b1;
          end
       end   
    end   


    // F_SLastN indicates that there is space for only two data words in the 
    // FIFO.
    always @(posedge Clk or negedge RstN)
    begin
 
       if(!RstN)
 
          F_SLastN <= 1'b1;
       
       else begin

          if(FClrN==1'b1) begin

             if( (F_LastN==1'b0 && ReadN==1'b0 && WriteN==1'b1) || 
                 (fcounter == (`FDEPTH-3) && WriteN==1'b0 && ReadN==1'b1))

                 F_SLastN <= 1'b0;
          

             else if(F_SLastN==1'b0 && (ReadN ^ WriteN) )
                 F_SLastN <= 1'b1;

          end
          else
             F_SLastN <= 1'b1;

       end
    end 

    // F_LastN indicates that there is one space for only one data 
    // word in the  fifo.
    always @(posedge Clk or negedge RstN)
    begin
 
       if(!RstN)
 
          F_LastN <= 1'b1;
 
       else begin
          if(FClrN==1'b1) begin
 
             if ((F_FullN==1'b0 && ReadN==1'b0)  ||
                 (fcounter == (`FDEPTH-2) && WriteN==1'b0 && ReadN==1'b1))
  
                 F_LastN <= 1'b0;
  
             else if(F_LastN==1'b0 && (ReadN ^ WriteN) )
                 F_LastN <= 1'b1;
          end
          else
             F_LastN <= 1'b1;
       end
    end
       

    // F_FullN indicates that the FIFO is full.
    always @(posedge Clk or negedge RstN)
    begin
 
       if(!RstN)
 
           F_FullN <= 1'b1;
 
       else begin
           if(FClrN==1'b1)  begin
 
               if (F_LastN==1'b0 && WriteN==1'b0 && ReadN==1'b1)
       
                    F_FullN <= 1'b0;
 
               else if(F_FullN==1'b0 && ReadN==1'b0)
    
                    F_FullN <= 1'b1;
           end
           else
               F_FullN <= 1'b1;
    
       end
    end
       
endmodule



///////////////////////////////////////////////////////////////////
//
//
//   Configurable memory block for fifo. The width of the mem
//   block is configured via "FWIDTH". All the data into fifo is done 
//   synchronous to block.
//
//   Author : Venkata Ramana Kalapatapu
//
///////////////////////////////////////////////////////////////////

module FIFO_MEM_BLK( clk,
                     writeN,
                     wr_addr,
                     rd_addr,
                     data_in,
                     data_out
                   );


input                    clk;       // input clk.
input                    writeN;    // Write Signal to put datainto fifo.
input  [(`FCWIDTH-1):0]  wr_addr;   // Write Address.
input  [(`FCWIDTH-1):0]  rd_addr;   // Read Address.
input  [(`FWIDTH-1):0]   data_in;   // DataIn in to Memory Block

output [(`FWIDTH-1):0]   data_out;  // Data Out from the Memory Block(FIFO)

wire   [(`FWIDTH-1):0] data_out;  

reg    [(`FWIDTH-1):0] FIFO[0:(`FDEPTH-1)];



assign data_out  = FIFO[rd_addr];

always @(posedge clk)
begin

   if(writeN==1'b0)
      FIFO[wr_addr] <= data_in;
end

endmodule


