`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:03:08 11/15/2020 
// Design Name: 
// Module Name:    ctrl 
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
module ctrl(
    input [5:0] op,
    input [5:0] func,
    output [1:0] Branch,
    output [1:0] EXTop,
    output [2:0] ALUop,
    output MemWrite,
    output RegWrite,
    output [1:0] RegDst,
    output ALUSrc,
    output [1:0] Data
    );
	 //中间信号
	wire ADDU,SUBU,JR,ORI,LW,SW,BEQ,LUI,JAL;
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
	 //判断控制信号
    assign Branch[1:0]={JAL|JR,BEQ|JR};
    assign EXTop[1:0]={LUI,ORI};
    assign ALUop[2:0]={1'b0,BEQ|ORI,SUBU|BEQ};
    assign MemWrite=SW;
    assign RegWrite=ADDU|SUBU|ORI|LW|LUI|JAL;
    assign RegDst[1:0]={JAL,ORI|LW|LUI};
    assign ALUSrc=ORI|LW|SW;
    assign Data[1:0]={LUI|JAL,LW|JAL};
endmodule
