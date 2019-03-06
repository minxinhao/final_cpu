`timescale 1ns / 1ps
 
// ������
module counter
#(
	parameter DATA_BITS = 16,
	parameter MAX_VALUE = 1 // counter�ﵽmax_valueʱ������Ϊ0
)
(
	input [DATA_BITS-1:0] data,
	input clear, // ֵΪ1ʱ�� ��counter����Ϊ0
	input load,	// ֵΪ1ʱ�� ��data���������뵽counter
	input count, // ֵΪ1ʱ�� counter����
	input clk, // ʱ�ӣ� ��������Ч
	input halt, //ֵΪ1ʱ������ʱ�����롣
	output reg [DATA_BITS-1:0] out, // �����ǰcounter��ֵ
	output reg carry // counter�ﵽmax_valueʱ�����Ϊ1
);

reg [DATA_BITS-1:0] counter;

initial begin
	counter = 0;
end

always @ (posedge clk) begin
    if(clear)begin
        counter = 0;
      end
	else if(halt) begin
		if (load) begin
			counter = data;
		end
		else if (count) begin
			if (counter == MAX_VALUE) begin
				counter = 0;
			end
			else begin
				counter = counter + 1;
			end
		end
	end
end

always @ (*) begin
	if (counter == MAX_VALUE) begin
		carry = 1;
	end
	else begin
		carry = 0;
	end
	out = counter;
end

endmodule