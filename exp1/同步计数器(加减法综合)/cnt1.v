module cnt_dec1(clk,rst,LED0,ud);
input clk,rst,ud;
output [6:0] LED0;
wire[3:0] cnt;
counter U1(.clk(clk),.cnt(cnt),.rst(rst),.ud(ud));
BCD7 B(.din(cnt),.dout(LED0));
endmodule

module counter(clk,cnt,rst,ud);
input clk,rst,ud;
output [3:0] cnt;
reg[3:0] cnt;

always @(posedge clk or negedge rst) begin
  if(~rst)
    cnt <= 4'b0000;
  else begin
	 if (ud) begin
		 if(cnt == 4'b1111) cnt <= 4'b0000;
		 else cnt <= cnt + 1;
	 end
	 else begin
	   if(cnt == 4'b0000) cnt <= 4'b1111;
	   else cnt <= cnt - 1;
	 end
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
             (din==4'h9)?7'b0010000:
             (din==4'hA)?7'b0001000:
             (din==4'hB)?7'b0000011:
             (din==4'hC)?7'b1000110:
             (din==4'hD)?7'b0100001:
             (din==4'hE)?7'b0000110:
             (din==4'hF)?7'b0001110:7'b0;
endmodule