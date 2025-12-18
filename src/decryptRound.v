module decryptRound(in, key, out);

input  [127:0] in;
input  [127:0] key;
output [127:0] out;

wire [127:0] afterInvShiftRows;
wire [127:0] afterInvSubBytes;
wire [127:0] afterAddroundKey;

invShiftRows    isr(in, afterInvShiftRows);
invSubBytes     isb(afterInvShiftRows, afterInvSubBytes);
addRoundKey     ark(afterInvSubBytes, key, afterAddroundKey);
invMixCollumns  mc(afterAddroundKey, out);

endmodule