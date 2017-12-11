`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:41:04 10/07/2017
// Design Name:   MAN_FSM
// Module Name:   D:/Programming/Verilog/HAG_1/TF.v
// Project Name:  HAG_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MAN_FSM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TF;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [2:0] std_out;
	wire [2:0] man_out;
	wire [2:0] ind_out;

	// Instantiate the Unit Under Test (UUT)
	HF1 uut(
		.clk(clk),
		.rst(rst),
		.man_out(man_out),
		.std_out(std_out),
		.ind_out(ind_out));
	
	always	#50 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;		
		// Add stimulus here
		
		#110 rst = 1'b1;
		#100 rst = 0;

	end
      
endmodule

