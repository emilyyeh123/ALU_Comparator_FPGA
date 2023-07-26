module reset(input logic clock, rstIn,
				 output logic synchedRst);

	// active low reset button, active low reset output
	
	logic intRst;
	
	always_ff@(posedge clock or negedge rstIn)
	begin
		if(!rstIn)
		begin
			intRst <= 1'b0;
			synchedRst <= 1'b0;
		end else begin
			intRst <= 1'b1;
			synchedRst <= intRst;
		end
	end

endmodule