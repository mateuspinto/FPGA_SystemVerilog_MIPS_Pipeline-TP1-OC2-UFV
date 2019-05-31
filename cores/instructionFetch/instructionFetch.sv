module instructionFetch(
    input logic clk,
    input logic reset,
    output logic [31:0] pcMore4,
    output logic [31:0] instruction
);

logic [31:0] address;

instructionMemory instructionMemory0 (clk, reset, address, instruction);

endmodule 