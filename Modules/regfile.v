`timescale 1ns / 1ps

module regfile(
	input clk,
	input Reset,
	input [4:0] A1,
	input [4:0] A2,
	input [4:0] WriteReg,
	input [31:0] WD,
	input WE,
	output [31:0] RD1,
	output [31:0] RD2
    );

reg [31:0] file[31:0];
integer i;

assign RD1 = file[A1[4:0]];
assign RD2 = file[A2[4:0]];

always @(posedge clk)
begin
	 if (Reset) begin
      for (i = 0; i < 32; i = i + 1)
        file[i] <= 0;
	    end
    else if(WE)
        file[WriteReg[4:0]] <= WD;
end

endmodule
