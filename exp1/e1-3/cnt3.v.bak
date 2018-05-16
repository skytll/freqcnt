module counter(clk,cnt,rst);
input clk,rst;
output [3:0] cnt;
reg [3:0] cnt;

always @(posedge clk or negedge rst) begin
	if (~rst) begin
		cnt <= 4'b1111;
	end
	else begin
		if(cnt == 4'b0000) cnt<=4'b1111;
		else cnt <= cnt - 1;
	end
end
endmodule
