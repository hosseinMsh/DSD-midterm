// ramp_pwm_top.v  -------------------
module ramp_pwm_top (
    input  wire clk_50,   // کلاک 50 MHz برد
    input  wire rst_n,    // دکمه Reset فعال-پایین
    output wire pwm_out
);
    ramp_pwm #(
        .CLK_HZ    (50_000_000),
        .RAMP_FREQ (1_000),   // 1 kHz رمپ
        .PWM_BITS  (10)
    ) u_core (
        .clk     (clk_50),
        .rst     (~rst_n),    // معکوس چون دکمه active-low است
        .pwm_out (pwm_out)
    );
endmodule
