module logic_operation(input logic [5:0] a, b,
								input logic [1:0] comparison,
								output logic [5:0] zLogic);
	
	// Do comparison logic and output T/F (1 or 0) based on truth of statement
	// Must convert inputs to twos-complements numbers
	
	logic [5:0] twosCompA, twosCompB;
	logic aisNeg, bisNeg;
	
	// if neg input, invert bits and add 1
	always_comb
	begin
		case(a[5])
			1'b0: // is positive num
			begin
				twosCompA <= a;
				aisNeg <= 1'b0;
			end
			1'b1: // is negative num
			begin
				twosCompA <= (~a) + 6'b000001;
				aisNeg <= 1'b1;
			end
		endcase
		
		case(b[5])
			1'b0: // is positive num
			begin
				twosCompB <= b;
				bisNeg <= 1'b0;
			end
			1'b1: // is negative num
			begin
				twosCompB <= (~b) + 6'b000001;
				bisNeg <= 1'b1;
			end
		endcase
	end
	
	
	
	always_comb
	begin
		case(comparison)
			2'b00:
				// if a == b
				if(twosCompA == twosCompB)
					zLogic <= 6'd1;
				else
					zLogic <= 6'd0;
			2'b01:
				// if a > b
				if(  (!aisNeg && bisNeg) ||
					( (!aisNeg && !bisNeg) && (twosCompA > twosCompB) ) ||
					( (aisNeg && bisNeg) && (twosCompA < twosCompB) ) )
					// IF a is pos and b is neg, THEN TRUE
					// IF a and b are pos AND a > b, THEN TRUE
					// IF a and b are neg AND a < b, THEN TRUE
					zLogic <= 6'd1;
				else
					zLogic <= 6'd0;
			2'b10:
				// if a < b
				if(  (aisNeg && !bisNeg) ||
					( (!aisNeg && !bisNeg) && (twosCompA < twosCompB) ) ||
					( (aisNeg && bisNeg) && (twosCompA > twosCompB) ) )
					// IF a is neg and b is pos, THEN TRUE
					// IF a and b are pos AND a < b, THEN TRUE
					// IF a and b are neg AND a > b, THEN TRUE
					zLogic <= 6'd1;
				else
					zLogic <= 6'd0;
			2'b11:
				// if a == 0
				if(a == 6'd0)
					zLogic <= 6'd1;
				else
					zLogic <= 6'd0;
			default: zLogic <= 6'd0;
		endcase
	end

endmodule