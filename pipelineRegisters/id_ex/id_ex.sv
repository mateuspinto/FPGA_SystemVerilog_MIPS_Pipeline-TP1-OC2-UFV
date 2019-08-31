module id_ex(
    input logic clk,
    input logic reset,

    input logic hazard,

    input logic branchControlExInput,

    input logic [31:0] pc4Input,

    input logic memToRegInput,
    input logic regWriteInput,
    input logic memWriteInput,
    input logic memReadInput,
    input logic [3:0] aluOpInput,
    input logic aluSrcInput,
    input logic regDstInput,
    input logic [1:0] branchInput,

    input logic [31:0] immediateExtendedInput,

    input logic [25:21] addressRsInput,
    input logic [20:16] addressRtInput,
    input logic [15:11] addressRdInput,

    input logic [31:0] dataRsInput,
    input logic [31:0] dataRtInput,

    input logic [5:0] funcInput,

    output logic [31:0] pc4Output,

    output logic memToRegOutput,
    output logic regWriteOutput,
    output logic memWriteOutput,
    output logic memReadOutput,
    output logic [3:0] aluOpOutput,
    output logic aluSrcOutput,
    output logic regDstOutput,
    output logic [1:0] branchOutput,

    output logic [31:0] immediateExtendedOutput,

    output logic [25:21] addressRsOutput,
    output logic [20:16] addressRtOutput,
    output logic [15:11] addressRdOutput,

    output logic [31:0] dataRsOutput,
    output logic [31:0] dataRtOutput,

    output logic [5:0] funcOutput
    
);

always_ff @(posedge clk) begin 

    if(reset | hazard | branchControlExInput)begin

        pc4Output<=0;

        memToRegOutput<=0;
        regWriteOutput<=0;
        memWriteOutput<=0;
        memReadOutput<=0;
        aluOpOutput<=0;
        aluSrcOutput<=0;
        regDstOutput<=0;
        branchOutput<=0;

        immediateExtendedOutput<=0;

        addressRsOutput<=0;
        addressRtOutput<=0;
        addressRdOutput<=0;

        dataRsOutput<=0;
        dataRtOutput<=0;

        funcOutput<=0;

    end

    else begin

        pc4Output<=pc4Input;

        memToRegOutput<=memToRegInput;
        regWriteOutput<=regWriteInput;
        memWriteOutput<=memWriteInput;
        memReadOutput<=memReadInput;
        aluOpOutput<=aluOpInput;
        aluSrcOutput<=aluSrcInput;
        regDstOutput<=regDstInput;
        branchOutput<=branchInput;

        immediateExtendedOutput<=immediateExtendedInput;

        addressRsOutput<=addressRsInput;
        addressRtOutput<=addressRtInput;
        addressRdOutput<=addressRdInput;

        dataRsOutput<=dataRsInput;
        dataRtOutput<=dataRtInput;

        funcOutput<=funcInput;

    end
end

endmodule