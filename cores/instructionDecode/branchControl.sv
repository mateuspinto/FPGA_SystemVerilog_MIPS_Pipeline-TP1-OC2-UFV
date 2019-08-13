module branchControl(
    input logic reset,

    input logic [1:0] branchInput,
    input logic zeroTestInput,

    output logic branchControlOutput
);

always_comb begin

    if(reset)begin
        branchControlOutput <= 0;
    end

    else begin
        case(branchInput)

            0: begin
                branchControlOutput <= 0;
            end

            1: begin
                branchControlOutput<=zeroTestInput;
            end

            2: begin
                branchControlOutput<=~zeroTestInput;
            end

            default: begin
                branchControlOutput <= 0;
            end

        endcase
    end
end

endmodule