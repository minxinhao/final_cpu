///////////////////////////////////////
// 二路选择器
// 输入两个数据，数据宽度由SIZE决定
//////////////////////////////////////
module MUX_2(select,din0,din1,dout);
	parameter SIZE=32;	
	input	select;	//输出选择，为0输出din0，为1输出din1
	input	[SIZE-1:0] din0,din1;
	output	reg	[SIZE-1:0] dout;
	
	initial	dout=0;
	
	always @(*) begin
			case(select)
			0: dout=din0;
			1: dout=din1;
			endcase
	end
endmodule

///////////////////////////////////////
// 四路选择器
// 输入四个数据，数据宽度由SIZE决定
//////////////////////////////////////
module MUX_4(select,din0,din1,din2,din3,dout);
	parameter SIZE=32;	
	input	[1:0] select;	//输出选择，为0输出din0，为1输出din1
	input	[SIZE-1:0] din0,din1,din2,din3;
	output	reg	[SIZE-1:0] dout;
	
	initial	dout=0;
	
	always @(*) begin
			case(select)
			2'b00: dout=din0;
			2'b01: dout=din1;
			2'b10: dout=din2;
			2'b11: dout=din3;
			endcase
	end
endmodule