`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:59:52 11/14/2020 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );
	 wire [31:0] GPR_rs,offset,PC_4,PC;
	 wire [4:0] rs,rt,rd;
	 wire [15:0] imm;
	 wire [2:0] ALUop;
	 wire [1:0] RegDst,EXTop,Data;
	 wire ALUSrc,RegWrite,MemWrite,ZERO;
	 
	COntrol control1 (
    .clk(clk), 
    .reset(reset), 
    .GPR_rs(GPR_rs), 
    .offset(offset), 
    .rs(rs), 
    .rt(rt), 
    .rd(rd), 
    .imm(imm), 
    .RegDst(RegDst), 
    .ALUSrc(ALUSrc), 
    .ALUop(ALUop), 
    .EXTop(EXTop), 
    .RegWrite(RegWrite), 
    .MemWrite(MemWrite), 
    .PC_4(PC_4), 
    .Data(Data), 
    .ZERO(ZERO),
	 .PC(PC)
    );
	datapath path1 (
    .clk(clk), 
    .reset(reset), 
    .rs(rs), 
    .rt(rt), 
    .rd(rd), 
    .imm(imm), 
    .RegDst(RegDst), 
    .ALUSrc(ALUSrc), 
    .ALUop(ALUop), 
    .EXTop(EXTop), 
    .RegWrite(RegWrite), 
    .MemWrite(MemWrite), 
    .PC_4(PC_4), 
    .Data(Data), 
    .ZERO(ZERO), 
    .GPR_rs(GPR_rs), 
    .offset(offset),
	 .PC(PC)
    );

endmodule
