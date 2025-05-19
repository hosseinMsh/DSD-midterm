module crc (
    input clk,
    input data_in,
    output [3:0] crc_out
);

    reg d0;
    reg d1;
    reg d2;
    reg d3;

    always @(posedge clk) begin
        d3 <= d2;
        d2 <= d1;
        d1 <= d0 ^ data_in;
        d0 <= data_in;
    end

    assign crc_out = { d3, d2, d1, d0 };
endmodule
