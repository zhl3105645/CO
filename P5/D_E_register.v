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
    input RegWriteD,
    input [1:0] MemtoRegD,
    input [0:0] MemWriteD,
    input [2:0] ALUcontrolD,
    input ALUSrcD,
    input [1:0] RegDstD,
    input [31:0] RD1D,
    input [31:0] RD2D,
    input [4:0] rsD,
    input [4:0] rtD,
    input [4:0] rdD,
    input [31:0] PC_4D,
	 input [31:0] ext_immD,
	 input [1:0] TnewD,
	 output reg RegWriteE,
    output reg [1:0] MemtoRegE,
    output reg [0:0] MemWriteE,
    output reg [2:0] ALUcontrolE,
    output reg ALUSrcE,
    output reg [1:0] RegDstE,
    output reg [31:0] RD1E,
    output reg [31:0] RD2E,
    output reg [4:0] rsE,
    output reg [4:0] rtE,
    output reg [4:0] rdE,
    output reg [31:0] PC_4E,
	 output reg [31:0] ext_immE,
	 output reg [1:0] TnewE
    );
	always@(posedge clk)
		begin
			if(reset)
				begin
					RegWriteE=0;
					MemtoRegE=0;
					MemWriteE=0;
					ALUcontrolE=0;
					ALUSrcE=0;
					RegDstE=0;
					RD1E=0;
					RD2E=0;
					rsE=0;
					rtE=0;
					rdE=0;
					PC_4E=0;
					ext_immE=0;
					TnewE=2'b00;
				end
			else if(clr)
				begin
					RegWriteE=0;
					MemtoRegE=0;
					MemWriteE=0;
					ALUcontrolE=0;
					ALUSrcE=0;
					RegDstE=0;
					RD1E=0;
					RD2E=0;
					rsE=0;
					rtE=0;
					rdE=0;
					PC_4E=0;
					ext_immE=0;
					if(TnewD==2'b00)
						TnewE=2'b00;
					else
						TnewE=TnewD-2'b01;
				end
			else 
				begin
					RegWriteE=RegWriteD;
					MemtoRegE=MemtoRegD;
					MemWriteE=MemWriteD;
					ALUcontrolE=ALUcontrolD;
					ALUSrcE=ALUSrcD;
					RegDstE=RegDstD;
					RD1E=RD1D;
					RD2E=RD2D;
					rsE=rsD;
					rtE=rtD;
					rdE=rdD;
					PC_4E=PC_4D;
					ext_immE=ext_immD;
					if(TnewD==2'b00)
						TnewE=2'b00;
					else
						TnewE=TnewD-2'b01;
				end
		end
endmodule
