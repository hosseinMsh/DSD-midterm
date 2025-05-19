module xor_gate (output Y, input A, B);
  wire nA, nB, AandnB, nAandB;
  not (nA, A);
  not (nB, B);
  and (AandnB, A, nB);
  and (nAandB, nA, B);
  or (Y, AandnB, nAandB);
endmodule
