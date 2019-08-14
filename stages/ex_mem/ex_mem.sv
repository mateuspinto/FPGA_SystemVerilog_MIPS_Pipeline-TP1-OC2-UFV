module ex_men(
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
    output logic memWriteOutput,
    output logic memReadOutput,

    output logic [31:0] aluResultOutput,

    output logic [31:0] memWriteDataOutput,

    output logic [4:0] regWriteAddressOutput

);

always_ff @(posedge clk) begin

    if(reset) begin

        memToRegOutput<=0;
        regWriteOutput<=0;
        memWriteOutput<=0;
        memReadOutput<=0;

        aluResultOutput<=0;

        memWriteDataOutput<=0;

        regWriteAddressOutput<=0;

    end

    else begin

        memToRegOutput<=memToRegInput;
        regWriteOutput<=regWriteInput;
        memWriteOutput<=memWriteInput;
        memReadOutput<=memReadInput;

        aluResultOutput<=aluResultInput;

        memWriteDataOutput<=memWriteDataInput;

        regWriteAddressOutput<=regWriteAddressInput;

    end    

end

endmodule