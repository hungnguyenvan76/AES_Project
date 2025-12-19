`timescale 1ns / 1ps

module addRoundKey_tb;

reg [127:0] in;
reg [127:0] key;
wire [127:0] out;	

addRoundKey m (in, key, out);

initial begin

    in  = 128'h046681e5_e0cb199a_48f8d37a_2806264c;
    key = 128'ha0fafe17_88542cb1_23a33939_2a6c7605;
    #10;
    $display("Test 1:");
    $display("input = %h", in);
    $display("key   = %h", key);
    $display("output= %h", out);

    $finish;
end

endmodule

