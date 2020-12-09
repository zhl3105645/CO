`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:35:35 11/22/2020 
// Design Name: 
// Module Name:    Execute 
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
module Execute(
    input RegWriteE1,
    input [1:0] MemtoRegE1,
    input MemWriteE1,
    input [2:0] ALUcontrolE,
    input ALUSrcE,
    input [1:0] RegDstE,
	 input [31:0] ALUoutM,
	 input [31:0] ResultW,
	 input [1:0] forwardAE,
	 input [1:0] forwardBE,
    input [31:0] RD1E,
    input [31:0] RD2E,
    input [31:0] PC_4E1,
    input [31:0] ext_immE1,
	 input [1:0] TnewE1,
	 input [4:0] A_rsE1,
    input [4:0] A_rtE1,
    input [4:0] AwriteE1,
	 output RegWriteE2,
    output [1:0] MemtoRegE2,
    output MemWriteE2, 
    output [31:0] ALUoutE,
    output [31:0] WriteDataE,
    output [31:0] PC_4E2,
    output [31:0] ext_immE2,
	 output [1:0] TnewE2,
	 output [4:0] A_rsE2,
    output [4:0] A_rtE2,
    output [4:0] AwriteE2
    );
	 wire [31:0] SrcAE,SrcBE,B;
	mux3_32 SrcA (
    .a0(RD1E), 
    .a1(ResultW), 
    .a2(ALUoutM), 
    .op(forwardAE), 
    .out(SrcAE)
    );	
	 mux3_32 b (
    .a0(RD2E), 
    .a1(ResultW), 
    .a2(ALUoutM), 
    .op(forwardBE), 
    .out(B)
    );
	 mux2_32 SrcB (
    .a0(B), 
    .a1(ext_immE1), 
    .op(ALUSrcE), 
    .out(SrcBE)
    );
	 ALU alu (
    .A(SrcAE), 
    .B(SrcBE), 
    .OP(ALUcontrolE), 
    .ANS(ALUoutE)
    );
	 assign RegWriteE2=RegWriteE1;
	 assign MemtoRegE2=MemtoRegE1;
	 assign MemWriteE2=MemWriteE1;
	 assign WriteDataE=B;
	 assign PC_4E2=PC_4E1;
	 assign ext_immE2=ext_immE1;
	 assign TnewE2=TnewE1;
	 assign A_rsE2=A_rsE1;
	 assign A_rtE2=A_rtE1;
	 assign AwriteE2=AwriteE1;
endmodule
