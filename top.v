module top (
    input  [15:0] A,
    input  [15:0] B,
    input        Cin,
    output [15:0] Sum,
    output        Cout
);
  manchester_adder u_adder (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
  );
endmodule