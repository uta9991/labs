`timescale 1ns / 1ps


module testbench7uta;

	// Inputs
	reg [31:0] A_in;
	reg [31:0] B_in;
	reg [5:0] cmd;
	reg [1:0] op;

	// Outputs
	wire [31:0] result;
	wire [3:0] flag;

	// Instantiate the Unit Under Test (UUT)
	lab7uta uut (
		.A_in(A_in), 
		.B_in(B_in), 
		.cmd(cmd), 
		.op(op), 
		.result(result), 
		.flag(flag)
	);

	initial begin
		// Initialize Inputs
		A_in = 0;
		B_in = 0;
		cmd = 0;
		op = 0;

		// Wait 100 ns for global reset to finish
		#10;
      A_in = 55;
		B_in = 32;
		cmd = 4;
		op = 0;
		#10;
		A_in = 4;
		B_in = 22;
		cmd = 1;
		op = 0;
		#10;

	end
      
endmodule

