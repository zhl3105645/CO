`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:10:26 12/13/2020 
// Design Name: 
// Module Name:    ext_load 
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
module ext_load(
    input [1:0] A,
    input [31:0] Din,
    input [2:0] op,
    output reg [31:0] Dout
    );
	always@(*)
		begin
			case(op)
				3'b000:Dout=Din;
				3'b001:
					begin
						case(A)
							2'b00:Dout={24'b0,Din[7:0]};
							2'b01:Dout={24'b0,Din[15:8]};
							2'b10:Dout={24'b0,Din[23:16]};
							2'b11:Dout={24'b0,Din[31:24]};
						endcase
					end
				3'b010:
					begin
						case(A)
							2'b00:Dout={{24{Din[7]}},Din[7:0]};
							2'b01:Dout={{24{Din[15]}},Din[15:8]};
							2'b10:Dout={{24{Din[23]}},Din[23:16]};
							2'b11:Dout={{24{Din[31]}},Din[31:24]};
						endcase
					end
				3'b011:
					begin
						case(A[1])
							1'b1:Dout={16'b0,Din[31:16]};
							1'b0:Dout={16'b0,Din[15:0]};
						endcase
					end
				3'b100:
					begin
						case(A[1])
							1'b1:Dout={{16{Din[31]}},Din[31:16]};
							1'b0:Dout={{16{Din[15]}},Din[15:0]};
						endcase
					end
			endcase
		end
endmodule
