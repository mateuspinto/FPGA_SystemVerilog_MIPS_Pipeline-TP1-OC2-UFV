module clock_extends(
    input logic clk,
    output logic clk_extends
);

always_ff @(posedge clk)begin
    clk_extends=1;
end

endmodule