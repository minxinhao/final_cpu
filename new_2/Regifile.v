
module Regifile(
	input	[31:0] Din,
	input	clk,
	input	WE,
	input	[4:0] WR,
	input	[4:0] R1,
	input	[4:0] R2,
	output	[31:0] data1,
	output	[31:0] data2
	);
	reg	[31:0] MyMen [31:0];
	integer i;
	
	initial begin
		for(i = 0; i < 32; i = i + 1)
			MyMen[i] = 0;
	end
	
	assign data1 = MyMen[R1];
    assign data2 = MyMen[R2];
	
	always @(negedge clk ) begin
		  if(WE == 1&&WR!=0)
              begin
                  MyMen[WR] = Din;
              end
          else ;
	end
endmodule
