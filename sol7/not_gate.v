module not_gate(output Y, input A);
  supply1 Vdd;
  supply0 Gnd;

  pmos (Y, Vdd, A);
  nmos (Y, Gnd, A);
endmodule
