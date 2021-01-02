`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:35:57 11/22/2020 
// Design Name: 
// Module Name:    WriteBack 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module WriteBack(
    input RegWriteW1,
    input [1:0] MemtoRegW,
	input [2:0] LoadopW,
    input [31:0] RDW,
    input [31:0] ALUoutW,
    input [4:0] AwriteW1,
    input [31:0] PC_4W,
    output RegWriteW2,
    output [31:0] ResultW,
    output [4:0] AwriteW2,
	output [31:0] PC_backD
    );
	 wire [31:0] PC_8;
	 assign PC_8=PC_4W+4;
	 assign PC_backD=PC_4W-4;
	 wire [31:0] Dout;
	 ext_load EXT_L (
    .A(ALUoutW[1:0]), 
    .Din(RDW), 
    .op(LoadopW), 
    .Dout(Dout)
    );
	mux3_32 result (
    .a0(ALUoutW), 
    .a1(Dout), 
    .a2(PC_8),  
    .op(MemtoRegW), 
    .out(ResultW)
    );
	assign RegWriteW2=RegWriteW1;
	assign AwriteW2=AwriteW1;
endmodule
