`timescale 1ns/1ns
module freqcnt_tb;
reg sysclk, rst, range;
reg [1:0] testmode;
wire rangedisp;
wire [3:0] freq0, freq1, freq2, freq3;
initial begin
sysclk = 0;
rst = 0;
range = 0;
testmode = 2'b10
#130 rst = 1;
end
always #20 sysclk <= ~sysclk;