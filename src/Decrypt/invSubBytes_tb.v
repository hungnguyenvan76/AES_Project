`timescale 1ns / 1ps

module invSubBytes_tb;
reg[127:0]  in;
wire[127:0] out;

invSubBytes s (in, out);

initial begin
    $monitor("input = %h, output = %h", in, out);
    in = 128'hd42711ae_e0bf98f1_b8b45de5_1e415230;
    #10;
    //in = 128'h7a9f1027_89d5f50b_2beffd9f_3dca4ea7;
    //#10;
    $finish;
end  
      
    
endmodule
