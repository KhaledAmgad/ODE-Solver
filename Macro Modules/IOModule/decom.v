module decompos(rst,x,enable,new,clk,out,finished);
  input clk;
  input [1:0] enable;
  input new;
  input [31:0] x;
  output reg[15:0] out;
  output finished;
  input rst;
  reg [4:0] check;
  reg [31:0]temp;
  reg[4:0]y;
  wire[4:0]z;
  wire overflowadder;
  assign finished = overflowadder;
  FixedPoint_AdderSub_CarrySelect  #(5) adder(check,y,0,z,overflowadder);
  always @ (posedge clk)
  begin
  check = z;
  if(rst)
    begin 
      check=5'b00000;
      y=4'b0000;
    end
  else
    begin
  if (enable == 2'b10)
  begin
  if(new==1'b1)
    begin 
      temp=x;
    end
  else
    begin
      temp=temp<<4;
    end
    
  case(temp[31:29])
  3'b000: begin  y=1; out = (out << 1); if(temp[28]) begin out = out | 1'b1; end end 
  3'b001: begin  y=2; out = (out << 2); if(temp[28]) begin out = out | 2'b11; end end 
  3'b010: begin  y=3; out = (out << 3); if(temp[28]) begin out = out | 3'b111; end end 
  3'b011: begin  y=4; out = (out << 4); if(temp[28]) begin out = out | 4'b1111; end end 
  3'b100: begin  y=5; out = (out << 5); if(temp[28]) begin out = out | 5'b11111; end end 
  3'b101: begin  y=6; out = (out << 6); if(temp[28]) begin out = out | 6'b111111; end end 
  3'b110: begin  y=7; out = (out << 7); if(temp[28]) begin out = out | 7'b1111111; end end 
  3'b111: begin  y=8; out = (out << 8); if(temp[28]) begin out = out | 8'b11111111; end end 
  endcase
  if(z[4]==1'b1)begin
    check=5'b00000;
  end
  end
  end
  end  
endmodule

