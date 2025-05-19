// ramp_pwm.v  -----------------------
module ramp_pwm #(
    parameter  CLK_HZ    = 50_000_000,   // کلاک روی برد
    parameter  RAMP_FREQ = 1_000,         // 1 kHz
    parameter  PWM_BITS  = 10             // وضوح PWM
)(
    input  wire clk,
    input  wire rst,          // فعال-بالا
    output wire pwm_out
);
    //-------------------------------
    localparam integer RAMP_STEPS = 1 << PWM_BITS;  // 1024
    localparam integer DIVIDER    = CLK_HZ / (RAMP_FREQ * RAMP_STEPS);
    //-------------------------------

    /* تقسیم ساعت برای تیکِ رمپ */
    reg [$clog2(DIVIDER)-1:0] div_cnt = 0;
    reg                       tick    = 0;
    always @(posedge clk) begin
        if (rst) begin div_cnt<=0; tick<=0; end
        else if (div_cnt==DIVIDER-1) begin div_cnt<=0; tick<=1; end
        else begin div_cnt<=div_cnt+1; tick<=0; end
    end

    /* شمارندهٔ رمپ */
    reg [PWM_BITS-1:0] ramp_val = 0;
    always @(posedge clk) begin
        if (rst)       ramp_val <= 0;
        else if (tick) ramp_val <= ramp_val + 1;
    end

    /* شمارندهٔ PWM */
    reg [PWM_BITS-1:0] pwm_cnt = 0;
    always @(posedge clk) begin
        if (rst) pwm_cnt <= 0;
        else     pwm_cnt <= pwm_cnt + 1;
    end

    assign pwm_out = (pwm_cnt < ramp_val);

endmodule
