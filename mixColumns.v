module mixColumn(state_in, state_out)

input[127:0] state_in;
output[127:0] state_out;

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
    // generate
    //     for(col = 0; col < 4; col = col+1) begin: mix_col
    //         assign state_out[i*32+7:i*32] = (xTimes(state_in[i*32+7:i*32])) ^ (xTimes(state_in[i*32+15:i*32+8]) ^ state_in[i*32+15:i*32+8])
    //                                         ^ state_in[i*32+23:i*32+16] ^ state_in[i*32+31:i*32+24];
    //         assign state_out[i*32+15:i*32+8] = (xTimes(state_in[i*32+15:i*32+8])) ^ (xTimes(state_in[i*32+23:i*32+16]) ^ state_in[i*32+23:i*32+16])
    //                                         ^ state_in[i*32+7:i*32] ^ state_in[i*32+31:i*32+24];
    //         assign state_out[i*32+23:i*32+16] = (xTimes(state_in[i*32+23:i*32+16])) ^ (xTimes(state_in[i*32+31:i*32+24]) ^ state_in[i*32+31:i*32+24])
    //                                         ^ state_in[i*32+7:i*32] ^ state_in[i*32+15:i*32+8];
    //         assign state_out[i*32+31:i*32+24] = (xTimes(state_in[i*32+31:i*32+24])) ^ (xTimes(state_in[i*32+7:i*32]) ^ state_in[i*32+7:i*32])
    //                                         ^ state_in[i*32+15:i*32+8] ^ state_in[i*32+23:i*32+16];
    //     end
    // endgenerate

    generate
        for (c = 0; c < 4; c = c + 1) begin : mix_col
            wire [7:0] s0 = state_in[c*32 +: 8];
            wire [7:0] s1 = state_in[c*32 + 8 +: 8];
            wire [7:0] s2 = state_in[c*32 + 16 +: 8];
            wire [7:0] s3 = state_in[c*32 + 24 +: 8];

            assign state_out[c*32 +: 8]      = xtime(s0) ^ (xtime(s1) ^ s1) ^ s2 ^ s3;
            assign state_out[c*32 + 8 +: 8]  = s0 ^ xtime(s1) ^ (xtime(s2) ^ s2) ^ s3;
            assign state_out[c*32 + 16 +: 8] = s0 ^ s1 ^ xtime(s2) ^ (xtime(s3) ^ s3);
            assign state_out[c*32 + 24 +: 8] = (xtime(s0) ^ s0) ^ s1 ^ s2 ^ xtime(s3);
        end
    endgenerate

endmodule