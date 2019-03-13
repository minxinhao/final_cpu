`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 08:09:00
// Design Name: 
// Module Name: 
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


///////////////////////////
// 寄存器
///////////////////////////
module Regfile(clk,en,clr,din,dout);
	parameter SIZE=32;	//寄存器位数
	input	clk;
	input	en,clr;	//使能端，清零
	input	[SIZE-1:0]din;	//输入
	output	reg	[SIZE-1:0]dout;	//输出
	
	reg [SIZE-1:0]data;	//寄存器中存储值
	
	initial begin
		dout=0;
		data=0;
	end
	
	always @(posedge clk) begin
		if(clr==1)	data=0;
		else if(en==1)	data=din;
		else  ;
		dout=data;
	end
endmodule

module Regfiled(clk,en,clr,din,dout);
	parameter SIZE=32;	//寄存器位数
	input	clk;
	input	en,clr;	//使能端，清零
	input	[SIZE-1:0]din;	//输入
	output	reg	[SIZE-1:0]dout;	//输出
	
	reg [SIZE-1:0]data;	//寄存器中存储值
	
	initial begin
		dout=0;
		data=0;
	end
	
	always @(negedge clk) begin
		if(clr==1)	data=0;
		else if(en==1)	data=din;
		else  ;
		dout=data;
	end
endmodule
