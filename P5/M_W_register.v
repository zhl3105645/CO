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
    input RegWriteM,
    input [1:0] MemtoRegM,
    input [31:0] RDM,
    input [31:0] ALUoutM,
    input [4:0] WriteRegM,
    input [31:0] PC_4M,
    input [31:0] ext_immM,
	 input [1:0] TnewM,
    output reg RegWriteW,
    output reg [1:0] MemtoRegW,
    output reg [31:0] RDW,
    output reg [31:0] ALUoutW,
    output reg [4:0] WriteRegW,
    output reg [31:0] PC_4W,
    output reg [31:0] ext_immW,
	 output reg [1:0] TnewW
    );
	always@(posedge clk)
		begin
			if(reset)
				begin
					RegWriteW=1'b0;
					MemtoRegW=2'b00;
					RDW=32'd0;
					ALUoutW=32'd0;
					WriteRegW=5'd0;
					PC_4W=32'd0;
					ext_immW=32'd0;
					TnewW=2'b00;
				end
			RegWriteW=RegWriteM;
			MemtoRegW=MemtoRegM;
			RDW=RDM;
			ALUoutW=ALUoutM;
			WriteRegW=WriteRegM;
			PC_4W=PC_4M;
			ext_immW=ext_immM;
			if(TnewM==2'b00)
					TnewW=2'b00;
			else
					TnewW=TnewM-2'b01;
		end

endmodule
