module Control(OpCode, Funct, zero, Branch,
	PCSrc, RegWrite, RegDst, 
	MemWrite, MemtoReg, 
	SgnZero, ALUSrc, ALUOp);
	
	input [5:0] OpCode;
	input [5:0] Funct;
	input zero;
	
	output Branch;
	output MemtoReg;
	output MemWrite;
	output PCSrc;
	output [3:0] ALUOp;
	output ALUSrc;
	output RegDst;
	output RegWrite;
	output SgnZero;

	
	//output Branch;
	assign Branch = ((OpCode == 6'h04)||(OpCode == 6'h05))?1'b1:1'b0;
	
	assign PCSrc = ((OpCode==6'h05)||(OpCode==6'h04))? 1'b1 : 1'b0;
	
	assign MemWrite = (OpCode == 6'h2b)? 1'b1:1'b0;

    // r-type/addi/lw/sw/beq/bne/andi/ori/xori/addiu/slti/sltiu/
	assign RegWrite = (OpCode == 6'h00 || OpCode == 6'h08 || 
					 OpCode == 6'h23 ||OpCode == 6'h0c ||
					 OpCode == 6'h0d ||OpCode == 6'h0e ||
					 OpCode == 6'h09 ||OpCode == 6'h0a ||
					 OpCode == 6'h0d ||OpCode == 6'h0b)?1'b1:1'b0;

	assign RegDst = (OpCode == 6'h00)? 1'b1:1'b0;

	assign MemtoReg = (OpCode == 6'h23)? 1'b1:1'b0;

	assign ALUSrc = (OpCode == 6'h23)?1'b1:
				   (OpCode == 6'h2b)?1'b1:
				   (OpCode == 6'h0f)?1'b1:
				   (OpCode == 6'h08)?1'b1:
				   (OpCode == 6'h09)?1'b1:
				   (OpCode == 6'h0c)?1'b1:
				   (OpCode == 6'h0a)?1'b1:
				   (OpCode == 6'h0d)?1'b1:
				   (OpCode == 6'h0e)?1'b1:
				   (OpCode == 6'h0b)?1'b1:1'b0;
	
	assign ALUOp[3:0] = 
		((OpCode==6'h08)||((OpCode==6'h00)&&(Funct==6'h20)))? 4'b0000: //ADD
		((OpCode==6'h00)&&(Funct==6'h22))? 4'b0001: //SUB
		(((OpCode==6'h00)&&(Funct==6'h24))||(OpCode==6'h0c))? 4'b0010: //AND
		(((OpCode==6'h00)&&(Funct==6'h25))||(OpCode==6'h0d))? 4'b0011: //OR
		(((OpCode==6'h00)&&(Funct==6'h28))||(OpCode==6'h0e))? 4'b0100: //XOR
		((OpCode==6'h00)&&(Funct==6'h27))? 4'b0101: //NOR
		((OpCode==6'h0a)||((OpCode==6'h00)&&(Funct==6'h2a)))? 4'b0110: //SLT
		(((OpCode==6'h00)&&(Funct==6'h2b))||(OpCode==6'h0b))? 4'b0111: //SLTU
		((OpCode==6'h00)&&(Funct==6'h19))? 4'b1000: //MULTU
		(((OpCode==6'h00)&&(Funct==6'h21))||(OpCode==6'h09))? 4'b1001: //ADDU
		((OpCode==6'h00)&&(Funct==6'h23))? 4'b1010:4'b1111; //SUBU
		
	assign SgnZero = 1'b1;
	
endmodule
