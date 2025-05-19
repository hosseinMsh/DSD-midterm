module manchester_adder (
    input  [15:0] A, B,
    input        Cin,
    output [15:0] Sum,
    output       Cout
);
  wire [15:0] P, G, C;

  assign P = A ^ B;   // Propagate bits
  assign G = A & B;   // Generate bits

  assign C[0] = Cin;  // Initial carry

  //--------- Manchester carry chain ---------
  genvar i;
  generate
    for (i = 0; i < 15; i = i + 1) begin : gen_carry
      assign C[i+1] = G[i] | (P[i] & C[i]);
    end
  endgenerate
  //-------------------------------------------

  assign Sum  = P ^ C;  // Final sum bits
  assign Cout = C[15];  // Final carry out
endmodule