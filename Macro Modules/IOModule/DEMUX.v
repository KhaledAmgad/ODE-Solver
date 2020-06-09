module DEMUX(input [31:0] In1, input Sel,output reg[31:0] out0,output reg[31:0] out1);

always@(*)
begin
   case(Sel)
   0: begin
         out1 = In1;
         //out2 = 0; // to be fixed
      end
   1: begin
         //out1 = 0; // to be fixed
         out0 = In1;
      end
endcase
end
endmodule