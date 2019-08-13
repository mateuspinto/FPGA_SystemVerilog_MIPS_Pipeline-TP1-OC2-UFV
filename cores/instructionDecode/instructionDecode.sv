module instructionDecode(

    input logic clk,
    input logic reset,
    
    //Coming Instruction Fetch
    input logic [31:0] instructionInput,
    input logic [31:0] pc4Input,

    //Coming Write Back
    input logic regWriteInput,
    input logic [4:0] writeRegister,
    input logic [31:0] writeDataInput,

    //From Controller 
    output logic memToRegOutput,
    output logic regWriteOutput,
    output logic memWriteOutput,
    output logic memReadOutput,
    output logic [3:0] aluOpOutput,
    output logic aluSrcOutput,
    output logic regDstOutput,

    output logic [31:0] immediateExtendedOutput,

    output logic [25:21] addressRsOutput,
    output logic [20:16] addressRtOutput,
    output logic [15:11] addressRdOutput,

    //From Register DB
    output logic [31:0] dataRsOutput,
    output logic [31:0] dataRtOutput,

    //To Instruction Fetch
    input logic outputBrachControlOutput,
    input logic [31:0] pcBranchOutput,
    input logic jumpOutput,
    input logic [31:0] pcJumpOutput,
);




// registerDatabase registerDatabase0 (clk, reset, regWriteInput, instructionInput[25:21], instructionInput[20:16], writeRegister, writeDataInput, readRegister0, readRegister1);
// controller controller0 (reset, instructionInput[31:26], regDst, jump, branch, memRead, memToReg, aluOp, memWrite, aluSrc, regWriteOut);
// signalExtender16_32bits signalExtender16_32bits0 (instructionInput[15:0], immediateExtended);



endmodule