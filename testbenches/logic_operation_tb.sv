module logic_operation_tb();

	// test that logical comparisons work 
	// 6-bit twos complement values a, b

	logic clock = 1'b0;
	always #20 clock <= ~clock;

	// waves
	logic [5:0] aIn, bIn, zOut;
	logic [1:0] compFunc = 2'b00;

	// device under test
	logic_operation dutLogicOp(.a(aIn), .b(bIn), .comparison(compFunc), .zLogic(zOut));




	task setInputs(logic [5:0] in1, in2);
		@(negedge clock);
		aIn <= in1;
		bIn <= in2;
	endtask



	task testGreaterThan(logic [5:0] isTrue);
		@(negedge clock);
		compFunc <= 2'b01;

		@(posedge clock);
		#1 assert(zOut == isTrue)
			$display("\tTEST A > B: returns expected value of %d", zOut);
			else $display("\tTIME: %t  TEST A > B: expected value of %d not found :(", $time, isTrue);
	endtask



	task testLessThan(logic [5:0] isTrue);
		@(negedge clock);
		compFunc <= 2'b10;

		@(posedge clock);
		#1 assert(zOut == isTrue)
			$display("\tTEST A < B: returns expected value of %d", zOut);
			else $display("\tTIME: %t  TEST A < B: expected value of %d not found :(", $time, isTrue);
	endtask



	task testAEqB(logic [5:0] isTrue);
		@(negedge clock);
		compFunc <= 2'b00;

		@(posedge clock);
		#1 assert(zOut == isTrue)
			$display("\tTEST A = B: returns expected value of %d", zOut);
			else $display("\tTIME: %t  TEST A = B: expected value of %d not found :(", $time, isTrue);
	endtask



	task testAEqZero(logic [5:0] isTrue);
		@(negedge clock);
		compFunc <= 2'b11;

		@(posedge clock);
		#1 assert(zOut == isTrue)
			$display("\tTEST A = 0: returns expected value of %d", zOut);
			else $display("\tTIME: %t  TEST A = 0: expected value of %d not found :(", $time, isTrue);
	endtask



	initial
	begin
		$display("A = +07, B = -08");
		setInputs(6'b000111, 6'b111000);
		testGreaterThan(6'd1);
		testLessThan(6'd0);
		testAEqB(6'd0);
		testAEqZero(6'd0);

		$display("\nA = +05, B = +05");
		setInputs(6'b000101, 6'b000101);
		testGreaterThan(6'd0);
		testLessThan(6'd0);
		testAEqB(6'd1);
		testAEqZero(6'd0);

		$display("\nA = -20, B = +24");
		setInputs(6'b101100, 6'b011000);
		testGreaterThan(6'd0);
		testLessThan(6'd1);
		testAEqB(6'd0);
		testAEqZero(6'd0);

		$display("\nA = +00, B = -15");
		setInputs(6'd0, 6'b110001);
		testGreaterThan(6'd1);
		testLessThan(6'd0);
		testAEqB(6'd0);
		testAEqZero(6'd1);

		$display("\nA = +24, B = +05");
		setInputs(6'b011000, 6'b000101);
		testGreaterThan(6'd1);
		testLessThan(6'd0);
		testAEqB(6'd0);
		testAEqZero(6'd0);

		$display("\nA = -20, B = -15");
		setInputs(6'b101100, 6'b110001);
		testGreaterThan(6'd0);
		testLessThan(6'd1);
		testAEqB(6'd0);
		testAEqZero(6'd0);

		$display("\nA = -08, B = -08");
		setInputs(6'b111000, 6'b111000);
		testGreaterThan(6'd0);
		testLessThan(6'd0);
		testAEqB(6'd1);
		testAEqZero(6'd0);

		$stop;
	end

endmodule