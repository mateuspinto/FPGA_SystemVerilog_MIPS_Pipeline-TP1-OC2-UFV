module if_id(
    input logic clk,
    input logic reset,

    input logic hazard,

    input logic ifFlushInput,

    input logic [31:0] pcInput,
    input logic [31:0] instructionInput,
    
    output logic [31:0] pcOutput,
    output logic [31:0] instructionOutput
);

always_ff @(posedge clk) begin 

    if (reset | ifFlushInput) begin
        pcOutput<=0;
        instructionOutput<=0;
    end

    else if (hazard) begin
        pcOutput<=pcOutput;
        instructionOutput<=instructionOutput;
    end

    else begin
        pcOutput<=pcInput;
        instructionOutput<=instructionInput;
    end

end

endmodule