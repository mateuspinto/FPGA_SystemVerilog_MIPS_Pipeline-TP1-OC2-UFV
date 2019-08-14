module instructionDecode(

    input logic clk,
    input logic reset,
    
    //Coming Instruction Fetch
    input logic [31:0] instructionInput,
    input logic [31:0] pc4Input,

    //Coming Write Back
    input logic regWriteInput,
    input logic [4:0] writeRegisterInput,
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
    output logic branchControlOutput,
    output logic [31:0] pcBranchOutput,
    output logic jumpOutput,
    output logic [31:0] pcJumpOutput,

    output logic [5:0] funcOutput,

    output logic ifFlushOutput

);

logic zeroTestOutput;
logic [1:0] branch;
logic [31:0] shiftLef_2_32bitsOutput;
logic [27:0] shiftLeft_2_26_28_bitsOutput;

assign addressRsOutput=instructionInput[25:21];
assign addressRtOutput=instructionInput[20:16];
assign addressRdOutput=instructionInput[15:11];
assign pcJumpOutput={pc4Input[31:28], shiftLeft_2_26_28_bitsOutput};
assign ifFlushOutput=(branchControlOutput | jumpOutput);
assign funcOutput=instructionInput[5:0];

controller controller0 (reset, instructionInput[31:26], regDstOutput, jumpOutput, branch, memReadOutput, memToRegOutput, aluOpOutput, memWriteOutput, aluSrcOutput, regWriteOutput);
registerDatabase registerDatabase0 (clk, reset, regWriteInput, instructionInput[25:21], instructionInput[20:16], writeRegisterInput, writeDataInput, dataRsOutput, dataRtOutput);

//Branch
signalExtender16_32bits signalExtender16_32bitsBranch0 (instructionInput[15:0], immediateExtendedOutput);
shiftLef_2_32bits shiftLef_2_32bits0(immediateExtendedOutput, shiftLef_2_32bitsOutput);
adder_32bits adder_32bits0 (shiftLef_2_32bitsOutput, pc4Input, pcBranchOutput);
zeroTest zeroTest0(reset, dataRsOutput, dataRtOutput, zeroTestOutput);
branchControl branchControl0 (reset, branch, zeroTestOutput, branchControlOutput);

//Jump
shiftLeft_2_26_28_bits shiftLeft_2_26_28_bits0 (instructionInput[25:0], shiftLeft_2_26_28_bitsOutput);





// signalExtender16_32bits signalExtender16_32bits0 (instructionInput[15:0], immediateExtended);



endmodule