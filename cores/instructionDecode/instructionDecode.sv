module instructionDecode(
    input logic clk,
    input logic reset,
    input logic regWriteIn,
    input logic [31:0] instruction,
    input logic [31:0] writeData,
    input logic [4:0] writeRegister,
    input logic [31:0] pcMore4Input,
    output logic [31:0] readRegister0,
    output logic [31:0] readRegister1,
    output logic [31:0] immediateExtended,
    output logic [31:0] pcMore4Output,
    output logic [20:16] addressRegisterRt,
    output logic [15:11] addressRegisterRd,
    output logic regDst,
    output logic jump,
    output logic [1:0] branch,
    output logic memRead,
    output logic memToReg,
    output logic [3:0] aluOp,
    output logic memWrite,
    output logic aluSrc,
    output logic regWriteOut
);

registerDatabase registerDatabase0 (clk, reset, regWriteIn, instruction[25:21], instruction[20:16], writeRegister, writeData, readRegister0, readRegister1);
controller controller0 (reset, instruction[31:26], regDst, jump, branch, memRead, memToReg, aluOp, memWrite, aluSrc, regWriteOut);
signalExtender16_32bits signalExtender16_32bits0 (instruction[15:0], immediateExtended);



endmodule