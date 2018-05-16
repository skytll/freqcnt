`timescale 1ns/1ns
module seqcheck_tb;
reg in, rst, clk;
wire out;
wire [2:0] statout;
seqcheck s1(.in(in), .out(out), .rst(rst), .clk(clk), .statout(statout));
initial begin
	clk = 0;
	rst = 0;
	in = 0;
	#100 rst = 1;
	#5 in = 0;
	#20 in = 0;
	#20 in = 1;
	#20 in = 0;
	#20 in = 1;
	#20 in = 0;
	#20 in = 1;
	#20 in = 1;
	#20 in = 0;
	#20 in = 1;
	#20 in = 0;
	#20 in = 1;
	#20 in = 1;
	#20 in = 1;
	#20 in = 0;
	#20 in = 0;
	#20 in = 0;
	#20 in = 1;
	#20 in = 0;
	#20 in = 1;
	#20 in = 0;
	#20 in = 1;
	#20 in = 1;
	#20 in = 0;
	#20 in = 0;
end
endmodule
