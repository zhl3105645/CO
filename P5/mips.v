`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:05:53 11/22/2020 
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
    input reset
    );
	 //控制信号
	 //D
	wire RegWriteD,MemWriteD,ALUSrcD;
	wire [1:0] MemtoRegD,RegDstD,PCSrcD;
	wire [2:0] ALUcontrolD;
	//E
	wire RegWriteE,MemWriteE,ALUSrcE;
	wire [1:0] MemtoRegE,RegDstE;
	wire [2:0] ALUcontrolE;
	wire RegWriteE1,MemWriteE1;
	wire [1:0] MemtoRegE1;
	//M
	wire RegWriteM,MemWriteM;
	wire [1:0] MemtoRegM;
	wire RegWriteM1;
	wire [1:0] MemtoRegM1;
	//W
	wire RegWriteW;
	wire [1:0] MemtoRegW;
	wire RegWriteW1;
	//Unit信号
	wire stallF,stallD,flushE;
	wire forwardAD,forwardBD,forwardM;
	wire [1:0] forwardAE,forwardBE;
	//五级流水线信号
	//F
	wire [31:0] InstrF,PC_4F;
	//F_D
	wire [31:0] InstrD,PC_4D;
	//D
	wire [31:0] RD1D,RD2D,ext_immD,ext_index,GPR_rs,PC_4D1;
	wire [4:0] A_rsD,A_rtD,AwriteD;
	wire [1:0] Tuse_rs,Tuse_rt,TnewD;
	//D_E
	wire [31:0] RD1E,RD2E,PC_4E,ext_immE;
	wire [1:0] TnewE;
	wire [4:0] A_rsE,A_rtE,AwriteE;
	//E
	wire [31:0] ALUoutE,WriteDataE,PC_4E1,ext_immE1;
	wire [1:0] TnewE1;
	wire [4:0] A_rsE1,A_rtE1,AwriteE1;
	//E_M
	wire [31:0] ALUoutM,WriteDataM,PC_4M,ext_immM;
	wire [1:0] TnewM;
	wire [4:0] A_rsM,A_rtM,AwriteM;
	//M
	wire [31:0] RDM,ALUoutM1,PC_4M1,ext_immM1;
	wire [1:0] TnewM1;
	wire [4:0] AwriteM1;
	//M_W
	wire [31:0] RDW,ALUoutW,PC_4W,ext_immW;
	wire [1:0] TnewW;
	wire [4:0] AwriteW;
	//W
	wire [31:0] ResultW,PC_backD;
	wire [4:0] AwriteW1;
	//实例化流水线
	 //F
	Fetch fetch (
    .clk(clk), 
    .reset(reset), 
    .EN(~stallF), 
    .PCSrc(PCSrcD), 
    .ext_imm(ext_immD), 
    .ext_index(ext_index), 
    .GPR_rs(GPR_rs), 
    .Instr(InstrF), 
    .PC_4(PC_4F)
    );
	 //F_D
	 F_D_register f_d (
    .clk(clk), 
	 .reset(reset),
    .EN(~stallD), 
    .InstrF(InstrF), 
    .PC_4F(PC_4F), 
    .InstrD(InstrD), 
    .PC_4D(PC_4D)
    );
	 //D
	Decode decode (
    .clk(clk), 
    .reset(reset), 
    .WE(RegWriteW1), 
    .InstrD(InstrD), 
    .PC_4D1(PC_4D), 
    .PC_backD(PC_backD), 
    .A3(AwriteW1), 
    .WD3(ResultW), 
    .forwardAD(forwardAD), 
    .forwardBD(forwardBD), 
    .ALUoutM(ALUoutM), 
    .RD1D(RD1D), 
    .RD2D(RD2D), 
    .ext_imm(ext_immD), 
    .ext_index(ext_index), 
    .GPR_rs(GPR_rs), 
    .PC_4D2(PC_4D1), 
    .Tuse_rs(Tuse_rs), 
    .Tuse_rt(Tuse_rt), 
    .TnewD(TnewD), 
    .A_rsD(A_rsD), 
    .A_rtD(A_rtD), 
    .AwriteD(AwriteD), 
    .RegWriteD(RegWriteD), 
    .MemtoRegD(MemtoRegD), 
    .MemWriteD(MemWriteD), 
    .ALUcontrolD(ALUcontrolD), 
    .ALUSrcD(ALUSrcD), 
    .RegDstD(RegDstD), 
    .PCSrcD(PCSrcD)
    );
	 //D_E
	 D_E_register d_e (
    .clk(clk), 
    .reset(reset), 
    .clr(flushE), 
    .RegWriteD(RegWriteD), 
    .MemtoRegD(MemtoRegD), 
    .MemWriteD(MemWriteD), 
    .ALUcontrolD(ALUcontrolD), 
    .ALUSrcD(ALUSrcD), 
    .RegDstD(RegDstD), 
    .RD1D(RD1D), 
    .RD2D(RD2D), 
    .PC_4D(PC_4D1), 
    .ext_immD(ext_immD), 
    .TnewD(TnewD), 
    .A_rsD(A_rsD), 
    .A_rtD(A_rtD), 
    .AwriteD(AwriteD), 
    .RegWriteE(RegWriteE), 
    .MemtoRegE(MemtoRegE), 
    .MemWriteE(MemWriteE), 
    .ALUcontrolE(ALUcontrolE), 
    .ALUSrcE(ALUSrcE), 
    .RegDstE(RegDstE), 
    .RD1E(RD1E), 
    .RD2E(RD2E), 
    .PC_4E(PC_4E), 
    .ext_immE(ext_immE), 
    .TnewE(TnewE), 
    .A_rsE(A_rsE), 
    .A_rtE(A_rtE), 
    .AwriteE(AwriteE)
    );
	 //E
	Execute execute (
    .RegWriteE1(RegWriteE), 
    .MemtoRegE1(MemtoRegE), 
    .MemWriteE1(MemWriteE), 
    .ALUcontrolE(ALUcontrolE), 
    .ALUSrcE(ALUSrcE), 
    .RegDstE(RegDstE), 
    .ALUoutM(ALUoutM), 
    .ResultW(ResultW), 
    .forwardAE(forwardAE), 
    .forwardBE(forwardBE), 
    .RD1E(RD1E), 
    .RD2E(RD2E), 
    .PC_4E1(PC_4E), 
    .ext_immE1(ext_immE), 
    .TnewE1(TnewE), 
    .A_rsE1(A_rsE), 
    .A_rtE1(A_rtE), 
    .AwriteE1(AwriteE), 
    .RegWriteE2(RegWriteE1), 
    .MemtoRegE2(MemtoRegE1), 
    .MemWriteE2(MemWriteE1), 
    .ALUoutE(ALUoutE), 
    .WriteDataE(WriteDataE), 
    .PC_4E2(PC_4E1), 
    .ext_immE2(ext_immE1), 
    .TnewE2(TnewE1), 
    .A_rsE2(A_rsE1), 
    .A_rtE2(A_rtE1), 
    .AwriteE2(AwriteE1)
    );
	//E_M
	E_M_register e_m (
    .clk(clk), 
    .reset(reset), 
    .RegWriteE(RegWriteE1), 
    .MemtoRegE(MemtoRegE1), 
    .MemWriteE(MemWriteE1), 
    .ALUoutE(ALUoutE), 
    .WriteDataE(WriteDataE), 
    .PC_4E(PC_4E1), 
    .ext_immE(ext_immE1), 
    .TnewE(TnewE1), 
    .A_rsE(A_rsE1), 
    .A_rtE(A_rtE1), 
    .AwriteE(AwriteE1), 
    .RegWriteM(RegWriteM), 
    .MemtoRegM(MemtoRegM), 
    .MemWriteM(MemWriteM), 
    .ALUoutM(ALUoutM), 
    .WriteDataM(WriteDataM), 
    .PC_4M(PC_4M), 
    .ext_immM(ext_immM), 
    .TnewM(TnewM), 
    .A_rsM(A_rsM), 
    .A_rtM(A_rtM), 
    .AwriteM(AwriteM)
    );
	 //M
	 Memory memory (
    .clk(clk), 
    .reset(reset), 
    .RegWriteM1(RegWriteM), 
    .MemtoRegM1(MemtoRegM), 
    .MemWriteM(MemWriteM), 
    .ResultW(ResultW), 
    .forwardM(forwardM), 
    .ALUoutM1(ALUoutM), 
    .WriteDataM(WriteDataM), 
    .PC_4M1(PC_4M), 
    .ext_immM1(ext_immM), 
    .TnewM1(TnewM), 
    .AwriteM1(AwriteM), 
    .RegWriteM2(RegWriteM1), 
    .MemtoRegM2(MemtoRegM1), 
    .RDM(RDM), 
    .ALUoutM2(ALUoutM1), 
    .PC_4M2(PC_4M1), 
    .ext_immM2(ext_immM1), 
    .TnewM2(TnewM1), 
    .AwriteM2(AwriteM1)
    );
	 //M_W
	 M_W_register m_w (
    .clk(clk), 
    .reset(reset), 
    .RegWriteM(RegWriteM1), 
    .MemtoRegM(MemtoRegM1), 
    .RDM(RDM), 
    .ALUoutM(ALUoutM1), 
    .PC_4M(PC_4M1), 
    .ext_immM(ext_immM1), 
    .TnewM(TnewM1), 
    .AwriteM(AwriteM1), 
    .RegWriteW(RegWriteW), 
    .MemtoRegW(MemtoRegW), 
    .RDW(RDW), 
    .ALUoutW(ALUoutW), 
    .PC_4W(PC_4W), 
    .ext_immW(ext_immW), 
    .TnewW(TnewW), 
    .AwriteW(AwriteW)
    );
	 //W
	 WriteBack writeback (
    .RegWriteW1(RegWriteW), 
    .MemtoRegW(MemtoRegW), 
    .RDW(RDW), 
    .ALUoutW(ALUoutW), 
    .AwriteW1(AwriteW), 
    .PC_4W(PC_4W), 
    .ext_immW(ext_immW), 
    .RegWriteW2(RegWriteW1), 
    .ResultW(ResultW), 
    .AwriteW2(AwriteW1), 
    .PC_backD(PC_backD)
    );
	//实例化Unit
	Unit unit (
    .Tuse_rs(Tuse_rs), 
    .Tuse_rt(Tuse_rt), 
    .TnewE(TnewE), 
    .TnewM(TnewM), 
    .TnewW(TnewW), 
    .A_rsD(A_rsD), 
    .A_rtD(A_rtD), 
    .A_rsE(A_rsE), 
    .A_rtE(A_rtE), 
    .A_rtM(A_rtM), 
    .AwriteE(AwriteE), 
    .AwriteM(AwriteM), 
    .AwriteW(AwriteW), 
    .stallF(stallF), 
    .stallD(stallD), 
    .flushE(flushE), 
    .forwardAD(forwardAD), 
    .forwardBD(forwardBD), 
    .forwardAE(forwardAE), 
    .forwardBE(forwardBE), 
    .forwardM(forwardM)
    );
endmodule
