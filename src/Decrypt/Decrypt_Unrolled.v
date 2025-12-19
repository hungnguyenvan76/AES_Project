`timescale 1ns / 1ps

module AES_Decrypt #(parameter N = 128, parameter Nr = 10, Nk = 4) (in, key, out);

input [127:0] in;
input [N-1:0] key;
output[127:0] out;

wire [127:0] states [0: Nr-1];
wire [128*(Nr+1)-1:0] keySched;

keyExpansion #(Nk, Nr) ke(key, keySched);

addRoundKey ark1(in, keySched[127:0], states[0]);

genvar i;
generate
    for(i = 1; i < Nr; i=i+1) begin: loop
        decryptRound dR(states[i-1], keySched[128*i +: 128], states[i]);
    end
endgenerate

wire [127:0] afterShift;
wire [127:0] afterSub;

invShiftRows isr(states[Nr-1], afterShift);
invSubBytes  isb(afterShift, fterSubBytes);
addRoundKey  ark2(afterSub, keySched[(128*(Nr+1)-1) -: 128], out);

endmodule