`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:32:40 12/13/2020 
// Design Name: 
// Module Name:    mult_div 
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
module mult_div(
	input clk,
	input reset,
    input [31:0] D1,
    input [31:0] D2,
    input [2:0] mult_div_op,
    input start,
    output reg Busy,
    output [31:0] HI,
    output [31:0] LO
    );
	reg [31:0] hi,lo;
	reg [31:0] i;
	reg [63:0] temp;
	initial 
		begin
			hi=32'b0;
			lo=32'b0;
			Busy=1'b0;
			i=0;
		end
	always@(posedge clk)
		begin
			if(reset)
				begin
					hi<=32'b0;
					lo<=32'b0;
					i<=0;
					Busy<=1'b0;
				end
			else if(Busy==1'b0)
				begin
					if(start)
						begin
							Busy<=1'b1;
						end
					case(mult_div_op)
						3'b001://multu
							begin
								temp<=D1*D2;
								i<=5;
							end
						3'b010://mult
							begin
								temp<=$signed(D1)*$signed(D2);
								i<=5;
							end
						3'b011://divu
							begin
								temp<={D1%D2,D1/D2};
								i<=10;
							end
						3'b100://div
							begin
								temp<={$signed(D1)%$signed(D2),$signed(D1)/$signed(D2)};
								i<=10;
							end
						3'b101://mthi
							begin
								hi<=D1;
							end
						3'b110://mtlo
							begin
								lo<=D1;
							end
					endcase
				end
			else if(Busy==1'b1)
				begin
					if(i>0)
						begin
							i=i-1;
							if(i==0)
								begin
									{hi,lo}<=temp;
									Busy<=0;
								end
						end
				end
		end			
	assign HI=hi;
	assign LO=lo;	
					

endmodule
