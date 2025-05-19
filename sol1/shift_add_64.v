
module shift_add_64 (
    input  signed [63:0] a,
    input  signed [63:0] b,
    output signed [127:0] result
);
    integer i;
    reg signed [127:0] temp_result;

    always @(*) begin
        temp_result = 0;
        for (i = 0; i < 64; i = i + 1) begin
            if (b[i]) begin
                temp_result = temp_result + (a <<< i);
            end
        end
    end

    assign result = temp_result;
endmodule
