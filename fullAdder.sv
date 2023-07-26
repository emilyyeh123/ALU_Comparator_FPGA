module fullAdder(input logic a, b, carryIn,
					  output logic z, carryOut);
	
	// single bit adder
	
	always_comb
	begin
		// z output: (NOT a AND (b XOR cI)) OR (a AND NOT (b XOR cI))
		z <= (~a & (b ^ carryIn)) | (a & ~(b ^ carryIn));
		
		// carryOut: (a AND b) OR (b AND cI) OR (a AND cI)
		carryOut <= (a & b) | (b & carryIn) | (a & carryIn);
	end

endmodule