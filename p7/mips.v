`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:19:10 12/26/2020 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset,
    input interrupt,
    output [31:0] addr
    );
	wire PrWe,DEV0_WE,DEV1_WE,IRQ0,IRQ1;
	wire [3:0] PrBE;
	wire [7:2] HWInt;
	wire [31:2] DEV_Addr;
	wire [31:0] PrRD,PrWD,PrAddr,DEV0_RD,DEV1_RD,DEV_WD;
	assign HWInt[7:2]={3'b000,interrupt,IRQ1,IRQ0};
	cpu CPU (
    .clk(clk), 
    .reset(reset), 
    .PrRD(PrRD), 
    .HWInt(HWInt), 
    .PrWe(PrWe), 
    .PrBE(PrBE), 
    .PrWD(PrWD), 
    .PrAddr(PrAddr),
	.Addr(addr)
    );
	Bridge bridge (
    .PrWe(PrWe), 
    .PrBE(PrBE), 
    .PrAddr(PrAddr), 
    .PrRD(PrRD), 
    .PrWD(PrWD), 
    .DEV_Addr(DEV_Addr), 
    .DEV0_RD(DEV0_RD), 
    .DEV1_RD(DEV1_RD), 
    .DEV_WD(DEV_WD), 
    .DEV0_WE(DEV0_WE), 
    .DEV1_WE(DEV1_WE)
    );
	timer Dev0 (
    .clk(clk), 
    .reset(reset), 
    .Addr(DEV_Addr), 
    .WE(DEV0_WE), 
    .Din(DEV_WD), 
    .Dout(DEV0_RD), 
    .IRQ(IRQ0)
    );
	timer Dev1 (
    .clk(clk), 
    .reset(reset), 
    .Addr(DEV_Addr), 
    .WE(DEV1_WE), 
    .Din(DEV_WD), 
    .Dout(DEV1_RD), 
    .IRQ(IRQ1)
    );

endmodule
