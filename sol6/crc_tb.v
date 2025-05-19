`timescale 1ns/1ps

module crc_tb;
    reg clk = 0;
    reg data_in = 0;
    wire [3:0] crc_out;

    // ساعت
    always #5 clk = ~clk;

    // واحد تحت تست (UUT)
    crc uut (
        .clk(clk),
        .data_in(data_in),
        .crc_out(crc_out)
    );

    initial begin
        $display("شروع شبیه‌سازی...");
        #10 data_in = 1;
        #10 data_in = 0;
        #10 data_in = 1;
        #10 data_in = 1;
        #10 data_in = 0;
        #10 data_in = 0;
        #10 data_in = 1;
        #10 data_in = 0;
        #10;

        $display("مقدار نهایی CRC: %b", crc_out);
        $finish;
    end
endmodule
