`timescale 1ns/1ns
module freqcnt_tb;
reg sysclk, rst, range;
reg [1:0] testmode;
wire rangedisp;
wire [3:0] freq0, freq1, freq2, freq3;
freqcnt f0(
	.sysclk(sysclk), .rst(rst), .range(range),
	.testmode(testmode), 
	.freq0(freq0), .freq1(freq1), .freq2(freq2), .freq3(freq3),
	.rangedisp(rangedisp)
	);
initial begin
sysclk = 0;
rst = 0;
range = 1;
testmode = 2'b11;//12500Hz
#130 rst = 1;
end
always #10 sysclk <= ~sysclk;
endmodule