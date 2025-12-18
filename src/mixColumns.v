module mixColumns(in, out)

input[127:0] in;
output[127:0] out;

    function [7:0] xTimes;
        input[7:0] byte;
        begin
            if(byte[7] == 1){
                xTimes = (byte << 1) ^ 8'h1B; 
            }   
            else xTimes = byte << 1;
        end
    endfunction

    genvar col;
    generate
        for (c = 0; c < 4; c = c + 1) begin : mix_col
            wire [7:0] s3 = in[c*32 +: 8];
            wire [7:0] s2 = in[c*32 + 8 +: 8];
            wire [7:0] s1 = in[c*32 + 16 +: 8];
            wire [7:0] s0 = in[c*32 + 24 +: 8];

            assign out[(c*32 + 24) +: 8]    = xTimes(s0) ^ (xTimes(s1) ^ s1) ^ s2 ^ s3;
            assign out[(c*32 + 16) +: 8]    = s0 ^ xTimes(s1) ^ (xTimes(s2) ^ s2) ^ s3;
            assign out[(c*32 + 8) +: 8]     = s0 ^ s1 ^ xTimes(s2) ^ (xTimes(s3) ^ s3);
            assign out[(c*32) +: 8]         = (xTimes(s0) ^ s0) ^ s1 ^ s2 ^ xTimes(s3);
        end
    endgenerate

endmodule