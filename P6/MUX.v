`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:45 11/14/2020 
// Design Name: 
// Module Name:    MUX 
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
module mux2_32(
    input [31:0] a0,
    input [31:0] a1,
    input op,
    output [31:0] out
    );
    assign out = (op==1'b0)?a0:a1;
endmodule
module mux3_32(
    input [31:0] a0,
    input [31:0] a1,
    input [31:0] a2,
    input [1:0] op,
    output [31:0] out
    );
    assign out = (op==2'b00)?a0:
        		(op==2'b01)?a1:
        (op==2'b10)?a2:32'd0;
endmodule
module mux4_32(
    input [31:0] a0,
    input [31:0] a1,
    input [31:0] a2,
	input [31:0] a3,
    input [1:0] op,
    output [31:0] out
    );
    assign out = (op==2'b00)?a0:
        		(op==2'b01)?a1:
        (op==2'b10)?a2:a3;
endmodule