`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:45:12 11/22/2020 
// Design Name: 
// Module Name:    AT 
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
module AT(
    input [31:0] InstrD,
    output reg [1:0] Tuse_rs,
    output reg [1:0] Tuse_rt,
    output reg [1:0] TnewD,
	output reg [4:0] A_rsD,
	output reg [4:0] A_rtD,
	output reg [4:0] AwriteD
    );
	wire [4:0] rs,rt,rd;
	wire [5:0] op,func;
	assign op=InstrD[31:26];
	assign func=InstrD[5:0];
	assign rs=InstrD[25:21];
	assign rt=InstrD[20:16];
	assign rd=InstrD[15:11];
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
	//
	wire MFCO,MTCO,ERET;
	assign MFCO=(op==6'b010000&&rs==5'b00000)?1'b1:1'b0;
	assign MTCO=(op==6'b010000&&rs==5'b00100)?1'b1:1'b0;
	assign ERET=(op==6'b010000&&func==6'b011000)?1'b1:1'b0;
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
	//判断AT	Tuse=11时为不使用该数据
	always@(*)
		begin
			if(LB|LBU|LW|LH|LHU)
				begin
					Tuse_rs=2'b01;
					Tuse_rt=2'b11;
					TnewD=2'b11;
					A_rsD=rs;
					A_rtD=5'd0;
					AwriteD=rt;
				end
			else if(SB|SH|SW)
				begin	
					Tuse_rs=2'b01;
					Tuse_rt=2'b10;
					TnewD=2'b00;
					A_rsD=rs;
					A_rtD=rt;
					AwriteD=5'd0;
				end
			else if(ADD|ADDU|SUB|SUBU|AND|OR|XOR|NOR)
				begin	
					Tuse_rs=2'b01;
					Tuse_rt=2'b01;
					TnewD=2'b10;
					A_rsD=rs;
					A_rtD=rt;
					AwriteD=rd;
				end
			else if(ADDI|ADDIU|ANDI|ORI|XORI)
				begin	
					Tuse_rs=2'b01;
					Tuse_rt=2'b11;
					TnewD=2'b10;
					A_rsD=rs;
					A_rtD=5'd0;
					AwriteD=rt;
				end
			else if(SLL|SRL|SRA)
				begin	
					Tuse_rs=2'b11;
					Tuse_rt=2'b01;
					TnewD=2'b10;
					A_rsD=5'd0;
					A_rtD=rt;
					AwriteD=rd;
				end
			else if(SLLV|SRLV|SRAV)
				begin	
					Tuse_rs=2'b01;
					Tuse_rt=2'b01;
					TnewD=2'b10;
					A_rsD=rs;
					A_rtD=rt;
					AwriteD=rd;
				end
			else if(SLT|SLTU)
				begin	
					Tuse_rs=2'b01;
					Tuse_rt=2'b01;
					TnewD=2'b10;
					A_rsD=rs;
					A_rtD=rt;
					AwriteD=rd;
				end
			else if(SLTI|SLTIU)
				begin	
					Tuse_rs=2'b01;
					Tuse_rt=2'b11;
					TnewD=2'b10;
					A_rsD=rs;
					A_rtD=5'd0;
					AwriteD=rt;
				end
			else if(MULT|MULTU|DIV|DIVU)
				begin	
					Tuse_rs=2'b01;
					Tuse_rt=2'b01;
					TnewD=2'b00;
					A_rsD=rs;
					A_rtD=rt;
					AwriteD=5'd0;
				end	
			else if(MFHI|MFLO)
				begin	
					Tuse_rs=2'b11;
					Tuse_rt=2'b11;
					TnewD=2'b10;
					A_rsD=5'd0;
					A_rtD=5'd0;
					AwriteD=rd;
				end
			else if(MTHI|MTLO)
				begin	
					Tuse_rs=2'b01;
					Tuse_rt=2'b11;
					TnewD=2'b00;
					A_rsD=rs;
					A_rtD=5'd0;
					AwriteD=5'd0;
				end
			else if(LUI)
				begin
					Tuse_rs=2'b11;
					Tuse_rt=2'b11;
					TnewD=2'b10;
					A_rsD=5'd0;
					A_rtD=5'd0;
					AwriteD=rt;
				end
			else if(BEQ|BNE)
				begin
					Tuse_rs=2'b00;
					Tuse_rt=2'b00;
					TnewD=2'b00;
					A_rsD=rs;
					A_rtD=rt;
					AwriteD=5'd0;
				end
			else if(BLEZ|BGTZ|BLTZ|BGEZ)
				begin
					Tuse_rs=2'b00;
					Tuse_rt=2'b11;
					TnewD=2'b00;
					A_rsD=rs;
					A_rtD=5'd0;
					AwriteD=5'd0;
				end
			else if(J)
				begin
					Tuse_rs=2'b11;
					Tuse_rt=2'b11;
					TnewD=2'b00;
					A_rsD=5'd0;
					A_rtD=5'd0;
					AwriteD=5'd0;
				end
			else if(JAL)
				begin
					Tuse_rs=2'b11;
					Tuse_rt=2'b11;
					TnewD=2'b11;
					A_rsD=5'd0;
					A_rtD=5'd0;
					AwriteD=5'd31;
				end
			else if(JALR)
				begin
					Tuse_rs=2'b00;
					Tuse_rt=2'b11;
					TnewD=2'b11;
					A_rsD=rs;
					A_rtD=5'd0;
					AwriteD=rd;
				end
			else if(JR)
				begin
					Tuse_rs=2'b00;
					Tuse_rt=2'b11;
					TnewD=2'b00;
					A_rsD=rs;
					A_rtD=5'd0;
					AwriteD=5'd0;
				end
			else if(MFCO)
				begin
					Tuse_rs=2'b11;
					Tuse_rt=2'b11;
					TnewD=2'b11;
					A_rsD=5'd0;
					A_rtD=5'd0;
					AwriteD=rt;
				end
			else if(MTCO)
				begin
					Tuse_rs=2'b11;
					Tuse_rt=2'b00;
					TnewD=2'b11;
					A_rsD=5'd0;
					A_rtD=rt;
					AwriteD=5'd0;
				end	
			else if(ERET)
				begin
					Tuse_rs=2'b11;
					Tuse_rt=2'b11;
					TnewD=2'b11;
					A_rsD=5'd0;
					A_rtD=5'd0;
					AwriteD=5'd0;
				end
			else 
				begin
					Tuse_rs=2'b11;
					Tuse_rt=2'b11;
					TnewD=2'b00;
					A_rsD=5'd0;
					A_rtD=5'd0;
					AwriteD=5'd0;
				end
		end
endmodule
