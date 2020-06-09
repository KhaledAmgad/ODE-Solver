module FixedPoint_Multiply_Baseline (
  input reg signed 	 [15:0] input1,
  input reg signed    [15:0] input2,
  output reg signed [15:0] multiply ,
  output reg overflowMultiply
  );
  
	reg signed [31:0] multiplyLarge;

	always @(input1 or  input2) 
	begin
	multiplyLarge=(input1 *  input2);
	multiply =multiplyLarge[22:7];
	assign overflowMultiply=( {8{multiply[15]}}== multiplyLarge[31:23])? 1'b0 : 1'b1;
	end
	

	endmodule