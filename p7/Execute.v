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
	input clk,
	input reset,
    input RegWriteE1,
    input [1:0] MemtoRegE1,
    input MemWriteE1,
    input [4:0] ALUcontrolE,
    input ALUSrcE,
    input [1:0] RegDstE,
	input [1:0] BEopE1,
	input startE,
	input [2:0] mult_div_opE,
	input [2:0] LoadopE1,
	input [1:0] OUTopE,
	input [31:0] ALUoutM,
	input [31:0] ResultW,
	input [1:0] forwardAE,
	input [1:0] forwardBE,
    input [31:0] RD1E,
    input [31:0] RD2E,
	input [4:0] shamtE,
    input [31:0] PC_4E1,
    input [31:0] ext_immE,
	input [1:0] TnewE1,
	input [4:0] A_rsE1,
    input [4:0] A_rtE1,
    input [4:0] AwriteE1,
	input IntReq,
	input [6:2] ExcCodeE1,
	input if_bdE1,
	input loadE1,
	input storeE1,
	input cal_ovE,
	input mfcoE1,
	input mtcoE1,
	input eretE1,
	input [4:0] rdE1,
	output RegWriteE2,
    output [1:0] MemtoRegE2,
    output MemWriteE2, 
	output [1:0] BEopE2,
	output [2:0] LoadopE2,
    output reg [31:0] ALUoutE,
    output [31:0] WriteDataE,
    output [31:0] PC_4E2,
	output [1:0] TnewE2,
	output [4:0] A_rsE2,
    output [4:0] A_rtE2,
    output [4:0] AwriteE2,
	output BusyE,
	output [6:2] ExcCodeE2,
	output if_bdE2,
	output loadE2,
	output storeE2,
	output OVE,
	output mfcoE2,
	output mtcoE2,
	output eretE2,
	output [4:0] rdE2
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
    .a1(ext_immE), 
    .op(ALUSrcE), 
    .out(SrcBE)
    );
	wire [31:0] ALUoutE1;
	 ALU alu (
    .A(SrcAE), 
    .B(SrcBE), 
	.shamt(shamtE),
    .OP(ALUcontrolE), 
    .ANS(ALUoutE1),
	.OV(OVE)
    );
	wire [31:0] HI,LO;
	mult_div m_d (
    .clk(clk), 
    .reset(reset), 
	.flush(IntReq),
    .D1(SrcAE), 
    .D2(SrcBE), 
    .mult_div_op(mult_div_opE), 
    .start(startE), 
    .Busy(BusyE), 
    .HI(HI), 
    .LO(LO)
    );
	always@(*)
		begin
			case(OUTopE)
				2'b00:ALUoutE=ALUoutE1;
				2'b01:ALUoutE=HI;
				2'b10:ALUoutE=LO;
			endcase
		end
	 assign RegWriteE2=RegWriteE1;
	 assign MemtoRegE2=MemtoRegE1;
	 assign MemWriteE2=MemWriteE1;
	 assign BEopE2=BEopE1;
	 assign WriteDataE=B;
	 assign PC_4E2=PC_4E1;
	 assign TnewE2=TnewE1;
	 assign A_rsE2=A_rsE1;
	 assign A_rtE2=A_rtE1;
	 assign AwriteE2=AwriteE1;
	 assign LoadopE2=LoadopE1;
	 assign ExcCodeE2[6:2]=(OVE&&cal_ovE)?5'd12:ExcCodeE1[6:2];
	 assign if_bdE2=if_bdE1;
	 assign loadE2=loadE1;
	 assign storeE2=storeE1;
	assign mfcoE2=mfcoE1;
	assign mtcoE2=mtcoE1;
	assign eretE2=eretE1;
	assign rdE2=rdE1;
endmodule
