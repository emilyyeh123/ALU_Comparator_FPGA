module dispSevSeg(input logic [3:0] inDecVal,
						input logic clock, rst, //button,
						output logic [6:0] dispDecNum);
	
	logic [6:0] holdDecDisp;
	
	setSevSeg setDispNum(.inVal(inDecVal), .decDisp(holdDecDisp));
	
	always_ff@(posedge clock or negedge rst)
	begin
		if(!rst)
			dispDecNum <= 7'b1000000;
		else //if(button)
			dispDecNum <= holdDecDisp;
	end

endmodule