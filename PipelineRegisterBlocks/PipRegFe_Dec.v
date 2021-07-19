`timescale 1ns / 1ps

module PipRegFe_Dec(clk, Reset, StallD, Flush, Inst_in, Inst_out, PC_in, PC_out);
  input clk, Reset, Flush, StallD;
  input [31:0] Inst_in;
  input [31:0] PC_in;
  output reg [31:0] Inst_out;
  output reg [31:0] PC_out;

  always @ (posedge clk) 
  begin
    if (Reset||Flush) 
	 begin
		Inst_out <= 0;
      PC_out <= 0;
    end
    else 
	 begin
      if (~StallD) 
		begin
          Inst_out <= Inst_in;
          PC_out <= PC_in;
      end
    end
  end
endmodule



