module if_id(
    input logic clk,
    input logic reset,
    input logic [31:0] pcMore4Input,
    input logic [31:0] instructionInput,
    output reg [31:0] pcMore4Output,
    output reg [31:0] instructionOutput
);

always_ff @(posedge clk) begin 
    pcMore4Output<=pcMore4Input;
    instructionOutput<=instructionInput;
end

endmodule