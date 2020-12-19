`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:23:40 11/22/2020 
// Design Name: 
// Module Name:    Decode 
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
module Decode(
    input clk,
    input reset,
    input WE,
    input [31:0] InstrD,
    input [31:0] PC_4D1,
	input [31:0] PC_backD,
    input [4:0] A3,
    input [31:0] WD3,
    input forwardAD,
    input forwardBD,
	input [31:0] ALUoutM,
    output [31:0] RD1D,
    output [31:0] RD2D,
	output [31:0] ext_imm,
	output [31:0] ext_index,
	output [31:0] GPR_rs,
    output [31:0] PC_4D2,
	output [1:0] Tuse_rs,
	output [1:0] Tuse_rt,
    output [1:0] TnewD,
	output [4:0] A_rsD,
	output [4:0] A_rtD,
	output [4:0] AwriteD,
	output [4:0] shamtD,
	output RegWriteD,
	output [1:0] MemtoRegD,
	output MemWriteD,
	output [4:0] ALUcontrolD,
	output ALUSrcD,
	output [1:0] RegDstD,
	output reg [1:0] PCSrcD,
	output [1:0] BEopD,
	output startD,
	output [2:0] mult_div_opD,
	output [2:0] LoadopD,
	output [1:0] OUTopD,
	output m_dD
    );
	wire [5:0] op,func;
	wire [4:0] rs,rt,rd;
	wire [15:0] imm;
	wire [25:0] index;
	wire [31:0] rd1,rd2;
	wire [31:0] PC;
	wire [1:0] BranchD;
	wire EXTopD;
	wire [2:0] B_jump;
	assign PC=PC_4D1-4;
	assign op=InstrD[31:26];
	assign func=InstrD[5:0];
	assign rs=InstrD[25:21];
	assign rt=InstrD[20:16];
	assign rd=InstrD[15:11];
	assign shamtD=InstrD[10:6];
	assign imm=InstrD[15:0];
	assign index=InstrD[25:0];
	control ctrl (
    .op(op), 
    .func(func), 
	.rt(rt),
    .Branch(BranchD), 
    .EXTop(EXTopD), 
    .ALUcontrol(ALUcontrolD), 
    .MemWrite(MemWriteD), 
    .RegWrite(RegWriteD), 
    .RegDst(RegDstD), 
    .ALUSrc(ALUSrcD), 
    .MemtoReg(MemtoRegD),
	.BEop(BEopD),
	.start(startD),
	.mult_div_op(mult_div_opD),
	.Loadop(LoadopD),
	.OUTop(OUTopD),
	.m_d(m_dD),
	.B_jump(B_jump)
    );
	GRF grf (
    .reset(reset), 
    .clk(clk), 
    .WE(WE), 
    .PC_4(PC_4D1), 
	.PC_backD(PC_backD),
    .A1(rs), 
    .A2(rt), 
    .A3(A3), 
    .WD3(WD3), 
    .RD1(rd1), 
    .RD2(rd2)
    );
	EXT ext (
    .offset(imm), 
    .EXTop(EXTopD), 
    .ext_offset(ext_imm)
    );
	 AT at (
    .InstrD(InstrD), 
    .Tuse_rs(Tuse_rs), 
    .Tuse_rt(Tuse_rt), 
    .TnewD(TnewD), 
    .A_rsD(A_rsD), 
    .A_rtD(A_rtD), 
    .AwriteD(AwriteD)
    );
	assign RD1D=(forwardAD==1'b1)?ALUoutM:rd1;
	assign RD2D=(forwardBD==1'b1)?ALUoutM:rd2;
	assign ext_index={PC[31:28],index,2'b00};
	assign GPR_rs=RD1D;
	assign PC_4D2=PC_4D1;
	always@(*)
		begin
			case(B_jump)
				3'b000:PCSrcD=BranchD;
				3'b001:PCSrcD=(RD1D==RD2D)?2'b01:2'b00;
				3'b010:PCSrcD=(RD1D!=RD2D)?2'b01:2'b00;
				3'b011:PCSrcD=($signed(RD1D)>=0)?2'b01:2'b00;
				3'b100:PCSrcD=($signed(RD1D)>0)?2'b01:2'b00;
				3'b101:PCSrcD=($signed(RD1D)<=0)?2'b01:2'b00;
				3'b110:PCSrcD=($signed(RD1D)<0)?2'b01:2'b00;
				default:PCSrcD=2'b00;
			endcase
		end
endmodule
