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
    input [31:0] RDW,
    input [31:0] ALUoutW,
    input [4:0] AwriteW1,
    input [31:0] PC_4W,
    input [31:0] ext_immW,
    output RegWriteW2,
    output [31:0] ResultW,
    output [4:0] AwriteW2,
	 output [31:0] PC_backD
    );
	 wire [31:0] PC_8;
	 assign PC_8=PC_4W+4;
	 assign PC_backD=PC_4W-4;
	mux4_32 result (
    .a0(ALUoutW), 
    .a1(RDW), 
    .a2(PC_8), 
    .a3(ext_immW), 
    .op(MemtoRegW), 
    .out(ResultW)
    );
	assign RegWriteW2=RegWriteW1;
	assign AwriteW2=AwriteW1;
endmodule
