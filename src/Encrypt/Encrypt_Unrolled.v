`timescale 1ns / 1ps

module Encrypt_Unrolled #(parameter N = 128, parameter Nr = 10, parameter Nk = 4) (in, key, out);

input [127:0] in;
input [N-1:0] key;
output[127:0] out;

wire  [127:0] afterSubBytes;
wire  [127:0] afterShiftRows;
wire  [127:0] state [Nr:0]; // Nr+1 states

wire  [128*(Nr+1)-1:0] keySched;

keyExpansion #(Nk, Nr) k (key, keySched);

addRoundKey ark1 (in, keySched[(128*(Nr+1)-1) -:128], state[0]);

genvar i;
generate

    for(i = 1; i < Nr; i = i+1) begin: ErU_loop
        encryptRound eR (state[i-1], keySched[((128*(Nr+1)-1)-128*i) -: 128], state[i], 1'b0);
    end

    subBytes    s     (state[Nr-1], afterSubBytes);
    shiftRows   r     (afterSubBytes, afterShiftRows);
    addRoundKey arkNr (afterShiftRows, keySched[127:0], state[Nr]);

assign out = state[Nr];

endgenerate

endmodule