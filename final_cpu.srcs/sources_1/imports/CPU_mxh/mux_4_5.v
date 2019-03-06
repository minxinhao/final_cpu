module mux_4_5(input [1:0] choose,input [4:0] data1,input [4:0] data2,input [4:0] data3,input [4:0] data4,output [4:0] out);
    reg [4:0] tmp;
    always @(*) begin
        case(choose)
            0:begin
                tmp = data1;
            end
            1:begin
                tmp = data2;
            end
            2:begin
                tmp = data3;
            end
            3:begin
                tmp = data4;
            end
      endcase
    end
    assign out = tmp;
endmodule