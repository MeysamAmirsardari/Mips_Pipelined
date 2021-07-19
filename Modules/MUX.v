`timescale 1ns / 1ps

module MUX2_32bit (in1, in2, setOut, out);
  input setOut;
  input [31:0] in1, in2;
  output [31:0] out;

  assign out = (setOut == 0) ? in1 : in2;
endmodule

module MUX3 (in1, in2, in3, setOut, out);
  input [31:0] in1, in2, in3;
  input [1:0] setOut;
  
  output [31:0] out;

  assign out = (setOut == 2'd0) ? in1 :
               (setOut == 2'd1) ? in2 : in3;
endmodule



