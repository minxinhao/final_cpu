`timescale 1ns / 1ps

module sel_bits_2_mux_tb();

reg [7:0] d0, d1, d2, d3;
reg [1:0] sel;
wire [7:0] out;

initial begin
	d0 = 8'b00000000;
	d1 = 8'b00110011;
	d2 = 8'b11001100;
	d3 = 8'b11111111;
	sel = 2'b00;
	forever #10 sel = sel + 2'b01;
end

sel_bits_2_mux #(.DATA_BITS(8)) my_tb(
	.d0(d0),
	.d1(d1),
	.d2(d2),
	.d3(d3),
	.sel(sel),
	.out(out));

endmodule