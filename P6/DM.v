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
	input [3:0] BE,
    input [31:0] WD,
    output reg [31:0] RD,
	input [31:0] PC_4
    );
    reg [31:0] dm[4095:0];
	reg [31:0] PC;
    integer i;
	initial 
        begin
            for(i=0;i<4096;i=i+1)
                begin
                    dm[i]=32'd0;
                end
        end
    always@(*)
        begin
            RD=dm[A[13:2]];
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
							case(BE)
								4'b1111:dm[A[13:2]]=WD;
								4'b1100:dm[A[13:2]]={WD[15:0],dm[A[13:2]][15:0]};
								4'b0011:dm[A[13:2]]={dm[A[13:2]][31:16],WD[15:0]};
								4'b1000:dm[A[13:2]]={WD[7:0],dm[A[13:2]][23:0]};
								4'b0100:dm[A[13:2]]={dm[A[13:2]][31:24],WD[7:0],dm[A[13:2]][15:0]};
								4'b0010:dm[A[13:2]]={dm[A[13:2]][31:16],WD[7:0],dm[A[13:2]][7:0]};
								4'b0001:dm[A[13:2]]={dm[A[13:2]][31:8],WD[7:0]};
							endcase
							PC=PC_4-4;
							$display("%d@%h: *%h <= %h", $time, PC, {18'b0,A[13:2],2'b00},dm[A[13:2]]);
                        end
                end
        end     
endmodule
