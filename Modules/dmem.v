`timescale 1ns / 1ps

module dmem(
	input clk,
	input WE,
	input [31:0] A,
	input [31:0] WD,
	output wire [31:0] RD,
	output wire MemReady
    );


reg [31:0] RAM[1024:0];
	 
assign RD = RAM[A[31:2]];
assign MemReady = 1'b1;

always @ (posedge clk)
begin
    if(WE)
        RAM[A[31:2]] <= WD;
end

endmodule
