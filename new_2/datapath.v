
`timescale 1ns / 1ps

module datapath(
    input rst,go,clk,
    input [3:0]led_addr,
    output [31:0]leddata,
    output [31:0]clk_num,      
    output [31:0]no_branch_num, 
    output [31:0]branch_num,    
    output [31:0]bub_num,       
    output [31:0]loaduse_num,   
    output [31:0]led_data_out,
    output [1:0]f1ex,
    output [31:0]resultmem,
    output sysm
    );
    wire ifen;wire [1:0]pcsrc;
    wire [31:0]pcif,irif,pcid,irid,pcex,irex,pcmem,irmem,pcwb,irwb;//
    wire loaduse,ldex,ldm,sysid,sysex,sysm,syswb,syshalt;
    wire [31:0]zero_extendid,signed_extendid,ext;
    wire [31:0]zero_extendex,signed_extendex,extex;
    wire [31:0]Din,jalwbd,alubin, alua,pre_alua,pre_alub;
    wire [4:0] alu_shamt_in ;
    wire [31:0]pc0,pc1,pre_pc2,pc2,pc3,pcin;
    wire [4:0]r1addr,r2addr,waddrex,waddrmem,waddrwb;
    wire [31:0]pre_din;
    
    wire [3:0]aluop;
    wire memtoreg,memwrite,alusrc,regwrite;
    wire syscall,signedext,rdst,beq,bne;
    wire jr,jmp,jal,srav,sb,blez;
    
    wire mtrex,rdex,jalex,sravex,sbex,rwex,mwex;
    wire [3:0]aluopex;
    wire alusrcex,sextex,jmpex,jrex,beqex,bneex,blezex;
    wire [31:0]r1,r2,r1ex,r2ex;
    wire [1:0]f1,f2,f1ex,f2ex;
    
    wire mtrmem,rdmem,jalmem,sravmem,sbmem,rwmem,mwmem;
    wire [3:0] datamem_sel  , datamem_sel_1  ;
    wire [31:0] datamem_din  , datamem_din_1  ;
    wire [31:0]result,result2,alub,resultmem,alubmem;
    
    wire mtrwb,rdwb,jalwb,sravwb,sbwb,rwwb;
    wire [31:0]mdmem,resultwb,mdwb;
    wire equ;
    wire branch,condi;
    wire led,pause,halt;
    assign branch=jmpex||condi;
    assign condi=(beqex&&equ)||(bneex&&!equ)||(blezex & (r1ex[31] || r1ex==0));
    assign sysid= ((syscall&&halt)||(syscall&&~go&&pause))&&(~rst);
    assign ifen=loaduse||ldex||ldm||sysid;
    //nextpc
    MUX_4 #(32) pcnext(pcsrc,pc0,pc1,pc2,pc3,pcin);
    //PC
    Regfile pcregfile(clk,~ifen,rst,pcin,pcif);

    instruction_mem irrom(pcif[11:2],irif);
    //IFID
    pipeline_IFID ifid(clk,
    rst||branch,
    ifen,
    irif,pcif,irid,pcid);
    //IDEX
    pipeline_IDEX idex(clk,
        rst||branch||(loaduse||ldex||ldm),
        sysex,
       irid,pcid,irex,pcex,memtoreg,rdst,jal,srav,sb,regwrite,
       mtrex,rdex,jalex,sravex,sbex,rwex,
       memwrite,mwex,aluop,alusrc,signedext,jmp,jr,beq,bne,blez,
       aluopex,alusrcex,sextex,jmpex,jrex,beqex,bneex,blezex,
       r1,r2,r1ex,r2ex,f1,f2,f1ex,f2ex);
     //EXMEM
     pipeline_EXMEM exmem(clk,
        rst,sysm,
        irex,pcex,irmem,pcmem,mtrex,rdex,jalex,sravex,sbex,rwex,
        mtrmem,rdmem,jalmem,sravmem,sbmem,rwmem,mwex,mwmem,
        result,alub,resultmem,alubmem
     );
     //MEMWB
     pipeline_MEMWB memwb(clk,
        rst,syswb,
        irmem,pcmem,irwb,pcwb,mtrmem,rdmem,jalmem,sravmem,sbmem,rwmem,
        mtrwb,rdwb,jalwb,sravwb,sbwb,rwwb,
        resultmem,mdmem,resultwb,mdwb
     );
     //id
     HardWiringController HWC(irid[31:26],irid[5:0],aluop,memtoreg,memwrite,
                 alusrc,regwrite,syscall,signedext,rdst,beq,bne,jr,jmp,jal,srav,sb,blez);
    //id
    Regifile rf(Din,clk,rwwb,waddrwb,r1addr,r2addr,r1,r2);
    //id
    unsign_extend32 #(16) z_extid(irid[15:0],zero_extendid);
    sign_extend32 #(16) s_extid(irid[15:0],signed_extendid);
    MUX_2 #(32) sign_id(signedext,zero_extendid,signed_extendid,ext);
    //id sys
    assign led=syscall&&((f1==0&&r1==34)||(f1==3&&resultmem==34));
    assign halt=syscall&&((f1==0&&r1==10)||(f1==3&&resultmem==10));
    assign pause=(!(led||halt))&&syscall;
    //id redirection analysis
    MUX_4 #(5) wex({jalex,rdex},irex[20:16],irex[15:11],5'b11111,5'b11111,waddrex);
    MUX_4 #(5) wmem({jalmem,rdmem},irmem[20:16],irmem[15:11],5'b11111,5'b11111,waddrmem);
    MUX_2 #(5) r1a(syscall,irid[25:21],5'b00010,r1addr);
    MUX_2 #(5) r2a(syscall,irid[20:16],5'b00100,r2addr);
    redirection_controller rdc(irid[31:26],irid[5:0],waddrex,waddrmem,r1addr,r2addr,rwex,rwmem,mtrmem,f1,f2);
    loaduse_analsys lua(irid[31:26],irid[5:0],irex[31:26],irex[5:0],waddrex,r1addr,r2addr,loaduse);
    Regfile #(1) luid(clk,1'b1,rst,loaduse,ldex);
    Regfile #(1) luex(clk,1'b1,rst,ldex,ldm);
    //exalu
    MUX_2 #(32) alubmux(alusrcex,alub,extex,alubin);
    MUX_2 #(5) alub_shamt_mux(sravex,irex[10:6],r1ex[4:0] ,alu_shamt_in);
    alu ALU(alua,alubin,aluopex,alu_shamt_in,result,result2,equ);
    //exextend
    unsign_extend32 #(16) z_extex(irex[15:0],zero_extendex);
    sign_extend32 #(16) s_extex(irex[15:0],signed_extendex);
    MUX_2 #(32) sign_ex(sextex,zero_extendex,signed_extendex,extex);
    //ex branch
    assign pcsrc = {condi||(jmpex&&!jrex),jmpex};
    assign pc0=pcif+4;
    assign pc1=r1ex;
    leftshifter #(32) b_pc(extex,02,pre_pc2);
    assign pc2=pcex+4+pre_pc2;
    assign pc3 ={pc0[31:28],irex[25:0],2'b00};
    //ex re
    //MUX_2 #(32) lui1(luimem,resultmem,{irmem[15:0],16'b0},pre_alua);
    MUX_4 #(32) luif1(f1ex,r1ex,mdwb,resultwb,resultmem,alua);
    MUX_4 #(32) luif2(f2ex,r2ex,mdwb,resultwb,resultmem,alub);
    //mem datamem
    MUX_4 #(4) datamem_sel_1_mux(resultmem[1:0],4'b0001,4'b0010,4'b0100,4'b1000,datamem_sel_1);
    MUX_2 #(4) datamem_sel_2_mux(sbmem,4'b1111,datamem_sel_1,datamem_sel);
    
    MUX_4 #(32) datamem_din_1_mux(resultmem[1:0],  alubmem , {alubmem[23:0] , 8'b0000_0000} , 
                                {alubmem[15:0] , 16'b00000_00000_00000_0 } ,
                                {alubmem[7:0] , 24'b00000_00000_00000_00000_0000} , datamem_din_1);

    MUX_2 #(32) datamem_din_mux(sbmem,alubmem,datamem_din_1,datamem_din);

    data_mem DATAMEM(resultmem[11:2],led_addr,datamem_din , datamem_sel,clk,mwmem,rst,mdmem,led_data_out);
    //wb address
    MUX_4 #(5) wwb({jalwb,rdwb},irwb[20:16],irwb[15:11],5'b11111,5'b11111,waddrwb);
    //wb data
    assign jalwbd = pcwb+4;
    
    // MUX_4 #(8) lbdata(resultwb[1:0],mdwb[7:0],mdwb[15:8],mdwb[23:16],mdwb[31:24],pre_sb);
    // unsign_extend32 #(8) sb_ext(pre_lbu,lbu_extend);
    
    //MUX_2 #(32) lb(lbuwb,mdwb,lbu_extend,lbu_result);
    MUX_2 #(32) mtr(mtrwb,resultwb,mdwb,pre_din);
    MUX_2 #(32) jl(jalwb,pre_din,jalwbd,Din);
    //MUX_2 #(32) lu(luiwb,pre_Din,{irwb[15:0],16'b0},Din);
    
    Regfile #(32) ledrf(clk,(alua==34),rst,alub,leddata);

    Regfiled #(1) sid(clk,1'b1,rst,sysid,sysex);
    Regfiled #(1) sex(clk,1'b1,rst,sysex,sysm);
    Regfiled #(1) sm(clk,1'b1,rst,sysm,syswb);
    Regfiled #(1) swb(clk,1'b1,rst,syswb,syshalt);
    //counter
    counter #(32) nb(jmpex,clk,rst,no_branch_num);
    counter #(32) b(condi,clk,rst,branch_num);
    counter #(32) cycle((~(ldex||ldm))&&(~syshalt),clk,rst,clk_num);
    counter #(32) bub(ldm||ldex||branch||loaduse,clk,rst,bub_num);
    counter #(32) ldu(loaduse,clk,rst,loaduse_num);
endmodule

