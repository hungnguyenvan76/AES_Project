`timescale 1ns / 1ps

module encryptRound(in, key, out);

    input  [127:0] in;
    input  [127:0] key;
    output [127:0] out;

    wire   [127:0] afterSubBytes;
    wire   [127:0] afterShiftRows;
    wire   [127:0] afterMixColumns;
    wire   [127:0] data_before_addkey;

    subBytes    s(in, afterSubBytes);
    shiftRows   r(afterSubBytes, afterShiftRows);
    mixColumns  m(afterShiftRows, afterMixColumns);
    addRoundKey b(afterMixColumns, key, out);
		
endmodule