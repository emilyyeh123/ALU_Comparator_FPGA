module sixBitAddSub(input logic [5:0] a, b,
						  input logic addOrSub,
						  output logic [5:0] z,
						  output logic carryOut, overflow,
						  output logic [5:0] aOut, bOut);
	
	// top level module to decide between adder vs. subtractor
	
	// variables to hold the outputs of the adder and subtractor
	logic [5:0] addZ, subZ;
	logic addCarry, subCarry, addOF, subOF;
	
	subtractor subCalc(.a(a), .b(b), .z(subZ), .cOut(subCarry), .overflow(subOF));
	adder addCalc(.a(a), .b(b), .carryIn(addOrSub), .z(addZ), .carryOut(addCarry), .overflow(addOF));
	
	always_comb
	begin
		if(addOrSub == 1)
		begin
			// input switch for subtraction
			z <= subZ;
			overflow <= subOF;
			carryOut <= subCarry;
		end else //if(addOrSub == 0)
		begin
			// input switch for addition
			z <= addZ;
			overflow <= addOF;
			carryOut <= addCarry;
		end
		aOut <= a;
		bOut <= b;
	end
	
endmodule