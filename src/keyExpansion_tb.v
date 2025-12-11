`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/2/2025 07:24:12 PM
// Design Name: 
// Module Name: keyExpansion_tb
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

module keyExpansion_tb;

    reg [127:0] k1;
    wire [1407:0] out1;
    
    reg [191:0] k2;
    wire [1663:0] out2;
    
    reg [255:0] k3;
    wire [1919:0] out3;

    // default AES-128
    keyExpansion ks(k1, out1);

    // AES-192: Nk = 6, Nr = 12
    keyExpansion #(6, 12) ks2(k2, out2);

    // AES-256: Nk = 8, Nr = 14
    keyExpansion #(8, 14) ks3(k3, out3);

    initial begin
        // Test AES-128
        k1 = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;
        #10;
        $display("======= AES-128 =======");
        $display("Key128   = %h", k1);
        $display("Out128   = %h", out1);
        
        // Test AES-192
        k2 = 192'h00010203_04050607_08090a0b_0c0d0e0f_10111213_14151617;
        #10;
        $display("======= AES-192 =======");
        $display("Key192   = %h", k2);
        $display("Out192   = %h", out2);

        // Test AES-256
        k3 = 256'h00010203_04050607_08090a0b_0c0d0e0f_10111213_14151617_18191a1b_1c1d1e1f;
        #10;
        $display("======= AES-256 =======");
        $display("Key256   = %h", k3);
        $display("Out256   = %h", out3);

        #10 $finish;
    end
    
endmodule

