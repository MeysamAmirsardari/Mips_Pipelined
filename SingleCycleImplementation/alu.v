`timescale 1ns / 1ps

module alu(
	input [31:0] A,
	input [31:0] B,
	input [3:0] ALUcon,
	output reg [31:0] Y,
	output reg Z);

reg [31:0] sol;
reg [31:0] res_Hi;
reg [31:0] res_Lo;

always @(posedge A or posedge B or posedge ALUcon)
begin
    case(ALUcon)
    4'b0000: sol = A+B;
    4'b0001: sol = A-B;
    4'b0010: sol = A&B;
    4'b0011: sol = A|B;
    4'b0100: sol = A^B;
    4'b0101: sol = ~(A|B);
    4'b0110: sol = (A<B)? A:B;
    4'b0111: sol = (((A<0)? (~A):A)<((B<0)? (~B):B)) ? A:B;
    4'b1000: {res_Hi, res_Hi} = ((A<0)? (~A):A)*((B<0)? (~B):B);
    endcase
    
    Y <= sol;
    Z <= ~((sol==0)&&(res_Hi==0));
end

endmodule
