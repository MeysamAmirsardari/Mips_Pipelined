module DataPath(clk, reset);
	input reset, clk;
	
	reg [31:0] PC;
	wire [31:0] PC_next;
	always @(posedge reset or posedge clk)
		if (reset)
			PC <= 32'h00000000;
		else
			PC <= PC_next;
	
	// PC ALU:
	wire [31:0] PC_plus4;
	assign PC_plus4 = PC + 32'd4;
	
	wire [31:0] Instruction;
	InstructionMemory imem1(.A(PC), .RD(Instruction));
	
	wire MemtoReg;
	wire MemWrite;
	wire PCSrc;
	wire RegDst;
	wire RegWrite;
	wire SgnZero;
	wire Branch;
	wire [3:0] ALUOp;
	wire ALUSrc;
 
	// Mane Controller:
	Control control(
		.OpCode(Instruction[31:26]), .Funct(Instruction[5:0]), .Zero(Zero),
		.PCSrc(PCSrc), .RegWrite(RegWrite), .RegDst(RegDst), 
		.MemWrite(MemWrite), .MemtoReg(MemtoReg), .SgnZero(SgnZero),
		.ALUSrc(ALUSrc), .ALUOp(ALUOp));
	
	wire [31:0] SrcA, SrcB, Result;
	wire [4:0] Write_register;
	
	assign Write_register = (RegDst)? Instruction[20:16]:Instruction[15:11];
	
	//register file:
	regfile regfile1(.clk(clk), .A1(Instruction[25:21]), .A2(Instruction[20:16]), .WriteReg(Write_register),
		.WD(Result), .WE(RegWrite), .RD1(SrcA), .RD2(RD2));
	
	//Sign Extend:
	wire [31:0] SignImm;
	assign SignImm = {{16{Instruction[15]}}, Instruction[15:0]};
	
	wire [31:0] ALUResult;
	
	assign SrcB = ALUSrc? SignImm: RD2;
	
	//ALU1:
	alu alu1(.A(SrcA), .B(SrcB), .ALUCon(ALUCtl), .Y(ALUResult), .Z(Zero));
	
	//Data Memory:
	wire [31:0] Read_data;
	dmem dmem(.clk(clk), .WE(MemWrite), .A(ALUResult), .WD(SrcB), .RD(Read_data), .MemReady(MemRead));
	
	assign Result = (MemtoReg)? Read_data: ALUResult;
	
	//shift unit:
	wire [31:0] shifted;
	assign shifted = {SignImm[29:0], 2'b00};
	
	//ALU2
	wire [31:0] PCBranch;
	assign PCBranch = PC_plus4 + shifted;

    //MUX_PC
	assign PC_next = (PCSrc)? PCBranch : PC_plus4;

endmodule   