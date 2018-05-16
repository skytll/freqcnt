`timescale 1ns/1ns
module seqcheck(in, out, clk, rst, state);
input in, clk, rst;
output out;
output state;
reg out;
wire [5:0] state;
dtricker D0(.d(in), .q(state[0]), .rst(rst), .clk(clk));
dtricker D1(.d(state[0]), .q(state[1]), .rst(rst), .clk(clk));
dtricker D2(.d(state[1]), .q(state[2]), .rst(rst), .clk(clk));
dtricker D3(.d(state[2]), .q(state[3]), .rst(rst), .clk(clk));
dtricker D4(.d(state[3]), .q(state[4]), .rst(rst), .clk(clk));
dtricker D5(.d(state[4]), .q(state[5]), .rst(rst), .clk(clk));
always @(posedge clk or negedge rst) begin
	if (~rst) begin
		out <= 0;
	end
	else if (clk) begin
		out <= 0;
		if(((state == 6'b010101) || (state == 6'b110101))
		 && (in == 1)) out <= 1;
	end
end
endmodule

module dtricker(d, q, rst, clk);
input d, rst, clk;
output q;
reg q;
always @(posedge clk or negedge rst) begin
	if (~rst) begin
		q <= 0;
	end
	else if (clk) begin
		#0 q <= d;
	end
end
endmodule