`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:30:46 11/14/2020 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input reset,
    input clk,
    input WE,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
    output [31:0] RD1,
    output [31:0] RD2,
	 input [31:0] PC
    );
    reg [31:0] GPR[31:0];
    integer i;
	 initial
		begin
			for(i=0;i<32;i=i+1)
				begin
					GPR[i]=32'b0;
				end
		end
    always@(posedge clk)
        begin
            if(reset)
                begin
                    for(i=0;i<32;i=i+1)
               			begin
                   			GPR[i]=32'b0;
								end
                end
            else 
                begin
                    if(WE&&(A3!=5'd0))
                        begin
                            GPR[A3]=WD3;
									 $display("@%h: $%d <= %h",PC,A3,WD3);
                        end
                end
        end
    assign RD1=(A1==5'd0)?32'd0:GPR[A1];
    assign RD2=(A2==5'd0)?32'd0:GPR[A2];
endmodule
