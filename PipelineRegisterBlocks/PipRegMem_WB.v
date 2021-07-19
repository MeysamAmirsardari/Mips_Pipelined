`timescale 1ns / 1ps

module PipRegMem_WB(clk, Reset, RegWriteM, RegWriteW, MemtoRegM, MemtoRegW,
		 ReadDataM, ReadDataW, ALUOutM, ALUOutW);
		 
  input clk, Reset, RegWriteM, MemtoRegM;
  input [31:0] ReadDataM, ALUOutM;

  output reg RegWriteW, MemtoRegW;
  output reg [31:0] ReadDataW, ALUOutW;

  always @ (posedge clk) 
  begin
    if (Reset) 
	 begin
      RegWriteW <= 0;
		MemtoRegW <= 0;
		ReadDataW <= 0;
		ALUOutW <= 0;
    end
    else 
	 begin
      RegWriteW <= RegWriteM;
		MemtoRegW <= MemtoRegM;
		ReadDataW <= ReadDataM;
		ALUOutW <= ALUOutM;
    end
  end
endmodule



