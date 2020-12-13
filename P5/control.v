`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:52:40 11/22/2020 
// Design Name: 
// Module Name:    control 
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
module control(
    input [5:0] op,
    input [5:0] func,
    output reg [1:0] Branch,
    output reg [1:0] EXTop,
    output reg [2:0] ALUcontrol,
    output reg MemWrite,
    output reg RegWrite,
    output reg [1:0] RegDst,
    output reg ALUSrc,
    output reg [1:0] MemtoReg
    );
	 initial
		begin
			 Branch[1:0]=2'b00;
			 EXTop[1:0]=2'b00;
			 ALUcontrol[2:0]=3'b000;
			 MemWrite=1'b0;
			 RegWrite=1'b0;
			 RegDst[1:0]=2'b00;
			 ALUSrc=1'b0;
			 MemtoReg[1:0]=2'b00;
		end
	 //中间信号
	wire ADDU,SUBU,JR,ORI,LW,SW,BEQ,LUI,JAL,J,ADDI,JALR;
	//判断指令
	 assign ADDU=(op==6'b000000&&func==6'b100001)?1'b1:1'b0;
	 assign SUBU=(op==6'b000000&&func==6'b100011)?1'b1:1'b0;
	 assign JR=(op==6'b000000&&func==6'b001000)?1'b1:1'b0;
	 assign ORI=(op==6'b001101)?1'b1:1'b0;
	 assign LW=(op==6'b100011)?1'b1:1'b0;
	 assign SW=(op==6'b101011)?1'b1:1'b0;
	 assign BEQ=(op==6'b000100)?1'b1:1'b0;
	 assign LUI=(op==6'b001111)?1'b1:1'b0;
	 assign JAL=(op==6'b000011)?1'b1:1'b0;
	 assign J=(op==6'b000010)?1'b1:1'b0;
	 assign ADDI=(op==6'b001000)?1'b1:1'b0;
	 assign JALR=(op==6'b000000&&func==6'b001001)?1'b1:1'b0;
	 //判断控制信号
	 always@(*)
		begin
			 Branch[1:0]={JAL|JR|J|JALR,BEQ|JR|JALR};
			 EXTop[1:0]={LUI,ORI};
			 ALUcontrol[2:0]={1'b0,ORI,SUBU};
			 MemWrite=SW;
			 RegWrite=ADDU|SUBU|ORI|LW|LUI|JAL|ADDI|JALR;
			 RegDst[1:0]={JAL,ORI|LW|LUI|ADDI};
			 ALUSrc=ORI|LW|SW|ADDI;
			 MemtoReg[1:0]={LUI|JAL|JALR,LW|LUI};
		end
    
endmodule
