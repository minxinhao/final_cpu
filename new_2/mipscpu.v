`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
module mipscpu24(
    input clk,rst,go,rate,
    input [2:0] select,
    input [3:0] addr_in,
    output	[7:0] an,		//7段数码管片选信号，低电平有效
    output  [7:0] seg   //7段数码管驱动，低电平有效
    /*output [31:0]clk_num,leddata,
    output [3:0]code,
    output [1:0]f1,
    output [31:0]resultmem,
    output sysm*/
);
    wire [31:0]led_data_out;
    wire clk_N,clk_d;
    wire [31:0]leddata;
    wire [31:0]clk_num;      //总周期数
    wire [31:0]no_branch_num; //无条件分支数
    wire [31:0]branch_num;    //有条件分支数
    wire [31:0]bub_num;
    wire [31:0]loaduse_num;
    wire [3:0]code;
    wire [1:0]f1;
    wire [31:0]resultmem;
    wire sysm;
    clk_divider clk_ds(clk,rate,clk_N);
    divider #(100_000) dis_d(clk,clk_d);
    datapath alldp(rst,go,clk_N,addr_in,leddata,clk_num,no_branch_num,branch_num,bub_num,loaduse_num,led_data_out,f1,resultmem,sysm);
   // display dsp(clk_d,leddata,an,seg,code);
    show show_all(clk_d,select,clk_num,no_branch_num,branch_num,leddata,bub_num,loaduse_num,led_data_out,an,seg);
endmodule
