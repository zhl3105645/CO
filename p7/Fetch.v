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
	input jumpD,
	input IntReq,
	input eret,
	input [31:2] EPC,
    output [31:0] Instr,
    output [31:0] PC_4,
	output [6:2] ExcCode,
	output if_bd
    );
    reg [31:0] im[0:4095];
	 reg [31:0] PC;
	 wire [31:0] nPC;
	 wire [31:0] ext_offset;
	 assign ext_offset=PC+(ext_imm<<2);
    //»úÆ÷Âë¶ÁÈ¡
	initial 
        begin
            $readmemh("code.txt", im);
			$readmemh("code_handler.txt", im, 1120, 2047);
			PC=32'h00003000;
		end
	wire [31:0] nPC1;
	mux4_32 PC_next (
    .a0(PC_4), 
    .a1(ext_offset), 
    .a2(ext_index), 
    .a3(GPR_rs), 
    .op(PCSrc), 
    .out(nPC1)
    );
	assign nPC=(IntReq)?32'h00004180:
			   (eret)?{EPC,2'b00}:nPC1;
    always@(posedge clk)
        begin
            if(reset)
				PC<=32'h00003000;
            else if(EN||IntReq)
                PC<=nPC;
        end
	wire [31:0] i;
	assign i=PC-32'h00003000;
    assign Instr=(AdEl)?32'd0:im[i[13:2]];
    assign PC_4=PC+4;
	wire AdEl;
	assign AdEl=((PC[1:0]!=2'b00)||!(PC>=32'h00003000&&PC<=32'h00004ffc))?1'b1:1'b0;
    assign ExcCode[6:2]=(AdEl)?5'd4:5'd0; 
	assign if_bd=(jumpD)?1'b1:1'b0;
endmodule
