`timescale 1ns / 1ps

module D_FF(clk,rst,d,q);
    input clk;
    input rst;
    input d;
    output reg q;
    initial q=0;
    always@(posedge clk )
        begin if(rst == 1'b1) 
            q <= 1'b0;  
            else
            q <= d;
    end 
endmodule



module pcenable(
    input go,
    input clk,
    input pause,
    input halt ,

    input rst,
    output enable
    );

//    D_FF d(clk,rst,(~halt) & go,Q);
    assign enable = ( ~halt & ~pause )|go;

endmodule
