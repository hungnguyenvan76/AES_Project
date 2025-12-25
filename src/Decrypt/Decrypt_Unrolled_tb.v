`timescale 1ns / 1ps

module Decrypt_Unrolled_tb;

// ===== AES-128 =====
reg  [127:0] ct128;
reg  [127:0] key128;
wire [127:0] pt128;
reg  [127:0] exp_pt128;

// ===== AES-192 =====
reg  [127:0] ct192;
reg  [191:0] key192;
wire [127:0] pt192;
reg  [127:0] exp_pt192;

// ===== AES-256 =====
reg  [127:0] ct256;
reg  [255:0] key256;
wire [127:0] pt256;
reg  [127:0] exp_pt256;

// ===== DUT =====
AES_Decrypt              dec128 (ct128, key128, pt128);
AES_Decrypt #(192,12,6)  dec192 (ct192, key192, pt192);
AES_Decrypt #(256,14,8)  dec256 (ct256, key256, pt256);

initial begin
    $display("==============================================================");
    $display("              AES UNROLLED DECRYPTION TEST");
    $display("==============================================================\n");

    // ================= AES-128 =================
    ct128      = 128'h3925841d_02dc09fb_dc118597_196a0b32;
    key128     = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;
    exp_pt128  = 128'h3243f6a8_885a308d_313198a2_e0370734;
    #10;

    $display(">> AES-128 Decryption (NIST)");
    $display("--------------------------------------------------------------");
    $display(" Ciphertext (Input) : %032h", ct128);
    $display(" Key                : %032h", key128);
    $display(" Plaintext (DUT)    : %032h", pt128);
    $display(" Expected Plaintext : %032h", exp_pt128);
    $display(" Result             : %s",
                (pt128 == exp_pt128) ? "PASS" : "FAIL");
    $display("");

    // ================= AES-192 =================
    ct192      = 128'hbc3aaab5_d97baa7b_325d7b8f_69cd7ca8;
    key192     = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
    exp_pt192  = 128'h3243f6a8_885a308d_313198a2_e0370734;
    #10;

    $display(">> AES-192 Decryption");
    $display("--------------------------------------------------------------");
    $display(" Ciphertext (Input) : %032h", ct192);
    $display(" Key                : %048h", key192);
    $display(" Plaintext (DUT)    : %032h", pt192);
    $display(" Expected Plaintext : %032h", exp_pt192);
    $display(" Result             : %s",
                (pt192 == exp_pt192) ? "PASS" : "FAIL");
    $display("");

    // ================= AES-256 =================
    ct256      = 128'h9a198830_ff9a4e39_ec150154_7d4a6b1b;
    key256     = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
    exp_pt256  = 128'h3243f6a8_885a308d_313198a2_e0370734;
    #10;

    $display(">> AES-256 Decryption");
    $display("--------------------------------------------------------------");
    $display(" Ciphertext (Input) : %032h", ct256);
    $display(" Key                : %064h", key256);
    $display(" Plaintext (DUT)    : %032h", pt256);
    $display(" Expected Plaintext : %032h", exp_pt256);
    $display(" Result             : %s",
                (pt256 == exp_pt256) ? "PASS" : "FAIL");
    $display("");

    $display("==============================================================");
    $display("                DECRYPTION TEST COMPLETED");
    $display("==============================================================");

    $finish;
end

endmodule
