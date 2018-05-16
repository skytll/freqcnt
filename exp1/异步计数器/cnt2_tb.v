`timescale 1ns/1ns
module counter_tb;
reg clk_in;
reg rst;
wire [6:0] LED0;
cnt_dec2 cnt1(.clk(clk_in), .rst(rst), .LED0(LED0));
initial
begin
	rst = 0;
	clk_in = 0;
	#130 rst = 1;
end
always #10 clk_in <= ~clk_in;
endmodule
