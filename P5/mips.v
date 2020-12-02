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
	//D
	wire [31:0] InstrD,PC_4D;
	wire [31:0] RD1D,RD2D,ext_offsetD,ext_indexD,GPR_rsD;
	wire [4:0] rsD,rtD,rdD;
	wire [1:0] Tuse_rs,Tuse_rt,TnewD;
	wire [31:0] PC_4D1;
	//E
	wire [31:0] RD1E,RD2E,ext_offsetE,PC_4E;
	wire [4:0] rsE,rtE,rdE;
	wire [1:0] TnewE;
	wire [31:0] ALUoutE,WriteDataE;
	wire [31:0] PC_4E1,ext_offsetE1;
	wire [4:0] WriteRegE;
	wire [1:0] TnewE1;
	//M
	wire [31:0] ALUoutM,WriteDataM,PC_4M,ext_offsetM;
	wire [4:0] WriteRegM;
	wire [1:0] TnewM;
	wire [31:0] RDM;
	wire [31:0] PC_4M1,ext_offsetM1,ALUoutM1;
	wire [4:0] WriteRegM1;
	wire [1:0] TnewM1;
	//W
	wire [31:0] RDW,ALUoutW,PC_4W,PCW,ext_offsetW;
	wire [4:0] WriteRegW;
	wire [1:0] TnewW;
	wire [31:0] ResultW,PC_backD;
	wire [4:0] WriteRegW1;
	wire [1:0] TnewW1;
	
	//实例化流水线
	 //F
	Fetch fetch (
    .clk(clk), 
    .reset(reset), 
    .EN(~stallF), 
    .PCSrc(PCSrcD), 
    .ext_offset(ext_offsetD), 
    .ext_index(ext_indexD), 
    .GPR_rs(GPR_rsD), 
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
    .A3(WriteRegW1), 
    .WD3(ResultW), 
    .forwardAD(forwardAD), 
    .forwardBD(forwardBD), 
    .ALUoutM(ALUoutM),
    .RD1D(RD1D), 
    .RD2D(RD2D), 
    .rsD(rsD), 
    .rtD(rtD), 
    .rdD(rdD), 
    .ext_imm(ext_offsetD), 
    .ext_index(ext_indexD), 
    .GPR_rs(GPR_rsD), 
    .PC_4D2(PC_4D1),
    .Tuse_rs(Tuse_rs), 
    .Tuse_rt(Tuse_rt), 
    .TnewD(TnewD), 
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
    .rsD(rsD), 
    .rtD(rtD), 
    .rdD(rdD), 
    .PC_4D(PC_4D1), 
    .ext_immD(ext_offsetD), 
    .TnewD(TnewD), 
    .RegWriteE(RegWriteE), 
    .MemtoRegE(MemtoRegE), 
    .MemWriteE(MemWriteE), 
    .ALUcontrolE(ALUcontrolE), 
    .ALUSrcE(ALUSrcE), 
    .RegDstE(RegDstE), 
    .RD1E(RD1E), 
    .RD2E(RD2E), 
    .rsE(rsE), 
    .rtE(rtE), 
    .rdE(rdE), 
    .PC_4E(PC_4E), 
    .ext_immE(ext_offsetE), 
    .TnewE(TnewE)
    );
	 //E
	Execute extcute (
    .ALUoutM(ALUoutM), 
    .ResultW(ResultW), 
    .forwardAE(forwardAE), 
    .forwardBE(forwardBE), 
    .RegWriteE1(RegWriteE), 
    .MemtoRegE1(MemtoRegE), 
    .MemWriteE1(MemWriteE), 
    .ALUcontrolE(ALUcontrolE), 
    .ALUSrcE(ALUSrcE), 
    .RegDstE(RegDstE), 
    .RD1E(RD1E), 
    .RD2E(RD2E), 
    .rsE(rsE), 
    .rtE(rtE), 
    .rdE(rdE), 
    .PC_4E1(PC_4E), 
    .ext_immE1(ext_offsetE), 
    .TnewE1(TnewE), 
    .RegWriteE2(RegWriteE1), 
    .MemtoRegE2(MemtoRegE1), 
    .MemWriteE2(MemWriteE1), 
    .ALUoutE(ALUoutE), 
    .WriteDataE(WriteDataE), 
    .WriteRegE(WriteRegE), 
    .PC_4E2(PC_4E1), 
    .ext_immE2(ext_offsetE1), 
    .TnewE2(TnewE1)
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
    .WriteRegE(WriteRegE), 
    .PC_4E(PC_4E1), 
    .ext_immE(ext_offsetE1), 
    .TnewE(TnewE1), 
    .RegWriteM(RegWriteM), 
    .MemtoRegM(MemtoRegM), 
    .MemWriteM(MemWriteM), 
    .ALUoutM(ALUoutM), 
    .WriteDataM(WriteDataM), 
    .WriteRegM(WriteRegM), 
    .PC_4M(PC_4M),
    .ext_immM(ext_offsetM), 
    .TnewM(TnewM)
    );
	 //M
	 Memory memory (
    .clk(clk), 
    .reset(reset), 
    .RegWriteM1(RegWriteM), 
    .MemtoRegM1(MemtoRegM), 
    .MemWriteM(MemWriteM), 
    .ALUoutM1(ALUoutM), 
    .WriteDataM(WriteDataM), 
    .WriteRegM1(WriteRegM), 
    .PC_4M1(PC_4M), 
    .ext_immM1(ext_offsetM), 
    .TnewM1(TnewM), 
    .RegWriteM2(RegWriteM1), 
    .MemtoRegM2(MemtoRegM1), 
    .RDM(RDM), 
    .ALUoutM2(ALUoutM1), 
    .WriteRegM2(WriteRegM1), 
    .PC_4M2(PC_4M1), 
    .ext_immM2(ext_offsetM1), 
    .TnewM2(TnewM1)
    );
	 //M_W
	 M_W_register m_w (
    .clk(clk), 
	 .reset(reset),
    .RegWriteM(RegWriteM1), 
    .MemtoRegM(MemtoRegM1), 
    .RDM(RDM), 
    .ALUoutM(ALUoutM1), 
    .WriteRegM(WriteRegM1), 
    .PC_4M(PC_4M1), 
    .ext_immM(ext_offsetM1), 
    .TnewM(TnewM1), 
    .RegWriteW(RegWriteW), 
    .MemtoRegW(MemtoRegW), 
    .RDW(RDW), 
    .ALUoutW(ALUoutW), 
    .WriteRegW(WriteRegW), 
    .PC_4W(PC_4W), 
    .ext_immW(ext_offsetW), 
    .TnewW(TnewW)
    );
	 //W
	 WriteBack writeback (
    .RegWriteW1(RegWriteW), 
    .MemtoRegW(MemtoRegW), 
    .RDW(RDW), 
    .ALUoutW(ALUoutW), 
    .WriteRegW1(WriteRegW), 
    .PC_4W(PC_4W), 
    .ext_immW(ext_offsetW), 
    .RegWriteW2(RegWriteW1), 
    .ResultW(ResultW), 
    .WriteRegW2(WriteRegW1),
	 .PC_backD(PC_backD)
    );
	//实例化Unit
	Unit unit (
    .Tuse_rs(Tuse_rs), 
    .Tuse_rt(Tuse_rt), 
    .TnewD(TnewD), 
    .TnewE(TnewE), 
    .TnewM(TnewM), 
    .TnewW(TnewW), 
    .rsD(rsD), 
    .rtD(rtD), 
    .rsE(rsE), 
    .rtE(rtE), 
	 .WriteRegE(WriteRegE), 
    .WriteRegM(WriteRegM), 
    .WriteRegW(WriteRegW), 
	 .RegWriteE(RegWriteE),
    .RegWriteM(RegWriteM), 
    .RegWriteW(RegWriteW), 
    .MemWriteM(MemWriteM), 
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
