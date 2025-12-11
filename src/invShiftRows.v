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
input [127:0] in;
output[127:0] out;

// Hàng đầu (r = 0) không dịch
assign out[127-:8] = in[127-:8]; // col0
assign out[95-:8]  = in[95-:8];  // col1
assign out[63-:8]  = in[63-:8];  // col2
assign out[31-:8]  = in[31-:8];  // col3

// Hàng thứ 2 (r = 1) dịch phải 1 byte
assign out[119-:8] = in[23-:8];
assign out[87-:8]  = in[119-:8];
assign out[55-:8]  = in[87-:8];
assign out[23-:8]  = in[55-:8];

// Hàng thứ 3 (r = 1) dịch phải 2 byte
assign out[111-:8] = in[47-:8];
assign out[79-:8]  = in[15-:8];
assign out[47-:8]  = in[111-:8];
assign out[15-:8]  = in[79-:8];

// Hàng thứ 4 (r = 1) dịch phải 3 byte
assign out[103-:8] = in[71-:8];
assign out[71-:8]  = in[39-:8];
assign out[39-:8]  = in[7-:8];
assign out[7-:8]   = in[103-:8];

endmodule
