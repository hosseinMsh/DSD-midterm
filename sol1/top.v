module top (
    input  [127:0] a_in,        // عدد اول 128 بیت
    input  [127:0] b_in,        // عدد دوم 128 بیت
    input          clk,         // کلاک
    input          rst_n,       // ریست اکتیو-لو
    output [255:0] result_out   // خروجی ضرب 256 بیت کامل
);

    reg  signed [127:0] a, b;
    wire signed [255:0] result;
    reg computed;

    // اتصال به ماژول Karatsuba
    karatsuba_128 uut (
        .a(a),
        .b(b),
        .result(result)
    );

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a <= 128'sd0;
            b <= 128'sd0;
            computed <= 1'b0;
        end else if (!computed) begin
            a <= a_in;
            b <= b_in;
            computed <= 1'b1;
        end
    end

    assign result_out = result;

endmodule
