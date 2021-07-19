`timescale 1ns / 1ps

module Mem_Stage(clk, ALUOutM, WriteDataM, MemWriteM, ReadDataM);
  input clk, MemWriteM;
  input [31:0] ALUOutM, WriteDataM;
  
  output [31:0] ReadDataM;
  
  wire MemReady;

  dmem dataMemory (
    .clk(clk),
	 .WE(MemWriteM),
	 .A(ALUOutM),
	 .WD(WriteDataM),
	 .RD(ReadDataM),
	 .MemReady(MemReady)
  );
endmodule
