`timescale 1ns / 1ps

module PipRegDec_Ex(clk, reset, FlushE, RegWriteD, RegWriteE, MemtoRegD,
		 MemtoRegE, MemWriteD, MemWriteE, ALUControlD, ALUControlE, 
		 ALUSrcD, ALUSrcE, RegDstD, RegDstE, RD1_in, RD1_out, RD2_in,
		 RD2_out, RsD, RsE, RtD, RtE, RdE, RdD, SignImmE, SignImmD);
 
  input clk, reset, FlushE, RegWriteD, MemtoRegD, MemWriteD, ALUSrcD, RegDstD;
  input [4:0] ALUControlD, RsD, RtD, RdD;
  input [31:0] RD1_in, RD2_in, SignImmD;
  
  
  output reg RegWriteE, MemtoRegE, MemWriteE, ALUSrcE, RegDstE;
  output reg [4:0] ALUControlE, RsE, RtE, RdE;
  output reg [31:0] RD1_out, RD2_out, SignImmE;

  always @ (posedge clk) 
  begin
    if (reset || FlushE) 
	 begin
			RegWriteE <= 0;
			MemtoRegE <= 0;
			MemWriteE <= 0;
			ALUSrcE <= 0;
			RegDstE <= 0;
			ALUControlE <= 0;
			RD1_out <= 0;
			RD2_out <= 0;
			RsE <= 0;
			RtE <= 0;
			RdE <= 0;
			SignImmE <= 0;
    end
    else 
	 begin
			RegWriteE <= RegWriteD;
			MemtoRegE <= MemtoRegD;
			MemWriteE <= MemWriteD;
			ALUSrcE <= ALUSrcD;
			RegDstE <= RegDstD;
			ALUControlE <= ALUControlD;
			RD1_out <= RD1_in;
			RD2_out <= RD2_in;
			RsE <= RsD;
			RtE <= RtD;
			RdE <= RdD;
			SignImmE <= SignImmD;
    end
  end
endmodule

