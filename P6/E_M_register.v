`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:06:51 11/22/2020 
// Design Name: 
// Module Name:    E_M_register 
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
module E_M_register(
	input clk,
	input reset,
    input RegWriteE,
    input [1:0] MemtoRegE,
    input MemWriteE,
	input [1:0] BEopE,
	input [2:0] LoadopE,
    input [31:0] ALUoutE,
    input [31:0] WriteDataE,
    input [31:0] PC_4E,
	input [1:0] TnewE,
	input [4:0] A_rsE,
	input [4:0] A_rtE,
	input [4:0] AwriteE,
    output reg RegWriteM,
    output reg [1:0] MemtoRegM,
    output reg MemWriteM,
	output reg [1:0] BEopM,
	output reg [2:0] LoadopM,
    output reg [31:0] ALUoutM,
	output reg [31:0] WriteDataM,
    output reg [31:0] PC_4M,
	output reg [1:0] TnewM,
	output reg [4:0] A_rsM,
	output reg [4:0] A_rtM,
	output reg [4:0] AwriteM
    );
	always@(posedge clk)
		begin
			if(reset)
				begin
					RegWriteM=1'b0;
					MemtoRegM=2'b00;
					MemWriteM=1'b0;
					BEopM=2'b0;
					LoadopM=3'b0;
					ALUoutM=32'd0;
					WriteDataM=32'd0;
					PC_4M=32'd0;
					TnewM=2'b00;
					A_rsM=5'd0;
					A_rtM=5'd0;
					AwriteM=5'd0;
				end 
			else 
				begin
					RegWriteM=RegWriteE;
					MemtoRegM=MemtoRegE;
					MemWriteM=MemWriteE;
					BEopM=BEopE;
					LoadopM=LoadopE;
					ALUoutM=ALUoutE;
					WriteDataM=WriteDataE;
					PC_4M=PC_4E;
					A_rsM=A_rsE;
					A_rtM=A_rtE;
					AwriteM=AwriteE;
					if(TnewE==2'b00)
							TnewM=2'b00;
					else
							TnewM=TnewE-2'b01;
				end
			
		end

endmodule
