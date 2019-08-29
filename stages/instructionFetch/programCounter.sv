module programCounter (
    input  logic        clk,
    input  logic        reset,
    input  logic        hazard,
    input  logic [31:0] programCounterInput,
    output logic [31:0] programCounterOutput
    );

    always_ff @(posedge clk) begin
        if (reset) begin
            programCounterOutput <= 0;
        end

        else if (hazard) begin
            programCounterOutput <= programCounterOutput;
        end

        else begin
            programCounterOutput <= programCounterInput;
		end
    end

endmodule