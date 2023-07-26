module fsm_control(input logic clock, en, rd_wr_sw, rst,
						 output logic fifo_full, fifo_empty, wr_en, rd_en,
						 output logic [3:0] wr_addr = 4'd0, rd_addr = 4'd0);
	
	// 2-bit statetype bc 2^x = number of states (rounded up)
	typedef enum logic [1:0] {sIdle, sRead, sWrite} statetype;
	statetype presentState = sIdle, nextState;
	
	always_ff@(posedge clock or negedge rst)
	begin
		if(!rst)
			presentState <= sIdle;
		else
			presentState <= nextState;
	end
	
	always_comb
	begin
		case(presentState)
		sIdle:
			if(en == 1'b1 && rd_wr_sw == 1'b0 && fifo_empty == 1'b0)
				// read, NOT empty
				nextState <= sRead;
			else if(en == 1'b1 && rd_wr_sw == 1'b1 && fifo_full == 1'b0)
				// write, NOT full
				nextState <= sWrite;
			else
				nextState <= sIdle;
		sRead:
			if(en == 1'b1 && fifo_empty == 1'b0) //rd_wr_sw == 1'b0 && 
				// read, NOT empty
				nextState <= sRead;
			/*else if(en == 1'b1 && rd_wr_sw == 1'b1 && fifo_full == 1'b0)
				// write, NOT full
				nextState <= sWrite;*/
			else
				nextState <= sIdle;
		sWrite:
			/*if(en == 1'b1 && rd_wr_sw == 1'b0 && fifo_empty == 1'b0)
				// read, NOT empty
				nextState <= sRead;
			else*/ if(en == 1'b1 && fifo_full == 1'b0) //rd_wr_sw == 1'b1 && 
				// write, NOT full
				nextState <= sWrite;
			else
				nextState <= sIdle;
		default: nextState <= sIdle;
		endcase
	end
	
	
	
	assign fifo_full = (wr_addr[3] != rd_addr[3]) && (wr_addr[2:0] == rd_addr[2:0]);
	assign fifo_empty = (wr_addr == rd_addr);
	
	
	
	always_ff@(posedge clock or negedge rst)
	begin
		if(!rst)
		begin
			// reset addresses
			wr_en <= 1'b0;
			rd_en <= 1'b0;
			rd_addr <= 4'd0; // increment read address
			wr_addr <= 4'd0; // increment write address
		end else begin
			wr_en <= (presentState == sWrite);
			rd_en <= (presentState == sRead);

			// address increments on clock cycle and when state enters respective state
			if(presentState == sRead) begin
				// if sw in read mode and present state == sRead
				rd_addr <= rd_addr + 1'b1; // increment read address
			end

			if(presentState == sWrite) begin
				// else if sw in write mode and presentState == sWrite
				wr_addr <= wr_addr + 1'b1; // increment write address
			end
		end
	end

endmodule