`timescale 1ns / 1ps

module invMixColumns_tb;

reg  [127:0] in;
wire [127:0] out;	

invMixColumns m (in,out);

initial begin

$monitor("input = %h, output = %h", in, out);

in = 128'h046681e5_e0cb199a_48f8d37a_2806264c;
#10;
//in = 128'hbaa03de7a1f9b56ed5512cba5f414d23;
//#10;
//in = 128'h_84e1dd69_1a41d76f_792d3897_83fbac70 ;
//#10;
//in = 128'h_6353e08c_0960e104_cd70b751_bacad0e7;
//#10;

end

endmodule
