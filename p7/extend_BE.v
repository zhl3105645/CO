`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:47:45 12/13/2020 
// Design Name: 
// Module Name:    extend_BE 
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
module extend_BE(
    input [1:0] A,
    input [1:0] BEop,
    output reg [3:0] BE
    );
	always@(*)
		begin
			case(BEop)
				2'b00:BE=4'b1111;
				2'b01:
					begin
						case(A[1])
							1'b1:BE=4'b1100;
							1'b0:BE=4'b0011;
						endcase
					end
				2'b10:
					begin
						case(A)
							2'b00:BE=4'b0001;
							2'b01:BE=4'b0010;
							2'b10:BE=4'b0100;
							2'b11:BE=4'b1000;
						endcase
					end
				default:BE=4'b0;
			endcase
		end

endmodule
