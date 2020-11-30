`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:32:41 11/14/2020 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input clk,
    input reset,
    input WE,
    input [31:0] A,
    input [31:0] WD,
    output reg [31:0] RD,
	 input [31:0] PC
    );
    reg [31:0] dm[1023:0];
    integer i;
	initial 
        begin
            for(i=0;i<1024;i=i+1)
                begin
                    dm[i]=32'd0;
                end
        end
    always@(*)
        begin
            RD=dm[A[11:2]];
        end
    always@(posedge clk)
        begin
            if(reset)
                begin
                    for(i=0;i<1024;i=i+1)
								begin
									dm[i]=32'd0;
               			end
                end
            else
                begin
                    if(WE)
                        begin
                            dm[A[11:2]]=WD;
									 $display("@%h: *%h <= %h", PC, A,WD);
                        end
                end
        end     
endmodule
