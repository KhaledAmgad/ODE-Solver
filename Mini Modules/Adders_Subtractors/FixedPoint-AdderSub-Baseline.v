module FixedPoint_AdderSub_Baseline#(parameter WIDTH = 16)(a,b,op,sum,overflowFlag);
  input  [WIDTH-1:0]a;
  input  [WIDTH-1:0]b;	
  input  op;
  reg [WIDTH-1:0]sum15; 
  reg sum16; 
  wire [WIDTH-1:0]b_signed; 
  reg Zero =1'b0;
  output reg overflowFlag;
  output reg [WIDTH-1:0]sum;   


//invert B if Sub=true
genvar i;
generate 
for (i = 0; i < WIDTH; i = i + 1) begin
	assign b_signed[i] = b[i] ^ op;
end
endgenerate
	

  always @ (a or b_signed or op ) begin
  sum15={Zero,a[WIDTH-2:0]}+{Zero,b_signed[WIDTH-2:0]}+op;
  {sum16,sum[WIDTH-1]}= sum15[WIDTH-1] + a[WIDTH-1] + b_signed[WIDTH-1];
  overflowFlag = ( sum15[WIDTH-1] ^ sum16); //Carry (n-1) not equal Carry(n) == overflow(1)
  sum[WIDTH-2:0]=sum15[WIDTH-2:0];
	
	
  end

endmodule