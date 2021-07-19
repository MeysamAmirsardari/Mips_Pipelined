`timescale 1ns / 1ps

module HazardUnit(StallF, StallD, BranchD, ForwardAD, ForwardBD, FlushE, 
		 ForwardAE, ForwardBE, MemtoRegE, RegWriteE, MemtoRegM, RegWriteM,
		 RegWriteW, RsE, RtE, RsD, RtD, WriteRegM, WriteRegW, WriteRegE);

  input BranchD, MemtoRegE, RegWriteE, MemtoRegM, RegWriteM, RegWriteW;
  input [4:0] RsE, RtE, RsD, RtD, WriteRegM, WriteRegW, WriteRegE;
  
  output StallF, StallD, ForwardAD, ForwardBD, FlushE;
  output [1:0] ForwardAE, ForwardBE;

  wire lwsstall;
  
  assign ForwardAE = ((RsE!=0)&&(RsE==WriteRegM)&&(RegWriteM))? 2'b10:
							((RsE!=0)&&(RsE==WriteRegW)&&(RegWriteW))? 2'b01: 2'b00;
							
  assign ForwardBE = ((RtE!=0)&&(RtE==WriteRegM)&&(RegWriteM))? 2'b10:
							((RtE!=0)&&(RtE==WriteRegW)&&(RegWriteW))? 2'b01: 2'b00;
							
  assign branchstall = ((BranchD && RegWriteE &&(WriteRegE==RsD)|| WriteRegE==RtD))||
							  (BranchD && MemtoRegM &&(WriteRegM==RsD)||(WriteRegM==RtD));
							
  assign ForwardAD = (RsD!=0)&&(RsD==WriteRegM)&&RegWriteM;
  assign ForwardBD = (RtD!=0)&&(RtD==WriteRegM)&&RegWriteM;

  assign lwstall = ((RsD==RtE)||(RtD==RtE))&& MemtoRegE;
  assign StallF = lwstall || branchstall;
  assign StallD = lwstall || branchstall;
  assign FlushE = lwstall || branchstall;
 
endmodule
