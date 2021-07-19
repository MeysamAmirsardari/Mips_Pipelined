`timescale 1ns / 1ps

module Fe_Stage(clk, Reset, StallF, RD, PCSrcD, PCBranchD, PCPlus4_F, PC);
  input clk, Reset, StallF, PCSrcD;
  input [31:0] PCBranchD;
  
  output [31:0] RD, PCPlus4_F, PC;

  wire [31:0] PC, PCF;

  MUX2_32bit PC_Mux(
    .in1(PCPlus4_F),
    .in2(PCBranchD),
    .setOut(PCSrcD),
    .out(PC)
  );

  adder add4_toPC(
    .in1(32'H0004),
    .in2(PC),
    .out(PC_plus4_F)
  );
  
  PipRegFe PCReg(
    .clk(clk),
    .Reset(Reset),
    .StallF(StallF), 
    .PC(PC),
    .PCF(PCF)
  );

  InstructionMemory inst (
    .A(PC),
    .RD(RD)
  );

endmodule
