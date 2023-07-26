module lab8_FIFO(input logic clock, enableButton, rd_wr_sw, rst,
					input logic [14:0] wr_data_in,
					output logic fifo_full, fifo_empty,
					output logic [14:0] rd_data_out);

	// FOR LAB 9, BUTTON GETS SYNCHRONIZED IN TOP LEVEL
	//logic syncEnable;
	//synchronizer syncButton(.clock(clock), .a(enableButton), .fallEdge(syncEnable));
	
	logic [3:0] hold_wr_addr, hold_rd_addr;
	fsm_control controlLogic(.clock(clock), .en(enableButton), .rd_wr_sw(rd_wr_sw), .rst(rst), //.en(syncEnable), 
									.fifo_full(fifo_full), .fifo_empty(fifo_empty), .wr_en(wr_en), .rd_en(rd_en),
									.wr_addr(hold_wr_addr), .rd_addr(hold_rd_addr));
	
	memory performMem(.clock(clock), .wr_en(wr_en), .rd_en(rd_en),
							.wr_addr(hold_wr_addr[2:0]), .rd_addr(hold_rd_addr[2:0]), .wr_data(wr_data_in), .rd_data(rd_data_out));
	
endmodule