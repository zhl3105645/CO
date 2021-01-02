`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:39:55 12/23/2020 
// Design Name: 
// Module Name:    CPO 
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
`define SR 12 
`define CAUSE 13 
`define EPC 14
`define PRID 15
module CP0(
    input [4:0] A1,//读CP0寄存器编号，执行MFC0指令时产生
    input [4:0] A2,//写CP0寄存器编号，执行MTCO指令时产生
    input [31:0] DIn,//CP0寄存器的写入数据，执行MTC0指令时产生，数据来自GPR
    input [31:2] PC,//中断/异常时的PC
	input if_bd,
    input [6:2] ExcCode,//中断/异常的类型，来自异常功能部件
    input [5:0] HWInt,//6个设备中断，来自外部硬件设备
    input We,//CP0寄存器写使能，执行MTC0指令时产生
    //input EXLSet,//用于置位SR的EXL，流水线在W阶段产生
    input EXLClr,//用于清除SR的EXL，执行ERET指令时产生
    input clk,
    input reset,
    output reg IntReq,//中断请求，输出至CPU控制器，是HWInt/IM/EXL/IE的函数
    output [31:2] EPC,//EPC寄存器输出至NPC
    output [31:0] DOut//CP0寄存器的输出数据，执行MFC0指令时产生，输出数据至GPR
    );
	//SR
	wire [31:0] sr;
	reg [15:10] im;
	reg exl;
	reg ie;
	assign sr={16'b0,im,8'b0,exl,ie};
	//CAUSE
	wire [31:0] cause;
	reg bd;
	reg [7:2] ip;
	reg [6:2] exccode;
	assign cause={bd,15'b0,ip[7:2],3'b0,exccode[6:2],2'b0};
	//EPC
	reg [31:0] epc;
	//PRID
	wire [31:0] prid;
	assign prid=32'h12345678;
	
	//中断异常信号
	reg Exception,Interrupt;
	
	initial 
		begin
			im<=6'b0;
			exl<=1'b0;
			ie<=1'b0;
			bd<=1'b0;
			ip<=6'b0;
			exccode<=5'b0;
			epc<=32'b0;
			Interrupt<=1'b0;
			Exception<=1'b0;
			IntReq<=1'b0;
		end
	
	assign EPC=epc[31:2];
	assign DOut = (A1==`SR) ? sr :
				  (A1==`CAUSE) ? cause :
				  (A1==`EPC) ? epc :
				  (A1==`PRID) ? prid : 32'b0;
	always@(*)
		begin
			Interrupt=(|(HWInt[5:0] & im[15:10])) & ie & !exl ;
			Exception=(ExcCode[6:2]>0&&exl==1'b0)?1'b1:1'b0;
			IntReq=(Interrupt||Exception)?1'b1:1'b0;
		end
	
	always@(posedge clk)
		begin
			if(reset)
				begin
					im<=6'b0;
					exl<=1'b0;
					ie<=1'b0;
					bd<=1'b0;
					ip<=6'b0;
					exccode<=5'b0;
					epc<=32'b0;
				end
			else if(We)
				begin
					ip[7:2]<=HWInt[5:0];
					case(A2)
						`SR:{im,exl,ie}<={DIn[15:10],DIn[1],DIn[0]};
						`EPC:begin
								epc<={DIn[31:2],2'b00};
								//$display("%d epc=%h", $time,epc);
							end
					endcase
				end
			else 
				begin
					ip[7:2]<=HWInt[5:0];
					if(IntReq)
						begin
							exl<=1'b1;
						end
					if(EXLClr)
						begin
							exl<=1'b0;
						end
					if(Interrupt)
						begin
							exccode[6:2]<=5'd0;
							if(if_bd)
								begin
									bd<=1'b1;
									epc<={PC[31:2],2'b00}-4;
								end
							else 
								begin
									bd<=1'b0;
									epc<={PC[31:2],2'b00};
								end
						end
					else if(Exception)
						begin
							exccode[6:2]<=ExcCode[6:2];
							if(if_bd)
								begin
									bd<=1'b1;
									epc<={PC[31:2],2'b00}-4;
								end
							else 
								begin
									bd<=1'b0;
									epc<={PC[31:2],2'b00};
								end
						end
				end
		end

							
endmodule
