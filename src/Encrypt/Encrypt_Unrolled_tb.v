`timescale 1ns / 1ps

module AES_Encrypt_tb;

// ====== AES-128 ======
reg  [127:0] pt128;
reg  [127:0] key128;
wire [127:0] ct128;
reg  [127:0] exp_ct128;

// ====== AES-192 ======
reg  [127:0] pt192;
reg  [191:0] key192;
wire [127:0] ct192;
reg  [127:0] exp_ct192;

// ====== AES-256 ======
reg  [127:0] pt256;
reg  [255:0] key256;
wire [127:0] ct256;
reg  [127:0] exp_ct256;

// ====== DUT ======
Encrypt_Unrolled              aes128 (pt128, key128, ct128);
Encrypt_Unrolled #(192,12,6)  aes192 (pt192, key192, ct192);
Encrypt_Unrolled #(256,14,8)  aes256 (pt256, key256, ct256);

initial begin
    $display("==============================================================");
    $display("              AES UNROLLED ENCRYPTION TEST");
    $display("==============================================================\n");

    // ================= AES-128 =================
    pt128      = 128'h3243f6a8_885a308d_313198a2_e0370734;
    key128     = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;
    exp_ct128  = 128'h3925841d_02dc09fb_dc118597_196a0b32;
    #10;

    $display(">> AES-128 Encryption (NIST)");
    $display("--------------------------------------------------------------");
    $display(" Plaintext          : %032h", pt128);
    $display(" Key                : %032h", key128);
    $display(" Ciphertext (DUT)   : %032h", ct128);
    $display(" Expected Ciphertext: %032h", exp_ct128);
    $display(" Result             : %s",
                (ct128 == exp_ct128) ? "PASS" : "FAIL");
    $display("");

    // ================= AES-192 =================
    pt192      = 128'h3243f6a8_885a308d_313198a2_e0370734;
    key192     = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
    exp_ct192  = 128'hbc3aaab5_d97baa7b_325d7b8f_69cd7ca8;
    #10;

    $display(">> AES-192 Encryption");
    $display("--------------------------------------------------------------");
    $display(" Plaintext          : %032h", pt192);
    $display(" Key                : %048h", key192);
    $display(" Ciphertext (DUT)   : %032h", ct192);
    $display(" Expected Ciphertext: %032h", exp_ct192);
    $display(" Result             : %s",
                (ct192 == exp_ct192) ? "PASS" : "FAIL");
    $display("");

    // ================= AES-256 =================
    pt256      = 128'h3243f6a8_885a308d_313198a2_e0370734;
    key256     = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
    exp_ct256  = 128'h9a198830_ff9a4e39_ec150154_7d4a6b1b;
    #10;

    $display(">> AES-256 Encryption");
    $display("--------------------------------------------------------------");
    $display(" Plaintext          : %032h", pt256);
    $display(" Key                : %064h", key256);
    $display(" Ciphertext (DUT)   : %032h", ct256);
    $display(" Expected Ciphertext: %032h", exp_ct256);
    $display(" Result             : %s",
                (ct256 == exp_ct256) ? "PASS" : "FAIL");
    $display("");

    $display("==============================================================");
    $display("                ENCRYPTION TEST COMPLETED");
    $display("==============================================================");

    $finish;
end

endmodule
