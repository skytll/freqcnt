module cnt_dec2(clk,rst,LED0);
input clk;
input rst;
output [6:0] LED0;
wire [3:0] cnt;
counter U1(.clk_in(clk),.rst(rst),.cnt(cnt));
BCD7 B(.din(cnt),.dout(LED0));
endmodule

module counter(clk_in,rst,cnt);
input clk_in,rst;
output [3:0] cnt;
wire [3:0] cnt;
Dfff dff1(.clk(clk_in),.rst(rst),.q(cnt[0]));
Dfff dff2(.clk(~cnt[0]),.rst(rst),.q(cnt[1]));
Dfff dff3(.clk(~cnt[1]),.rst(rst),.q(cnt[2]));
Dfff dff4(.clk(~cnt[2]),.rst(rst),.q(cnt[3]));
endmodule

module Dfff(clk,rst,q);
input clk,rst;
output q;
reg q;
always @(negedge rst or posedge clk)
begin
	if(~rst)
		q <= 0;
	else begin
		q <= ~q;
	end
end
endmodule

module BCD7(
    din,
    dout
);
input   [3:0]   din;
output  [6:0]   dout;

assign  dout=(din==4'h0)?7'b1000000:
             (din==4'h1)?7'b1111001:
             (din==4'h2)?7'b0100100:
             (din==4'h3)?7'b0110000:
             (din==4'h4)?7'b0011001:
             (din==4'h5)?7'b0010010:
             (din==4'h6)?7'b0000010:
             (din==4'h7)?7'b1111000:
             (din==4'h8)?7'b0000000:
             (din==4'h9)?7'b0010000:
             (din==4'hA)?7'b0001000:
             (din==4'hB)?7'b0000011:
             (din==4'hC)?7'b1000110:
             (din==4'hD)?7'b0100001:
             (din==4'hE)?7'b0000110:
             (din==4'hF)?7'b0001110:7'b0;
endmodule