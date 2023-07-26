	logic [5:0] aInteger, bInteger;
	logic [1:0] negAB;
	
	
	task generateRandAB();
		// set random A & B inputs
		// range of 6-bit twos comp = -32 to +31
	
		// decide which inputs are negative
		// a is neg if negAB[1] = 1, b is neg if negAB[0] = 1
		negAB = $urandom();
				
		// set A input
		if(negAB[1] == 1'b1)
		begin
			// if neg, rand value bt 0-32 
			// then set input to twos comp of the rand value
			aInteger = $urandom_range(0,32);
			aIn <= (~aInteger) + 1'b1;
		end else begin
			// if pos, set input to rand value bt 0-31
			aInteger = $urandom_range(0,31);
			aIn <= aInteger;
		end
		
		// set B input
		if(negAB[0] == 1'b1)
		begin
			// if neg, rand value bt 0-32 
			// then set input to twos comp of the rand value
			bInteger = $urandom_range(0,32);
			bIn <= (~bInteger) + 1'b1;
		end else begin
			// if pos, set input to rand value bt 0-31
			bInteger = $urandom_range(0,31);
			bIn <= bInteger;
		end
	endtask

	
	task storeData();
		rd_wr_sw <= 1'b1; // set switch to write mode
		repeat (5) @(negedge clock);
		button <= 1'b1; // push button to store data
		repeat (5) @(negedge clock);
		button <= 1'b0; // release button
	endtask
	
	
	task writeRandomOp();
		generateRandAB();
		@(negedge clock) instrIn <= $urandom();
		storeData();
		
		if(rst == 1'b0) $display("System in reset, no data can be written");
		else if(!fifo_full) $display("STORING DATA: Operation %b for inputs A = %b, B = %b", instrIn, aIn, bIn);
		else $display("FIFO is now full, no more data can be stored until some data is read/cleared");
	endtask
	
	
	task readData();
		rd_wr_sw <= 1'b0; // set switch to read mode
		repeat (5) @(negedge clock);
		button <= 1'b1; // push button to read data
		repeat (5) @(negedge clock);
		button <= 1'b0; // release button
		
		if(rst == 1'b0) $display("System in reset, no data can be read; dataOut: %b%b%b, zOut: %b", instrOut, aOut, bOut, zOut);
		else if(!fifo_empty)
		begin
			$display("\nREADING DATA: Operation %b for inputs A = %b, B = %b", instrOut, aOut, bOut);
			case(instrOut)
			3'b000: additionSim();
			3'b001: subtractionSim();
			3'b100: aEqB_sim();
			3'b101: aGreaterB_sim();
			3'b110: aLessB_sim();
			3'b111: aEq0_sim();
			default: $display("Invalid Instruction, no operation performed; zOut = %b, zNeg = %b", zOut, zNeg);
			endcase
		end else $display("No data to read, FIFO is empty");
	endtask
