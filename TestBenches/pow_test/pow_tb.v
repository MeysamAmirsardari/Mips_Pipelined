
`timescale 1ns/1ns

module pow_tb;
   integer file;
   reg clk = 1;
   always @(clk)
      clk <= #5 ~clk;

   reg reset;
   initial begin
      reset = 1;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      #1;
      reset = 0;
   end

   initial
      $readmemh("powtest.hex", SingleCycle.InstructionMemory.imem);

   parameter end_pc = 32'h54;
 
   integer i;
   always @(SingleCycle.pc)
      if(SingleCycle.pc == end_pc) begin
        $write("%x ", SingleCycle.DataMemory.dmem[15]);
        $write("\n");
        $stop;
      end
      
   MIPS SingleCycle(
      .clk(clk),
      .reset(reset)
   );


endmodule

