module mda_pos(
	input			clk,
	input			rst,
	input			enable,		// Valid during valid pixel periods
	output		[6:0]	col,		// Character column (0-79)
	output		[4:0]	row,		// Character row    (0-24)
	output		[3:0]	char_pixel,	// Output pixel position within the character
	output		[3:0]	char_row	// Character row to output (0-13)
);

parameter MAX_COL = 80-1;   // Maximum columns
parameter MAX_ROW = 25-1;   // Maximum rows
parameter MAX_CHAR_ROW = 14-1; // Maximum character rows
parameter CHAR_WIDTH = 9-1; // Width of the character in pixels

reg [6:0] col_counter = 0;
reg [4:0] row_counter = 0;
reg [3:0] char_row_counter = 0;
reg [3:0] char_pixel_counter = 0;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		char_pixel_counter <= 0;
		char_row_counter <= 0;
		col_counter <= 0;
		row_counter <= 0;
	end else if (enable) begin
		// Increment pixel within char
		if (char_pixel_counter < CHAR_WIDTH)
			char_pixel_counter <= char_pixel_counter + 1;
		else begin
			char_pixel_counter <= 0;

			// We wrapped around from 8 to 0. Check if we also hit
			// 80 columns
			if (col_counter < MAX_COL)
				col_counter <= col_counter + 1;
			else begin
				col_counter <= 0;

				// We wrapped around from 79 to 0. Check if we
				// also hit 14 lines
				if (char_row_counter < MAX_CHAR_ROW)
					char_row_counter <= char_row_counter + 1;
				else begin
					char_row_counter <= 0;

					// We wrapped around from 13 to 0.
					// Check if we also hit 25 rows
					if (row_counter < MAX_ROW)
						row_counter <= row_counter + 1;
					else
						row_counter <= 0;
				end
			end
		end
	end
end

assign col = col_counter;
assign row = row_counter;
assign char_row = char_row_counter;
assign char_pixel = char_pixel_counter;

endmodule
