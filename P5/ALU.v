`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:33:53 11/14/2020 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [2:0] OP,
    output reg [31:0] ANS
    );
    always@(*)
    	begin
            case(OP)
                3'b000:ANS=A+B;
                3'b001:ANS=A-B;
                3'b010:ANS=A|B;
                default:ANS=32'd0;
            endcase
        end  

endmodule