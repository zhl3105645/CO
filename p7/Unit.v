`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:36 11/22/2020 
// Design Name: 
// Module Name:    Unit 
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
module Unit(
    input [1:0] Tuse_rs,
    input [1:0] Tuse_rt,
    input [1:0] TnewE,
    input [1:0] TnewM,
    input [1:0] TnewW,
    input [4:0] A_rsD,
    input [4:0] A_rtD,
    input [4:0] A_rsE,
    input [4:0] A_rtE,
	input [4:0] A_rtM,
	input [4:0] AwriteE,
    input [4:0] AwriteM,
    input [4:0] AwriteW,
	input startE,
	input BusyE,
	input m_dD,
    output reg stallF,
    output reg stallD,
	output reg flushE,
    output reg forwardAD,
    output reg forwardBD,
    output reg [1:0] forwardAE,
    output reg [1:0] forwardBE,
    output reg forwardM
    );
	 reg stop_rs,stop_rt;
	 initial 
		begin
			forwardAD=1'b0;
			forwardBD=1'b0;
			forwardAE=2'b00;
			forwardBE=2'b00;
			forwardM=1'b0;
			stop_rs=1'b0;
			stop_rt=1'b0;
			stallF=1'b0;
			stallD=1'b0;
			flushE=1'b0;
		end
	always@(*)
		begin
				//stop D
			if((A_rsD!=5'd0)&&(A_rsD==AwriteE)&&Tuse_rs<TnewE)
				stop_rs=1'b1;
			else if((A_rsD!=5'd0)&&(A_rsD==AwriteM)&&Tuse_rs<TnewM)
				stop_rs=1'b1;
			else if((A_rsD!=5'd0)&&(A_rsD==AwriteW)&&Tuse_rs<TnewW)
				stop_rs=1'b1;
			else if(m_dD&&(BusyE||startE))
				stop_rs=1'b1;
			else 
				stop_rs=1'b0;
				
			if((A_rtD!=5'd0)&&(A_rtD==AwriteE)&&Tuse_rt<TnewE)
				stop_rt=1'b1;
			else if((A_rtD!=5'd0)&&(A_rtD==AwriteM)&&Tuse_rt<TnewM)
				stop_rt=1'b1;
			else if((A_rtD!=5'd0)&&(A_rtD==AwriteW)&&Tuse_rt<TnewW)
				stop_rt=1'b1;
			else if(m_dD&&(BusyE||startE))
				stop_rt=1'b1;
			else 
				stop_rt=1'b0;
				//ÖØ¶¨Ïò
			//D
			if((A_rsD!=5'd0)&&(A_rsD==AwriteM)&&TnewM==2'b00)
				forwardAD=1'b1;
			else 
				forwardAD=1'b0;
				
			if((A_rtD!=5'd0)&&(A_rtD==AwriteM)&&TnewM==2'b00)
				forwardBD=1'b1;
			else 
				forwardBD=1'b0;
			//E
			if((A_rsE!=5'd0)&&(A_rsE==AwriteM)&&TnewM==2'b00)
				forwardAE=2'b10;
			else if((A_rsE!=5'd0)&&(A_rsE==AwriteW)&&TnewW==2'b00)
				forwardAE=2'b01;
			else 
				forwardAE=2'b00;
			
			if((A_rtE!=5'd0)&&(A_rtE==AwriteM)&&TnewM==2'b00)
				forwardBE=2'b10;
			else if((A_rtE!=5'd0)&&(A_rtE==AwriteW)&&TnewW==2'b00)
				forwardBE=2'b01;
			else 
				forwardBE=2'b00;
			//M
			if((A_rtM!=5'd0)&&(A_rtM==AwriteW)&&TnewW==2'b00)
				forwardM=1'b1;
			else 
				forwardM=1'b0;
			//stop
			stallF=((stop_rs==1'b1)||(stop_rt==1'b1))?1'b1:1'b0;
			stallD=((stop_rs==1'b1)||(stop_rt==1'b1))?1'b1:1'b0;
			flushE=((stop_rs==1'b1)||(stop_rt==1'b1))?1'b1:1'b0;	
		end
endmodule
