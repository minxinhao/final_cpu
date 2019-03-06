`timescale 1ns / 1ps

module sign_ex_16to32( input [15:0] data_16bit, output [31:0] data_32bit
    );
   assign data_32bit = {{16{data_16bit[15]}},data_16bit};
endmodule

module zero_ex_16to32(input [15:0] data_16bit,output [31:0] data_32bit);
  assign data_32bit = { {16{1'b0}},data_16bit};
endmodule
