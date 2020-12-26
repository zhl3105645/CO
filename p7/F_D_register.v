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
	input CLR,
    input [31:0] InstrF,
    input [31:0] PC_4F,
	input [6:2] ExcCodeF,
	input if_bdF,
    output reg [31:0] InstrD,
    output reg [31:0] PC_4D,
	output reg [6:2] ExcCodeD,
	output reg if_bdD
    );
	wire [31:0] PCF;
	assign PCF=PC_4F-4;
	always@(posedge clk)
		begin
			if(reset|CLR)
				begin
					InstrD<=32'b0;
					PC_4D<=32'b0;
					ExcCodeD[6:2]<=5'b0;
					if_bdD<=1'b0;
				end
			else if(EN==1'b1)
				begin
					InstrD<=InstrF;
					PC_4D<=PC_4F;
					ExcCodeD[6:2]<=ExcCodeF[6:2];
					if_bdD<=if_bdF;
					//if(PCF==32'h000031c4)
					//	$display("%d@%h: $%d <= %h", $time,PCF,5'd2,InstrF);
				end
		end
endmodule
