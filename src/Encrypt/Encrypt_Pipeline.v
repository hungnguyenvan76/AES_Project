`timescale 1ns / 1ps

module Encrypt_Pipeline #(parameter N = 128, parameter Nr = 10, Nk = 4) (clk, in, key, out);

input clk;
input [127:0] in;
input [N-1:0] key;
output reg [127:0] out;
reg [127:0] state [Nr:0];
wire [127:0] round_out [1:Nr];
wire [127:0] afterSub, afterShift;

wire [128*(Nr+1)-1:0] keySched;
keyExpansion #(Nk, Nr) k (key, keySched);

always @(posedge clk) begin
    state[0] <= in ^ keySched[(128*(Nr+1)-1) -: 128];
end

genvar i;
generate
    for (i = 1; i < Nr; i = i+1) begin : pipe_loop
        encryptRound eR (state[i-1], keySched[((128*(Nr+1)-1) - 128*i) -: 128], round_out[i]);
        always @(posedge clk) begin
            state[i] <= round_out[i];
        end
    end
endgenerate

subBytes    s (state[Nr-1], afterSub);
shiftRows   r (afterSub, afterShift);
addRoundKey arkNr (afterShift, keySched[127:0], round_out[Nr]);

always @(posedge clk) begin
    out <= round_out[Nr];
end

endmodule