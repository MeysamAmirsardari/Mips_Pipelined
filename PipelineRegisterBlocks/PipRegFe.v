`timescale 1ns / 1ps

module PipRegFe(clk, Reset, StallF, PC, PCF);
input clk, StallF, Reset;
input [31:0] PC;

output reg [31:0] PCF;

always @ (posedge clk) 
  begin
    if (Reset) 
		PCF <= 0;
    else 
	 begin
      if (~StallF) 
          PCF <= PC;
	 end
  end
endmodule
