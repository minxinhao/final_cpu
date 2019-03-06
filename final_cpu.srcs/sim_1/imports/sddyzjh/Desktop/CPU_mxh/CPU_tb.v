`timescale 1ns / 1ps

/*
module CPU (input clk,
			input rst,
            input Go,
			input [3:0]led_in,
			input clkswitch,
			input [6:0]dispmode,
			output [7:0]cpu_sel,
			output [7:0]cpu_seg
    );
*/


module CPU_tb();


reg clk ,rst, clkswitch;
reg[3:0] led_in ;
reg[6:0] dispmode ;
wire [7:0]cpu_sel;
wire [7:0]cpu_seg;

CPU CPU_test(clk , rst , 0, led_in ,  clkswitch  , dispmode , cpu_sel ,cpu_seg);


initial 
    begin
        clk <= 0;
        rst <= 0;
        clkswitch <= 0;
        led_in <= 3'b0;
        dispmode <= 7'b0;
    end

always 
begin
	#1 clk = ~clk ;
end
  
endmodule
