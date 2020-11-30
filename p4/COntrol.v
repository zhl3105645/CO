`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:06:55 11/15/2020 
// Design Name: 
// Module Name:    COntrol 
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
module COntrol(
    input clk,
	 input reset,
	 input [31:0] GPR_rs,
	 input [31:0] offset,
	 output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [15:0] imm,
    output [1:0] RegDst,
    output ALUSrc,
    output [2:0] ALUop,
    output [1:0] EXTop,
    output RegWrite,
    output MemWrite,
    output [31:0] PC_4,
    output [1:0] Data,
	 output [31:0] PC,
    input ZERO
    );
	wire [1:0] Branch;
	reg [1:0] PCSrc;
	wire [5:0] op,func;
	wire [31:0] Instr;
	wire [25:0] index;
	IFU ifu1(
		.clk(clk), 
		.reset(reset), 
		.PCSrc(PCSrc), 
		.offset(offset), 
		.index(index), 
		.GPR_rs(GPR_rs), 
		.Instr(Instr), 
		.PC_4(PC_4),
		.PC(PC)
    );
	assign func=Instr[5:0];
	assign rd =Instr[15:11];
	assign rt=Instr[20:16];
	assign rs=Instr[25:21];
	assign op=Instr[31:26];
	assign imm=Instr[15:0];
	assign index=Instr[25:0];
	ctrl ct1 (
		.op(op), 
		.func(func), 
		.Branch(Branch), 
		.EXTop(EXTop), 
		.ALUop(ALUop), 
		.MemWrite(MemWrite), 
		.RegWrite(RegWrite), 
		.RegDst(RegDst), 
		.ALUSrc(ALUSrc), 
		.Data(Data)
    );
	 always@(*)
		begin
			if(Branch==2'b01)
				begin
					if(ZERO)
						PCSrc=2'b01;
					else 
						PCSrc=2'b00;
				end
			else 
				PCSrc=Branch;
		end
	 
endmodule
