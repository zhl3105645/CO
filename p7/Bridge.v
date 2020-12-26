`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:11:06 12/23/2020 
// Design Name: 
// Module Name:    Bridge 
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
module Bridge(
	input PrWe,
	input [3:0] PrBE,
    input [31:0] PrAddr,
	output [31:0] PrRD,
    input [31:0] PrWD,
	output [31:2] DEV_Addr,
    input [31:0] DEV0_RD,
	input [31:0] DEV1_RD,
	output [31:0] DEV_WD,
	output DEV0_WE,
	output DEV1_WE
    );
	//设备译码
	wire HitDEV0,HitDEV1;
	assign HitDEV0 = (PrAddr[31:4]==28'h00007f0) ? 1'b1 : 1'b0;
	assign HitDEV1 = (PrAddr[31:4]==28'h00007f1) ? 1'b1 : 1'b0;
	//设备输出汇聚至cpu的数据输入
	assign PrRD = (HitDEV0) ? DEV0_RD :
				  (HitDEV1) ? DEV1_RD :
				   32'd0;
	//设备内部地址
	assign DEV_Addr = PrAddr[31:2];
	//cpu的输出派发至设备
	assign DEV_WD[7:0] = (PrBE[0]) ? PrWD[7:0] :8'b0;
	assign DEV_WD[15:8] = (PrBE[1]) ? PrWD[15:8] :8'b0;
	assign DEV_WD[23:16] = (PrBE[2]) ? PrWD[23:16] :8'b0;
	assign DEV_WD[31:24] = (PrBE[3]) ? PrWD[31:24] :8'b0;
	//设备使能
	assign DEV0_WE = PrWe & HitDEV0;
	assign DEV1_WE = PrWe & HitDEV1;
	
	
endmodule
