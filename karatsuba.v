
module ka_8x8(
    input [7:0] a,
    input [7:0] b,
    output [15:0] out
    );
    
    wire [7:0] ac,bc,ad,bd;
    wire [15:0] t1,t2;
    wire [12:0] psum;
    
  ka_4x4 m1(.a(a[7:4]),.b(b[7:4]),.out(ac));
  ka_4x4 m2(.a(a[3:0]),.b(b[7:4]),.out(bc));
  ka_4x4 m3(.a(a[7:4]),.b(b[3:0]),.out(ad));
  ka_4x4 m4(.a(a[3:0]),.b(b[3:0]),.out(bd));
  assign t2= bd;
  assign psum = (bc+ad) << 4;
  assign t1={ac,8'b0000};
  assign out= t1+t2+psum;
endmodule

module ka_4x4(
    input [3:0] a,
    input [3:0] b,
    output [7:0] out
    );
    wire [3:0] ac,bc,ad,bd;
    wire [7:0] t1,t2;
    wire [6:0] psum;
    
  ka_2x2 m1(.a(a[3:2]),.b(b[3:2]),.out(ac));
  ka_2x2 m2(.a(a[1:0]),.b(b[3:2]),.out(bc));
  ka_2x2 m3(.a(a[3:2]),.b(b[1:0]),.out(ad));
  ka_2x2 m4(.a(a[1:0]),.b(b[1:0]),.out(bd));
  assign t2= bd;
  assign psum = (bc+ad) << 2;
  assign t1={ac,4'b0000};
  assign out= t1+t2+psum;
  
endmodule

module ka_2x2(
    input [1:0] a,
    input [1:0] b,
    output [3:0] out
    );
    wire temp;
    assign out[0]= a[0]&b[0];
    assign out[1]= (a[1]&b[0])^(a[0]&b[1]);
    assign temp =  (a[1]&b[0])&(a[0]&b[1]);
    assign out[2]= temp ^(a[1]&b[1]);
    assign out[3]= temp &(a[1]&b[1]);
endmodule
