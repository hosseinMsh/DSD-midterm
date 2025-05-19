module tb;
  reg [15:0] A, B;
  reg Cin;
  wire [15:0] Sum;
  wire Cout;

  manchester_adder uut (
    .A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout)
  );

  initial begin
    $monitor("A=%h B=%h Cin=%b => Sum=%h Cout=%b", A, B, Cin, Sum, Cout);

    A = 16'hAAAA; B = 16'h5555; Cin = 0; #10;
    A = 16'h1234; B = 16'h4321; Cin = 0; #10;
    A = 16'hFFFF; B = 16'h0001; Cin = 0; #10;
    A = 16'h0000; B = 16'h0000; Cin = 1; #10;
    $finish;
  end
endmodule