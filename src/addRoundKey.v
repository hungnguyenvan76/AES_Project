`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 9/2/2025 07:13:00 PM
// Design Name: 
// Module Name: addRoundKey
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


module addRoundKey(data, key, out);

    input  [127:0] data;
    input  [127:0] key;
    output [127:0] out;
    
    assign out = key ^ data;

endmodule
