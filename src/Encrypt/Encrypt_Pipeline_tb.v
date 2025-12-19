`timescale 1ns / 1ps

module Encrypt_Pipeline_tb;

    reg clk;

    reg [127:0] in1;
    reg [127:0] key1;
    wire [127:0] out1;

    reg [127:0] in2;
    reg [191:0] key2;
    wire [127:0] out2;

    reg [127:0] in3;
    reg [255:0] key3;
    wire [127:0] out3;

    Encrypt_Pipeline #(128, 10, 4) dut128 (.clk(clk), .in(in1), .key(key1), .out(out1));
    Encrypt_Pipeline #(192, 12, 6) dut192 (.clk(clk), .in(in2), .key(key2), .out(out2));
    Encrypt_Pipeline #(256, 14, 8) dut256 (.clk(clk), .in(in3), .key(key3), .out(out3));

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        in1 = 0;
        in2 = 0;
        in3 = 0;
        
        key1 = 128'h000102030405060708090a0b0c0d0e0f;
        key2 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
        key3 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;

        #20;

        // Nạp Gói 1
        @(posedge clk);
        in1 = 128'h00112233445566778899aabbccddeeff;
        in2 = 128'h00112233445566778899aabbccddeeff;
        in3 = 128'h00112233445566778899aabbccddeeff;
        $display("%t ns | [INPUT]  Fed Packet 1", $time);

        // Nạp Gói 2
        @(posedge clk);
        in1 = 128'h3243f6a8885a308d313198a2e0370734;
        in2 = 128'h3243f6a8885a308d313198a2e0370734;
        in3 = 128'h3243f6a8885a308d313198a2e0370734;
        $display("%t ns | [INPUT]  Fed Packet 2", $time);

        // Nạp Gói 3
        @(posedge clk);
        in1 = 128'h6bc1bee22e409f96e93d7e117393172a;
        in2 = 128'h6bc1bee22e409f96e93d7e117393172a;
        in3 = 128'h6bc1bee22e409f96e93d7e117393172a;
        $display("%t ns | [INPUT]  Fed Packet 3", $time);

        // Dừng nạp
        @(posedge clk);
        in1 = 0; in2 = 0; in3 = 0;

        // Fork-Join
        fork
            wait_and_display(128, 11);
            wait_and_display(192, 13);
            wait_and_display(256, 15);
        join

        #50;
        $finish;
    end

    task automatic wait_and_display;
        input integer name;
        input integer latency;
        integer i;
        begin
            for(i=0; i < latency - 3; i=i+1) @(posedge clk);
            
            display_output(name, 1);
            @(posedge clk); display_output(name, 2);
            @(posedge clk); display_output(name, 3);
        end
    endtask

    task automatic display_output;
        input integer name;
        input integer pkt_num;
        reg [127:0] val;
        begin
            if (name == 128) val = out1;
            else if (name == 192) val = out2;
            else val = out3;
            
            $display("%t ns | [OUTPUT] AES-%0d | Packet %0d Out: %h", $time, name, pkt_num, val);
        end
    endtask

endmodule