module Comparator(
input [16-1:0]A,
input [16-1:0]B,
output [16-1:0]C,
output overflowFlag,
output GE // greater than or equal
);

FixedPoint_AdderSub_CarryLookAhead#(.WIDTH(16)) substractorCircuit(
  .a(A),
  .b(B),
  .op("1"),
  .sum(C),
  .overflowFlag(overflowFlag)
);

assign GE = C[15];
endmodule
