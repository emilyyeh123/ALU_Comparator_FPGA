module synchronizer(input logic clock, a, rst,
						  output logic fallEdge, riseEdge, synch);

	logic ff1, ff2, ff3;
	
	always_ff @(posedge clock or negedge rst)
	begin
		if(!rst) begin
			ff1 <= 1'b0;
			ff2 <= 1'b0;
			ff3 <= 1'b0;
		end else begin
			ff1 <= a;
			ff2 <= ff1;
			ff3 <= ff2;
		end
	end

	assign fallEdge = ~ff2 & ff3;
	assign riseEdge = ff2 & ~ff3;
	assign synch = ff2;
	
endmodule