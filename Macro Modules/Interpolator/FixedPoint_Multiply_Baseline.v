 module FixedPoint_Multiply_Baseline (
  input  signed 	 [15:0] input1,
  input  signed    [15:0] input2,
  output  signed [15:0] multiply ,
  output  overflowMultiply
  );
  
	wire signed [31:0] multiplyLarge;


	assign multiplyLarge=input1 *  input2;
	assign multiply =multiplyLarge[22:7];

	assign	overflowMultiply= |( {multiply[15],multiply[15],multiply[15],multiply[15],multiply[15],multiply[15],multiply[15],multiply[15],multiply[15]} ^ multiplyLarge[31:23]) ;


	endmodule