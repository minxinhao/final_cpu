module AluController(
	input [5:0]op ,[5:0]func,
	output reg [3:0]aluop//杩愮畻鎺у埗鍣?
);
	always@(*) begin
		if(op == 6'b000000) begin
			case(func)
				6'b000000:aluop=0;//SLL
				6'b000011:aluop=1;//SRA
				6'b000010:aluop=2;//SRL
				6'b100000:aluop=5;//ADD
				6'b100001:aluop=5;//ADDU
				6'b100010:aluop=6;//SUB
				6'b100100:aluop=7;//AND
				6'b100101:aluop=8;//OR
				6'b100111:aluop=10;//NOR
				6'b101010:aluop=11;//SLT
				6'b101011:aluop=12;//SLTU
				6'b000111:aluop=1;//SRAV				
				default:;
			endcase
		end
		else begin
			case(op)
				6'b001000:aluop=5;//ADDI
				6'b001001:aluop=5;//ADDIU
				6'b001010:aluop=11;//SLTI
				6'b001100:aluop=7;//ANDI
				6'b001101:aluop=8;//ORI
				6'b100011:aluop=5;//LW
				6'b101011:aluop=5;//SW
				6'b001110:aluop=9;//XORI
				6'b101000:aluop=5;//SB
				6'b000110:aluop=11;//BLEZ


				default:;
			endcase
		end
	end
endmodule