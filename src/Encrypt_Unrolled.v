`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/4/2025 07:14:17 PM
// Design Name: 
// Module Name: AES_Encrypt
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Encrypt_Unrolled #(parameter N = 128, parameter Nr = 10, Nk = 4) (in, key, out);

input [127:0] in;
input [N-1:0] key;
output[127:0] out;

wire  [127:0] afterSubBytes;
wire  [127:0] afterShiftRows;
wire  [127:0] state [Nr:0]; // Nr+1 state

wire  [128*(Nr+1)-1:0] keySched;

keyExpansion #(Nk, Nr) k (key, keySched);

addRoundKey ark1 (in, keySched[(128*(Nr+1)-1) -:128], state[0]);

genvar i;
generate

for (i=1; i<Nr; i=i+1) begin : loop
    encryptRound eR (state[i-1], keySched[((128*(Nr+1)-1)-128*i) -: 128], state[i]);
end

subBytes    s     (state[Nr-1], afterSubBytes);
shiftRows   r     (afterSubBytes, afterShiftRows);
addRoundKey arkNr (afterShiftRows, keySched[127:0], state[Nr]);

assign out = state[Nr];

endgenerate

endmodule