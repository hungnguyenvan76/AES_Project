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

    reg [127:0] pt_storage [1:3];
    reg [127:0] exp_storage_128 [1:3];
    reg [127:0] exp_storage_192 [1:3];
    reg [127:0] exp_storage_256 [1:3];

    Encrypt_Pipeline #(128, 10, 4) dut128 (.clk(clk), .in(in1), .key(key1), .out(out1));
    Encrypt_Pipeline #(192, 12, 6) dut192 (.clk(clk), .in(in2), .key(key2), .out(out2));
    Encrypt_Pipeline #(256, 14, 8) dut256 (.clk(clk), .in(in3), .key(key3), .out(out3));

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        in1 = 0; in2 = 0; in3 = 0;
        
        key1 = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;
        key2 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
        key3 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;

        // Plain text
        pt_storage[1] = 128'h3243f6a8_885a308d_313198a2_e0370734; 
        pt_storage[2] = 128'h00112233_44556677_8899aabb_ccddeeff; 
        pt_storage[3] = 128'h6bc1bee22e409f96e93d7e117393172a; 
        
        // AES-128 Expected
        exp_storage_128[1] = 128'h3925841d02dc09fbdc118597196a0b32;
        exp_storage_128[2] = 128'h7649abac8119b246cee98e9b12e9197d;
        exp_storage_128[3] = 128'h3ad77bb40d7a3660a89ecaf32466ef97;

        // AES-192 Expected
        exp_storage_192[1] = 128'hbc3aaab5d97baa7b325d7b8f69cd7ca8;
        exp_storage_192[2] = 128'hdda97ca4864cdfe06eaf70a0ec0d7191;
        exp_storage_192[3] = 128'h1b58bc54cd0cb07a1c91b8d25339da3b;
        
        // AES-256 Expected
        exp_storage_256[1] = 128'h9a198830ff9a4e39ec1501547d4a6b1b;
        exp_storage_256[2] = 128'h8ea2b7ca516745bfeafc49904b496089;
        exp_storage_256[3] = 128'he0a8f50ec76a04d5a96a175aa870ef63;

        #20;
        $display("==============================================================");
        $display("              AES PIPELINE ENCRYPTION TEST ");
        $display("==============================================================\n");

        fork
            begin
                @(posedge clk);
                in1 = pt_storage[1]; in2 = pt_storage[1]; in3 = pt_storage[1];
                $display("[Time %t] INPUT FED: Packet 1", $time);

                @(posedge clk);
                in1 = pt_storage[2]; in2 = pt_storage[2]; in3 = pt_storage[2];
                $display("[Time %t] INPUT FED: Packet 2", $time);

                @(posedge clk);
                in1 = pt_storage[3]; in2 = pt_storage[3]; in3 = pt_storage[3];
                $display("[Time %t] INPUT FED: Packet 3", $time);

                @(posedge clk);
                in1 = 0; in2 = 0; in3 = 0;
                $display("[Time %t] INPUT STOPPED)", $time);
            end

            // KIỂM TRA AES-128
            begin
                repeat(12) @(posedge clk); 
                
                print_packet_report(128, 1);
                @(posedge clk); 
                print_packet_report(128, 2);
                @(posedge clk); 
                print_packet_report(128, 3);
            end

            // KIỂM TRA AES-192
            begin
                repeat(14) @(posedge clk); 
                print_packet_report(192, 1);
                @(posedge clk); 
                print_packet_report(192, 2);
                @(posedge clk); 
                print_packet_report(192, 3);
            end

            // KIỂM TRA AES-256
            begin
                repeat(16) @(posedge clk); 
                print_packet_report(256, 1);
                @(posedge clk); 
                print_packet_report(256, 2);
                @(posedge clk); 
                print_packet_report(256, 3);
            end
        join

        $display("==============================================================");
        $display("                ENCRYPTION TEST COMPLETED");
        $display("==============================================================");
        $finish;
    end

    // Task in kết quả
    task automatic print_packet_report;
        input integer mode;     // 128, 192, 256
        input integer pkt_idx;  // 1, 2, 3
        
        reg [127:0] current_pt;
        reg [127:0] current_ct;
        reg [127:0] current_exp;
        
        begin
            current_pt = pt_storage[pkt_idx];
            
            // Lấy Output & Expected tương ứng
            if (mode == 128) begin
                current_ct  = out1;
                current_exp = exp_storage_128[pkt_idx];
            end else if (mode == 192) begin
                current_ct  = out2;
                current_exp = exp_storage_192[pkt_idx];
            end else begin
                current_ct  = out3;
                current_exp = exp_storage_256[pkt_idx];
            end

            $display(">> AES-%0d | Packet %0d (Time: %t ns)", mode, pkt_idx, $time);
            $display("--------------------------------------------------------------");
            $display(" Plaintext          : %032h", current_pt);
            
            if(mode == 128)      $display(" Key                : %032h", key1);
            else if(mode == 192) $display(" Key                : %048h", key2);
            else                 $display(" Key                : %064h", key3);
            
            $display(" Ciphertext (DUT)   : %032h", current_ct);
            
            if (current_exp != 0) begin
                $display(" Expected Ciphertext: %032h", current_exp);
                $display(" Result             : %s", (current_ct == current_exp) ? "PASS" : "FAIL");
            end else begin
                $display(" Expected Ciphertext: [Reference Not Set]");
                $display(" Result             : CHECK MANUALLY");
            end
            $display(""); 
        end
    endtask

endmodule