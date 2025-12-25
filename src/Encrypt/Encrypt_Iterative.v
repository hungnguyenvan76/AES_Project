`timescale 1ns / 1ps

module Encrypt_Iterative #(parameter N = 128, parameter Nr = 10, parameter Nk = 4) (clk, rst, start, in, key, out, done);

input clk;
input rst;
input start;
input [127:0] in;
input [N-1:0] key;
output reg [127:0] out;
output reg done;

wire [128*(Nr+1)-1:0] keySched;
keyExpansion #(Nk, Nr) k (key, keySched);

reg [127:0] state;
reg [3:0] round_cnt;

wire [127:0] round_out;
wire [127:0] current_key;

assign current_key = keySched[(128*(Nr+1)-1) - 128*round_cnt -: 128];

wire is_last = (round_cnt == Nr);

encryptRound eR (
    .in(state), 
    .key(current_key), 
    .out(round_out),
    .is_last_round(is_last)
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        round_cnt <= 0;
        done <= 0;
        state <= 0;
        out <= 0;
    end 
    else begin
        if (start) begin
            if (round_cnt == 0) begin
                done <= 0;
                state <= in ^ keySched[(128*(Nr+1)-1) -: 128]; 
                round_cnt <= 1;
            end
            
            else if (round_cnt < Nr) begin
                state <= round_out;
                round_cnt <= round_cnt + 1;
            end
            
            else if (round_cnt == Nr) begin
                out <= round_out;
                done <= 1;
                round_cnt <= 0;
            end
        end 
        else begin
            round_cnt <= 0;
            done <= 0;
        end
    end
end

endmodule