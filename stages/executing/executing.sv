module executing(

    input logic clk,
    input logic reset,

    input logic [31:0] pc4Input,

    input logic memToRegInput,
    input logic regWriteInput,
    input logic memWriteInput,
    input logic memReadInput,

    input logic [3:0] aluOpInput,
    input logic aluSrcInput,
    input logic regDstInput,
    input logic [1:0] branchInput,

    input logic [31:0] immediateExtendedInput,

    input logic [25:21] addressRsInput,
    input logic [20:16] addressRtInput,
    input logic [15:11] addressRdInput,

    input logic [31:0] dataRsInput,
    input logic [31:0] dataRtInput,

    input logic [5:0] funcInput,

    input logic [1:0] forwardingMux0Input,
    input logic [1:0] forwardingMux1Input,

    input logic [31:0] regWriteDataWbInput,
    input logic [31:0] aluResultMemInput,

    output logic memToRegOutput,
    output logic regWriteOutput,
    output logic memWriteOutput,
    output logic memReadOutput,

    output logic [31:0] aluResultOutput,

    output logic [31:0] memWriteDataOutput,

    output logic [4:0] regWriteRegisterOutput,

    //output logic aluResultZeroOutput,

    output logic branchControlOutput,

    output logic [31:0] pcBranchOutput
);

logic aluResultZeroOutput;
logic regHiLoWrite;
logic [3:0] aluControl;
logic [31:0] mux3_1_32bits0Output, mux3_1_32bits1Output, mux2_1_32bits0Output, shiftLef_2_32bitsOutput;
 
assign memToRegOutput=memToRegInput;
assign regWriteOutput=regWriteInput;
assign memWriteOutput=memWriteInput;
assign memReadOutput=memReadInput;
assign memWriteDataOutput=mux3_1_32bits1Output;

mux3_1_32bits mux3_1_32bits0 (forwardingMux0Input, dataRsInput, aluResultMemInput, regWriteDataWbInput, mux3_1_32bits0Output);
mux3_1_32bits mux3_1_32bits1 (forwardingMux1Input, dataRtInput, aluResultMemInput, regWriteDataWbInput, mux3_1_32bits1Output);

mux2_1_32bits mux2_1_32bits0 (aluSrcInput, mux3_1_32bits1Output, immediateExtendedInput, mux2_1_32bits0Output);

mux2_1_5bits mux2_1_5bits0 (regDstInput, addressRtInput, addressRdInput, regWriteRegisterOutput);

aritimeticalControl aritimeticalControl0 (reset, aluOpInput, funcInput, aluControl, regHiLoWrite);
alu alu0 (reset, aluControl, mux3_1_32bits0Output, mux2_1_32bits0Output, aluResultOutput, aluResultZeroOutput);

shiftLef_2_32bits shiftLef_2_32bits0(immediateExtendedInput, shiftLef_2_32bitsOutput);
adder_32bits adder_32bits0 (shiftLef_2_32bitsOutput, pc4Input, pcBranchOutput);

branchControl branchControl0 (reset, branchInput, aluResultZeroOutput, branchControlOutput);


endmodule