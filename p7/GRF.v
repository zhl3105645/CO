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
	input [31:0] PC_4,
	input [31:0] PC_backD,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
    output reg [31:0] RD1,
    output reg [31:0] RD2
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
							$display("%d@%h: $%d <= %h", $time,PC_backD,A3,WD3);
                        end
                end
        end
	 always@(*)//寄存器内部转发
		begin
			if((A1==A3)&&(WE==1'b1)&&(A3!=5'd0))
				RD1=WD3;
			else 
				RD1=(A1==5'd0)?32'd0:GPR[A1];
				
			if(A2==A3&&WE==1'b1&&A3!=5'd0)
				RD2=WD3;
			else 
				RD2=(A2==5'd0)?32'd0:GPR[A2];
		end
endmodule
