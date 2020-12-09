`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:57:39 11/21/2020 
// Design Name: 
// Module Name:    Fetch 
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
module Fetch(
    input clk,
    input reset,
	 input EN,
    input [1:0] PCSrc,
    input [31:0] ext_imm,
    input [31:0] ext_index,
    input [31:0] GPR_rs,
    output [31:0] Instr,
    output [31:0] PC_4
    );
    reg [31:0] im[0:1023];
	 reg [31:0] PC;
	 wire [31:0] nPC;
	 wire [31:0] ext_offset;
	 assign ext_offset=PC+(ext_imm<<2);
    //»úÆ÷Âë¶ÁÈ¡
	initial 
        begin
            $readmemh("code.txt",im);
				PC<=32'h00003000;
		end
		
	mux4_32 PC_next (
    .a0(PC_4), 
    .a1(ext_offset), 
    .a2(ext_index), 
    .a3(GPR_rs), 
    .op(PCSrc), 
    .out(nPC)
    );
			
    always@(posedge clk)
        begin
            if(reset)
					PC<=32'h00003000;
            else if(EN==1'b1)
                PC<=nPC;
        end
    assign Instr=im[PC[11:2]];
    assign PC_4=PC+4;
            
endmodule
