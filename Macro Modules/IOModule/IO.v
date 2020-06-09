module IOBlock // rst is considered a request from cpu and wrld is from coordinator
(input clk,rst,input [1:0] WrLd,input new,input demuxSel,input [15:0] RAM_input,inout[31:0] CPUBus,output [31:0] Coordinator_Output,output[31:0] RAM_Output,output finished,output decompress_single_run_finished);
wire [31:0] down_counter_input,decompressor_input;
wire [31:0] down_counter_output;
wire [15:0] decompressor_output;
reg [31:0] CO,RO;
reg temp_CPU_out;
wire counter_zero_flag;
//up_counter upcounter(.out(demuxSel),.clk(clk),.reset(rst));
DEMUX input_selector(.In1(CPUBus),.Sel(demuxSel),.out0(down_counter_input),.out1(decompressor_input));
down_counter IOcounter(.d(down_counter_input),.clk(clk),.rst(rst),.load(demuxSel),.new(new),.qd(down_counter_output),.zero(counter_zero_flag));
decompos decompression_block(.rst(rst),.x(decompressor_input),.enable(WrLd),.new(new),.clk(clk),.out(decompressor_output),.finished(decompress_single_run_finished));
//DEMUX output_selector(.In1(decompressor_output),.Sel(demuxSel[1]),.out0(Coordinator_Output),.out1(RAM_Output));
always @ (posedge clk)
begin
  if (rst)
  CO = 0;
  RO = 0;
  if (WrLd == 2'b01)
  temp_CPU_out = RAM_input;
end
assign finished = counter_zero_flag;
assign CPUBus = temp_CPU_out;
assign Coordinator_Output = CO;
assign RAM_Output = RO;
// coordinator needs to count 7 clock cycles after recieving finished signal from IO before sending enable signals to ODE blocks
endmodule

