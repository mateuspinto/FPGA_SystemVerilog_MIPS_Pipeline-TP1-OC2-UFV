module zeroTest(
    input logic reset,

    input logic [31:0] dataRsInput,
    input logic [31:0] dataRtInput,

    output logic zeroTestOutput
);

logic [31:0] resultSub=(dataRsInput-dataRtInput);

always_comb begin

    if(reset)begin
        zeroTestOutput <= 0;
    end

    else begin
        case(resultSub)
            0: begin
                zeroTestOutput <= 0;
            end

            default: begin
                zeroTestOutput <= 1;
            end
        endcase
    end
end

endmodule

