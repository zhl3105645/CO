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
	wire ADDU,SUBU,JR,ORI,LW,SW,BEQ,LUI,JAL,J,ADDI,JALR;
	//判断指令
    assign ADDU=(op==6'b000000&&func==6'b100001)?1'b1:1'b0;
	 assign SUBU=(op==6'b000000&&func==6'b100011)?1'b1:1'b0;
	 assign JR=(op==6'b000000&&func==6'b001000)?1'b1:1'b0;
	 assign ORI=(op==6'b001101)?1'b1:1'b0;
	 assign LW=(op==6'b100011)?1'b1:1'b0;
	 assign SW=(op==6'b101011)?1'b1:1'b0;
	 assign BEQ=(op==6'b000100)?1'b1:1'b0;
	 assign LUI=(op==6'b001111)?1'b1:1'b0;
	 assign JAL=(op==6'b000011)?1'b1:1'b0;
	 assign J=(op==6'b000010)?1'b1:1'b0;
	 assign ADDI=(op==6'b001000)?1'b1:1'b0;
	 assign JALR=(op==6'b000000&&func==6'b001001)?1'b1:1'b0;
	//判断AT	Tuse=11时为不使用该数据
	always@(*)
		begin
			if(ADDU==1'b1)
				begin
					Tuse_rs=2'b01;
					Tuse_rt=2'b01;
					TnewD=2'b10;
					A_rsD=rs;
					A_rtD=rt;
					AwriteD=rd;
				end
			else if(SUBU==1'b1)
				begin
					Tuse_rs=2'b01;
					Tuse_rt=2'b01;
					TnewD=2'b10;
					A_rsD=rs;
					A_rtD=rt;
					AwriteD=rd;
				end
			else if(ORI==1'b1)
				begin
					Tuse_rs=2'b01;
					Tuse_rt=2'b11;
					TnewD=2'b10;
					A_rsD=rs;
					A_rtD=5'd0;
					AwriteD=rt;
				end
			else if(LW==1'b1)
				begin
					Tuse_rs=2'b01;
					Tuse_rt=2'b11;
					TnewD=2'b11;
					A_rsD=rs;
					A_rtD=5'd0;
					AwriteD=rt;
				end
			else if(SW==1'b1)
				begin
					Tuse_rs=2'b01;
					Tuse_rt=2'b10;
					TnewD=2'b00;
					A_rsD=rs;
					A_rtD=rt;
					AwriteD=5'd0;
				end
			else if(BEQ==1'b1)
				begin
					Tuse_rs=2'b00;
					Tuse_rt=2'b00;
					TnewD=2'b00;
					A_rsD=rs;
					A_rtD=rt;
					AwriteD=5'd0;
				end
			else if(LUI==1'b1)
				begin
					Tuse_rs=2'b11;
					Tuse_rt=2'b11;
					TnewD=2'b11;
					A_rsD=5'd0;
					A_rtD=5'd0;
					AwriteD=rt;
				end
			else if(J==1'b1)
				begin
					Tuse_rs=2'b11;
					Tuse_rt=2'b11;
					TnewD=2'b00;
					A_rsD=5'd0;
					A_rtD=5'd0;
					AwriteD=5'd0;
				end
			else if(JAL==1'b1)
				begin
					Tuse_rs=2'b11;
					Tuse_rt=2'b11;
					TnewD=2'b11;
					A_rsD=5'd0;
					A_rtD=5'd0;
					AwriteD=5'd31;
				end
			else if(JR==1'b1)
				begin
					Tuse_rs=2'b00;
					Tuse_rt=2'b11;
					TnewD=2'b00;
					A_rsD=rs;
					A_rtD=5'd0;
					AwriteD=5'd0;
				end
			else if(ADDI==1'b1)
				begin
					Tuse_rs=2'b01;
					Tuse_rt=2'b11;
					TnewD=2'b10;
					A_rsD=rs;
					A_rtD=5'd0;
					AwriteD=rt;
				end
			else if(JALR==1'b1)
				begin
					Tuse_rs=2'b00;
					Tuse_rt=2'b11;
					TnewD=2'b11;
					A_rsD=rs;
					A_rtD=5'd0;
					AwriteD=rd;
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
