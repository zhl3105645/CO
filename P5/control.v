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
	wire ADDU,SUBU,JR,ORI,LW,SW,BEQ,LUI,JAL,J;
	//判断指令
    assign ADDU=~op[0]&~op[1]&~op[2]&~op[3]&~op[4]&~op[5]&func[0]&~func[1]&~func[2]&~func[3]&~func[4]&func[5];
    assign SUBU=~op[0]&~op[1]&~op[2]&~op[3]&~op[4]&~op[5]&func[0]&func[1]&~func[2]&~func[3]&~func[4]&func[5];
    assign JR=~op[0]&~op[1]&~op[2]&~op[3]&~op[4]&~op[5]&~func[0]&~func[1]&~func[2]&func[3]&~func[4]&~func[5];
    assign ORI=op[0]&~op[1]&op[2]&op[3]&~op[4]&~op[5];
    assign LW=op[0]&op[1]&~op[2]&~op[3]&~op[4]&op[5];
    assign SW=op[0]&op[1]&~op[2]&op[3]&~op[4]&op[5];
    assign BEQ=~op[0]&~op[1]&op[2]&~op[3]&~op[4]&~op[5];
    assign LUI=op[0]&op[1]&op[2]&op[3]&~op[4]&~op[5];
    assign JAL=op[0]&op[1]&~op[2]&~op[3]&~op[4]&~op[5];
    assign J=~op[0]&op[1]&~op[2]&~op[3]&~op[4]&~op[5];
	 //判断控制信号
	 always@(*)
		begin
			 Branch[1:0]={JAL|JR|J,BEQ|JR};
			 EXTop[1:0]={LUI,ORI};
			 ALUcontrol[2:0]={1'b0,ORI,SUBU};
			 MemWrite=SW;
			 RegWrite=ADDU|SUBU|ORI|LW|LUI|JAL;
			 RegDst[1:0]={JAL,ORI|LW|LUI};
			 ALUSrc=ORI|LW|SW;
			 MemtoReg[1:0]={LUI|JAL,LW|LUI};
		end
    
endmodule
