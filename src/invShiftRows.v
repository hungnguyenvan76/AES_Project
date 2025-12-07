`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2025 08:43:23 PM
// Design Name: 
// Module Name: invShiftRows
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


module invShiftRows(in, out);
input[127:0] in;
output[127:0] out;

// Hàng đầu (r = 0) không dịch
assign out [0+:8]  = in[0+:8];
assign out [32+:8] = in[32+:8];
assign out [64+:8] = in[64+:8];
assign out [96+:8] = in[96+:8];

// Hàng thứ 2 (r = 1) dịch phải 1 byte
assign out [8+:8]   = in[104+:8];
assign out [40+:8]  = in[8+:8];
assign out [72+:8]  = in[40+:8];
assign out [104+:8] = in[72+:8];

// Hàng thứ 3 (r = 1) dịch phải 2 byte
assign out [16+:8]  = in[80+:8];
assign out [48+:8]  = in[112+:8];
assign out [80+:8]  = in[16+:8];
assign out [112+:8] = in[48+:8];

// Hàng thứ 4 (r = 1) dịch phải 3 byte
assign out [24+:8]  = in[56+:8];
assign out [56+:8]  = in[88+:8];
assign out [88+:8]  = in[120+:8];
assign out [120+:8] = in[24+:8];

endmodule
