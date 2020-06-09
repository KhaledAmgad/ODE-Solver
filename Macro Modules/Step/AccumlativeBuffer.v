module AccBuff
(
input Clk,reset,enable,
input [16-1:0] inputData,inputData2,
input op,
output [16-1:0] outputData,
output overflowFlag
);
reg [16-1:0]Data,Data2;
//wire [16-1:0]Sum;
wire [16-1:0]Sum;
assign inputData2 = Data;


FixedPoint_AdderSub_CarryLookAhead#(.WIDTH(16)) adderCircuit(
  .a(inputData),
  .b(inputData2),
  .op("0"),
  .sum(Sum),
  .overflowFlag(overflowFlag)
);


always @(posedge Clk) begin
  if(reset) begin
    Data = 0;
  end
  else if(enable) begin
    Data = Sum;
  end
end
assign outputData = Data;
endmodule
