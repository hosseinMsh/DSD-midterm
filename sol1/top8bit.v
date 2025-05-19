module top8bit (
    input  [7:0] a_in,     // عدد اول
    input  [7:0] b_in,     // عدد دوم
    input        clk,      // ساعت
    input        rst_n,    // ریست اکتیو-لو
    output [7:0] result_out // 8 بیت پایین حاصل ضرب
);

    reg  signed [127:0] a, b;
    wire signed [255:0] result;

    // ماژول ضرب Karatsuba
    karatsuba_128 uut (
        .a(a),
        .b(b),
        .result(result)
    );

    reg computed = 0;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            computed <= 0;
            a <= 0;
            b <= 0;
        end else if (!computed) begin
            a <= {{120{a_in[7]}}, a_in};  // sign-extend
            b <= {{120{b_in[7]}}, b_in};  // sign-extend
            computed <= 1;
        end
    end

    assign result_out = result[7:0]; 

endmodule
