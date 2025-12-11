`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/1/2025 06:35:30 PM
// Design Name: 
// Module Name: encryptRound
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


module encryptRound(in, key, out);
    input  [127:0] in;
    output [127:0] out;
    input  [127:0] key;
    wire   [127:0] afterSubBytes;
    wire   [127:0] afterShiftRows;
    wire   [127:0] afterMixColumns;
    wire   [127:0] afterAddroundKey;
    
    subBytes s(in,afterSubBytes);
    shiftRows r(afterSubBytes,afterShiftRows);
    mixColumns m(afterShiftRows,afterMixColumns);
    addRoundKey b(afterMixColumns,out,key);
		
endmodule
