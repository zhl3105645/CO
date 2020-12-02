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
    assign ADDU=~op[0]&~op[1]&~op[2]&~op[3]&~op[4]&~op[5]&func[0]&~func[1]&~func[2]&~func[3]&~func[4]&func[5];
    assign SUBU=~op[0]&~op[1]&~op[2]&~op[3]&~op[4]&~op[5]&func[0]&func[1]&~func[2]&~func[3]&~func[4]&func[5];
    assign JR=~op[0]&~op[1]&~op[2]&~op[3]&~op[4]&~op[5]&~func[0]&~func[1]&~func[2]&func[3]&~func[4]&~func[5];
    assign ORI=op[0]&~op[1]&op[2]&op[3]&~op[4]&~op[5];
    assign LW=op[0]&op[1]&~op[2]&~op[3]&~op[4]&op[5];
    assign SW=op[0]&op[1]&~op[2]&op[3]&~op[4]&op[5];
    assign BEQ=~op[0]&~op[1]&op[2]&~op[3]&~op[4]&~op[5];
    assign LUI=op[0]&op[1]&op[2]&op[3]&~op[4]&~op[5];
    assign JAL=op[0]&op[1]&~op[2]&~op[3]&~op[4]&~op[5];
    assign J=~op[0]&op[1]&~op[2]&~op[3]&~op[4]&~op[5];
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
