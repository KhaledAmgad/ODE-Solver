 module FixedPoint_Division_Baseline (
  input  signed 	 [15:0] input1,
  input  signed    [15:0] input2,
  output  signed [15:0] out ,
  output  overflow
  );
  
	wire signed [22:0] input1Large;
	wire signed [31:0] outLarge;

	assign input1Large=input1<<7;
	assign outLarge= input1Large /  input2;
	assign out =outLarge[15:0];

	assign	overflow= |( {out[15],out[15],out[15],out[15],out[15],out[15],out[15],out[15],out[15],out[15],out[15],out[15],out[15],out[15],out[15],out[15]} ^ outLarge[31:16])  |   ~| input2  ;


	endmodule