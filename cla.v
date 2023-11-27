///////////////////////////////////////////////////////////
//16-bit Carry Look Ahead Adder 
///////////////////////////////////////////////////////////

`timescale 1ns / 1ps
module carry_look_ahead_8bit(a,b, cin, sum);
input [7:0] a,b;
input cin;
output [8:0] sum;
wire cout;
wire c1;
wire [7:0] sum_wire;
carry_look_ahead_4bit cla1 (.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum_wire[3:0]), .cout(c1));
carry_look_ahead_4bit cla2 (.a(a[7:4]), .b(b[7:4]), .cin(c1), .sum(sum_wire[7:4]), .cout(cout));
 assign sum = {cout,sum_wire};
endmodule

////////////////////////////////////////////////////////
//4-bit Carry Look Ahead Adder 
////////////////////////////////////////////////////////

module carry_look_ahead_4bit(a,b, cin, sum,cout);
input [3:0] a,b;
input cin;
output [3:0] sum;
output cout;

wire [3:0] p,g,c;

assign p=a^b;//propagate
assign g=a&b; //generate

//carry=gi + Pi.ci

assign c[0]=cin;
assign c[1]= g[0]|(p[0]&c[0]);
assign c[2]= g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
assign c[3]= g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
assign cout= g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&c[0];
assign sum=p^c;

endmodule
