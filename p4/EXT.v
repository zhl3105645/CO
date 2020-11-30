`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:35:17 11/14/2020 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] offset,
    input [1:0] EXTop,
    output reg [31:0] ext_offset
    );
    always@(*)
        begin
            case(EXTop)
                2'b00:ext_offset={{16{offset[15]}},offset};
                2'b01:ext_offset={16'b0,offset};
                2'b10:ext_offset={offset,16'b0};
                default:ext_offset=32'b0;
            endcase
        end

endmodule

