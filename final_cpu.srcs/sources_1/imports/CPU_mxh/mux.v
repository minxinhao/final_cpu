module mux(input choose,input [31:0] data1,input [31:0] data2,output [31:0] out);
    reg [31:0] tmp;
    always @(*) 
    begin
        if(choose == 0)
            tmp = data1;
         else
            tmp = data2;
    end
    assign out = tmp;
endmodule
module mux_2_5(input choose,input [4:0] data1,input [4:0] data2,output [4:0] out);
    reg [4:0] tmp;
    always @(*) 
    begin
        if(choose == 0)
            tmp = data1;
         else
            tmp = data2;
    end
    assign out = tmp;
endmodule