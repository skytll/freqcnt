module seqcheck(in, out, rst, clk, statout);
input in, rst, clk;
output out, statout;
wire [2:0] statout;
reg [5:0] state;
reg out;
always @(posedge clk or negedge rst) begin
	if (~rst) begin
		state <= 6'b000000;
		out <= 0;
	end
	else if (clk) begin
	out <= 0;
		if(state == 6'b000000) begin
			if(in == 0) state <= 6'b000000;
			else if(in == 1) state <= 6'b000001;
		end
		else if (state == 6'b000001) begin
			if(in == 0) state <= 6'b000010;
			else if(in == 1) state <= 6'b000001;
		end
		else if (state == 6'b000010) begin
			if(in == 0) state <= 6'b000000;
			else if(in == 1) state <= 6'b000101;
		end
		else if (state == 6'b000101) begin
			if(in == 0) state <= 6'b001010;
			else if(in == 1) state <= 6'b000001;
		end
		else if (state == 6'b001010) begin
			if(in == 0) state <= 6'b000000;
			else if(in == 1) state <= 6'b010101;
		end
		else if (state == 6'b010101) begin
			if(in == 0) state <= 6'b001010;
			else if(in == 1) begin
				state <= 6'b101011;
				out <= 1;
			end
		end
		else if (state == 6'b101011) begin
			if(in == 0) state <= 6'b000010;
			else if(in == 1) state <= 6'b000001;
		end
	end
end
stat s0(.din(state), .dout(statout));
endmodule

module stat(din, dout);
input [5:0] din;
output [2:0]dout;
assign dout = (din==6'b000000)?3'b000:
             (din==6'b000001)?3'b001:
             (din==6'b000010)?3'b010:
             (din==6'b000101)?3'b011:
             (din==6'b001010)?3'b100:
             (din==6'b010101)?3'b101:
             (din==6'b101011)?3'b111:3'b000;
endmodule