module instructionFetch(
    input logic clk,
    input logic reset,

    input logic hazard,

    //Coming Instruction Decode
    input logic outputBrachControlInput,
    input logic [31:0] pcBranchInput,
    input logic jumpInput,
    input logic [31:0] pcJumpInput,

    //Go to Instruction Decode
    output logic [31:0] instruction,
    output logic [31:0] pc4Output
);

logic [31:0] pcOutputDemuxBranch, pc4, pcOutput, pcInput;
assign pc4Output=pc4;

instructionMemory instructionMemory0 (clk, reset, pcOutput, instruction);
programCounter programCounter0 (clk, reset, hazard, pcInput, pcOutput);

adderProgramCounter adderProgramCounter0 (clk, reset, pcOutput, pc4);
mux2_1_32bits mux2_1_32bits0(outputBrachControlInput, pc4, pcBranchInput, pcOutputDemuxBranch);
mux2_1_32bits mux2_1_32bits1(jumpInput, pcOutputDemuxBranch, pcJumpInput, pcInput);

endmodule 