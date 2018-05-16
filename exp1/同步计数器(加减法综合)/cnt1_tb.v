`timescale 1ns/1ns
module single_clk_cnt;
reg clk;
reg rst;
reg ud;
wire [6:0] led0;
cnt_dec1 cnt1(.clk(clk) , .rst(rst), .LED0(led0), .ud(ud));

initial
begin
	rst = 0;
	clk = 0;
	ud = 1;
	#130 rst = 1;
end
always #10 clk <= ~clk;
endmodule
