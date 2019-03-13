`timescale 1ns / 1ps
//////////////////////////////////////////
// 显示模块
// 将要显示的你内容的输入规格化
//////////////////////////////////////////
module show(clk,select,cycle_number,branch_un,branch_con,leddata,bubnum,loaduse,led_data_out,an,patt);
	input	clk;
	input	[2:0] select;
	// 选择显示内容
	// 001：显示周期数；	010：显示无条件分支数
	// 011：显示条件分支数	100：显示内存内容
	// default：显示运行时内容ledData；
	input	[31:0] cycle_number;	//周期数
	input	[31:0] branch_un;		//无条件分支数
	input	[31:0] branch_con;		//条件分支数
	input	[31:0] leddata;	//运行时显示内容
	input  [31:0] bubnum;
	input  [31:0] loaduse;
	input   [31:0]led_data_out;
	output	[7:0] an;		//7段数码管片选信号，低电平有效
	output	[7:0] patt;		//7段数码管驱动，低电平有效

    wire [31:0] number_display;

	display v1(clk,number_display,an,patt);
	show3 v2(clk,select,cycle_number,branch_un,branch_con,leddata,bubnum,loaduse,led_data_out,number_display);
endmodule

/////////////////////////////////////////////
// 显示内容选择模块
// 选择显示内容，包括：运行显示，总周期数，
// 无条件跳转数，条件跳转数，内存内容
/////////////////////////////////////////////
module show3(clk,select,cycle_number,branch_un,branch_con,leddata,bubnum,loaduse,led_data_out,number_display);
	input	clk;
	input	[2:0] select;
	input	[31:0] cycle_number;		//周期数
	input	[31:0] branch_un;		//无条件分支数
	input	[31:0] branch_con;		//条件分支数
	input	[31:0] leddata;	//运行时显示内容
	input  [31:0] bubnum;
    input  [31:0] loaduse;
	input   [31:0] led_data_out;
	output	reg [31:0] number_display;	//当前显示内容
	
	initial number_display=0;
	
	always @(posedge clk) begin
		case(select)
			3'b001: number_display=cycle_number;
			3'b010: number_display=branch_un;
			3'b011: number_display=branch_con;
			3'b100: number_display=bubnum;
			3'b101: number_display=loaduse;
			3'b111: number_display=led_data_out;
			default: number_display=leddata;
		endcase
	end
endmodule
