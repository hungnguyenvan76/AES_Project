`timescale 1ns / 1ps

module encryptRound(in, key, out, is_last_round);

    input  [127:0] in;
    input  [127:0] key;
    output [127:0] out;
    input is_last_round;

    wire   [127:0] afterSubBytes;
    wire   [127:0] afterShiftRows;
    wire   [127:0] afterMixColumns;
    wire   [127:0] data_before_addkey;

    subBytes    s(in, afterSubBytes);
    shiftRows   r(afterSubBytes, afterShiftRows);
    mixColumns  m(afterShiftRows, afterMixColumns);

    assign data_before_addkey = (is_last_round == 1'b1) ? afterShiftRows : afterMixColumns;

    addRoundKey b(data_before_addkey, key, out);
		
endmodule