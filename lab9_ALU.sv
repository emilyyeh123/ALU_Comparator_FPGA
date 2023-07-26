module lab9_ALU(input logic clock, rstSw, button, rd_wr_sw,
					 input logic [2:0] instruction_in,
					 input logic [5:0] a, b,
					 //output logic [5:0] aOut, bOut, zOut,
					 output logic [6:0] aTens, aOnes, bTens, bOnes, zTens, zOnes,
					 output logic [2:0] instr_out,
					 output logic fifo_full, fifo_emp, aIsNeg, bIsNeg, zIsNeg);

	logic [5:0] aOut, bOut, zOut;

	// ALU Instruction Set:
	// Add = 000
	// Subtract = 001
	// Equal = 100
	// Greater than = 101
	// Less than = 110
	// A equal 0 = 111
	
	// synchronize reset and button inputs
	logic rstSync, buttonSync;
	reset syncReset(.clock(clock), .rstIn(rstSw), .synchedRst(rstSync));
	synchronizer syncButt(.clock(clock), .a(button), .rst(rstSync), .fallEdge(buttonSync));
	
	//concatenate input data = instruction_in + a + b
	logic [14:0] inputData;
	assign inputData = {instruction_in, a, b};
	logic [14:0] outData;
	// store data in memory
	lab8_FIFO fifo_mem(.clock(clock), .enableButton(buttonSync), .rd_wr_sw(rd_wr_sw), .rst(rstSync), .wr_data_in(inputData),
							 .fifo_full(fifo_full), .fifo_empty(fifo_emp), .rd_data_out(outData));

	// separate output data
	// instr_out = outData[14:12], A = outData[11:6], B = outData[5:0]
	assign instr_out = outData[14:12];
	assign aOut = outData[11:6];
	assign bOut = outData[5:0];
	/*always_ff @(posedge clock or negedge rstSync)
	begin
		if(!rstSync) begin
			instr_out <= 3'b0;
			aOut <= 6'd0;
			bOut <= 6'd0;
		end else begin
			instr_out <= outData[14:12];
			aOut <= outData[11:6];
			bOut <= outData[5:0];
		end
	end*/
	
	// do calculation/comparison
	logic [5:0] zLogic, zMath;
	logic_operation comparisons(.a(aOut), .b(bOut), .comparison(instr_out[1:0]), .zLogic(zLogic));
	sixBitAddSub alu_addSub(.a(aOut), .b(bOut), .addOrSub(instr_out[0]), .z(zMath));
	
	// use combinational logic to decide which operation to output to zOut
	always_comb
	begin
			aIsNeg <= aOut[5];
			bIsNeg <= bOut[5];
			
			//decide which operation to output to zOut
			case(instr_out[2])
				1'b1: // comparison logic
				begin
					zOut <= zLogic;
					zIsNeg <= 1'b0;
				end
				1'b0: // add/sub calculation
				begin
					if(instr_out[1:0] == 00 || instr_out[1:0] == 01)
					begin
						zOut <= zMath;
						zIsNeg <= zOut[5];
					end else begin
						zOut <= 6'b0;
						zIsNeg <= 1'b0;
					end
				end
			endcase
	end
	
	// display outputs: aTens, aOnes, bTens, bOnes, zTens, zOnes
	dualSevDisp dispA(.clock(clock), .rstIn(rstSync), .sixBit(aOut), .dispTens(aTens), .dispOnes(aOnes));
	dualSevDisp dispB(.clock(clock), .rstIn(rstSync), .sixBit(bOut), .dispTens(bTens), .dispOnes(bOnes));
	dualSevDisp dispC(.clock(clock), .rstIn(rstSync), .sixBit(zOut), .dispTens(zTens), .dispOnes(zOnes));

endmodule