module pixclk_gen(
	input wire	clk,
	input		rst,
	output		pixclk,
	output		locked
);

`ifdef SYNTHESIS
wire rstb = ~rst;

SB_PLL40_CORE #(
	.FEEDBACK_PATH("SIMPLE"),
	.DIVR(4'b0000),		// DIVR =  0
	.DIVF(7'b1010110),	// DIVF = 86
	.DIVQ(3'b110),		// DIVQ =  6
	.FILTER_RANGE(3'b001)	// FILTER_RANGE = 1
) pll (
	.LOCK(locked),
	.RESETB(rstb),
	.BYPASS(1'b0),
	.REFERENCECLK(clk),
	.PLLOUTCORE(pixclk)
);
`endif

`ifndef SYNTHESIS
	assign pixclk = clk;
`endif

endmodule
