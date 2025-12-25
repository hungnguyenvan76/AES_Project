`timescale 1ns / 1ps

module Encrypt_Iterative_tb;

    reg clk;
    reg rst;
    reg start;

    // AES-128
    reg  [127:0] pt128;
    reg  [127:0] key128;
    wire [127:0] ct128;
    wire done128;
    reg  [127:0] exp_ct128;

    // AES-192
    reg  [127:0] pt192;
    reg  [191:0] key192;
    wire [127:0] ct192;
    wire done192;
    reg  [127:0] exp_ct192;

    // AES-256
    reg  [127:0] pt256;
    reg  [255:0] key256;
    wire [127:0] ct256;
    wire done256;
    reg  [127:0] exp_ct256;

    Encrypt_Iterative #(128, 10, 4) dut128 (
        .clk(clk), .rst(rst), .start(start),
        .in(pt128), .key(key128), .out(ct128), .done(done128)
    );

    Encrypt_Iterative #(192, 12, 6) dut192 (
        .clk(clk), .rst(rst), .start(start),
        .in(pt192), .key(key192), .out(ct192), .done(done192)
    );

    Encrypt_Iterative #(256, 14, 8) dut256 (
        .clk(clk), .rst(rst), .start(start),
        .in(pt256), .key(key256), .out(ct256), .done(done256)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("==============================================================");
        $display("              AES ITERATIVE ENCRYPTION TEST");
        $display("==============================================================\n");

        rst = 1; start = 0;
        pt128 = 0; key128 = 0;
        pt192 = 0; key192 = 0;
        pt256 = 0; key256 = 0;

        pt128      = 128'h3243f6a8_885a308d_313198a2_e0370734;
        key128     = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;
        exp_ct128  = 128'h3925841d_02dc09fb_dc118597_196a0b32;

        pt192      = 128'h3243f6a8_885a308d_313198a2_e0370734;
        key192     = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
        exp_ct192  = 128'hbc3aaab5_d97baa7b_325d7b8f_69cd7ca8;

        pt256      = 128'h3243f6a8_885a308d_313198a2_e0370734;
        key256     = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
        exp_ct256  = 128'h9a198830_ff9a4e39_ec150154_7d4a6b1b;

        #20 rst = 0; #10;
        start = 1;

        // ================= AES-128 (NIST Vector) =================
        wait(done128);
        $display(">> AES-128 Encryption");
        $display("--------------------------------------------------------------");
        $display(" Plaintext          : %032h", pt128);
        $display(" Key                : %032h", key128);
        $display(" Ciphertext (DUT)   : %032h", ct128);
        $display(" Expected Ciphertext: %032h", exp_ct128);
        $display(" Result             : %s", (ct128 == exp_ct128) ? "PASS" : "FAIL");
        $display("");

        // ================= AES-192 =================
        wait(done192);
        $display(">> AES-192 Encryption");
        $display("--------------------------------------------------------------");
        $display(" Plaintext          : %032h", pt192);
        $display(" Key                : %048h", key192);
        $display(" Ciphertext (DUT)   : %032h", ct192);
        $display(" Expected Ciphertext: %032h", exp_ct192);
        $display(" Result             : %s", (ct192 == exp_ct192) ? "PASS" : "FAIL");
        $display("");

        // ================= AES-256 =================
        wait(done256);
        $display(">> AES-256 Encryption");
        $display("--------------------------------------------------------------");
        $display(" Plaintext          : %032h", pt256);
        $display(" Key                : %064h", key256);
        $display(" Ciphertext (DUT)   : %032h", ct256);
        $display(" Expected Ciphertext: %032h", exp_ct256);
        $display(" Result             : %s", (ct256 == exp_ct256) ? "PASS" : "FAIL");
        $display("");

        $display("==============================================================");
        $display("                ENCRYPTION TEST COMPLETED");
        $display("==============================================================");
        #20;
        $finish;
    end

endmodule