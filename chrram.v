module chrram (
	input		clk,
//	input		wen,

	input	[6:0]	col,
	input	[4:0]	row,
	output	[7:0]	r_code,
	output	[7:0]	r_attr

//	input	[7:0]	w_code,
//	input	[7:0]	w_attr
);

wire	[10:0]	full_addr = 80*row + col;
wire	[2:0]	ram_sel   = full_addr[10:8];
wire	[7:0]	ram_raddr = full_addr[7:0];

reg	[15:0]	data;
wire	[7:0]	r_code = data[15:8];
wire	[7:0]	r_attr = data[7:0];

wire [15:0]	ram_data0,
		ram_data1,
		ram_data2,
		ram_data3,
		ram_data4,
		ram_data5,
		ram_data6,
		ram_data7;

always @(posedge clk) begin
	case(ram_sel)
		3'd0: data <= ram_data0;
		3'd1: data <= ram_data1;
		3'd2: data <= ram_data2;
		3'd3: data <= ram_data3;
		3'd4: data <= ram_data4;
		3'd5: data <= ram_data5;
		3'd6: data <= ram_data6;
		3'd7: data <= ram_data7;
	endcase
end

bram #(.INIT_DATA("ram/ram0.hex")) chrram0(
	.raddr(ram_raddr),
	.rdata(ram_data0),
	.waddr(8'd0),
	.wdata(16'd0),
	.wen(1'b0),
	.clk(clk)
);

// Repeat for the next seven BRAMs

bram #(.INIT_DATA("ram/ram1.hex")) chrram1(
	.raddr(ram_raddr),
	.rdata(ram_data1),
	.waddr(8'd0),
	.wdata(16'd0),
	.wen(1'b0),
	.clk(clk)
);

bram #(.INIT_DATA("ram/ram2.hex")) chrram2(
	.raddr(ram_raddr),
	.rdata(ram_data2),
	.waddr(8'd0),
	.wdata(16'd0),
	.wen(1'b0),
	.clk(clk)
);

bram #(.INIT_DATA("ram/ram3.hex")) chrram3(
	.raddr(ram_raddr),
	.rdata(ram_data3),
	.waddr(8'd0),
	.wdata(16'd0),
	.wen(1'b0),
	.clk(clk)
);

bram #(.INIT_DATA("ram/ram4.hex")) chrram4(
	.raddr(ram_raddr),
	.rdata(ram_data4),
	.waddr(8'd0),
	.wdata(16'd0),
	.wen(1'b0),
	.clk(clk)
);

bram #(.INIT_DATA("ram/ram5.hex")) chrram5(
	.raddr(ram_raddr),
	.rdata(ram_data5),
	.waddr(8'd0),
	.wdata(16'd0),
	.wen(1'b0),
	.clk(clk)
);

bram #(.INIT_DATA("ram/ram6.hex")) chrram6(
	.raddr(ram_raddr),
	.rdata(ram_data6),
	.waddr(8'd0),
	.wdata(16'd0),
	.wen(1'b0),
	.clk(clk)
);

bram #(.INIT_DATA("ram/ram7.hex")) chrram7(
	.raddr(ram_raddr),
	.rdata(ram_data7),
	.waddr(8'd0),
	.wdata(16'd0),
	.wen(1'b0),
	.clk(clk)
);

endmodule
