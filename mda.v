module mda_top(
	input clk,
	input rst,
	output inten, video, hsync, vsync
);

wire pixclk;

pixclk_gen pixclk_gen_inst(
	.rst(rst),
	.clk(clk),
	.pixclk(pixclk)
);

/*
wire enable_delayed;

delay #(.NUM(6)) enable_delay(
	.clk(pixclk),
	.rst(rst),
	.in(enable),
	.out(enable_delayed)
);
*/

wire enable;
wire [9:0] x;
wire [8:0] y;
videogen videogen_inst(
	.rst(rst),
	.pixclk(pixclk),
	.hs(hsync),
	.vs(vsync),
	.xpix(x),
	.ypix(y),
	.enable(enable)
);

wire [6:0] col;
wire [4:0] row;
wire [7:0] char_code;
wire [7:0] char_line;
wire [3:0] char_pixel; // Counts 0-8 for each character
wire [3:0] char_row;   // Counts 0-13 for each character
mda_pos mda_pos_inst(		// Gives character position for X/Y pixel coordinate (720x350 -> 80x25)
	.clk(pixclk),
	.rst(rst),
	//.enable(enable_delayed),
	.enable(enable),
	.col(col),
	.row(row),
	.char_pixel(char_pixel),
	.char_row(char_row)
);

wire vidsig;
pixel_ser pixel_ser_inst(
	.pixclk(pixclk),
	.char_line(char_line),
	.char_pixel(char_pixel),
	.char_code(char_code),
	.pixel_out(vidsig)
);

chrrom chrrom_inst(
	.clk(pixclk),
	.code(char_code),
	.row(char_row),
	.data(char_line)
);

wire [7:0] attr;

assign inten = attr[3];

chrram chrram_inst(
	.clk(pixclk),
	.col(col),
	.row(row),
	.r_code(char_code),
	.r_attr(attr)
);

assign video = vidsig & enable;


endmodule

// -----------------------------------------------------------------------------

module delay(
	input clk,
	input rst,
	input in,
	output out
);

parameter NUM = 4;

reg [NUM-1:0] shift;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		shift <= 0;
	end else begin
		shift <= { shift[NUM-2:0], in };
	end
end

assign out = shift[NUM-1];

endmodule
