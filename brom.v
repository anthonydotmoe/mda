/* -----------------------------------------------------------------------------
*
* The iCE40 UP5k has 30 4k EBRs.
*
* We are aiming to produce an MDA screen. (720x350 pixels, 80x25 characters)
*
* Each character is 9x14 pixels.
*
* Code Page 437
*
* Character font is 8 pixels wide, for box drawing characters (0xC0~0xDF) the
* ninth pixel column will be a duplicate of the eighth.
*
* The character ROM stores characters in 13 Block RAMs:
* 	- The first row of the character is stored in one EBR, followed by the
* 	next row in the next EBR, etc.
*
* Each character will be in
*/

module brom (
	input clk,
	input	[8:0]	raddr,
	output	reg [7:0]	rdata
	//input	[8:0]	waddr,
	//input	[7:0]	wdata,
	//input wen, clk
);

parameter INIT_DATA = "rom/dummy.hex";

reg [7:0] memory [0:511];
initial $readmemb(INIT_DATA, memory);

always @(posedge clk) rdata <= memory[raddr];
// always @(posedge clk) if (wen) memory[waddr] <= wdata;

endmodule
