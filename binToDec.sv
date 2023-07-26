module binToDec(input logic [5:0] bin,
					 output logic [3:0] tens, ones);

	logic [5:0] valOut;
	
	// if neg input, invert bits and add 1
	always_comb
	begin
		case(bin[5])
			1'b0: // is positive num
				valOut <= bin;
			1'b1: // is negative num
				valOut <= (~bin) + 6'b000001;
		endcase
	end

	// set values for tens and ones
	always_comb
	begin
		tens <= valOut / 10;
		ones <= valOut % 10;
	end
	
endmodule