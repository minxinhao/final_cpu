`timescale 1ns / 1ps
module reg_used_anal(
    input [5:0]op,func,
    output r1_used,r2_used
    );
    assign r1_used=(op!=2)&&(op!=3)&&(op!=40);
    assign r2_used=(op==0&&func!=8)||(op==4)||(op==5)||(op==43) || (op==40);
endmodule
