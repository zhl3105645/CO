`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:25:26 11/22/2020 
// Design Name: 
// Module Name:    M_W_register 
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
module M_W_register(
	input clk,
	input reset,
	input CLR,
    input RegWriteM,
    input [1:0] MemtoRegM,
	input [2:0] LoadopM,
    input [31:0] RDM,
    input [31:0] ALUoutM,
    input [31:0] PC_4M,
	input [1:0] TnewM,
	input [4:0] AwriteM,
    output reg RegWriteW,
    output reg [1:0] MemtoRegW,
	output reg [2:0] LoadopW,
    output reg [31:0] RDW,
    output reg [31:0] ALUoutW,
    output reg [31:0] PC_4W,
	output reg [1:0] TnewW,
	output reg [4:0] AwriteW
    );
	always@(posedge clk)
		begin
			if(reset||CLR)
				begin
					RegWriteW=1'b0;
					MemtoRegW=2'b00;
					LoadopW=3'b0;
					RDW=32'd0;
					ALUoutW=32'd0;
					PC_4W=32'd0;
					TnewW=2'b00;
					AwriteW=5'd0;
				end
			else
				begin
					RegWriteW=RegWriteM;
					MemtoRegW=MemtoRegM;
					LoadopW=LoadopM;
					RDW=RDM;
					ALUoutW=ALUoutM;
					PC_4W=PC_4M;
					AwriteW=AwriteM;
					if(TnewM==2'b00)
							TnewW=2'b00;
					else
							TnewW=TnewM-2'b01;
				end
		end
endmodule
