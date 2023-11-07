module pixel_ser (
	input			pixclk,
	input		[7:0]	char_line,	// 8-bit data representing the character row pixels left to right
	input		[3:0]	char_pixel,	// Current pixel position within the character
	input		[7:0]	char_code,	// Character code for special case
	output 		reg	pixel_out	// Output video signal
);

always @(pixclk) begin
	// Handle the condition for characters 0xC0 to 0xDF
	if (char_code >= 8'hC0 && char_code <= 8'hDF && char_pixel == 8) begin
		pixel_out <= char_line[7];
	end else if (char_pixel < 8) begin
		pixel_out <= char_line[char_pixel];
	end else begin
		pixel_out <= 0;
	end
end

// assign pixel_out = (char_pixel < 8) ? char_line[char_pixel] : 1'b0;

endmodule
