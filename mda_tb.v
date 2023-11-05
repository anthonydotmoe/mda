`timescale 1ns/1ps

module mda_tb();

reg clk, rst;
wire video, hsync, vsync;

mda_top mda(
	.clk(clk),
	.rst(rst),
	.video(video),
	.hsync(hsync),
	.vsync(vsync)
);

initial begin
	clk = 1'b0;
	forever begin
		#30.844 clk = ~clk;
	end
end

initial begin
	$dumpfile("mda_tb.vcd");
	$dumpvars(0, mda_tb);

	rst = 1'b1;

	#1000;
	rst = 1'b0;

	#40000000;

	$finish;
end


endmodule
