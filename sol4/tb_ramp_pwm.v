// tb_ramp_pwm.v  --------------------
`timescale 1ns/1ps
module tb_ramp_pwm;

    /* پارامترها */
    localparam CLK_HZ  = 50_000_000;
    localparam CLK_PER = 1_000_000_000 / CLK_HZ;   // ns  (20 ns)

    /* سیگنال‌ها */
    reg  clk = 0;
    reg  rst = 1;
    wire pwm_out;

    /* واحد تحت آزمون */
    ramp_pwm #(
        .CLK_HZ   (CLK_HZ),
        .RAMP_FREQ(1_000),
        .PWM_BITS (10)
    ) dut (
        .clk     (clk),
        .rst     (rst),
        .pwm_out (pwm_out)
    );

    /* تولید کلاک 50 MHz */
    always #(CLK_PER/2) clk = ~clk;

    /* توالی ریست و پایان شبیه‌سازی */
    initial begin
        #(10*CLK_PER);   rst = 0;      // پس از 10 کلاک ریست آزاد
        #(5_000_000);                // 5 ms = 5 پریود رمپ
        $stop;
    end

endmodule
