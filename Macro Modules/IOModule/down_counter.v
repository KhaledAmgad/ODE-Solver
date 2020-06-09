module down_counter( d, clk, rst, load,new, qd,zero);
input   [31:0] d;
input   clk;
input   rst;
input   load;
input new;
inout  [31:0] qd;
output reg zero;
reg     [31:0] cnt;
wire [31:0] subcnt;
FixedPoint_AdderSub_CarrySelect #(32) subtractor(.a(cnt),.b(1),.op(1),.sum(subcnt));
always @ (posedge clk)
begin
if (rst)
  begin
        cnt <= 32'h00;
	zero <= 1'b0;
  end
else 
begin

    if (load)
        cnt <= d;
    else if (new)
        cnt <= subcnt;
   else
        cnt <= cnt;

   if (cnt == 32'd0)
      begin
      zero = 1'b1;
      end
   else
      begin
      zero = 1'b0;
      end
       
end 
end 
assign qd = cnt;
endmodule