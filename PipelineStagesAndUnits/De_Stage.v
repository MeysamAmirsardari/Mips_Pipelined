`timescale 1ns / 1ps

module De_Stage(clk, Reset, InstrD, PCPlus4_D, PCBranchD, ForwardAD, ForwardBD,
					 RsD, RtD, RdD, SignImmD, ALUOutM, RegWriteW, RD1_D, RD2_D,
					 PCSrcD, WriteRegW, ResultW, BranchD);
					 
  input clk, Reset, ForwardAD, ForwardBD, RegWriteW, BranchD;
  input [31:0] InstrD, PCPlus4_D, ALUOutM, ResultW;
  
  output PCSrcD;
  output [31:0] RD1_D, RD2_D, SignImmD, PCBranchD;
  output [4:0] RsD, RtD, RdD, WriteRegW;

  wire CU2and, Cond2and;
  wire [1:0] CU2Cond;
  wire Is_Imm, ST_or_BNE;
  wire [31:0] CheckIn1, CheckIn2, shifted;
	
  regfile RegFile (
   .clk(clk),
	.Reset(Reset),
	.A1(InstrD[25:21]),
	.A2(InstrD[20:16]),
	.WriteReg(WriteRegW),
	.WD(ResultW),
	.WE(RegWriteW),
	.RD1(RD1_D),
	.RD2(RD2_D)
    );

  MUX2_32bit mux_D1 (
    .in1(RD1_D),
    .in2(ALUOutM),
    .setOut(ForwardAD),
    .out(CheckIn1)
  );

  MUX2_32bit mux_D2 (
    .in1(RD2_D),
    .in2(ALUOutM),
    .setOut(ForwardBD),
    .out(CheckIn2)
  );

  signExtend signExtend(
    .in(InstrD[15:0]),
    .out(SignImmD)
  );
  
  assign shifted = SignImmD << 2;

  adder adder_De(
    .in1(shifted),
    .in2(PCPlus4_D),
    .out(PCBranchD)
  );

  assign PCSrcD = ((CheckIn1==CheckIn2) && BranchD);
  assign RsD = InstrD[25:21];
  assign RtD = InstrD[20:16];
  assign RdD = InstrD[15:11];
  
  endmodule
