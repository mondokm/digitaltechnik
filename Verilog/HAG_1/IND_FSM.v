`timescale 1ns / 1ps

module IND_FSM(
    input clk,
    input rst,
    output [2:0] ind_out
    );
reg [2:0] cnt,out;

always @ (posedge clk)
	if(rst) cnt <= 3'b0;
	else cnt <= cnt+1;
	
always @ (*)
	case(cnt)
		3'b000: out<= 3'b000;
		3'b001: out<= 3'b011;
		3'b010: out<= 3'b010;
		3'b011: out<= 3'b101;
		3'b100: out<= 3'b001;
		3'b101: out<= 3'b110;
		3'b110: out<= 3'b100;
		3'b111: out<= 3'b111;
		default: out<= 3'b000;
	endcase

assign ind_out=out;

endmodule
