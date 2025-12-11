`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2025 08:11:40 PM
// Design Name: 
// Module Name: invSubBytes
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


module invSubBytes(in, out);

input[127:0]  in;
output[127:0] out;
genvar i;

generate
for (i=0; i<128;i=i+8) begin : invSubByte
    invSbox s(in[i +:8], out[i +:8]);
end
endgenerate

endmodule
