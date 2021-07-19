`timescale 1ns/1ns

module ALU_test();
	//registers
	reg [31:0] SrcA;
	reg [31:0] SrcB;
	reg [3:0] ALUcon;
	
   wire [31:0] Y;
	wire Z;
	 
	
	initial
		begin
			SrcA = 32'd0;
			SrcB = 32'd0;
			ALUcon = 4'b0000;

			#30
			SrcA = 32'h0019;
			SrcB = 32'h0064;
			ALUcon = 4'b0000;
			
			#30
			SrcA = 32'h0019;
			SrcB = 32'h000a;
			ALUcon = 4'b0001;
			
			#30
			SrcA = 32'd25536;
			SrcB = 32'd150100;
			ALUcon = 4'b1000;
			
			#30
			SrcA = 32'ha0a0;
			SrcB = 32'h5f5f;
			ALUcon = 4'b0011;
			
			#30
			SrcA = 32'h1212;
			SrcB = 32'h3232;
			ALUcon = 4'b0100;
			
			#30
			SrcA = 32'h2222;
			SrcB = 32'h2222;
			ALUcon = 4'b0101;
			
			#30
			SrcA = 32'hf345;
			SrcB = 32'h7745;
			ALUcon = 4'b0110;
			
			#30
			SrcA = 32'hf345;
			SrcB = 32'h7745;
			ALUcon = 4'b0111;
			
			#100
		$stop();
		end
  
	// Module instance under test
	alu alu (.A(SrcA), .B(SrcB),
						 .ALUcon(ALUcon), .Y(Y), .Z(Z));       
endmodule
