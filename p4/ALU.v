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
    output reg [31:0] ANS,
	 output reg ZERO
    );
    always@(*)
    	begin
            case(OP)
                3'b000:
						begin
							ANS=A+B;
							ZERO=1'b0;
						end
                3'b001:
						begin
							ANS=A-B;
							ZERO=1'b0;
						end
                3'b010:
						begin	
							ANS=A|B;
							ZERO=1'b0;
						end
                3'b011:
						begin
							ANS=32'b0;
							if(A==B)
								ZERO=1'b1;
							else
								ZERO=1'b0;
						end
                default:
						begin
							ANS=32'd0;
							ZERO=1'b0;
						end
            endcase
        end  

endmodule