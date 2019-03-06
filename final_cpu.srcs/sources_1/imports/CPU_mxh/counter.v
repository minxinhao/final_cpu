//enable 为1时停机,信号给到enable，rst为1时清0

module counter(input clk,input enable,input rst,output [15:0] out);
    reg [15:0] num;
    initial begin num <= 0; end
    always @ (posedge clk) begin
        if(rst)
            num <= 16'b0;
        else if(enable == 1)
            num <= num + 1;
        end
    assign out = num;
endmodule

module three_counter(input clk, input rst, input jmp, input branch, input halt, input go, input pause, 
                output [15:0]unconditional_branch_number, 
                output [15:0]branch_succeeded_number,
                output [15:0]period_number);
    counter c1(clk, jmp, rst, unconditional_branch_number);
    counter c2(clk, branch, rst, branch_succeeded_number);
    wire temp;
    assign temp = ~(halt | go | pause);
    counter c3(clk, temp, rst, period_number);
endmodule
