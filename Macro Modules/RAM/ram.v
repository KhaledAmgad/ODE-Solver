module RAM
#(parameter N = 16, M = 6000, K = 13) // generic paramter
(input WE, Clk, //write enable , clock
input[K-1:0]addressPortOne,
input[K-1:0]addressPortTwo,
input[K-1:0]addressWritePort,
output[N-1:0]readPortOneData,
output[N-1:0]readPortTwoData,
input [N-1:0]writePortData);
reg [N-1:0]RAM[0:M-1];

//posedge +ve edge , negegde -ve egde
always @(posedge Clk)
  if(WE) begin
    RAM[addressWritePort] = writePortData;
  end
  
assign readPortOneData = RAM[addressPortOne];
assign readPortTwoData = RAM[addressPortTwo];
endmodule