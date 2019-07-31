module instructionFetch(
    input logic clk,
    input logic reset,
    input logic pcFlush,
    input logic outputBrachControl,
    input logic [31:0] pcBranch,
    input logic jump,
    input logic [31:0] pcJump,
    output logic [31:0] pcMore4,
    output logic [31:0] instruction,
    output logic [31:0] pc4Output
);

logic [31:0] pcOutputDemuxBranch, pc4, pcOutput, branchOutput, adder_32bitsOutput, pcInput;
assign pc4Output=pc4;


instructionMemory instructionMemory0 (clk, reset, pcOutput, instruction);
programCounter programCounter0 (clk, reset, pcFlush, pcInput, pcOutput);

adderProgramCounter adderProgramCounter0 (clk, reset, pcOutput, pc4);
mux2_1_32bits mux2_1_32bits0(outputBrachControl, pc4, pcBranch, pcOutputDemuxBranch);
mux2_1_32bits mux2_1_32bits1(jump, pcOutputDemuxBranch, pcJump, pcInput);

endmodule 