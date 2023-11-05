module chrrom (
	input clk,
	input	[7:0]	code,	// Character code
	input	[3:0]	row,	// Row of character
	output	reg [7:0]	data
);

always @(posedge clk) begin
	case(row)
		4'd00:	data <= fontrow0;
		4'd01:	data <= fontrow1;
		4'd02:	data <= fontrow2;
		4'd03:	data <= fontrow3;
		4'd04:	data <= fontrow4;
		4'd05:	data <= fontrow5;
		4'd06:	data <= fontrow6;
		4'd07:	data <= fontrow7;
		4'd08:	data <= fontrow8;
		4'd09:	data <= fontrow9;
		4'd10:	data <= fontrow10;
		4'd11:	data <= fontrow11;
		4'd12:	data <= fontrow12;
		4'd13:	data <= fontrow13;
		default: data <= 8'd0;
	endcase
end

wire [7:0] fontrow0, fontrow1, fontrow2, fontrow3, fontrow4, fontrow5, fontrow6, fontrow7, fontrow8, fontrow9, fontrow10, fontrow11, fontrow12, fontrow13;

brom #(.INIT_DATA("rom/rom0.bin")) chrrom0(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow0)
);

brom #(.INIT_DATA("rom/rom1.bin")) chrrom1(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow1)
);

brom #(.INIT_DATA("rom/rom2.bin")) chrrom2(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow2)
);

brom #(.INIT_DATA("rom/rom3.bin")) chrrom3(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow3)
);

brom #(.INIT_DATA("rom/rom4.bin")) chrrom4(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow4)
);

brom #(.INIT_DATA("rom/rom5.bin")) chrrom5(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow5)
);

brom #(.INIT_DATA("rom/rom6.bin")) chrrom6(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow6)
);

brom #(.INIT_DATA("rom/rom7.bin")) chrrom7(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow7)
);

brom #(.INIT_DATA("rom/rom8.bin")) chrrom8(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow8)
);

brom #(.INIT_DATA("rom/rom9.bin")) chrrom9(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow9)
);

brom #(.INIT_DATA("rom/rom10.bin")) chrrom10(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow10)
);

brom #(.INIT_DATA("rom/rom11.bin")) chrrom11(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow11)
);

brom #(.INIT_DATA("rom/rom12.bin")) chrrom12(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow12)
);

brom #(.INIT_DATA("rom/rom13.bin")) chrrom13(
	.clk(clk),
	.raddr({1'b0, code}),
	.rdata(fontrow13)
);

endmodule
