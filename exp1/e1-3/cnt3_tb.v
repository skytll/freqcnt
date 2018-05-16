`timescale 1ns/1ns
module single_clk_cnt;
reg clk;
reg rst;
wire [3:0] cnt;
counter cnt1(.clk(clk) , .rst(rst), .cnt(cnt));
initial
begin
	rst = 0;
	clk = 0;
	#130 rst = 1;
end
always #5 clk <= ~clk;

endmodule
