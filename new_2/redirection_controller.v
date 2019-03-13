`timescale 1ns / 1ps
module redirection_controller(
    input [5:0]op,func,
    input [4:0]exwaddr,memaddr,r1,r2,
    input exrw,memrw,memmtr,
    output [1:0]forward1,forward2
    );
    wire r1_used,r2_used;
    wire f11,f12,f21,f22; 
    wire pref1a,pref1b,pref1c,pref1d;
    wire pref2a,pref2b,pref2c,pref2d;
    reg_used_anal rua(op,func,r1_used,r2_used);
    
    assign pref1a=exrw&&r1_used&&(r1!=0)&&(exwaddr==r1);
    assign pref1b=memrw&&r1_used&&(r1!=0)&&(memaddr==r1);
    assign f11=pref1a||(!pref1a&&!memmtr&&pref1b);
    assign f12=pref1a||(!pref1a&&memmtr&&pref1b);
    
    assign pref2a=exrw&&r2_used&&(r2!=0)&&(exwaddr==r2);
    assign pref2b=memrw&&r2_used&&(r2!=0)&&(memaddr==r2);
    assign f21=pref2a||(!pref2a&&!memmtr&&pref2b);
    assign f22=pref2a||(!pref2a&&memmtr&&pref2b);
    
    assign forward1={f11,f12};
    assign forward2={f21,f22};
    
endmodule
