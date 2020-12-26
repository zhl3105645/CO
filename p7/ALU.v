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
    input [4:0] OP,
	input [4:0] shamt,
    output reg [31:0] ANS,
	output reg OV
    );
	reg [32:0] temp;
    always@(*)
    	begin
            case(OP)
                5'b00000:
					begin
						ANS=A+B;
						OV=1'b0;
					end
				5'b00001:
					begin
						temp={A[31],A}+{B[31],B};
						ANS=temp[31:0];
						OV=(temp[32]==temp[31])?1'b0:1'b1;
					end
				5'b00010:
					begin
						ANS=A-B;
						OV=1'b0;
					end
				5'b00011:
					begin
						temp={A[31],A}-{B[31],B};
						ANS=temp[31:0];
						OV=(temp[32]==temp[31])?1'b0:1'b1;
					end
				5'b00100:
					begin
						ANS=A&B;
						OV=1'b0;
					end
				5'b00101:
					begin
						ANS=A|B;
						OV=1'b0;
					end
				5'b00110:
					begin
						ANS=A^B;
						OV=1'b0;
					end
				5'b00111:
					begin
						ANS=~(A|B);
						OV=1'b0;
					end
				5'b01000:
					begin
						ANS={B[15:0],16'b0};
						OV=1'b0;
					end
				5'b01001:
					begin
						ANS=B<<shamt;
						OV=1'b0;
					end
				5'b01010:
					begin
						ANS=B<<A[4:0];
						OV=1'b0;
					end
				5'b01011:
					begin
						ANS=B>>shamt;
						OV=1'b0;
					end
				5'b01100:
					begin
						ANS=B>>A[4:0];
						OV=1'b0;
					end
				5'b01101:
					begin
						ANS=$signed($signed(B) >>> shamt);
						OV=1'b0;
					end
				5'b01110:
					begin
						ANS=$signed($signed(B) >>> A[4:0]);
						OV=1'b0;
					end
				5'b01111:
					begin
						ANS=({1'b0,A}<{1'b0,B})?32'd1:32'd0;
						OV=1'b0;
					end
				5'b10000:
					begin
						ANS=($signed(A)<$signed(B))?32'd1:32'd0;
						OV=1'b0;
					end
                default:
					begin
						ANS=32'd0;
						OV=1'b0;
					end
            endcase
        end  

endmodule