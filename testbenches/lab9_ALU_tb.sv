module lab9_ALU_tb();

	// testbench to check that
	// - data gets stored in memory
	// - all operations are performed properly when data is read out of memory
	
	// *testbench should utilize: randomization, tasks, and self-checking

	logic clock = 1'b0;
	always #20 clock <= ~clock;

	// waves
	logic rst = 1'b0; // start system in reset
	logic button = 1'b0; // start system with button not being pressed
	logic rd_wr_sw = 1'b0; // active high write
	logic [2:0] instrIn; //instruction input
	logic [5:0] aIn, bIn; // a & b inputs
	logic [2:0] instrOut;
	logic [5:0] aOut, bOut, zOut;
	logic aNeg, bNeg, zNeg, fifo_full, fifo_empty;
	//logic [6:0] aT, aO, bT, bO, zT, zO;

	// device under test
	lab9_ALU dut_lab9_ALU(.clock(clock), .rstSw(rst), .button(button), .rd_wr_sw(rd_wr_sw),
				.instruction_in(instrIn), .a(aIn), .b(bIn),
				.aOut(aOut), .bOut(bOut), .zOut(zOut),
				//.aTens(aT), .aOnes(aO), .bTens(bT), .bOnes(bO), .zTens(zT), .zOnes(zO),
				.fifo_full(fifo_full), .fifo_emp(fifo_empty),
				.instr_out(instrOut), .aIsNeg(aNeg), .bIsNeg(bNeg), .zIsNeg(zNeg)); 
	
	`include "tb_generateRandInputs.sv"
	`include "tb_operationalTasks.sv"


	initial
	begin		
		@(negedge clock);
		rst <= 1'b1; // reset off
		
		repeat(5)
		begin
			$display("\n");
			repeat($urandom_range(1, 10)) writeRandomOp();
			repeat($urandom_range(1, 10)) readData();
		end
		
		// write some data,
		// check if reset works when some data is stored in memory
		repeat(3) writeRandomOp();
		@(negedge clock);
		rst <= 1'b0; // reset on
		$display("\n");
		repeat(10) readData();
		repeat(10) writeRandomOp();
		
		// turn off reset
		@(negedge clock);
		rst <= 1'b1; // reset off
		repeat(5)
		begin
			$display("\n");
			repeat($urandom_range(1, 10)) writeRandomOp();
			repeat($urandom_range(1, 10)) readData();
		end

		$stop;
	end

endmodule