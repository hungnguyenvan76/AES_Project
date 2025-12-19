`timescale 1ns / 1ps

module invSubBytes(in, out);

input[127:0]  in;
output[127:0] out;
genvar i;

generate
for (i=0; i<128; i=i+8) begin : invSubByte
    invSbox s(in[i +:8], out[i +:8]);
end
endgenerate

endmodule
