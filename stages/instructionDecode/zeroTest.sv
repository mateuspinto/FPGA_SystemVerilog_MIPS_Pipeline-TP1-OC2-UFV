module zeroTest(
    input logic reset,

    input logic [31:0] dataRsInput,
    input logic [31:0] dataRtInput,

    output logic zeroTestOutput
);

always_comb begin

    if(reset)begin
        zeroTestOutput <= 0;
    end

    else begin
        if(dataRsInput == dataRtInput) begin
            zeroTestOutput <= 1;
        end

        else begin
            zeroTestOutput <= 0;
        end
    end
end

endmodule

