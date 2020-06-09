	  
 module AmultiplyX #(parameter N ) (
  input 	 clk,
  input   enable,
  input  [15:0] h,
  input  [((16*N)-1):0] Xo  ,
  input  [((16*N)-1):0] A,   // y is a 2D array rows=2,cols=4 each 8-bit wide
  output [15:0] AmulX ,
  output error
  );
 

  reg		done;
  reg errorr;
  reg  [15:0] j;
  reg [15:0] firstmultiply;
  reg [15:0] firstmultiplytemp;
  reg [15:0] Atemp;
  reg [15:0] Btemp;
  wire overflow1;
  wire overflow2;
  wire overflow3;
  wire [15:0] AmulB;
  wire [15:0]multiplyresult;
  wire [ 15:0] FirstMul;
  FixedPoint_AdderSub_CarrySelect#(16) adder  (.a(firstmultiply),.b(AmulB),.op(1'b0),.sum(multiplyresult),.overflowFlag(overflow1));
  FixedPoint_Multiply_Baseline mul(.input1(Atemp),.input2(Btemp),.multiply(AmulB),.overflowMultiply(overflow2));
  FixedPoint_Multiply_Baseline mul2(.input1(firstmultiply),.input2(h),.multiply(FirstMul),.overflowMultiply(overflow3));
  
  assign AmulX = firstmultiplytemp;	
  assign error = errorr;
  
	always @( posedge clk ) begin
		if( enable) begin		
		  
		  done <= 1'b0;	
		  firstmultiplytemp<=16'b0000000000000000;								
			j<=((16*N)-1);								
			Atemp <= 0  ;								
			Btemp <= 0;									
			firstmultiply<=0;
			errorr<=1'b0;
				
		end
		else if(!done) begin
		
		  Atemp<=A[(j)-:16];
		  Btemp<=Xo[(j)-:16];
		  firstmultiply <= multiplyresult;
		 
		   j<=j-16;
		  //Multily overflow doesn't work correctly
		 //	if (overflow1==1| overflow2==1 |overflow3==1)
		   if (overflow1==1)
				   errorr<=1'b1;
				
			if(j == 16'b1111111111101111)begin  //finished
				 done <= 1'b1;	
				 firstmultiplytemp <= FirstMul; 
			end
			
		end  
 
		
end
endmodule





