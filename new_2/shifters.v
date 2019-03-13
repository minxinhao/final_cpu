`timescale 1ns / 1ps

//////////////////////////////////
//左移器
//size调整数据位宽
/////////////////////////////////
module leftshifter(
x,y,result
    );
parameter size = 8;
input[size-1:0] x;   //被移位数
input[size-1:0] y;   //移动位数
output reg[size-1:0] result;  //输出

always@(x or y)
begin
    result <= x<<y;
end
endmodule

////////////////////////////
//32位无符号扩展
//扩展为32位
//size选择数据位宽
///////////////////////////
module unsign_extend32(
x,y
    );
parameter size = 16;
input[size-1:0] x;
output reg[31:0] y;
always@(x)
begin
     y <= {{(32 - size){1'b0}},x};
end
endmodule

/*
////////////////////////////
//16位无符号扩展
//扩展为16位
//size 选择数据位宽
///////////////////////////
module unsign_extend16(
x,y
    );
parameter size = 8;
input[size-1:0] x;
output reg[15:0] y;
always@(x)
begin
     y <= {{(16 - size){1'b0}},x};
end
endmodule
*/

////////////////////////////
//32位有符号扩展
//扩展为32位
//size选择输入数据位宽
///////////////////////////
module sign_extend32(
x,y
);
parameter size = 16;
input[size-1:0] x;
output reg[31:0] y;
always@(x)
begin
     y <= {{(32 - size){x[size-1]}},x};
end
endmodule
/*
////////////////////////////
//16位有符号扩展
//扩展为16位
//size 选择数据位宽
///////////////////////////
module sign_extend16(
x,y
    );
parameter size = 8;
input[size-1:0] x;
output reg[15:0] y;
always@(x)
begin
     y <= {{(16 - size){x[size-1]}},x};
end
endmodule
*/

///////////////////////////
//计数器
//输入en,clk,clr
//输出size位count
//////////////////////////
module counter(en,clk,clr,count);
parameter size  = 16;
input en;
input clk;
input clr;
output reg [size-1:0] count;

initial
begin
    count = 0;
end

always@(posedge clk)
begin
    if(clr == 1)
        count <= 0;
    else if(en == 1)
    begin
        count <= count + 1;
    end
    else
    begin
        count <= count; 
    end   
end
endmodule

// module counterd(en,clk,clr,count);
// parameter size  = 16;
// input en;
// input clk;
// input clr;
// output reg [size-1:0] count;

// initial
// begin
//     count = 0;
// end

// always@(negedge clk)
// begin
//     if(clr == 1)
//         count <= 0;
//     else if(en == 1)
//     begin
//         count <= count + 1;
//     end
//     else
//     begin
//         count <= count; 
//     end   
// end
// endmodule