`timescale 1ns / 1ps

module syscall( input [31:0]r1,mwdata,input clk,rst,sys,
output [31:0]LedData,output led,halt,pause );  //?reg类型的信号？
reg [31:0]data;
//reg led1,halt1,pause

initial begin
    data=0;
end
assign LedData = data;
assign led = (r1==34 && sys == 1);
assign halt = (r1==10 && sys == 1);
assign pause = (sys == 1 && led==0 && halt==0);

always@(posedge clk or posedge rst)
  begin
    if(rst) data=0;
    else begin
      if(led) begin
        data = mwdata;
      end
    end
  end 
endmodule
