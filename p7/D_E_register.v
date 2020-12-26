`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:14:24 11/22/2020 
// Design Name: 
// Module Name:    D_E_register 
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
module D_E_register(
	input clk,
	input reset,
	input clr,
	input CLR,
    input RegWriteD,
    input [1:0] MemtoRegD,
    input MemWriteD,
    input [4:0] ALUcontrolD,
    input ALUSrcD,
    input [1:0] RegDstD,
	input [1:0] BEopD,
	input startD,
	input [2:0] mult_div_opD,
	input [2:0] LoadopD,
	input [1:0] OUTopD,
    input [31:0] RD1D,
    input [31:0] RD2D,
	input [4:0] shamtD,
    input [31:0] PC_4D,
	input [31:0] ext_immD,
	input [1:0] TnewD,
	input [4:0] A_rsD,
    input [4:0] A_rtD,
    input [4:0] AwriteD,
	input [6:2] ExcCodeD,
	input if_bdD,
	input loadD,
	input storeD,
	input cal_ovD,
	input mfcoD,
	input mtcoD,
	input eretD,
	input [4:0] rdD,
	output reg RegWriteE,
    output reg [1:0] MemtoRegE,
    output reg  MemWriteE,
    output reg [4:0] ALUcontrolE,
    output reg ALUSrcE,
    output reg [1:0] RegDstE,
	output reg [1:0] BEopE,
	output reg startE,
	output reg [2:0] mult_div_opE,
	output reg [2:0] LoadopE,
	output reg [1:0] OUTopE,
    output reg [31:0] RD1E,
    output reg [31:0] RD2E,
	output reg [4:0] shamtE,
    output reg [31:0] PC_4E,
	output reg [31:0] ext_immE,
	output reg [1:0] TnewE,
	output reg [4:0] A_rsE,
    output reg [4:0] A_rtE,
    output reg [4:0] AwriteE,
	output reg [6:2] ExcCodeE,
	output reg if_bdE,
	output reg loadE,
	output reg storeE,
	output reg cal_ovE,
	output reg mfcoE,
	output reg mtcoE,
	output reg eretE,
	output reg [4:0] rdE
    );
	always@(posedge clk)
		begin
			if(reset||CLR)
				begin
					RegWriteE<=0;
					MemtoRegE<=0;
					MemWriteE<=0;
					ALUcontrolE<=0;
					ALUSrcE<=0;
					RegDstE<=0;
					BEopE<=0;
					startE<=0;
					mult_div_opE<=0;
					LoadopE<=0;
					OUTopE<=0;
					RD1E<=0;
					RD2E<=0;
					shamtE<=0;
					A_rsE<=0;
					A_rtE<=0;
					AwriteE<=0;
					PC_4E<=0;
					ext_immE<=0;
					TnewE<=0;
					ExcCodeE[6:2]<=5'b0;
					if_bdE<=1'b0;
					loadE<=1'b0;
					storeE<=1'b0;
					cal_ovE<=1'b0;
					mfcoE<=1'b0;
					mtcoE<=1'b0;
					eretE<=1'b0;
					rdE<=5'd0;
				end
			else if(clr)
				begin
					RegWriteE<=0;
					MemtoRegE<=0;
					MemWriteE<=0;
					ALUcontrolE<=0;
					ALUSrcE<=0;
					RegDstE<=0;
					BEopE<=0;
					startE<=0;
					mult_div_opE<=0;
					LoadopE<=0;
					OUTopE<=0;
					RD1E<=0;
					RD2E<=0;
					shamtE<=0;
					A_rsE<=0;
					A_rtE<=0;
					AwriteE<=0;
					PC_4E<=PC_4D;
					ext_immE<=0;
					TnewE<=0;
					ExcCodeE[6:2]<=5'b0;
					if_bdE<=if_bdD;
					loadE<=1'b0;
					storeE<=1'b0;
					cal_ovE<=1'b0;
					mfcoE<=1'b0;
					mtcoE<=1'b0;
					eretE<=1'b0;
					rdE<=5'd0;
				end
			else 
				begin
					RegWriteE<=RegWriteD;
					MemtoRegE<=MemtoRegD;
					MemWriteE<=MemWriteD;
					ALUcontrolE<=ALUcontrolD;
					ALUSrcE<=ALUSrcD;
					RegDstE<=RegDstD;
					BEopE<=BEopD;
					startE<=startD;
					mult_div_opE<=mult_div_opD;
					LoadopE<=LoadopD;
					OUTopE<=OUTopD;
					RD1E<=RD1D;
					RD2E<=RD2D;
					shamtE<=shamtD;
					A_rsE<=A_rsD;
					A_rtE<=A_rtD;
					AwriteE<=AwriteD;
					PC_4E<=PC_4D;
					ext_immE<=ext_immD;
					if(TnewD==2'b00)
						TnewE<=2'b00;
					else
						TnewE<=TnewD-2'b01;
					ExcCodeE[6:2]<=ExcCodeD[6:2];
					if_bdE<=if_bdD;
					loadE<=loadD;
					storeE<=storeD;
					cal_ovE<=cal_ovD;
					mfcoE<=mfcoD;
					mtcoE<=mtcoD;
					eretE<=eretD;
					rdE<=rdD;
				end
		end
endmodule
