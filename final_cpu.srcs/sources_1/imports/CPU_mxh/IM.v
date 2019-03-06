`timescale 1ns / 1ps
module IM( input[31:0] addr,output[31:0]dout);
 reg [31:0]im_mem[1023:0];

initial
    begin
im_mem[0] = 32'h20110001;
im_mem[1] = 32'h08000c05;
im_mem[2] = 32'h20110001;
im_mem[3] = 32'h20120002;
im_mem[4] = 32'h20130003;
im_mem[5] = 32'h08000c09;
im_mem[6] = 32'h20110001;
im_mem[7] = 32'h20120002;
im_mem[8] = 32'h20130003;
im_mem[9] = 32'h08000c0d;
im_mem[10] = 32'h20110001;
im_mem[11] = 32'h20120002;
im_mem[12] = 32'h20130003;
im_mem[13] = 32'h08000c11;
im_mem[14] = 32'h20110001;
im_mem[15] = 32'h20120002;
im_mem[16] = 32'h20130003;
im_mem[17] = 32'h0c000cf8;
im_mem[18] = 32'h20100001;
im_mem[19] = 32'h20110001;
im_mem[20] = 32'h00118fc0;
im_mem[21] = 32'h00112020;
im_mem[22] = 32'h20020022;
im_mem[23] = 32'h0000000c;
im_mem[24] = 32'h00118882;
im_mem[25] = 32'h12200001;
im_mem[26] = 32'h08000c15;
im_mem[27] = 32'h00112020;
im_mem[28] = 32'h20020022;
im_mem[29] = 32'h0000000c;
im_mem[30] = 32'h20110001;
im_mem[31] = 32'h00118880;
im_mem[32] = 32'h00112020;
im_mem[33] = 32'h20020022;
im_mem[34] = 32'h0000000c;
im_mem[35] = 32'h12200001;
im_mem[36] = 32'h08000c1f;
im_mem[37] = 32'h20110001;
im_mem[38] = 32'h00118fc0;
im_mem[39] = 32'h00112020;
im_mem[40] = 32'h20020022;
im_mem[41] = 32'h0000000c;
im_mem[42] = 32'h001188c3;
im_mem[43] = 32'h00112020;
im_mem[44] = 32'h20020022;
im_mem[45] = 32'h0000000c;
im_mem[46] = 32'h00118903;
im_mem[47] = 32'h00112020;
im_mem[48] = 32'h20020022;
im_mem[49] = 32'h0000000c;
im_mem[50] = 32'h00118903;
im_mem[51] = 32'h00112020;
im_mem[52] = 32'h20020022;
im_mem[53] = 32'h0000000c;
im_mem[54] = 32'h00118903;
im_mem[55] = 32'h00112020;
im_mem[56] = 32'h20020022;
im_mem[57] = 32'h0000000c;
im_mem[58] = 32'h00118903;
im_mem[59] = 32'h00112020;
im_mem[60] = 32'h20020022;
im_mem[61] = 32'h0000000c;
im_mem[62] = 32'h00118903;
im_mem[63] = 32'h00112020;
im_mem[64] = 32'h20020022;
im_mem[65] = 32'h0000000c;
im_mem[66] = 32'h00118903;
im_mem[67] = 32'h00112020;
im_mem[68] = 32'h20020022;
im_mem[69] = 32'h0000000c;
im_mem[70] = 32'h00118903;
im_mem[71] = 32'h00112020;
im_mem[72] = 32'h20020022;
im_mem[73] = 32'h0000000c;
im_mem[74] = 32'h20100001;
im_mem[75] = 32'h00109fc0;
im_mem[76] = 32'h00139fc3;
im_mem[77] = 32'h00008021;
im_mem[78] = 32'h2012000c;
im_mem[79] = 32'h24160003;
im_mem[80] = 32'h26100001;
im_mem[81] = 32'h3210000f;
im_mem[82] = 32'h20080008;
im_mem[83] = 32'h20090001;
im_mem[84] = 32'h00139900;
im_mem[85] = 32'h02709825;
im_mem[86] = 32'h00132020;
im_mem[87] = 32'h20020022;
im_mem[88] = 32'h0000000c;
im_mem[89] = 32'h01094022;
im_mem[90] = 32'h1500fff9;
im_mem[91] = 32'h22100001;
im_mem[92] = 32'h2018000f;
im_mem[93] = 32'h02188024;
im_mem[94] = 32'h00108700;
im_mem[95] = 32'h20080008;
im_mem[96] = 32'h20090001;
im_mem[97] = 32'h00139902;
im_mem[98] = 32'h02709825;
im_mem[99] = 32'h00132021;
im_mem[100] = 32'h20020022;
im_mem[101] = 32'h0000000c;
im_mem[102] = 32'h01094022;
im_mem[103] = 32'h1500fff9;
im_mem[104] = 32'h00108702;
im_mem[105] = 32'h02c9b022;
im_mem[106] = 32'h12c00001;
im_mem[107] = 32'h08000c50;
im_mem[108] = 32'h00004020;
im_mem[109] = 32'h01084027;
im_mem[110] = 32'h00084400;
im_mem[111] = 32'h3508ffff;
im_mem[112] = 32'h00082021;
im_mem[113] = 32'h20020022;
im_mem[114] = 32'h0000000c;
im_mem[115] = 32'h2010ffff;
im_mem[116] = 32'h20110000;
im_mem[117] = 32'hae300000;
im_mem[118] = 32'h22100001;
im_mem[119] = 32'h22310004;
im_mem[120] = 32'hae300000;
im_mem[121] = 32'h22100001;
im_mem[122] = 32'h22310004;
im_mem[123] = 32'hae300000;
im_mem[124] = 32'h22100001;
im_mem[125] = 32'h22310004;
im_mem[126] = 32'hae300000;
im_mem[127] = 32'h22100001;
im_mem[128] = 32'h22310004;
im_mem[129] = 32'hae300000;
im_mem[130] = 32'h22100001;
im_mem[131] = 32'h22310004;
im_mem[132] = 32'hae300000;
im_mem[133] = 32'h22100001;
im_mem[134] = 32'h22310004;
im_mem[135] = 32'hae300000;
im_mem[136] = 32'h22100001;
im_mem[137] = 32'h22310004;
im_mem[138] = 32'hae300000;
im_mem[139] = 32'h22100001;
im_mem[140] = 32'h22310004;
im_mem[141] = 32'hae300000;
im_mem[142] = 32'h22100001;
im_mem[143] = 32'h22310004;
im_mem[144] = 32'hae300000;
im_mem[145] = 32'h22100001;
im_mem[146] = 32'h22310004;
im_mem[147] = 32'hae300000;
im_mem[148] = 32'h22100001;
im_mem[149] = 32'h22310004;
im_mem[150] = 32'hae300000;
im_mem[151] = 32'h22100001;
im_mem[152] = 32'h22310004;
im_mem[153] = 32'hae300000;
im_mem[154] = 32'h22100001;
im_mem[155] = 32'h22310004;
im_mem[156] = 32'hae300000;
im_mem[157] = 32'h22100001;
im_mem[158] = 32'h22310004;
im_mem[159] = 32'hae300000;
im_mem[160] = 32'h22100001;
im_mem[161] = 32'h22310004;
im_mem[162] = 32'hae300000;
im_mem[163] = 32'h22100001;
im_mem[164] = 32'h22310004;
im_mem[165] = 32'h22100001;
im_mem[166] = 32'h00008020;
im_mem[167] = 32'h2011003c;
im_mem[168] = 32'h8e130000;
im_mem[169] = 32'h8e340000;
im_mem[170] = 32'h0274402a;
im_mem[171] = 32'h11000002;
im_mem[172] = 32'hae330000;
im_mem[173] = 32'hae140000;
im_mem[174] = 32'h2231fffc;
im_mem[175] = 32'h1611fff8;
im_mem[176] = 32'h00102020;
im_mem[177] = 32'h20020022;
im_mem[178] = 32'h0000000c;
im_mem[179] = 32'h22100004;
im_mem[180] = 32'h2011003c;
im_mem[181] = 32'h1611fff2;
im_mem[182] = 32'h20020032;
im_mem[183] = 32'h0000000c;
im_mem[184] = 32'h20080001;
im_mem[185] = 32'h20090003;
im_mem[186] = 32'h20110876;
im_mem[187] = 32'h00118d00;
im_mem[188] = 32'h00112020;
im_mem[189] = 32'h20020022;
im_mem[190] = 32'h0000000c;
im_mem[191] = 32'h200b0008;
im_mem[192] = 32'h01118807;
im_mem[193] = 32'h01318807;
im_mem[194] = 32'h00112020;
im_mem[195] = 32'h20020022;
im_mem[196] = 32'h0000000c;
im_mem[197] = 32'h216bffff;
im_mem[198] = 32'h1560fff9;
im_mem[199] = 32'h2002000a;
im_mem[200] = 32'h0000000c;
im_mem[201] = 32'h2008ffff;
im_mem[202] = 32'h20117777;
im_mem[203] = 32'h00112020;
im_mem[204] = 32'h20020022;
im_mem[205] = 32'h0000000c;
im_mem[206] = 32'h200b0010;
im_mem[207] = 32'h3a31ffff;
im_mem[208] = 32'h00112020;
im_mem[209] = 32'h20020022;
im_mem[210] = 32'h0000000c;
im_mem[211] = 32'h216bffff;
im_mem[212] = 32'h1560fffa;
im_mem[213] = 32'h2002000a;
im_mem[214] = 32'h0000000c;
im_mem[215] = 32'h20090000;
im_mem[216] = 32'h200b0020;
im_mem[217] = 32'h20110000;
im_mem[218] = 32'h20120001;
im_mem[219] = 32'ha1310000;
im_mem[220] = 32'h00112020;
im_mem[221] = 32'h20020022;
im_mem[222] = 32'h0000000c;
im_mem[223] = 32'h02328820;
im_mem[224] = 32'h21290001;
im_mem[225] = 32'h216bffff;
im_mem[226] = 32'h1560fff8;
im_mem[227] = 32'h200b0008;
im_mem[228] = 32'h20090000;
im_mem[229] = 32'h8d310000;
im_mem[230] = 32'h00112020;
im_mem[231] = 32'h20020022;
im_mem[232] = 32'h0000000c;
im_mem[233] = 32'h21290004;
im_mem[234] = 32'h216bffff;
im_mem[235] = 32'h1560fff9;
im_mem[236] = 32'h2002000a;
im_mem[237] = 32'h0000000c;
im_mem[238] = 32'h2011fff1;
im_mem[239] = 32'h00112020;
im_mem[240] = 32'h20020022;
im_mem[241] = 32'h0000000c;
im_mem[242] = 32'h22310001;
im_mem[243] = 32'h1a20fffb;
im_mem[244] = 32'h2002000a;
im_mem[245] = 32'h0000000c;
im_mem[246] = 32'h2002000a;
im_mem[247] = 32'h0000000c;
im_mem[248] = 32'h20100000;
im_mem[249] = 32'h22100001;
im_mem[250] = 32'h00102020;
im_mem[251] = 32'h20020022;
im_mem[252] = 32'h0000000c;
im_mem[253] = 32'h22100002;
im_mem[254] = 32'h00102020;
im_mem[255] = 32'h20020022;
im_mem[256] = 32'h0000000c;
im_mem[257] = 32'h22100003;
im_mem[258] = 32'h00102020;
im_mem[259] = 32'h20020022;
im_mem[260] = 32'h0000000c;
im_mem[261] = 32'h22100004;
im_mem[262] = 32'h00102020;
im_mem[263] = 32'h20020022;
im_mem[264] = 32'h0000000c;
im_mem[265] = 32'h22100005;
im_mem[266] = 32'h00102020;
im_mem[267] = 32'h20020022;
im_mem[268] = 32'h0000000c;
im_mem[269] = 32'h22100006;
im_mem[270] = 32'h00102020;
im_mem[271] = 32'h20020022;
im_mem[272] = 32'h0000000c;
im_mem[273] = 32'h22100007;
im_mem[274] = 32'h00102020;
im_mem[275] = 32'h20020022;
im_mem[276] = 32'h0000000c;
im_mem[277] = 32'h22100008;
im_mem[278] = 32'h00102020;
im_mem[279] = 32'h20020022;
im_mem[280] = 32'h20020022;
im_mem[281] = 32'h0000000c;
im_mem[282] = 32'h03e00008;
end
 
 //wire [9:0] addr1 = {0,0,addr[9:2]};
 assign dout = im_mem[addr[11:2]]; //最高两位是0
endmodule
