`timescale 1ns / 1ps
module loaduse_analsys(
    input [5:0]op0,func0,op1,func1,
    input [4:0]exwaddr,r1,r2,
    output loaduse
    );
    wire r1_used,r2_used;
    wire lu1,lu2;
    reg_used_anal rual(op0,func0,r1_used,r2_used);
    assign lu1=(op1==35||op1==36)&&(r1_used&&(r1==exwaddr));
    assign lu2=(op1==35||op1==36)&&(r2_used&&(r2==exwaddr));
    assign loaduse=lu1||lu2;
endmodule
