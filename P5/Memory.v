`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:17:39 11/22/2020 
// Design Name: 
// Module Name:    Memory 
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
module Memory(
	 input clk,
	 input reset,
    input RegWriteM1,
    input [1:0] MemtoRegM1,
    input MemWriteM,
    input [31:0] ALUoutM1,
    input [31:0] WriteDataM,
    input [4:0] WriteRegM1,
    input [31:0] PC_4M1,
    input [31:0] ext_immM1,
	 input [1:0] TnewM1,
    output RegWriteM2,
    output [1:0] MemtoRegM2,
    output [31:0] RDM,
    output [31:0] ALUoutM2,
    output [4:0] WriteRegM2,
    output [31:0] PC_4M2,
    output [31:0] ext_immM2,
	 output [1:0] TnewM2
    );
	DM dm (
    .clk(clk), 
    .reset(reset), 
    .WE(MemWriteM), 
    .A(ALUoutM1), 
    .WD(WriteDataM), 
    .RD(RDM), 
    .PC_4(PC_4M1)
    );
	assign RegWriteM2=RegWriteM1;
	assign MemtoRegM2=MemtoRegM1;
	assign ALUoutM2=ALUoutM1;
	assign WriteRegM2=WriteRegM1;
	assign PC_4M2=PC_4M1;
	assign ext_immM2=ext_immM1;
	assign TnewM2=TnewM1;
endmodule
