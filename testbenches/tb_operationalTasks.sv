// tasks to take in random a,b values and perform mathematical/logical operations
// then test if output is as expected when in specified mode

logic [6:0] calcAdd, calcSub;

task additionSim();
// perform mathematical addition
	$display("TESTING ADDITION:");

	calcAdd <= aOut + bOut;
	
	$display("\t A:   %b\n\t B: + %b\n\t-------------\n\t Z:   %b", aOut, bOut, zOut);
	@(posedge clock);
	#1 assert(zOut == calcAdd[5:0])
		$display("\t --> Output matches expected output: %b (first bit indicates overflow)", calcAdd);
		else $display("\t --> Output DOES NOT match expected output: %b (first bit indicates overflow)", calcAdd);
endtask

task subtractionSim();
// perform mathematical subtraction
	$display("TESTING SUBTRACTION:");
	
	calcSub <= aOut - bOut;
	
	$display("\t\t A:   %b\n\t\t B: - %b\n\t\t-------------\n\t\t Z:   %b", aOut, bOut, zOut);
	@(posedge clock);
	#1 assert(zOut == calcSub[5:0])
		$display("\t --> Output matches expected output: %b (first bit indicates overflow)", calcSub);
		else $display("\t --> ***Output DOES NOT match expected output: %b (first bit indicates overflow)", calcSub);
endtask


task aEqB_sim();
// if A == B, output 1, else output 0
	$display("TESTING A = B:");
	
	if(aOut == bOut)
	begin
		@(posedge clock);
		#1 assert(zOut == 6'd1) // z is true
			$display("\tCORRECT; A %b = B %b and output is %d", aOut, bOut, zOut);
			else $display("\tINCORRECT OUTPUT AT TIME %t; A %b = B %b but output is %d", $time, aOut, bOut, zOut);
	end else begin
		@(posedge clock);
		#1 assert(zOut == 6'd0) // z is true
			$display("\tCORRECT; A %b != B %b and output is %d", aOut, bOut, zOut);
			else $display("\tINCORRECT OUTPUT AT TIME %t; A %b != B %b but output is %d", $time, aOut, bOut, zOut);
	end
endtask


task aGreaterB_sim();
// if A > B, output 1, else output 0
	$display("TESTING A > B:");

	// if A pos and B pos and A>B
	// if A neg and B neg and A<B
	// if A pos and B neg
	if(((!aNeg && !bNeg) && (aOut > bOut)) ||
		(( aNeg &&  bNeg) && ((~aOut+1'b1) < (~bOut+1'b1))) ||
		( !aNeg &&  bNeg))
	begin
		@(posedge clock);
		#1 assert(zOut == 6'd1) // z is true
			$display("\tCORRECT; A %b > B %b and output is %d", aOut, bOut, zOut);
			else $display("\tINCORRECT OUTPUT AT TIME %t; A %b > B %b but output is %d", $time, aOut, bOut, zOut);
	end else begin
		@(posedge clock);
		#1 assert(zOut == 6'd0) // z is true
			$display("\tCORRECT; A %b !> B %b and output is %d", aOut, bOut, zOut);
			else $display("\tINCORRECT OUTPUT AT TIME %t; A %b !> B %b but output is %d", $time, aOut, bOut, zOut);
	end
endtask


task aLessB_sim();
// if A < B, output 1, else output 0
	$display("TESTING A < B:");

	// if A pos and B pos and A<B
	// if A neg and B neg and A>B
	// if A neg and B pos
	if(((!aNeg && !bNeg) && (aOut < bOut)) ||
		(( aNeg &&  bNeg) && ((~aOut+1'b1) > (~bOut+1'b1))) ||
		(  aNeg && !bNeg))
	begin
		@(posedge clock);
		#1 assert(zOut == 6'd1) // z is true
			$display("\tCORRECT; A %b < B %b and output is %d", aOut, bOut, zOut);
			else $display("\tINCORRECT OUTPUT AT TIME %t; A %b < B %b but output is %d", $time, aOut, bOut, zOut);
	end else begin
		@(posedge clock);
		#1 assert(zOut == 6'd0) // z is true
			$display("\tCORRECT; A %b !< B %b and output is %d", aOut, bOut, zOut);
			else $display("\tINCORRECT OUTPUT AT TIME %t; A %b !< B %b but output is %d", $time, aOut, bOut, zOut);
	end
endtask


task aEq0_sim();
// if A == 0, output 1, else output 0
	$display("TESTING A = 0:");
	
	if(aOut == 1'b0)
	begin
		@(posedge clock);
		#1 assert(zOut == 6'd1) // z is true
			$display("\tCORRECT; A %b = 0 and output is %d", aOut, zOut);
			else $display("\tINCORRECT OUTPUT AT TIME %t; A %b = 0 but output is %d", $time, aOut, zOut);
	end else begin
		@(posedge clock);
		#1 assert(zOut == 6'd0) // z is true
			$display("\tCORRECT; A %b != 0 and output is %d", aOut, zOut);
			else $display("\tINCORRECT OUTPUT AT TIME %t; A %b != 0 but output is %d", $time, aOut, zOut);
	end
endtask