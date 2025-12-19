`timescale 1ns / 1ps

module Wrapper_Iterative #(parameter N=128, parameter Nr=10, parameter Nk=4) (
    input clk,
    input rst,
    input start,
    input [127:0] in,
    input [N-1:0] key,
    output reg [127:0] out,
    output reg done
);

    reg [127:0] r_in;
    reg [N-1:0] r_key;
    reg r_start;
    reg r_rst;

    wire [127:0] w_out;
    wire w_done;

    always @(posedge clk) begin
        r_in    <= in;
        r_key   <= key;
        r_start <= start;
        r_rst   <= rst;
    end

    Encrypt_Iterative #(N, Nr, Nk) dut (
        .clk(clk),
        .rst(r_rst),
        .start(r_start),
        .in(r_in),
        .key(r_key),
        .out(w_out),
        .done(w_done)
    );

    always @(posedge clk) begin
        out  <= w_out;
        done <= w_done;
    end

endmodule