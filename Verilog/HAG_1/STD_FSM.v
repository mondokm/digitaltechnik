`timescale 1ns / 1ps

module STD_FSM(
    input clk,
    input rst,
    output [2:0] std_out
    );

parameter START = 3'b000;
parameter A = 3'b011;
parameter B = 3'b010;
parameter C = 3'b101;
parameter D = 3'b001;
parameter E = 3'b110;
parameter F = 3'b100;
parameter G = 3'b111;

reg [2:0] state, next_state;

// Zustandserfrischung
always @ (posedge clk)
	if(rst) state <= START;
	else state <= next_state;

//Zustanduebergangslogik
always @ (*)
	case(state)
		START: next_state <= A;
		A: next_state <= B;
		B: next_state <= C;
		C: next_state <= D;
		D: next_state <= E;
		E: next_state <= F;
		F: next_state <= G;
		G: next_state <= START;
	endcase

//Ausgangslogik
assign std_out = state;
		
endmodule
