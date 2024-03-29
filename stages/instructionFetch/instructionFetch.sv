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
    output logic [31:0] instructionOutput,
    output logic [31:0] pc4Output
);

logic [31:0] pcOutputDemuxJump, pc4, pcOutput, pcInput;
assign pc4Output=pc4;

instructionMemory instructionMemory0 (clk, reset, pcOutput, instructionOutput);
programCounter programCounter0 (clk, reset, hazard, pcInput, pcOutput);

adderProgramCounter adderProgramCounter0 (clk, reset, pcOutput, pc4);
mux2_1_32bits mux2_1_32bits0(jumpInput, pc4, pcJumpInput, pcOutputDemuxJump);
mux2_1_32bits mux2_1_32bits1(outputBrachControlInput, pcOutputDemuxJump, pcBranchInput, pcInput);

endmodule 