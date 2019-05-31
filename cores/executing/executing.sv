module executing(
    input logic clk,
    input logic reset,
    input logic aluSrc,
    input logic regDst,
    input logic [3:0] aluOp,
    input logic [31:0] readRegister0,
    input logic [31:0] readRegister1,
    input logic [31:0] immediateExtended,
    input logic [5:0] func,
    input logic [4:0] addressRegisterRt,
    input logic [4:0] addressRegisterRd,
    output logic [31:0] resultAluOutput,
    output logic isAluOutputZero,
    output logic [4:0] addressRegWrite;
);

wire [3:0] aluControl;
// wire [31:0] resultAluOutput;
wire [31:0] aluInput1;
wire [1:0] regHiLoWrite;

mux2_1_32bits mux2_1_32bits0 (aluSrc, readRegister1, immediateExtended, aluInput1);
mux2_1_5bits mux2_1_5bits0 (regDst, addressRegisterRt, addressRegisterRd, addressRegWrite);

aritimeticalControl aritimeticalControl0 (reset, aluOp, func, aluControl, regHiLoWrite);
alu alu0 (reset, aluControl, readRegister0, aluInput1, resultAluOutput, isAluOutputZero);


endmodule