`timescale 1ns / 1ps

module Ex_Stage(clk, RD1_E, RD2_E, RtE, RdE, SignImmE, RegDstE, ALUSrcE,
					 ALUControlE, ALUOutE, WriteDataE, WriteRegE, ForwardAE,
					 ForwardBE, ResultW);
  input clk, RegDstE, ALUSrcE;
  input [1:0] ForwardAE, ForwardBE;
  input [4:0] RtE, RdE;
  input [3:0] ALUControlE;
  input [31:0] RD1_E, RD2_E, SignImmE, ResultW;
  
  output [4:0] WriteRegE;
  output [31:0] ALUOutE, WriteDataE;

  wire [31:0] SrcAE, SrcBE;
  wire Z;

  MUX3 mux_E1 (
    .in1(RD1_E),
    .in2(ResultW),
    .in3(ALUOutM),
    .setOut(ForwardAE),
    .out(SrcAE)
  );

  MUX3 mux_E2 (
    .in1(RD2_E),
    .in2(ResultW),
    .in3(ALUOutM),
    .setOut(ForwardBE),
    .out(WriteDataE)
  );

  MUX2_32bit mux_E3 (
    .in1(WriteDataE),
    .in2(SignImmE),
    .setOut(ALUSrcE),
    .out(SrcBE)
  );

  alu ALU(
	 .A(SrcAE),
	 .B(SrcBE),
	 .ALUcon(ALUControlE),
	 .Y(ALUOutE),
	 .Z(Z)
  );
  
endmodule 