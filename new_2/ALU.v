//-----------------
//ALU功能模块
//输入：dataA、dataB(32位)、aluop(4位)
//输出：Result1、Result2(32位)、Equal(1位)
//-----------------
module alu(
	input	[31:0] dataA,
	input	[31:0] dataB,
	input	[3:0] aluop,
	input [4:0] shamt,
	output	reg [31:0] Result1,
	output	reg [31:0] Result2,
	output	reg Equal
	);
	
	reg	[63:0] result;
	
	initial begin
		Result1 = 0;
		Result2 = 0;
		Equal = 0;
	end
	
	always	@(*) begin
		if(dataA == dataB)
			Equal = 1;
		else
			Equal = 0;
			
		case(aluop[3:0])
			4'b0000 : begin
						//shamt = dataB[4:0];
						Result1 = dataB << shamt;
						Result2 = 0;
					  end
			4'b0001 : begin
						//shamt = dataB[4:0];
						Result1 = ($signed(dataB)) >>> shamt;
						Result2 = 0;
					  end
			4'b0010 : begin
						//shamt = dataB[4:0];
						Result1 = dataB>> shamt;
						Result2 = 0;
					  end
			4'b0011 : begin
						result = ($unsigned(dataA)) * ($unsigned(dataB));
						Result1 = result[31:0];
						Result2 = result[63:32];
					  end
			4'b0100 : begin
						Result1 = ($unsigned(dataA))/($unsigned(dataB));
						Result2 = ($unsigned(dataA))%($unsigned(dataB));
					  end
			4'b0101 : begin
						Result1 = dataA+dataB;
						Result2 = 0;
					  end
			4'b0110 : begin
						Result1 = dataA-dataB;
						Result2 = 0;
					  end
			4'b0111 : begin
						Result1 = dataA&dataB;
						Result2 = 0;
					  end
			4'b1000 : begin
						Result1 = dataA|dataB;
						Result2 = 0;
					  end
			4'b1001 : begin
						Result1 = dataA^dataB;
						Result2 = 0;
					  end
			4'b1010 : begin
						Result1 = ~(dataA|dataB);
						Result2 = 0;
					  end
			4'b1011 : begin
						if(($signed(dataA))<($signed(dataB)))
							Result1 = 1;
						else
							Result1 = 0;
						Result2 = 0;
					  end
			4'b1100 : begin
						if(($unsigned(dataA))<($unsigned(dataB)))
							Result1 = 1;
						else
							Result1 = 0;
						Result2 = 0;
					  end
			default : begin
						Result1 = 0;
						Result2 = 0;
					  end
			endcase
		end
endmodule
