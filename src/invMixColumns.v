`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2025 06:31:50 PM
// Design Name: 
// Module Name: invMixColumns
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


module invMixColumns(state_in, state_out);

input  [127:0] state_in;
output [127:0] state_out;

function [7:0] multiply(input[7:0] x, input integer n); // multipy by 2 n times;
integer i;
begin
    for (i=0; i<n; i=i+1) begin
        if (x[7] == 1)
            x = (x << 1) ^ 8'h1b;
        else x = x << 1;
    end
    multiply = x;
end
endfunction

function [7:0] mb0e(input[7:0] x); // multiply by {0e};
    mb0e = multiply(x, 3) ^ multiply(x, 2) ^ multiply(x, 1);
endfunction

function [7:0] mb0b(input[7:0] x); // multiply by {0b};
    mb0b = multiply(x, 3) ^ multiply(x, 1) ^ x;
endfunction

function [7:0] mb0d(input[7:0] x); // multiply by {0d};
    mb0d = multiply(x, 3) ^ multiply(x, 2) ^ x;
endfunction

function [7:0] mb09(input[7:0] x); // multiply by {09};
    mb09 = multiply(x, 3) ^ x;
endfunction

genvar i;

generate
    for (i=0; i<4; i=i+1) begin : mcol // tạo định danh cho từng khối mcol[0], mcol[1],..
        assign state_out[32*i+24 +:8] = mb0e(state_in[32*i+24 +:8]) ^ mb0b(state_in[32*i+16 +:8]) ^ mb0d(state_in[32*i+8 +:8]) ^ mb09(state_in[32*i +:8]);
        assign state_out[32*i+16 +:8] = mb09(state_in[32*i+24 +:8]) ^ mb0e(state_in[32*i+16 +:8]) ^ mb0b(state_in[32*i+8 +:8]) ^ mb0d(state_in[32*i +:8]);
        assign state_out[32*i+8  +:8] = mb0d(state_in[32*i+24 +:8]) ^ mb09(state_in[32*i+16 +:8]) ^ mb0e(state_in[32*i+8 +:8]) ^ mb0b(state_in[32*i +:8]);
        assign state_out[32*i    +:8] = mb0b(state_in[32*i+24 +:8]) ^ mb0d(state_in[32*i+16 +:8]) ^ mb09(state_in[32*i+8 +:8]) ^ mb0e(state_in[32*i +:8]);
    end
endgenerate

endmodule

