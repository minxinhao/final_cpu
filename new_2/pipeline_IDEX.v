`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/25 16:53:11
// Design Name: 
// Module Name: pipeline_IDEX
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


module pipeline_IDEX(
    input clk,rst,en,
    input [31:0]IRin,PCin,
    output [31:0]IRout,PCout,
    input mtrin,rdin,jalin,sravin,sbin,rwin,
    output mtrout,rdout,jalout,sravout,sbout,rwout,
    input mwin,
    output mwout,
    input [3:0]aluopin,
    input alusrcin,sextin,jmpin,jrin,beqin,bnein,blezin,
    output [3:0]aluopout,
    output alusrcout,sextout,jmpout,jrout,beqout,bneout,blezout,
    input [31:0]r1in,r2in,
    output [31:0]r1out,r2out,
    input [1:0]forward1,forward2,
    output [1:0]f1out,f2out
    );
        
        wire [31:0]IRtemp,PCtemp;
        wire mtrtemp,rdtemp,jaltemp,sravtemp,sbtemp,rwtemp;
        wire mwtemp;
        wire [3:0]aluoptemp;
        wire alusrctemp,sexttemp,jmptemp,jrtemp,beqtemp,bnetemp,bleztemp;
        wire [31:0]r1temp,r2temp;
        wire [1:0]f1temp,f2temp;
        
        
        MUX_2 irmux(rst,IRin,0,IRtemp); 
        Regfile irreg(clk,~en,1'b0,IRtemp,IRout);
        
        MUX_2 pcmux(rst,PCin,0,PCtemp); 
        Regfile pcreg(clk,~en,1'b0,PCtemp,PCout);
        
        MUX_2 r1mux(rst,r1in,0,r1temp); 
        Regfile r1reg(clk,~en,1'b0,r1temp,r1out);
        
        MUX_2 r2mux(rst,r2in,0,r2temp); 
        Regfile r2reg(clk,~en,1'b0,r2temp,r2out);
        
        /*
        module MUX_2(select,din0,din1,dout);
        parameter SIZE=32;  
        input   select; //输出选择，为0输出din0，为1输出din1
        input   [SIZE-1:0] din0,din1;
        output  reg [SIZE-1:0] dout;
        */
         MUX_2 #(22) mtrmux
         (
            rst,
            {   
                mtrin,rdin,jalin,sravin,sbin,rwin,mwin,aluopin[3:0],alusrcin,
                sextin,jmpin,jrin,beqin,bnein,blezin,forward1[1:0],forward2[1:0]
            },
            22'b0000000000000000000000,
            {   
                mtrtemp,rdtemp,jaltemp,sravtemp,sbtemp,rwtemp,mwtemp,aluoptemp[3:0],
                alusrctemp,sexttemp,jmptemp,jrtemp,beqtemp,bnetemp,bleztemp,f1temp[1:0],
                f2temp[1:0]
            }
         ); 

         /*
            module Regfile(clk,en,clr,din,dout);
            parameter SIZE=32;  //寄存器位数
            input   clk;
            input   en,clr; //使能端，清零
            input   [SIZE-1:0]din;  //输入
            output  reg [SIZE-1:0]dout; //输出
         */
         Regfile #(22) mtrreg
         (
            clk,~en,1'b0,
            {
                mtrtemp,rdtemp,jaltemp,sravtemp,sbtemp,rwtemp,mwtemp,
                aluoptemp[3:0],alusrctemp,sexttemp,jmptemp,jrtemp,
                beqtemp,bnetemp,bleztemp,f1temp[1:0],f2temp[1:0]
            },
            {
                mtrout,rdout,jalout,sravout,sbout,rwout,mwout,aluopout[3:0],
                alusrcout,sextout,jmpout,jrout,beqout,bneout,blezout,
                f1out[1:0],f2out[1:0]
            }
         );
        

endmodule
