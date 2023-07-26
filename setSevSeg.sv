module setSevSeg(input logic [3:0] inVal,
						output logic [6:0] decDisp);
	
	// set sev seg disp for values 0-9
	always_comb
	begin
		case(inVal)
			4'b0000: decDisp <= 7'b1000000; //0
			4'b0001: decDisp <= 7'b1111001; //1
			4'b0010: decDisp <= 7'b0100100; //2
			4'b0011: decDisp <= 7'b0110000; //3
			4'b0100: decDisp <= 7'b0011001; //4
			4'b0101: decDisp <= 7'b0010010; //5
			4'b0110: decDisp <= 7'b0000010; //6
			4'b0111: decDisp <= 7'b1111000; //7
			4'b1000: decDisp <= 7'b0000000; //8
			4'b1001: decDisp <= 7'b0011000; //9
			default: decDisp <= 7'b1000000;
		endcase
	end
	
endmodule