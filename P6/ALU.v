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
    output reg [31:0] ANS
    );
	reg [32:0] temp1;
    always@(*)
    	begin
            case(OP)
                5'b00000:ANS=A+B;
				5'b00001:ANS=$signed(A)+$signed(B);
				5'b00010:ANS=A-B;
				5'b00011:ANS=$signed(A)-$signed(B);
				5'b00100:ANS=A&B;
				5'b00101:ANS=A|B;
				5'b00110:ANS=A^B;
				5'b00111:ANS=~(A|B);
				5'b01000:ANS={B[15:0],16'b0};
				5'b01001:ANS=B<<shamt;
				5'b01010:ANS=B<<A[4:0];
				5'b01011:ANS=B>>shamt;
				5'b01100:ANS=B>>A[4:0];
				5'b01101:ANS=$signed($signed(B) >>> shamt);
				5'b01110:ANS=$signed($signed(B) >>> A[4:0]);
				5'b01111:ANS=({1'b0,A}<{1'b0,B})?32'd1:32'd0;
				5'b10000:ANS=($signed(A)<$signed(B))?32'd1:32'd0;
                default:ANS=32'd0;
            endcase
        end  

endmodule