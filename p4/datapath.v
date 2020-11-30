`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:39:44 11/15/2020 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
    input clk,
    input reset,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [15:0] imm,
    input [1:0] RegDst,
    input ALUSrc,
    input [2:0] ALUop,
    input [1:0] EXTop,
    inout RegWrite,
    input MemWrite,
    input [31:0] PC_4,
    input [1:0] Data,
    output ZERO,
    output [31:0] GPR_rs,
	 output [31:0] offset,
	 input [31:0] PC
    );
    wire [31:0] RD1,RD2,ANS,RD,WD3,B;
	 wire [4:0] A3;
    GRF grf1 (
			.reset(reset), 
   		.clk(clk), 
			.WE(RegWrite), 
			.A1(rs), 
			.A2(rt), 
			.A3(A3), 
			.WD3(WD3), 
			.RD1(RD1), 
			.RD2(RD2),
			.PC(PC)
    );
    assign GPR_rs=RD1;
    EXT ext1 (
			.offset(imm), 
			.EXTop(EXTop), 
			.ext_offset(offset)
    );
    mux2_B mux_b (
			.a0(RD2), 
			.a1(offset), 
			.op(ALUSrc), 
			.out(B)
    );
    ALU alu1 (
			.A(RD1), 
			.B(B), 
			.OP(ALUop), 
			.ANS(ANS),
			.ZERO(ZERO)
    );
    DM dm1 (
			.clk(clk), 
			.reset(reset), 
			.WE(MemWrite), 
			.A(ANS), 
			.WD(RD2), 
			.RD(RD),
			.PC(PC)
    );
    mux4_WD3 mux_wd3 (
			.a0(ANS), 
			.a1(RD), 
			.a2(offset), 
			.a3(PC_4), 
			.op(Data),
			.out(WD3)
    );
	mux3_A3 mux_a3 (
			.a0(rd), 
			.a1(rt), 
			.a2(5'd31), 
			.op(RegDst),
			.out(A3)
    );
    

endmodule
