`timescale 1ns / 1ps

module Input4B(syscall,AluSrcB,SignedExt,R2,D,B);

    input syscall,AluSrcB,SignedExt;//控制信号
    input reg [31:0] R2;            //寄存器文件输出R2
    input reg [31:0] sigext;         //符号扩展
    input reg [31:0] zeroext;        //零扩展
    output reg [31:0] B;            //ALU输入B
    initial
    begin
        B <= 0;
    end
    always @(*)
    begin
    if(syscall)
    begin
        B <= 34;
    end
    else if(SignedExt)
    begin
        B <= sigext;
    end
    else if(AluSrcB && (~SignedExt))
    begin
        B <= zeroext;
    end
    else if((~syscall) && (~AluSrcB) )
    begin
        B <= R2;
    end
    else
    begin
        B <= 0;//shouldn't happen
    end
    end
endmodule
