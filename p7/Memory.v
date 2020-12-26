`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:17:39 11/22/2020 
// Design Name: 
// Module Name:    Memory 
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
module Memory(
	input clk,
	input reset,
	input [7:2] HWInt,
	input [31:0] PrRD,
    input RegWriteM1,
    input [1:0] MemtoRegM1,
    input MemWriteM,
	input [1:0] BEopM,
	input [2:0] LoadopM1,
	input [31:0] ResultW,
	input forwardM,
    input [31:0] ALUoutM1,
    input [31:0] WriteDataM,
    input [31:0] PC_4M1,
	input [1:0] TnewM1,
	input [4:0] AwriteM1,
	input [6:2] ExcCodeM,
	input if_bdM,
	input loadM,
	input storeM,
	input OVM,
	input mfcoM,
	input mtcoM,
	input eretM,
	input [4:0] rdM,
    output RegWriteM2,
    output [1:0] MemtoRegM2,
	output [2:0] LoadopM2,
    output [31:0] RDM,
    output [31:0] ALUoutM2,
    output [31:0] PC_4M2,
	output [1:0] TnewM2,
	output [4:0] AwriteM2,
	output IntReq,
	output [31:2] EPC,
	output PrWe,
	output [31:0] PrWD,
	output [3:0] PrBE,
	output [31:0] PrAddr
    );
	reg [6:2] ExcCode;
	wire lw,lh,lb;
	wire sw,sh,wb;
	assign lw=(LoadopM1==3'b000)?1'b1:1'b0;
	assign lh=(LoadopM1==3'b011||LoadopM1==3'b100)?1'b1:1'b0;
	assign lb=(LoadopM1==3'b001||LoadopM1==3'b010)?1'b1:1'b0;
	assign sw=(BEopM==2'b00)?1'b1:1'b0;
	assign sh=(BEopM==2'b01)?1'b1:1'b0;
	assign sb=(BEopM==2'b10)?1'b1:1'b0;
	
	wire is_dm,is_timer0,is_timer1;
	assign is_dm=(ALUoutM1>=32'h00000000&&ALUoutM1<=32'h00002fff)?1'b1:1'b0;
	assign is_timer0=(ALUoutM1>=32'h00007f00&&ALUoutM1<=32'h00007f0b)?1'b1:1'b0;
	assign is_timer1=(ALUoutM1>=32'h00007f10&&ALUoutM1<=32'h00007f1b)?1'b1:1'b0;
	
	wire [31:0] data;
	wire [3:0] BE;
	assign data=(forwardM==1'b1)?ResultW:WriteDataM;
	wire [31:0] D_dm;
	assign RDM=(is_timer0|is_timer1)?PrRD:
			   (is_dm)?D_dm:32'd0;
	 extend_BE ext_BE (
    .A(ALUoutM1[1:0]), 
    .BEop(BEopM), 
    .BE(BE)
    );
	wire MemWrite_dm;
	wire MemWrite_timer;
	assign MemWrite_dm=MemWriteM & is_dm & (!IntReq);
	assign MemWrite_timer=MemWriteM & (is_timer0|is_timer1) & (!IntReq);
	DM dm (
    .clk(clk), 
    .reset(reset), 
    .WE(MemWrite_dm), 
    .A(ALUoutM1), 
	.BE(BE),
    .WD(data), 
    .RD(D_dm), 
    .PC_4(PC_4M1)
    );
	always@(*)
		begin
			if(loadM)
				begin
					if(OVM)
						ExcCode[6:2]=5'd4;
					else if(!(is_dm|is_timer0|is_timer1))
						ExcCode[6:2]=5'd4;
					else if(lw)
						begin
							if(ALUoutM1[1:0]!=2'b00)
								ExcCode[6:2]=5'd4;
							else 
								ExcCode[6:2]=ExcCodeM[6:2];
						end
					else if(lh)
						begin
							if(ALUoutM1[0]!=1'b0)
								ExcCode[6:2]=5'd4;
							else if(is_timer0|is_timer1)
								ExcCode[6:2]=5'd4;
							else 
								ExcCode[6:2]=ExcCodeM[6:2];
						end
					else if(lb)
						begin
							if(is_timer0|is_timer1)
								ExcCode[6:2]=5'd4;
							else 
								ExcCode[6:2]=ExcCodeM[6:2];
						end
				end
			else if(storeM)
				begin
					if(OVM)
						ExcCode[6:2]=5'd5;
					else if(!(is_dm|is_timer0|is_timer1))
						ExcCode[6:2]=5'd5;
					else if(ALUoutM1==32'h00007f08||ALUoutM1==32'h00007f18)
						ExcCode[6:2]=5'd5;
					else if(sw)
						begin
							if(ALUoutM1[1:0]!=2'b00)
								ExcCode[6:2]=5'd5;
							else 
								ExcCode[6:2]=ExcCodeM[6:2];
						end
					else if(sh)
						begin
							if(ALUoutM1[0]!=1'b0)
								ExcCode[6:2]=5'd5;
							else if(is_timer0|is_timer1)
								ExcCode[6:2]=5'd5;
							else 
								ExcCode[6:2]=ExcCodeM[6:2];
						end
					else if(sb)
						begin
							if(is_timer0|is_timer1)
								ExcCode[6:2]=5'd5;
							else 
								ExcCode[6:2]=ExcCodeM[6:2];
						end
				end
			else 
				ExcCode[6:2]=ExcCodeM[6:2];
		end
	wire [31:0] PC;
	assign PC[31:0]=PC_4M1-4;
	wire [31:0] D_cp0;
	CP0 cp0 (
    .A1(rdM), 
    .A2(rdM), 
    .DIn(data), 
    .PC(PC[31:2]), 
    .if_bd(if_bdM), 
    .ExcCode(ExcCode), 
    .HWInt(HWInt[7:2]), 
    .We(mtcoM), 
    .EXLClr(eretM), 
    .clk(clk), 
    .reset(reset), 
    .IntReq(IntReq), 
    .EPC(EPC), 
    .DOut(D_cp0)
    );
	assign RegWriteM2=RegWriteM1;
	assign MemtoRegM2=MemtoRegM1;
	assign LoadopM2=LoadopM1;
	assign ALUoutM2=(mfcoM)?D_cp0:ALUoutM1;
	assign PC_4M2=PC_4M1;
	assign TnewM2=TnewM1;
	assign AwriteM2=AwriteM1;
	assign PrWe=MemWrite_timer;
	assign PrWD=data;
	assign PrBE=BE;
	assign PrAddr=ALUoutM1;
endmodule
