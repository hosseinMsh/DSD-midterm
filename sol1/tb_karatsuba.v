
module tb_karatsuba;
    reg  signed [127:0] a, b;
    wire signed [255:0] result;
    reg  signed [255:0] expected;

    karatsuba_128 uut (
        .a(a),
        .b(b),
        .result(result)
    );

    initial begin
        a = -128'h00000000000000000000000000000002;
        b =  128'h00000000000000000000000000000003;

        expected = a * b;

        #10;

        if (result === expected)
            $display("PASS: %0d * %0d = %0d", a, b, result);
        else begin
            $display("FAIL: %0d * %0d != %0d (Expected: %0d)", a, b, result, expected);
            $stop;
        end

        $finish;
    end
endmodule
