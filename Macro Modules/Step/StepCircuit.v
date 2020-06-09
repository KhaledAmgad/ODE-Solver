module StepCircuit
(
  input Clk,reset,
  input [16-1:0] inputDataOne,
  input [16-1:0] inputDataTwo
);
wire [1:0]CoordWires;
wire muxWire,compareResult,incTime,enableCoord,	// enableCoord depends on the fixed mode
	AccBf1OV,AccBf2OV,err1OV,err2OV,ComparatorOV,exceptionErr,
	DivOV,DivByZero,DivFinished,startDiv,
	Mult1ResOV,Mult2ResOV,Mult3ResOV,halfHStepOV,LMultNOV,
	stepFinish;
	
wire [16-1:0]AccBf1Output,AccBf2Output,
	error1,error2,error,muxData,
	N,L,LMultN,LDivideE,
	Mult1Res,Mult2Res,Mult3Res,
	hStepOutput,hStep,hModified,halfHStep,Const1,Const2; // Const1 = 0.9 , Const2 = 0.5

//making accumlating buffers for Xn+1(0) , Xn+1(1) respectively

AccBuff AccBf1(
  .Clk(Clk & enableCoord),
  .reset(reset),
  .enable( !CoordWires[0] & !CoordWires[1] ),
  .inputData(inputDataOne),
  .outputData(AccBf1Output),
  .overflowFlag(AccBf1OV)
);

AccBuff AccBf2(
  .Clk(Clk & enableCoord),
  .reset(reset),
  .enable( !CoordWires[0] & CoordWires[1] ),
  .inputData(inputDataTwo),
  .outputData(AccBf2Output),
  .overflowFlag(AccBf2OV)
);



/*

overflow mn kol wa7da , divbyzero mn kol wa7da w hakaza

*/

//here we would take the absolute error so we made 2 errors

//error1 if AccBf1Output > AccBf2Output
FixedPoint_AdderSub_CarryLookAhead#(.WIDTH(16)) err1Circuit(
  .a(AccBf1Output),
  .b(AccBf2Output),
  .op("1"),
  .sum(error1),
  .overflowFlag(err1OV)
);

//error2 if AccBf2Output > AccBf1Output
FixedPoint_AdderSub_CarryLookAhead#(.WIDTH(16)) err2Circuit(
  .a(AccBf2Output),
  .b(AccBf1Output),
  .op("1"),
  .sum(error2),
  .overflowFlag(err2OV)
);


//multiply L with N
//////////////////////////////// modify it
FixedPoint_Multiply_Baseline LMultNCircui(
  .input1(L),
  .input2(N),
  .multiply(LMultN),
  .overflowMultiply(LMultNOV)
  );

//compare L with ERROR i.e. check if L >= error
Comparator CompLE(
  .A(LMultN),
  .B(error),
  .overflowFlag(ComparatorOV),
  .GE(compareResult)
);


//hModified = h*h*0.9*L/error

// L/error
fixedpoint_Division DivideLE(
	.dividend(LMultN),
	.divisor(error),
	.clk(Clk),
	.quotient_out(LDivideE),
	.overflow(DivOV),
	.divbyzero(DivByZero),
	.finished(DivFinished),
	.enable(DivEnable)
	);


//0.9*h
FixedPoint_Multiply_Baseline Mult1Circuit(
  .input1(Const1),
  .input2(hStep),
  .multiply(Mult1Res),
  .overflowMultiply(Mult1ResOV)
  );

//0.9*h*h
FixedPoint_Multiply_Baseline Mult2Circuit(
  .input1(Mult1Res),
  .input2(hStep),
  .multiply(Mult2Res),
  .overflowMultiply(Mult2ResOV)
  );

//0.9*h*h*L/error
FixedPoint_Multiply_Baseline Mult3Circuit(
  .input1(Mult2Res),
  .input2(LDivideE),
  .multiply(Mult3Res),
  .overflowMultiply(Mult3ResOV)
  );

//h = h * 0.5
FixedPoint_Multiply_Baseline halfHCircuit(
  .input1(Const2),
  .input2(hStep),
  .multiply(halfHStep),
  .overflowMultiply(halfHStepOV)
  );


//absolute error
assign error = 
	(error1[15] == 0) ? error1 :
		error2;
//making the multiplixer which is before the comparator circuit
assign muxWire = CoordWires[0] & CoordWires[1];
assign muxData = 
  (muxWire == 0) ? 0 :
  error;

//should be sent to the coordinator
assign stepFinish = (!compareResult | DivFinished ) & (CoordWires[0] & CoordWires[1]);

//exceptionErr should be sent to the coordinator
assign exceptionErr = AccBf1OV | AccBf2OV | err1OV | err2OV | ComparatorOV | 
					DivByZero | DivOV | Mult1ResOV | Mult2ResOV | Mult3ResOV | halfHStepOV;

//send this signal when the current h is correct
assign incTime = CoordWires[0] & CoordWires[1] & !compareResult;
assign hModified = 
  (compareResult == 1) ? Mult3Res :
  hStep;

assign startDiv = 
	(compareResult == 1 & CoordWires[0] == 1 & CoordWires[1] == 1) ? 1 :
	0;
	
//hStepOutput should be sent to the coordinator and the ODE
assign hStepOutput = 
  (CoordWires[0] == 0 & CoordWires[1] == 0) ? hStep :
  (CoordWires[0] == 1 & CoordWires[1] == 1 & stepFinish == 1) ? hModified :
  halfHStep;

endmodule

