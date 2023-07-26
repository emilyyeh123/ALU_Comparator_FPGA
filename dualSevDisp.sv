module dualSevDisp(input logic [5:0] sixBit, input logic clock, rstIn, //buttonIn, 
						 output logic [6:0] dispTens, dispOnes);
	
	logic [3:0] holdTens, holdOnes;
	
	binToDec convertToDec(.bin(sixBit), .tens(holdTens), .ones(holdOnes));
	dispSevSeg dispTensVal(.inDecVal(holdTens), .clock(clock), .rst(rstIn), .dispDecNum(dispTens)); //.button(buttonIn), 
	dispSevSeg dispOnesVal(.inDecVal(holdOnes), .clock(clock), .rst(rstIn), .dispDecNum(dispOnes)); //.button(buttonIn), 
	
endmodule