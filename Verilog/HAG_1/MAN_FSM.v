`timescale 1ns / 1ps

module MAN_FSM(
    input clk,
    input rst,
    output [2:0] man_out
    );

reg [2:0] state;
wire [2:0] next_state;

// Zustandserfrischung
always @ (posedge clk)
	if(rst)	state<=3'b0;
	else		state<=next_state;
	
// Zustandsuebergangslogik
assign next_state[2] = state[1] & ~state[0] | state[2] & ~state[1] & ~state[0] | state[0] & ~state[2] & ~state[1];
assign next_state[1] = state[0] & ~state[2] | ~state[0] & ~state[1];
assign next_state[0] = ~state[2] & ~state[0] | state[2] & ~state[1];

// Ausgangslogik
assign man_out = state;

endmodule
