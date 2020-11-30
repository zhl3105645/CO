`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:11 11/14/2020 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
    input clk,
    input reset,
    input [1:0] PCSrc,
    input [31:0] offset,
    input [25:0] index,
    input [31:0] GPR_rs,
    output [31:0] Instr,
    output [31:0] PC_4,
	 output reg [31:0] PC
    );
    reg [31:0] im[0:1023];
	 reg [31:0] nPC;
    //»úÆ÷Âë¶ÁÈ¡
	initial 
        begin
            $readmemh("code.txt",im);
				PC<=32'h00003000;
		end
		//the next PC
		always@(*)
			begin
				case(PCSrc)
					2'b00:nPC<=PC+4;
					2'b01:nPC<=PC+4+{offset[29:0],2'b00};
					2'b10:nPC<={PC[31:28],index,2'b00};
					2'b11:nPC<=GPR_rs;
				endcase
			end
			
    always@(posedge clk)
        begin
            if(reset)
                PC=32'h00003000;
            else 
                PC<=nPC;
        end
    assign Instr=im[PC[11:2]];
    assign PC_4=PC+4;
            
endmodule
