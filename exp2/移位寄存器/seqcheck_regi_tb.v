`timescale 1ns/1ns
module seqcheck_regi_tb;
reg rst,clk,in;
wire out;
wire [5:0] state;
seqcheck s1(.in(in), .out(out), .clk(clk), .rst(rst), .state(state));
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
always #10 clk <= ~clk;
endmodule