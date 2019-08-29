module mem_wb(
    input logic clk,
    input logic reset,

    input logic memToRegInput,
    input logic regWriteInput,
    input logic [31:0] dataMemoryInput,
    input logic [31:0] aluResultInput,
    input logic [4:0] regWriteAddressInput,

    output logic memToRegOutput,
    output logic regWriteOutput,
    output logic [31:0] dataMemoryOutput,
    output logic [31:0] aluResultOutput,
    output logic [4:0] regWriteAddressOutput
);

    always_ff @(posedge clk) begin

        if(reset) begin
            memToRegOutput <= 0;
            regWriteOutput <= 0;
            dataMemoryOutput <= 0;
            aluResultOutput <= 0;
            regWriteAddressOutput <= 0;
        end

        else begin
            memToRegOutput <= memToRegInput;
            regWriteOutput <= regWriteInput;
            dataMemoryOutput <= dataMemoryInput;
            aluResultOutput <= aluResultInput;
            regWriteAddressOutput <= regWriteAddressInput;
        end

    end

endmodule