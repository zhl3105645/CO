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
    input [1:0] TnewD,
    input [1:0] TnewE,
    input [1:0] TnewM,
    input [1:0] TnewW,
    input [4:0] rsD,
    input [4:0] rtD,
    input [4:0] rsE,
    input [4:0] rtE,
	 input [4:0] WriteRegE,
    input [4:0] WriteRegM,
    input [4:0] WriteRegW,
	 input RegWriteE,
    input RegWriteM,
    input RegWriteW,
    input MemWriteM,
    output  reg stallF,
    output  reg stallD,
	 output  reg flushE,
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
			//D
				//stop
			if((rsD!=5'd0)&&(rsD==WriteRegE)&&RegWriteE&&Tuse_rs<TnewE)
				stop_rs=1'b1;
			else 
				stop_rs=1'b0;
			if((rtD!=5'd0)&&(rtD==WriteRegE)&&RegWriteE&&Tuse_rt<TnewE)
				stop_rt=1'b1;
			else 
				stop_rt=1'b0;	
				//ÖØ¶¨Ïò
			if((rsD!=5'd0)&&(rsD==WriteRegM)&&RegWriteM&&TnewM==2'b00)
				forwardAD=1'b1;
			else 
				forwardAD=1'b0;
			if((rtD!=5'd0)&&(rtD==WriteRegM)&&RegWriteM&&TnewM==2'b00)
				forwardBD=1'b1;
			else 
				forwardBD=1'b0;
			//E
			if((rsE!=5'd0)&&(rsE==WriteRegM)&&RegWriteM)
				begin
					if(TnewM==2'b00)
						begin
							forwardAE=2'b10;
						end
				end
			else if((rsE!=5'd0)&&(rsE==WriteRegW)&&RegWriteW)
				begin
					if(TnewW==2'b00)
						begin
							forwardAE=2'b01;
						end
				end
			else 
				forwardAE=2'b00;
			if((rtE!=5'd0)&&(rtE==WriteRegM)&&RegWriteM)
				begin
					if(TnewM==2'b00)
						begin
							forwardBE=2'b10;
						end
				end
			else if((rtE!=5'd0)&&(rtE==WriteRegW)&&RegWriteW)
				begin
					if(TnewW==2'b00)
						begin
							forwardBE=2'b01;
						end
				end
			else 
				forwardBE=2'b00;
			//M
			if((WriteRegM!=5'd0)&&(WriteRegM==WriteRegW)&&RegWriteW&&MemWriteM)
				begin
					if(TnewW==2'b00)
						begin
							forwardM=1'b1;
						end
				end
			else 
				forwardM=1'b0;
			stallF=((stop_rs==1'b1)||(stop_rt==1'b1))?1'b1:1'b0;
			stallD=((stop_rs==1'b1)||(stop_rt==1'b1))?1'b1:1'b0;
			flushE=((stop_rs==1'b1)||(stop_rt==1'b1))?1'b1:1'b0;	
		end
endmodule
