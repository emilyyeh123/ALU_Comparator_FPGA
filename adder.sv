module adder(input logic [5:0] a, b,
				 input logic carryIn,
				 output logic [5:0] z,
				 output logic carryOut, overflow);

	// six bit adder system
	
	logic [4:0] cOut;
	
	fullAdder add0(.a(a[0]), .b(b[0]), .carryIn(carryIn), .z(z[0]), .carryOut(cOut[0]));
	fullAdder add1(.a(a[1]), .b(b[1]), .carryIn(cOut[0]), .z(z[1]), .carryOut(cOut[1]));
	fullAdder add2(.a(a[2]), .b(b[2]), .carryIn(cOut[1]), .z(z[2]), .carryOut(cOut[2]));
	fullAdder add3(.a(a[3]), .b(b[3]), .carryIn(cOut[2]), .z(z[3]), .carryOut(cOut[3]));
	fullAdder add4(.a(a[4]), .b(b[4]), .carryIn(cOut[3]), .z(z[4]), .carryOut(cOut[4]));
	fullAdder add5(.a(a[5]), .b(b[5]), .carryIn(cOut[4]), .z(z[5]), .carryOut(carryOut));
	
	assign overflow = (a[5] & b[5] & ~z[5]) | (~a[5] & ~b[5] & z[5]);

endmodule