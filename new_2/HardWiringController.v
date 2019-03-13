
module HardWiringController(
	input [5:0]op ,[5:0]func,
	output [3:0]aluop,
	output memtoreg,memwrite,alusrc,regwrite,
	output syscall,signedext,regdst,beq,bne,
	output jr,jmp,jal,srav,blez,sb
);
	AluController AluCtrl(op,func,aluop);

	/*
	module SignalController(
	    input [5:0]OP_CODE,
	    input [5:0]FUNC,
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
	SignalController SignCtrl(op,func,memtoreg,memwrite,
		alusrc,regwrite,syscall,signedext,regdst,beq,bne,jr,jmp,jal,srav,blez,sb);

endmodule