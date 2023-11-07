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

// Bodge wire
wire add_one;

wire [6:0] col;
wire [4:0] row;
wire [7:0] char_code;
wire [7:0] char_line;
wire [3:0] char_pixel; // Counts 0-8 for each character
wire [3:0] char_row;   // Counts 0-13 for each character
mda_pos mda_pos_inst(		// Gives character position for X/Y pixel coordinate (720x350 -> 80x25)
	.clk(pixclk),
	.rst(rst),
	.enable(enable),
	.add_one(add_one),
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
chrram chrram_inst(
	.clk(pixclk),
	.col(col),
	.row(row),
	.add_one(add_one),
	.r_code(char_code),
	.r_attr(attr)
);


// Implement intensity
wire inten = attr[3];

// Implement blinking

wire char_blink = char_blink_c[2];
reg [2:0] char_blink_c;
always @(posedge vsync or posedge rst) begin
	if (rst)
		char_blink_c <= 0;
	else
		char_blink_c <= char_blink_c + 1;
end

// Implement underline

wire underline = ( (char_row == 4'd13) && (attr[2:0] == 3'b001) );

assign video = (attr[7] == 1'b1) ? enable & ( char_blink & (vidsig || underline) ) : enable & (vidsig || underline);

endmodule
