module memory(input logic clock, wr_en, rd_en,
				  input logic [2:0] wr_addr, rd_addr,
				  input logic [14:0] wr_data,
				  output logic [14:0] rd_data);

	// simple dual port memory module
	
	logic [14:0] mem [7:0];
	
	// initialize memory to value of its address
	// when simulating in Questa, must suppress memory error: 
	// vlog ... -suppress 7061 file.sv
	initial
	begin
		for (int i = 0; i < 8; i = i + 1)
			mem[i] <= i; 
	end

	
	always_ff@(posedge clock)
	begin
		if(wr_en)
			mem[wr_addr] <= wr_data;
			
		if(rd_en)
			rd_data <= mem[rd_addr];
	end

endmodule