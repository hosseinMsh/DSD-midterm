
module karatsuba_128 (
    input  signed [127:0] a,
    input  signed [127:0] b,
    output signed [255:0] result
);
    wire signed [63:0] a_high = a[127:64];
    wire signed [63:0] a_low  = a[63:0];
    wire signed [63:0] b_high = b[127:64];
    wire signed [63:0] b_low  = b[63:0];

    wire signed [127:0] z0, z1, z2;

    shift_add_64 mul1 (.a(a_low), .b(b_low), .result(z0));
    shift_add_64 mul2 (.a(a_high), .b(b_high), .result(z2));

    wire signed [63:0] a_sum = a_low + a_high;
    wire signed [63:0] b_sum = b_low + b_high;

    shift_add_64 mul3 (.a(a_sum), .b(b_sum), .result(z1));

    wire signed [127:0] middle = z1 - z0 - z2;

    assign result = (({128'b0, z2}) << 128) + (({128'b0, middle}) << 64) + z0;
endmodule
