`timescale 1ns / 1ps

module subBytes(in, out);

input   [127:0] in;
output  [127:0] out;

genvar i;
generate
    for(i = 0; i < 128; i = i+8) begin: sub_bytes
    sBox s(in[i+7:i], out[i+7:i]);
    end
endgenerate

endmodule
