`timescale 1ns / 1ps

module InstructionMemory( 
    input [31:0] A, 
    output wire [31:0] RD);
   
    reg [31:0] RAM[1024:0];
	 
	 initial
		$readmemh("powerTest.hex",RAM);
    
    assign RD = RAM[A[31:2]];
endmodule