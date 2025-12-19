`timescale 1ns / 1ps

module subBytes_tb;

reg [127:0] in;
wire [127:0] out;

subBytes sb(in, out);

initial begin
    $monitor("input= %h, output= %h", in, out);
    in = 128'h193de3be_a0f4e22b_9ac68d2a_e9f84808;
    #10;
    in = 128'ha49c7ff2_689f352b_6b5bea43_026a5049;
    #10;
    in = 128'haa8f5f03_61dde3ef_82d24ad2_6832469a;
    #10;
    $finish;
end

endmodule