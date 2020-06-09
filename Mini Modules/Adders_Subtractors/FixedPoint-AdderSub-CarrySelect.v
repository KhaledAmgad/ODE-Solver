
module FixedPoint_AdderSub_CarrySelect#(parameter WIDTH = 16)(a,b,op,sum,overflowFlag);
  input [WIDTH-1:0]a;
  input [WIDTH-1:0]b;
  input op;
  
  output  [WIDTH-1:0]sum;
  output overflowFlag;
  wire [WIDTH-1:0]b_modified;
  wire [(WIDTH/2)-1:0]carryouts;
  wire carryBeforelast;
  genvar i;


 
 
  //invert B if Sub=true
  generate 
    for (i = 0; i < WIDTH; i = i + 1) begin
		assign b_modified[i] = b[i] ^ op;
    end
  endgenerate
  
  

  generate 
	for (i = 0; i <= (WIDTH/2)-2; i = i + 1) begin
		if(i==0)
		   TwoFullAdder f0(a[0],b_modified[0],a[1],b_modified[1],op,sum[0],sum[1],carryouts[0]);
		else 
			TwoFullAdderWithMux fi(a[i*2],b_modified[i*2],a[(i*2)+1],b_modified[(i*2)+1],carryouts[i-1],sum[i*2],sum[(i*2)+1],carryouts[i]);
	end
  endgenerate
  TwoFullAdderWithMux_TwoCarryOut fEnd(a[WIDTH-2],b_modified[WIDTH-2],a[WIDTH-1],b_modified[WIDTH-1],carryouts[(WIDTH/2)-2],sum[WIDTH-2],sum[WIDTH-1],carryBeforelast,carryouts[(WIDTH/2)-1]);
  
  
  assign overflowFlag = (carryBeforelast ^ carryouts[(WIDTH/2)-1]) ;
  
  
  
endmodule 


module FullAdder(a, b,cin ,sum, carry);
  input a,b,cin;
  output sum,carry;
  
  wire x1,x2,x3;
  
  assign x1 = a ^ b;
  assign x2 = x1 & cin;
  assign x3 = a & b;
 
  assign sum   = x1 ^ cin;
  assign carry = x2 | x3;
  

  
endmodule


module TwoFullAdderWithMux(x,y,z,w,cin,s1,s2,cout);
  input x,y,z,w,cin;
  output s1,s2,cout;
  
  wire [1:0] sTemp1,sTemp2,coutTemp;
  TwoFullAdder h1(x,y,z,w,1'b0,sTemp1[0],sTemp2[0],coutTemp[0]);
  TwoFullAdder h2(x,y,z,w,1'b1,sTemp1[1],sTemp2[1],coutTemp[1]);
  Mux M({coutTemp[0],sTemp2[0],sTemp1[0]},{coutTemp[1],sTemp2[1],sTemp1[1]},cin,{cout,s2,s1});
  
  
endmodule

module Mux(a,b,s0,f);
  input [2:0]a;
  input [2:0]b;
  input s0;
  output [2:0]f;
  
  assign f = (s0 == 0) ? a :b; 
   

  
endmodule


module TwoFullAdder(x,y,z,w,cin,s1,s2,cout);
  input x,y,z,w,cin;
  output s1,s2,cout;
  
  wire carry;
  
  FullAdder H1(x,y,cin,s1,carry) ;
  FullAdder H2(z,w,carry,s2,cout);
  
endmodule



module TwoFullAdder_TwoCarryOut(x,y,z,w,cin,s1,s2,cout1,cout2);
  input x,y,z,w,cin;
  output s1,s2,cout1,cout2;

  
  FullAdder H1(x,y,cin,s1,cout1) ;
  FullAdder H2(z,w,cout1,s2,cout2);
  
endmodule


module TwoFullAdderWithMux_TwoCarryOut(x,y,z,w,cin,s1,s2,cout1,cout2);
  input x,y,z,w,cin;
  output s1,s2,cout1,cout2;
  
  wire [1:0] sTemp1,sTemp2,coutTemp1,coutTemp2;
  TwoFullAdder_TwoCarryOut h1(x,y,z,w,1'b0,sTemp1[0],sTemp2[0],coutTemp1[0],coutTemp2[0]);
  TwoFullAdder_TwoCarryOut h2(x,y,z,w,1'b1,sTemp1[1],sTemp2[1],coutTemp1[1],coutTemp2[1]);
  Mux4 M({coutTemp1[0],coutTemp2[0],sTemp2[0],sTemp1[0]},{coutTemp1[1],coutTemp2[1],sTemp2[1],sTemp1[1]},cin,{cout1,cout2,s2,s1});
  
  
endmodule

module Mux4(a,b,s0,f);
  input [3:0]a;
  input [3:0]b;
  input s0;
  output [3:0]f;
  
  assign f = (s0 == 0) ? a :b; 
   

  
endmodule
