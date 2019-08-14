module memory(
    input logic clk,
    input logic reset,

    input logic memToRegInput,
    input logic regWriteInput,
    input logic memWriteInput,
    input logic memReadInput,

    input logic [31:0] aluResultInput,

    input logic [31:0] memWriteDataInput,

    input logic [4:0] regWriteAddressInput,

    output logic memToRegOutput,
    output logic regWriteOutput,

    output logic [31:0] dataMemoryOutput,

    output logic [31:0] aluResultOutput,

    output logic [4:0] regWriteAddressOutput

);

assign aluResultOutput=aluResultInput;
assign memToRegOutput=memToRegInput;
assign regWriteOutput=regWriteInput;
assign regWriteAddressOutput=regWriteAddressInput;

memoryDatabase memoryDatabase0(clk, reset, memWriteInput, aluResultInput, memWriteDataInput, dataMemoryOutput);

endmodule

