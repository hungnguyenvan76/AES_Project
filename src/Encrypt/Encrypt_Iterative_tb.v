`timescale 1ns / 1ps

module Encrypt_Iterative_tb;

    reg clk;
    reg rst;
    reg start;

    reg [127:0] in1;
    reg [127:0] key1;
    wire [127:0] out1;
    wire done1;

    reg [127:0] in2;
    reg [191:0] key2;
    wire [127:0] out2;
    wire done2;

    reg [127:0] in3;
    reg [255:0] key3;
    wire [127:0] out3;
    wire done3;

    Encrypt_Iterative #(128, 10, 4) dut128 (
        .clk(clk), .rst(rst), .start(start),
        .in(in1), .key(key1), .out(out1), .done(done1)
    );

    Encrypt_Iterative #(192, 12, 6) dut192 (
        .clk(clk), .rst(rst), .start(start),
        .in(in2), .key(key2), .out(out2), .done(done2)
    );

    Encrypt_Iterative #(256, 14, 8) dut256 (
        .clk(clk), .rst(rst), .start(start),
        .in(in3), .key(key3), .out(out3), .done(done3)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        rst = 1;
        start = 0;
        in1 = 0; key1 = 0;
        in2 = 0; key2 = 0;
        in3 = 0; key3 = 0;

        in1 = 128'h00112233445566778899aabbccddeeff;
        key1 = 128'h000102030405060708090a0b0c0d0e0f;

        in2 = 128'h00112233445566778899aabbccddeeff;
        key2 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;

        in3 = 128'h00112233445566778899aabbccddeeff;
        key3 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;

        $display("--- Resetting System ---");
        #20; // Giữ reset trong 2 chu kỳ
        rst = 0;
        #10; // Đợi 1 chút sau reset

        $display("--- Starting Encryption ---");
        start = 1; // Giữ start = 1 để máy chạy. Nếu start = 0 máy sẽ reset về round 0.
        
        wait(done1);
        $display("[Time %t] AES-128 Done!", $time);
        $display("Input: %h", in1);
        $display("Key:   %h", key1);
        $display("Out:   %h (Expected: 69c4e0d86a7b0430d8cdb78070b4c55a)", out1);
        $display("--------------------------------------------------");

        wait(done2);
        $display("[Time %t] AES-192 Done!", $time);
        $display("Input: %h", in2);
        $display("Key:   %h", key2);
        $display("Out:   %h (Expected: dda97ca4864cdfe06eaf70a0ec0d7191)", out2);
        $display("--------------------------------------------------");

        wait(done3);
        $display("[Time %t] AES-256 Done!", $time);
        $display("Input: %h", in3);
        $display("Key:   %h", key3);
        $display("Out:   %h (Expected: 8ea2b7ca516745bfeafc49904b496089)", out3);
        $display("--------------------------------------------------");

        #20;
        $finish;
    end

endmodule