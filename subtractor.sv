module subtractor(input logic [5:0] a, b,
						output logic [5:0] z,
						output logic cOut, overflow);

	// subtraction: invert b and add 1
	// equivalent of XOR in the diagram
	
	logic [5:0] inverseB;
	assign inverseB[5] = ~b[5];
	assign inverseB[4] = ~b[4];
	assign inverseB[3] = ~b[3];
	assign inverseB[2] = ~b[2];
	assign inverseB[1] = ~b[1];
	assign inverseB[0] = ~b[0];
	
	adder sub(.a(a), .b(inverseB), .carryIn(1'b1), .z(z), .carryOut(cOut), .overflow(overflow));

endmodule