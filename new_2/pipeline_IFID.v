`timescale 1ns / 1ps
module pipeline_IFID(
    input clk,rst,en,
    input [31:0]IRin,PCin,
    output  [31:0]IRout,PCout
    );
    wire [31:0]IRtemp,PCtemp;
    
    MUX_2 #(32)irmux(rst,IRin,0,IRtemp); 
    /*
	module Regfile(clk,en,clr,din,dout);
	parameter SIZE=32;	//寄存器位数
	input	clk;
	input	en,clr;	//使能端，清零
	input	[SIZE-1:0]din;	//输入
	output	reg	[SIZE-1:0]dout;	//输出
    */
    Regfile irreg(clk,~en,1'b0,IRtemp,IRout);
    
    MUX_2 #(32)pcmux(rst,PCin,0,PCtemp); 
    Regfile pcreg(clk,~en,1'b0,PCtemp,PCout);
    
endmodule

