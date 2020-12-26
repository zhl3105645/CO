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
	input [4:0] rt,
	input [4:0] rs,
    output reg [1:0] Branch,
    output reg EXTop,
    output reg [4:0] ALUcontrol,
    output reg MemWrite,
    output reg RegWrite,
    output reg [1:0] RegDst,
    output reg ALUSrc,
    output reg [1:0] MemtoReg,
	output reg [1:0] BEop,
	output reg start,
	output reg [2:0] mult_div_op,
	output reg [2:0] Loadop,
	output reg [1:0] OUTop,
	output reg m_d,
	output reg [2:0] B_jump,
	output reg load,
	output reg store,
	output reg cal_ov,
	output reg RI,
	output reg jump,
	output reg MFCO,
	output reg MTCO,
	output reg ERET
    );
	 initial
		begin
			 Branch[1:0]=2'b00;
			 EXTop=1'b0;
			 ALUcontrol[4:0]=5'd0;
			 MemWrite=1'b0;
			 RegWrite=1'b0;
			 RegDst[1:0]=2'b00;
			 ALUSrc=1'b0;
			 MemtoReg[1:0]=2'b00;
			 BEop[1:0]=2'b00;
			 start=1'b0;
			 mult_div_op[2:0]=3'b000;
			 Loadop=3'b0;
			 OUTop[1:0]=2'b0;
			 m_d=1'b0;
			 B_jump=3'b000;
			 load=1'b0;
			 store=1'b0;
			 cal_ov=1'b0;
			 RI=1'b0;
			 jump=1'b0;
			 MFCO=1'b0;
			 MTCO=1'b0;
			 ERET=1'b0;
		end
	//中间信号
	//存储类
	wire LB,LBU,LH,LHU,LW,SB,SH,SW;	
	//运算类
	wire ADD,ADDU,SUB,SUBU,AND,OR,XOR,NOR;
	wire ADDI,ADDIU,ANDI,ORI,XORI;
	wire SLL,SRL,SRA,SLLV,SRLV,SRAV;
	wire SLT,SLTI,SLTIU,SLTU;
	wire LUI;
	//乘除类
	wire MULT,MULTU,DIV,DIVU,MFHI,MFLO,MTHI,MTLO;
	//跳转类
	wire BEQ,BNE,BLEZ,BGTZ,BLTZ,BGEZ;
	wire J,JAL,JALR,JR;
	//判断指令
	//
	assign LB=(op==6'b100000)?1'b1:1'b0;
	assign LBU=(op==6'b100100)?1'b1:1'b0;
	assign LH=(op==6'b100001)?1'b1:1'b0;
	assign LHU=(op==6'b100101)?1'b1:1'b0;
	assign LW=(op==6'b100011)?1'b1:1'b0;
	assign SB=(op==6'b101000)?1'b1:1'b0;
	assign SH=(op==6'b101001)?1'b1:1'b0;
	assign SW=(op==6'b101011)?1'b1:1'b0;
	//
	assign ADD=((op==6'b000000)&&(func==6'b100000))?1'b1:1'b0;
	assign ADDU=((op==6'b000000)&&(func==6'b100001))?1'b1:1'b0;
	assign SUB=((op==6'b000000)&&(func==6'b100010))?1'b1:1'b0;
	assign SUBU=((op==6'b000000)&&(func==6'b100011))?1'b1:1'b0;
	assign AND=((op==6'b000000)&&(func==6'b100100))?1'b1:1'b0;
	assign OR=((op==6'b000000)&&(func==6'b100101))?1'b1:1'b0;
	assign XOR=((op==6'b000000)&&(func==6'b100110))?1'b1:1'b0;
	assign NOR=((op==6'b000000)&&(func==6'b100111))?1'b1:1'b0;
	//
	assign ADDI=(op==6'b001000)?1'b1:1'b0;
	assign ADDIU=(op==6'b001001)?1'b1:1'b0;
	assign ANDI=(op==6'b001100)?1'b1:1'b0;
	assign ORI=(op==6'b001101)?1'b1:1'b0;
	assign XORI=(op==6'b001110)?1'b1:1'b0;
	//
	assign SLL=((op==6'b000000)&&(func==6'b000000))?1'b1:1'b0;
	assign SRL=((op==6'b000000)&&(func==6'b000010))?1'b1:1'b0;
	assign SRA=((op==6'b000000)&&(func==6'b000011))?1'b1:1'b0;
	assign SLLV=((op==6'b000000)&&(func==6'b000100))?1'b1:1'b0;
	assign SRLV=((op==6'b000000)&&(func==6'b000110))?1'b1:1'b0;
	assign SRAV=((op==6'b000000)&&(func==6'b000111))?1'b1:1'b0;
	//
	assign SLT=((op==6'b000000)&&(func==6'b101010))?1'b1:1'b0;
	assign SLTI=(op==6'b001010)?1'b1:1'b0;
	assign SLTIU=(op==6'b001011)?1'b1:1'b0;
	assign SLTU=((op==6'b000000)&&(func==6'b101011))?1'b1:1'b0;
	//
	assign LUI=(op==6'b001111)?1'b1:1'b0;
	//
	assign MULT=((op==6'b000000)&&(func==6'b011000))?1'b1:1'b0;
	assign MULTU=((op==6'b000000)&&(func==6'b011001))?1'b1:1'b0;
	assign DIV=((op==6'b000000)&&(func==6'b011010))?1'b1:1'b0;
	assign DIVU=((op==6'b000000)&&(func==6'b011011))?1'b1:1'b0;
	assign MFHI=((op==6'b000000)&&(func==6'b010000))?1'b1:1'b0;
	assign MFLO=((op==6'b000000)&&(func==6'b010010))?1'b1:1'b0;
	assign MTHI=((op==6'b000000)&&(func==6'b010001))?1'b1:1'b0;
	assign MTLO=((op==6'b000000)&&(func==6'b010011))?1'b1:1'b0;
	//
	assign BEQ=(op==6'b000100)?1'b1:1'b0;
	assign BNE=(op==6'b000101)?1'b1:1'b0;
	assign BLEZ=(op==6'b000110)?1'b1:1'b0;
	assign BGTZ=(op==6'b000111)?1'b1:1'b0;
	assign BLTZ=((op==6'b000001)&&(rt==5'b00000))?1'b1:1'b0;
	assign BGEZ=((op==6'b000001)&&(rt==5'b00001))?1'b1:1'b0;
	assign J=(op==6'b000010)?1'b1:1'b0;
	assign JAL=(op==6'b000011)?1'b1:1'b0;
	assign JALR=((op==6'b000000)&&(func==6'b001001))?1'b1:1'b0;
	assign JR=((op==6'b000000)&&(func==6'b001000))?1'b1:1'b0;
	//
	always@(*)
		begin
			MFCO=(op==6'b010000&&rs==5'b00000)?1'b1:1'b0;
			MTCO=(op==6'b010000&&rs==5'b00100)?1'b1:1'b0;
			ERET=(op==6'b010000&&func==6'b011000)?1'b1:1'b0;
		end
	//判断控制信号
	always@(*)
		begin
			if(BEQ|BNE|BLEZ|BGTZ|BLTZ|BGEZ|J|JAL|JALR|JR)
				jump=1'b1;
			else 
				jump=1'b0;
			if(LB)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00001;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b01;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b01;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b010;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b1;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(LBU)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00001;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b01;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b01;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b001;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b1;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(LH)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00001;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b01;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b01;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b100;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b1;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(LHU)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00001;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b01;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b01;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b011;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b1;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(LW)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00001;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b01;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b01;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b1;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SB)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00001;
					 MemWrite=1'b1;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b10;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b1;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SH)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00001;
					 MemWrite=1'b1;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b01;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b1;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SW)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00001;
					 MemWrite=1'b1;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b1;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(ADD)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00001;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b1;
					 RI=1'b0;
				end
			else if(ADDU)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SUB)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00011;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b1;
					 RI=1'b0;
				end
			else if(SUBU)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00010;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(AND)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00100;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(OR)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00101;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(XOR)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00110;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(NOR)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00111;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(ADDI)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00001;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b01;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b1;
					 RI=1'b0;
				end
			else if(ADDIU)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b01;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(ANDI)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b1;
					 ALUcontrol[4:0]=5'b00100;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b01;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(ORI)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b1;
					 ALUcontrol[4:0]=5'b00101;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b01;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(XORI)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b1;
					 ALUcontrol[4:0]=5'b00110;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b01;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SLL)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b01001;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SRL)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b01011;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SRA)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b01101;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SLLV)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b01010;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SRLV)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b01100;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SRAV)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b01110;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SLT)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b10000;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SLTU)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b01111;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SLTI)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b10000;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b01;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(SLTIU)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b01111;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b01;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(MULT)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b1;
					 mult_div_op[2:0]=3'b010;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b1;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(MULTU)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b1;
					 mult_div_op[2:0]=3'b001;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b1;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(DIV)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b1;
					 mult_div_op[2:0]=3'b100;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b1;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(DIVU)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b1;
					 mult_div_op[2:0]=3'b011;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b1;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(MFHI)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b01;
					 m_d=1'b1;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(MFLO)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b10;
					 m_d=1'b1;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(MTHI)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b101;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b1;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(MTLO)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b110;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b1;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(LUI)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b01000;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b01;
					 ALUSrc=1'b1;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(BEQ)
				begin
					 Branch[1:0]=2'b01;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b001;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(BNE)
				begin
					 Branch[1:0]=2'b01;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b010;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(BLEZ)
				begin
					 Branch[1:0]=2'b01;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b101;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(BGTZ)
				begin
					 Branch[1:0]=2'b01;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b100;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(BLTZ)
				begin
					 Branch[1:0]=2'b01;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b110;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(BGEZ)
				begin
					 Branch[1:0]=2'b01;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b011;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(J)
				begin
					 Branch[1:0]=2'b10;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(JAL)
				begin
					 Branch[1:0]=2'b10;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b10;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b10;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(JALR)
				begin
					 Branch[1:0]=2'b11;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b10;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(JR)
				begin
					 Branch[1:0]=2'b11;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
				end
			else if(MFCO)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'd0;
					 MemWrite=1'b0;
					 RegWrite=1'b1;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b0;
					 OUTop[1:0]=2'b0;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
					 jump=1'b0;
				end
			else if(MTCO)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'd0;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b0;
					 OUTop[1:0]=2'b0;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
					 jump=1'b0;
				end
			else if(ERET)
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'd0;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b0;
					 OUTop[1:0]=2'b0;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b0;
					 jump=1'b0;
				end
			else 
				begin
					 Branch[1:0]=2'b00;
					 EXTop=1'b0;
					 ALUcontrol[4:0]=5'b00000;
					 MemWrite=1'b0;
					 RegWrite=1'b0;
					 RegDst[1:0]=2'b00;
					 ALUSrc=1'b0;
					 MemtoReg[1:0]=2'b00;
					 BEop[1:0]=2'b00;
					 start=1'b0;
					 mult_div_op[2:0]=3'b000;
					 Loadop=3'b000;
					 OUTop[1:0]=2'b00;
					 m_d=1'b0;
					 B_jump=3'b000;
					 load=1'b0;
					 store=1'b0;
					 cal_ov=1'b0;
					 RI=1'b1;
				end
		end
endmodule
