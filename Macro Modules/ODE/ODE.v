module ODE #(parameter N=2,parameter M=3) (
  input 	 clk,
  input   enableODE,
  input enable,
  input  [15:0] h,
  input  [((16*N)-1):0] Xo  ,
  input  [((16*N)-1):0] A,   
  input  [((16*M)-1):0] Uk  ,
  input  [((16*M)-1):0] B,
  output [15:0] Xnext ,
  output error
  );
 

  reg		done;
  wire [15:0] AmulX;
  wire [15:0] BmulU;
  reg [15:0] XnextTemp;
  reg overflow;
  initial done = 1'b1; 
  wire [15:0]sum1;
  wire [15:0]sum2;
  wire overflow1;
  wire overflow2;
  wire err1;
  wire err2;
  
  AmultiplyX #(N) AbyX  (.clk(clk),.enable(enable),.h(h),.Xo(Xo),.A(A),.AmulX(AmulX),.error(err1));
  BmultiplyU #(M) BbyU (.clk(clk),.enable(enable),.h(h),.U(Uk),.B(B),.BmulU(BmulU),.error(err2));
  
  FixedPoint_AdderSub_CarrySelect#(16) adder  (.a(Xo[31:16]),.b(AmulX),.op(1'b0),.sum(sum1),.overflowFlag(overflow1));
  FixedPoint_AdderSub_CarrySelect#(16) adder2  (.a(sum1),.b(BmulU),.op(1'b0),.sum(sum2),.overflowFlag(overflow2));
  
  assign Xnext = XnextTemp;	
  assign error = overflow;
  
	always @( posedge clk ) begin
		if(enableODE) begin		
		  XnextTemp = sum2;
		  if (overflow1==1 | overflow2==1 | err1==1|err2==1)
		    overflow<= 1'b1;
		  else
		    overflow<= 1'b0;
		end  
  end
		
endmodule



