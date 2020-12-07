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
    input [5:0] op,
    input [5:0] func,
    output reg [1:0] Tuse_rs,
    output reg [1:0] Tuse_rt,
    output reg [1:0] TnewD
    );
	wire ADDU,SUBU,JR,ORI,LW,SW,BEQ,LUI,JAL,J;
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
	//判断T	Tuse=11时为不使用该数据
	always@(*)
		begin
			if(ADDU==1'b1)
				begin
					Tuse_rs=2'b01;
					Tuse_rt=2'b01;
					TnewD=2'b10;
				end
			else if(SUBU==1'b1)
				begin
					Tuse_rs=2'b01;
					Tuse_rt=2'b01;
					TnewD=2'b10;
				end
			else if(ORI==1'b1)
				begin
					Tuse_rs=2'b01;
					Tuse_rt=2'b11;
					TnewD=2'b10;
				end
			else if(LW==1'b1)
				begin
					Tuse_rs=2'b01;
					Tuse_rt=2'b11;
					TnewD=2'b11;
				end
			else if(SW==1'b1)
				begin
					Tuse_rs=2'b01;
					Tuse_rt=2'b10;
					TnewD=2'b00;
				end
			else if(BEQ==1'b1)
				begin
					Tuse_rs=2'b00;
					Tuse_rt=2'b00;
					TnewD=2'b00;
				end
			else if(LUI==1'b1)
				begin
					Tuse_rs=2'b11;
					Tuse_rt=2'b11;
					TnewD=2'b11;
				end
			else if(J==1'b1)
				begin
					Tuse_rs=2'b11;
					Tuse_rt=2'b11;
					TnewD=2'b00;
				end
			else if(JAL==1'b1)
				begin
					Tuse_rs=2'b11;
					Tuse_rt=2'b11;
					TnewD=2'b11;
				end
			else if(JR==1'b1)
				begin
					Tuse_rs=2'b00;
					Tuse_rt=2'b11;
					TnewD=2'b00;
				end
		end
endmodule
