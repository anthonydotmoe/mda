module videogen (
	input rst,
	input pixclk,
	output hs,
	output vs,
	output wire [9:0] xpix,
	output wire [8:0] ypix,
	output enable
);

parameter HA_END = 719;
parameter HS_STA = HA_END + 9;
parameter HS_END = HS_STA + 135;
parameter LINE   = 881;

parameter VA_END = 349;
parameter VS_STA = VA_END + 2;
parameter VS_END = VS_STA + 16;
parameter SCREEN = 368;

reg [9:0] hcounter = 0;
reg [9:0] vcounter = 0;

parameter H_ACTIVE = 2'b00;
parameter H_BLANK1 = 2'b01;
parameter H_SYNC   = 2'b10;
parameter H_BLANK2 = 2'b11;

reg [1:0] h_state, h_next_state;

parameter V_ACTIVE = 2'b00;
parameter V_BLANK1 = 2'b01;
parameter V_SYNC   = 2'b10;
parameter V_BLANK2 = 2'b11;

reg [1:0] v_state, v_next_state;

/*

initial begin
	hs <= 0;
	vs <= 1;
end

always @(posedge rst) begin
	if(rst) begin
		hs	 <= 0;
		vs	 <= 1;
		hcounter <= 0;
		vcounter <= 0;
	end
end

always @(posedge pixclk)
	if(hcounter == LINE)
		hcounter <= 0;
	else
		hcounter <= hcounter + 1;

always @(posedge pixclk)
	if(hcounter == LINE && vcounter == SCREEN)
		vcounter <= 0;
	else if(hcounter == LINE)
		vcounter <= vcounter + 1;

always @(posedge pixclk)
	if(hcounter == HS_STA)
		hs <= 1;
	else if(hcounter == HS_END)
		hs <= 0;

always @(posedge pixclk)
	if(vcounter == VS_STA)
		vs <= 0;
	else if(vcounter == VS_END)
		vs <= 1;

assign enable = (hcounter <= HA_END && vcounter <= VA_END);
assign xpix = (hcounter <= HA_END) ? hcounter : HA_END;
assign ypix = (vcounter <= VA_END) ? vcounter[8:0] : VA_END;
	
*/

assign enable = (hcounter <= HA_END && vcounter <= VA_END);
assign xpix = (hcounter <= HA_END) ? hcounter : HA_END;
assign ypix = (vcounter <= VA_END) ? vcounter[8:0] : VA_END;

always @(posedge pixclk or posedge rst) begin
	if (rst) begin
		hcounter <= 0;
		vcounter <= 0;
	end else begin
		if (hcounter == LINE)
			hcounter <= 0;
		else
			hcounter <= hcounter + 1;

		if (hcounter == LINE) begin
			if (vcounter == SCREEN)
				vcounter <= 0;
			else
				vcounter <= vcounter + 1;
		end
	end
end


always @(posedge pixclk or posedge rst) begin
	if (rst)
		h_state <= H_ACTIVE;
	else
		h_state <= h_next_state;
end

always @(*) begin
	case (h_state)
		H_ACTIVE:
			if (hcounter == HA_END)
				h_next_state = H_BLANK1;
			else
				h_next_state = h_state;
		H_BLANK1: 
			if (hcounter == HS_STA) 
				h_next_state = H_SYNC;
			else
				h_next_state = h_state;
		
		H_SYNC: 
			if (hcounter == HS_END) 
				h_next_state = H_BLANK2;
			else
				h_next_state = h_state;
		
		H_BLANK2: 
			if (hcounter == LINE)
				h_next_state = H_ACTIVE;
			else
				h_next_state = h_state;
	endcase
end

always @(posedge pixclk or posedge rst) begin
	if (rst)
		v_state <= V_ACTIVE;
	else
		v_state <= v_next_state;
end

always @(*) begin
	case (v_state)
		V_ACTIVE:
			if (vcounter == VA_END)
				v_next_state = V_BLANK1;
			else
				v_next_state = v_state;
		V_BLANK1: 
			if (vcounter == VS_STA) 
				v_next_state = V_SYNC;
			else
				v_next_state = v_state;
		
		V_SYNC: 
			if (vcounter == VS_END) 
				v_next_state = V_BLANK2;
			else
				v_next_state = v_state;
		
		V_BLANK2: 
			if (vcounter == SCREEN)
				v_next_state = V_ACTIVE;
			else
				v_next_state = v_state;
	endcase
end

assign hs = (h_state == H_SYNC) ? 1'b1 : 1'b0;
assign vs = (v_state == V_SYNC) ? 1'b0 : 1'b1;	// Watch out! VSYNC is active high

endmodule
