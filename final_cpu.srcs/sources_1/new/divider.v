`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/06 00:09:03
// Design Name: 
// Module Name: divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module clk_divider(
    input clk,
    input [1:0]rate,
    output reg clk_N
    );
    wire clk1,clk2,clk3,clk4;
    always@(*)begin
        case(rate)
        0:clk_N = clk1;
        1:clk_N = clk2;
        2:clk_N = clk3;
        3:clk_N = clk4;
        endcase
    end
    divider #(1_562_500)rate3(clk,clk1);//64hz
    divider #(3_125_000) rate1(clk,clk2);//32hz
    divider #(6_250_000) rate2(clk,clk3);//16hz
    divider #(12_500_000)rate4(clk,clk4);//8hz
    
endmodule


module divider(clk,clk_N);
    input clk;// clock in digilent
    output reg clk_N;// clock after divide
    parameter N = 6_250_000;// 16Hz clock?,N=fclk/fclk_N
    reg[31:0] counter = 0; /* 计数器变量，通过计数实现分频。
                                      当计数器从0计数到(N/2-1)时，
                                      输出时钟翻转，计数器清零 */

    
    always@(posedge clk)
    begin
        if(counter == N/2-1)
            begin
                clk_N <= !clk_N;
                counter <= 0;
            end
         else
            counter  = counter + 1;
      end
        
endmodule
