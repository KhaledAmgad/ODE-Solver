module FixedPoint_AdderSub_CarryLookAhead#(parameter WIDTH = 16)(a,b,op,sum,overflowFlag);
	input [WIDTH-1:0] a,b;
	input op;
	output [WIDTH-1:0] sum;
	output overflowFlag;
	wire carrylast,carryBeforelast;
	wire [WIDTH-1:0]b_modified;
	wire [WIDTH:0]    C;
	wire [WIDTH-1:0]    G, P;
	
	//invert B if Sub=true
	genvar i;
	generate 
	for (i = 0; i < WIDTH; i = i + 1) begin
		assign b_modified[i] = b[i] ^ op;
	end
	endgenerate
	
	
	assign G = a & b_modified;
	assign P = a | b_modified;
	
	
	assign C = {G | (P & C[WIDTH-1:0]),op};
	assign sum = (P & ~G) ^C[WIDTH-1:0];
	assign overflowFlag = (C[WIDTH-1] ^ C[WIDTH]) ;
	 
endmodule



