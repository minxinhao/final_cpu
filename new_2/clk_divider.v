`timescale 1ns / 1ps

module clk_divider(
    input clk,rate,
    output reg clk_N
    );
    wire clk_l,clk_h;
    always@(*)begin
        case(rate)
        0:clk_N=clk_l;
        1:clk_N=clk_h;
        endcase
    end
    divider #(100_000_0) lowrate(clk,clk_l);
    divider #(20) highrate(clk,clk_h);
endmodule
