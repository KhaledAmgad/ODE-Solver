module interpolateALU#(parameter WIDTH = 16)(Tk,Tn,Tz,Uz,Un,Uk,error,clk,start,ready);
	input [WIDTH-1:0] Tk,Tn,Tz,Uz,Un;
	input 	 clk,start;
	output [WIDTH-1:0] Uk;
	output error,ready;

	wire divbyzero_fixedDiv,overflow_fixedDiv;
	wire  [WIDTH-1:0]Tk_Sub_Tn,Tz_Sub_Tn,Uz_sub_Un,Div,Mult;
    wire [5:0] overflowFlag;
	
	


	
	FixedPoint_AdderSub_CarrySelect#(WIDTH) sub1(Tk,Tn,1'b1,Tk_Sub_Tn,overflowFlag[0]);
	FixedPoint_AdderSub_CarrySelect#(WIDTH) sub2(Tz,Tn,1'b1,Tz_Sub_Tn,overflowFlag[1]);
	
	

	FixedPoint_AdderSub_CarrySelect#(WIDTH) sub3(Uz,Un,1'b1,Uz_sub_Un,overflowFlag[2]);
	
	//fixedpoint_Division fixedDiv (.dividend(Uz_sub_Un), .divisor(Tz_Sub_Tn),.clk(clk), .quotient_out(Div),.error(overflowFlag[4]),.finished(ready),.enable(start),.overflow(overflow_fixedDiv),.divbyzero(divbyzero_fixedDiv));
	FixedPoint_Division_Baseline fixedDiv(Uz_sub_Un,Tz_Sub_Tn,Div,overflowFlag[4]);
	assign ready= 1'b1;

	
	FixedPoint_Multiply_Baseline mul(Tk_Sub_Tn,Div,Mult,overflowFlag[5]);
	

	FixedPoint_AdderSub_CarrySelect#(WIDTH) add1(Mult,Un,1'b0,Uk,overflowFlag[3]);
	
	assign error = |overflowFlag;

endmodule
