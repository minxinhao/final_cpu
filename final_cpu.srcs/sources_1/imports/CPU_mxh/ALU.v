`timescale 1ns / 1ps
module ALU(
	input [31:0] X,
	input [31:0] Y,
	input [3:0] ALU_OP,
	input [4:0] shamt,

	output reg [31:0] Result,
	output reg [31:0] Result2,
	output Equal
	);

	wire signed [31:0] shift_x;
	wire signed [31:0] shift_y;


	initial begin
		Result <= 0;
		Result2 <= 0;
	end

	assign shift_y = $signed(Y) >>> shamt[4:0];
	assign Equal = (X==Y) ;


always @( * ) 
begin
	case(ALU_OP)
	0:
	//right shift
		begin
			Result <= (Y<<shamt[4:0]);
			Result2 <= 0;
		end
	1:
	//right arithmetic shift
		begin
			Result <= shift_y ;
			Result2 <= 0 ;
		end
	2:
	//right logical shift
		begin
			Result <= (Y>>shamt[4:0]);
			Result2 <= 0;
		end
	3:
	//usigned multiply
		begin
			{Result2,Result} <= $signed(X) * $signed(Y);
		end
	4:
	//unsigned divider
		begin
			Result <= (X/Y);
			Result2 <= (X%Y);
		end
	5:
	//add
		begin
			Result <= (X+Y);
		end
	6:
	//sub
		begin
			Result <= (X-Y);
		end
	7:
	//&
		begin
			Result <=(X&Y);
		end
	8:
	//|
		begin            
			Result <= X | Y;
		end
	9:
	//^
		begin            
			Result <= X ^ Y;
		end
	10:
	//XOR
		begin            
			Result <= ~(X | Y);
		end
	11:
	//signed compare
		begin
			Result <= ($signed(X) < $signed(Y))? 1 : 0;
		end
	12:
	//unsigned compare
		begin            
			Result <= (X < Y)? 1 : 0;
		end
	endcase
end

endmodule




















