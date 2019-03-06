`timescale 1ns/1ps
module CPU (input clk_n,
            input rst,
            input GO,
            //input [3:0]led_in,
            input [1:0]clkswitch,
            input [1:0]dispmode,
            output [7:0]an,
            output [7:0]seg
    );
    
    wire clk,clk1;
/*    module clk_divider(
        input clk,
        input [1:0]rate,
        output reg clk_N
        );*/
    clk_divider(clk_n,clkswitch,clk);
    //divider clock1(clk_n,clk); 
    divider #(10000)clock2(clk_n,clk1);//for display
    // pc out
    wire [31:0]PC_out;
    wire [31:0]nextPC;
    wire PCEnable_in;
    // instruction rom out 
    wire [31:0] IR_out;
    //IR decoder
    wire [5:0]OP_CODE;
    wire [5:0]FUNC;
    wire [4:0]rs;
    wire [4:0]rt;
    wire [4:0]rd;
    wire [15:0]imm;
    wire [25:0]instr_index;
    wire [4:0]sa;
    wire [31:0] signed_ext_imm;
    wire [3:0]ALU_OP;
    wire MemToReg;
    wire MemWrite;
    wire ALU_SRC;
    wire RegWrite;
    wire SysCALL;
    wire SignedExt;
    wire RegDst;
    wire Beq;
    wire Bne;
    wire JR;
    wire JMP;
    wire JAL;
    wire SRAV;
    wire SB ;
    wire BLEZ ;
    //R1# , R2#,  W#
    wire [4:0]RF_R1_in, RF_R2_in, RF_W_in;
    // wire RF_WE_in;
    parameter [4:0]Constant_two = 5'h02;
    parameter [4:0]Constant_four = 5'h04;
    parameter [4:0]Constant_one_f = 5'h1f;
    // parameter [3:0]Constant_one = 4'h02;
    // parameter [3:0]Constant_four_one_bit = 5'h04;
    // parameter [3:0]Constant_one_f = 5'h1f;
    // parameter [3:0]Constant_one_f = 5'h1f;

    wire [31:0]RF_DIN_in, RF_R1_out, RF_R2_out, RF_DIN_temp;
    wire ALU_Equal_out;
    wire [31:0]ALU_A_in, ALU_B_in;
    wire [4:0]ALU_shamt_in;
    wire [31:0]ALU_Result_out, ALU_Result2_out;
    wire [31:0]RAM_addr_in, RAM_din_in;
    wire [31:0]RAM_din_shift;
    wire [3:0]RAM_SEL,RAM_SEL_shift;
    wire RAM_WE_in;
    wire [31:0]RAM_dout_out;
    wire branch; // tiao jian fen zhi zhuan yi cheng gong de biao zhi
    wire [31:0]LedData_in;
    wire halt, pause, led;
    //wire [7:0]an_final, seg_final;
    wire [15:0]unconditional_branch_number;
    wire [15:0]branch_succeeded_number;
    wire [15:0]period_number;
    assign  OP_CODE = IR_out[31:26];
    assign  FUNC = IR_out[5:0];
    assign  rs = IR_out[25:21];
    assign  rt = IR_out[20:16];
    assign  rd = IR_out[15:11];
    assign  instr_index = IR_out[25:0];
    assign  imm = IR_out[15:0];
    assign  sa = IR_out[10:6];
/*
module PC (nextpc_in, enable_in, clk_in, rst_in, pc_out);
    input wire [31:0] nextpc_in;
    input wire enable_in;
    input wire clk_in;
    input wire rst_in;
    output reg [31:0] pc_out;
*/
PC pc_instance(nextPC, PCEnable_in, clk, rst, PC_out);
/*
module IM(
    input [11:0] address,
    output [31:0] im_now
    );
*/
IM im_instance (PC_out, IR_out);
/*
module controller(
    input [5:0]OP_CODE,
    input [5:0]FUNC,
    output reg [3:0]ALU_OP,
    output reg MemToReg,
    output reg MemWrite,
    output reg ALU_SRC,
    output reg RegWrite,
    output reg SysCALL,
    output reg SignedExt,
    output reg RegDst,
    output reg Beq,
    output reg Bne,
    output reg JR,
    output reg JMP,
    output reg JAL,
    output reg SRAV,
    output reg BLEZ,
    output reg SB

);
*/
controller contro_instance(OP_CODE , FUNC , ALU_OP , MemToReg, MemWrite , ALU_SRC , 
                            RegWrite , SysCALL , SignedExt , RegDst ,
                            Beq , Bne , JR , JMP , JAL , SRAV , BLEZ , SB);
/*
module mux(input choose,input [31:0] data1,
           input [31:0] data2,output [31:0] out);
module mux4(input [1:0] choose,input [31:0] data1,
            input [31:0] data2,input [31:0] data3,
            input [31:0] data4,output [31:0] out);
module mux4(input [1:0] choose,input [4:0] data1,
            input [4:0] data2,input [4:0] data3,
            input [4:0] data4,output [4:0] out);
*/
mux_2_5 mux_R1_addr (SysCALL, rs , Constant_two , RF_R1_in);
mux_2_5 mux_R2_addr (SysCALL, rt , Constant_four , RF_R2_in);
mux_4_5 mux_RegFile_W_addr ({JAL, RegDst}, rt, rd, Constant_one_f, Constant_one_f ,  RF_W_in);
/*
module RegFile(r1, r2, w, din, we, clk, a, b);
    input wire[4:0] r1,r2,w;//寄存器编�?
    input clk, we;        //时钟，写入控�?
    input wire [31:0] din; //写入数据
    output reg [31:0] a,b;//两个输出
*/
mux mux_RegFile_DIN_ALU_Result_or_RAM_dout(MemToReg, ALU_Result_out, RAM_dout_out, RF_DIN_temp);
mux mux_RegFile_DIN_temp_or_PC(JAL, RF_DIN_temp, PC_out+4, RF_DIN_in);
// assign RF_WE_IN = RegWrite;
RegFile RegFile_instance (
    RF_R1_in , RF_R2_in , RF_W_in,
    RF_DIN_in, RegWrite,
    clk, RF_R1_out, RF_R2_out);
/*
module ALU(
    input [31:0] X,
    input [31:0] Y,
    input [3:0] ALU_OP,
    input [4:0] shamt,

    output reg [31:0] Result,
    output reg [31:0] Result2,
    output Equal
    );
*/
assign ALU_A_in = RF_R1_out;
mux mux_ALU_inputB(ALU_SRC, RF_R2_out, signed_ext_imm, ALU_B_in);
// assign ALU_shamt_in = sa;
mux_2_5 mux_ALU_shamt_in(SRAV , sa , RF_R1_out [4:0] , ALU_shamt_in);
ALU ALU_instance(ALU_A_in, ALU_B_in, ALU_OP, ALU_shamt_in, ALU_Result_out, ALU_Result2_out, ALU_Equal_out);
/*
module npc( input rst,clk,signedext,jr,branch,jmp,
            input [31:0] pcnow,R1,
            input [15:0] Imm,
            input [25:0] Index,
            output wire [31:0] nextpc,
            output wire [31:0] imm_ext //立即�?
);
*/
assign branch = (Beq & ALU_Equal_out) | (Bne & ~ALU_Equal_out) | (BLEZ & ~(RF_R1_out>0));
npc npc_instance(rst, clk, SignedExt, JR, branch, JMP, PC_out, RF_R1_out, imm, instr_index, nextPC, signed_ext_imm);
/*
module RAM( addr,din,mode,WE,clk,clr,dout);
*/
assign RAM_addr_in = {20'b0000_0000_0000_0000_0000, ALU_Result_out[11:2], 2'b00};
mux4 mux_RAM_din_shift(ALU_Result_out[1:0] , RF_R2_out , {RF_R2_out[23:0],8'b0000_0000}   , 
                       {RF_R2_out[15:0],16'b0000_0000_0000_0000},  {RF_R2_out[7:0],24'b0000_0000_0000_0000_0000_0000} , RAM_din_shift);
mux mux_RAM_din_in(SB ,RF_R2_out , RAM_din_shift ,RAM_din_in );
//assign RAM_din_in = RF_R2_out;

mux_4_4 mux_RAM_SEL_shift(ALU_Result_out[1:0] ,4'b0001 , 4'b0010, 4'b0100 ,4'b1000 , RAM_SEL_shift ) ;
mux_2_4 mux_RAM_SEL(SB ,4'b1111 , RAM_SEL_shift ,RAM_SEL ) ;

assign RAM_WE_in = MemWrite;
RAM RAM_instance(RAM_addr_in, RAM_din_in, RAM_SEL, RAM_WE_in, clk, rst, RAM_dout_out);
/*
module syscall( input [31:0]r1,mwdata,input clk,rst,sys,
output [31:0]LedData,output reg led,halt,pause );  //?reg类型的信号？
*/
syscall syscall_instance(RF_R1_out, RF_R2_out, clk, rst, SysCALL, LedData_in, led, halt, pause);
/*

module choose_display(
    //input [31:0] r2,
    //input [31:0] r1,//R2,R1
    input halt,
    input pause,
    input [31:0] LedData,  //跑马灯数�?
    input [15:0] round,//总周�?
    input [15:0] con,//有条�?
    input [15:0] uncon,//无条�?
    //input syscall,
    input [1:0] choose,
    input clk,
    
    output [7:0]an,
    output [7:0] seg
    );
*/
choose_display choose_display_instance(
    // RF_R2_out, 
    // RF_R1_out, 
    halt, 
    pause, 
    LedData_in, 
    period_number, 
    branch_succeeded_number,
    unconditional_branch_number, 
    dispmode, clk1, an, seg);
/*
module three_counter(input clk, input rst, input jmp, input branch, input halt, input go, input pause, 
                output [15:0]unconditional_branch_number, 
                output [15:0]branch_succeeded_number,
                output [15:0]period_number);
*/
three_counter three_counter_instance(clk, rst, JMP, branch, halt, GO, pause, unconditional_branch_number, branch_succeeded_number, period_number);
/*
module pcenable(
    input go,
    input clk,
    input pause,
    input halt ,

    input rst,
    output enable
    );
*/
pcenable pcenable_instance(GO, clk, pause, halt, rst, PCEnable_in);
endmodule