`timescale 1ns / 1ps


/////////////////////////////////////////
// 数字显示模块
// 引用三个小模块显示32位数字
////////////////////////////////////////
module display(clk,number,an,patt,code);
    input   clk;
    input   [31:0] number;  //显示的16进制数
    output  [7:0] an;       //7段数码管片选信号，低电平有效
    output  [7:0] patt;     //7段数码管驱动，低电平有效
    output  [3:0] code;     //中间变量，当前显示数字
    
    pattern v1(code,patt);
    show1   v2(clk,an);
    show2   v3(clk,an,number,code);
endmodule

/////////////////////////////////////////
// 7段显示译码管
// 选择亮的数字
/////////////////////////////////////////
module pattern(code, patt);
    input [3: 0] code;              // 16进制数字的4位二进制编码
    output reg [7:0] patt;          // 7段数码管驱动，低电平有效
    
    initial patt=8'b11111111;
    
    always @(code[3:0]) begin       // 功能实现
        case(code[3:0])
            4'b0000: patt=8'b1100_0000;
            4'b0001: patt=8'b1111_1001;
            4'b0010: patt=8'b1010_0100;
            4'b0011: patt=8'b1011_0000;
            4'b0100: patt=8'b1001_1001;
            4'b0101: patt=8'b1001_0010;
            4'b0110: patt=8'b1000_0010;
            4'b0111: patt=8'b1111_1000;
            4'b1000: patt=8'b1000_0000;
            4'b1001: patt=8'b1001_1000;
            4'b1010: patt=8'b1000_1000;
            4'b1011: patt=8'b1000_0011;
            4'b1100: patt=8'b1100_0110;
            4'b1101: patt=8'b1010_0001;
            4'b1110: patt=8'b1000_0110;
            4'b1111: patt=8'b1000_1110;
            default: patt=8'b1111_1111;
        endcase
    end                       
endmodule

////////////////////////////////////////
// 走马灯显示模块
// 8个显示管循环显示
////////////////////////////////////////
module show1(clk,an);
    input   clk;
    output  reg [7:0] an;   //7段数码管片选信号，低电平有效
    
    initial an=8'b11111111;
    
    always @(posedge clk) begin
        case(an)
            8'b11111111: an=8'b11111110;
            8'b11111110: an=8'b11111101;
            8'b11111101: an=8'b11111011;
            8'b11111011: an=8'b11110111;
            8'b11110111: an=8'b11101111;
            8'b11101111: an=8'b11011111;
            8'b11011111: an=8'b10111111;
            8'b10111111: an=8'b01111111;
            8'b01111111: an=8'b11111110;
            default: an=8'b11111111;
        endcase
    end
endmodule

////////////////////////////////////////////
// 数字选择模块
// 根据当前亮的显示管选择要显示的数字
////////////////////////////////////////////
module show2(clk,an,number,code);
    input   clk;
    input   [7:0] an;       //7段数码管片选信号，低电平有效
    input   [31:0] number;  //要显示的数字，16进制，每4位为一个数字
    output  reg [3:0] code;     //中间变量，表示当前显示的数字
    
    initial code=0;
    
    always @(posedge clk) begin
        case(an)
            8'b11111110: code=number[7:4];
            8'b11111101: code=number[11:8];
            8'b11111011: code=number[15:12];
            8'b11110111: code=number[19:16];
            8'b11101111: code=number[23:20];
            8'b11011111: code=number[27:24];
            8'b10111111: code=number[31:28];
            8'b01111111: code=number[3:0];
            default: code=0;        
        endcase
    end
endmodule
