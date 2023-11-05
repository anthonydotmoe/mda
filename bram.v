module bram (
	input		[7:0]	raddr,
	output reg	[15:0]	rdata,
	input		[7:0]	waddr,
	input		[15:0]	wdata,
	input		wen, clk
);

parameter INIT_DATA="ram/dummy.hex";

reg [15:0] memory [0:255];
initial $readmemh(INIT_DATA, memory);

always @(posedge clk) rdata <= memory[raddr];
always @(posedge clk) if (wen) memory[waddr] <= wdata;

endmodule
