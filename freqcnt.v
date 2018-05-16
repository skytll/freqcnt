module freqcnt(sysclk, rst, range, testmode, freq0, freq1, freq2, freq3, rangedisp);
input sysclk, rst, range;
input [1:0] testmode;
output [3:0] freq0, freq1, freq2, freq3;
output rangedisp;
wire [3:0] freq0, freq1, freq2, freq3;
wire sigctr, rawsigin, sigin;
signalinput sin (
	.sysclk(sysclk), 
	.resetb(rst), 
	.testmode(testmode), 
	.sigin(rawsigin)
	);

rangechoose chooser(.range(range), .rawsigin(rawsigin), .sigin(sigin), .rst(rst));

sigcontrol control(.sysclk(sysclk), .rst(rst), .sigctr(sigctr));

wire enable, lock;
sig_en e(.clk(sigctr), .enable(enable), .lock(lock), .rst(rst));

wire [20:0] times, lockedtimes;
counter cnt0(
	.sigin(sigin), 
	.times(times), 
	.rst(rst), 
	.enable(enable)
	);

locker lock0(.din(times), .dout(lockedtimes), .rst(rst), .lock(lock));

wire dispLED;
freqdisp disp0(
	.din(lockedtimes), 
	.freq0(freq0), .freq1(freq1), .freq2(freq2), .freq3(freq3),
	.range(range),
	.rangedisp(dispLED)
	);


endmodule

module sig_en(clk, enable, lock, rst);
input clk, rst;
output enable, lock;
reg enable, zero;
always @(posedge clk or negedge rst) begin
	if (~rst) begin
		enable <= 0;
	end
	else begin
		enable <= ~enable;
	end
end
assign lock = ~enable;
endmodule

module counter(sigin, times, rst, enable);
input sigin, rst, enable;
output [20:0] times;
reg [20:0] times; 
always @(posedge sigin or negedge rst or enable) begin
	if (~rst) begin
		times <= 0;
	end
	else if(enable && sigin) begin
		times <= times + 1;
	end
	else if(!enable) begin
		times <= 0;
	end
end
endmodule

module locker(din, dout, lock, rst);
input lock, rst;
input [20:0] din;
output [20:0] dout;
reg [20:0] dout;
always @(*) begin
	if (~rst) begin
		dout <= 21'd0;
	end
	else begin
		if(!lock) dout <= din;
	end
end
endmodule

module freqdisp(din, freq0, freq1, freq2, freq3, range, rangedisp);
input [20:0] din;
input range;
output [3:0] freq0, freq1, freq2, freq3;
output rangedisp;
reg [3:0] num0, num1, num2, num3;
always @(*) begin
	num3 = din / 1000;
	num2 = (din - num3 * 1000) / 100;
	num1 = (din - num3 * 1000 - num2 * 100) / 10;
	num0 = (din - num3 * 1000 - num2 * 100 - num1 * 10);
end
BCD7 B0(num0, freq0);
BCD7 B1(num1, freq1);
BCD7 B2(num2, freq2);
BCD7 B3(num3, freq3);
assign rangedisp = range;
endmodule


module rangechoose(range, rawsigin, sigin, rst);
input range, rawsigin, rst;
output sigin;
reg sigin;
reg [3:0] cnt;
always @(*) begin
	if(range == 0) sigin <= rawsigin;
end
always @(posedge rawsigin or negedge rst or range) begin
	if (~rst) begin
		cnt <= 4'd0;
		sigin <= 0;
	end
	else begin
		if(range == 1) begin
			if(cnt == 4'd5) begin
				cnt <= 4'd1;
				sigin <= ~sigin;
			end
			else cnt <= cnt + 4'd1;
		end
	end
end
endmodule



//struct 1Hz signal
module sigcontrol(sigctr, sysclk, rst);
input sysclk,rst;
output sigctr;
reg sigctr;
reg [31:0] cntctr;
always @(posedge sysclk or negedge rst) begin
	if (~rst) begin
		cntctr <= 21'd0;
		sigctr <= 0;
	end
	else begin
		if (cntctr == 32'd25000000) begin
			cntctr <= 32'd1;
			sigctr <= ~sigctr;
		end
		else cntctr <= cntctr + 32'd1;	//count++
	end
end
endmodule

/*
sysclk : 50MHz 系统时钟
resetb : 低电平有效异步复位信号
testmode : 00,01,10,11 分别代表 3125,6250,50,12500Hz,使用 SW1~SW0 来控制 sigin : 待测时钟输出,频率由 testmode 选择
*/
module signalinput( 
	sysclk,
	resetb, 
	testmode, 
	sigin
);

input		sysclk;
input		resetb;
input [1:0]	testmode;
output		sigin;

reg  [20:0] divide;
always @(*) 
begin
	case(testmode)
		2'b00 : divide=21'd16000;//3125Hz
		2'b01 : divide=21'd8000; //6250Hz
		2'b10 : divide=21'd1000000; //50Hz
		2'b11 : divide=21'd4000;//12500Hz
	endcase 
end

reg 		sigin;
reg [20:0]	state;
always @(posedge sysclk or negedge resetb) 
begin
	if(~resetb) begin 
		sigin <= 1'b0;
		state <= 21'd0; 
	end
	else begin
	if(state==divide - 2)
		state <= 21'd0;
	else
		state <= state + 21'd2;
	if(state==21'd0) 
		sigin <= ~sigin;
	end 
end
endmodule

module BCD7(din,dout);
input [3:0] din;
output [6:0] dout;

assign  dout=(din==4'h0)?7'b1000000:
             (din==4'h1)?7'b1111001:
             (din==4'h2)?7'b0100100:
             (din==4'h3)?7'b0110000:
             (din==4'h4)?7'b0011001:
             (din==4'h5)?7'b0010010:
             (din==4'h6)?7'b0000010:
             (din==4'h7)?7'b1111000:
             (din==4'h8)?7'b0000000:
             (din==4'h9)?7'b0010000:7'b0;
endmodule

