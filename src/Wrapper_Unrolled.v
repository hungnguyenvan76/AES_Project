`timescale 1ns / 1ps

module Wrapper_Unrolled #(parameter N=128, parameter Nr=10, parameter Nk=4) (
    input clk, // Clock này dùng cho Wrapper, không phải cho Core
    input [127:0] in,
    input [N-1:0] key,
    output reg [127:0] out
);

    reg [127:0] r_in;
    reg [N-1:0] r_key;

    wire [127:0] w_out;

    always @(posedge clk) begin
        r_in  <= in;
        r_key <= key;
    end

    Encrypt_Unrolled #(N, Nr, Nk) dut (
        .in(r_in),
        .key(r_key),
        .out(w_out)
    );

    always @(posedge clk) begin
        out <= w_out;
    end

endmodule