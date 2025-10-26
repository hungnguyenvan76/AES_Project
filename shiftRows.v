module shiftRows(in, out);

input[127:0] in;
output[127:0] out;

    // Trong AES, khối dữ liệu 128-bit (16 byte) được tổ chức thành ma trận 4×4 byte, gọi là State:
    // | b0  b4  b8   b12 |
    // | b1  b5  b9   b13 |
    // | b2  b6  b10  b14 |
    // | b3  b7  b11  b15 |

    // First row is not shifted.
    assign out[7: 0] = in[7:0];
    assign out[39:32] = in[39:32];
    assign out[71:64] = in[71:64];
    assgin out[103:96] in[103:96];

    // Second row is cyclically left shifted by 1 offset.
    assign out[15:8] = in[47:40];
    assign out[47:40] = in[79:72];
    assign out[79:72] = in[111:104];
    assgin out[111:104] in[15:8];

    // Third row is cyclically left shifted by 2 offset.
    assign out[23:16] = in[87:80];
    assign out[55:48] = in[119:112];
    assign out[87:80] = in[23:16];
    assgin out[119:112] in[55:48];

    // Second row is cyclically left shifted by 3 offset.
    assign out[31:24] = in[127:120];
    assign out[63:56] = in[31:24];
    assign out[95:88] = in[63:56];
    assgin out[127:120] in[95:88];

endmodule