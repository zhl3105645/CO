`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:05:24 11/22/2020 
// Design Name: 
// Module Name:    F_D_register 
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
module F_D_register(
	 input clk,
	 input reset,
	 input EN,
    input [31:0] InstrF,
    input [31:0] PC_4F,
    output reg [31:0] InstrD,
    output reg [31:0] PC_4D
    );
	always@(posedge clk)
		begin
			if(reset)
				begin
					InstrD=32'b0;
					PC_4D=32'b0;
				end
			else if(EN==1'b1)
				begin
					InstrD=InstrF;
					PC_4D=PC_4F;
				end
		end
endmodule
