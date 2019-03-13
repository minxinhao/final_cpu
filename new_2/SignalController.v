//硬布线控制器
//input: [5:0]op ,[5:0]func;
//output: memtoreg,memwrite,alusrc,regwrite
//        syscall,signedext,regdst,beq,bne
//        jr,jmp,jal
module SignalController(
    input [5:0]op ,[5:0]func,
    output memtoreg,memwrite,alusrc,regwrite,syscall,
    output signedext,regdst,beq,bne,jr,jmp,jal,srav,sb,blez
);
    assign memtoreg=(op==6'b100011||op==6'b100100)?1:0;
    assign memwrite=(op==6'b101011 || op==6'b101000)?1:0;
    assign alusrc=(op==6'b101000 ||  op==6'b001110 || op==6'b001000||op==6'b001001||op==6'b001010||op==6'b001100||op==6'b001101||op==6'b100011||op==6'b101011||op==6'b100100)?1:0;
    assign regwrite=(op==6'b001110 ||  ((op==0) && (func == 6'b000111)) || 
                       ((op==6'b000000) && (func!=6'b001000) &&(func!=6'b001100))
                        ||op==6'b001000 || op==6'b001001 || op==6'b001010 ||op==6'b001100||op==6'b001101||op==6'b100011||op==6'b000011||op==6'b001111||op==6'b100100)?1:0;
    assign syscall=(op==6'b000000&&func==6'b001100)?1:0;
    assign signedext=(op==6'b101000 || op==6'b001000||op==6'b001001||op==6'b001010||op==6'b100011||op==6'b101011||op==6'b100100)?1:0;
    assign regdst=(  ((op==6'b000000)&&(func!=6'b001100)) || ( (op==0) && (func == 6'b000111) ) )  ? 1:0;
    assign beq=(op==6'b000100)?1:0;
    assign bne=(op==6'b000101)?1:0;
    assign jr=(op==6'b000000&&func==6'b001000)?1:0;
    assign jmp=((op==6'b000000&&func==6'b001000)||op==6'b000010||op==6'b000011)?1:0;
    assign jal=(op==6'b000011)?1:0;
    assign srav=( (op==0) && (func == 6'b000111) ) ? 1:0;
    assign sb=(op==6'b101000)?1:0;
    assign blez=(op==6'b000110)?1:0;
    //op==6'b001110 xori
endmodule
