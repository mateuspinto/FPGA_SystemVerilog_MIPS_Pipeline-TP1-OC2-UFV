module id_ex(
    input logic clk,
    input logic reset,

    input logic [31:0] readRegister0In,
    input logic [31:0] readRegister1In,
    input logic [31:0] immediateExtendedIn,
    input logic [31:0] pcMore4In,
    input logic [20:16] addressRegisterRtIn,
    input logic [15:11] addressRegisterRdIn,
    input logic regDstIn,
    input logic jumpIn,
    input logic [1:0] branchIn,
    input logic memReadIn,
    input logic memToRegIn,
    input logic [3:0] aluOpIn,
    input logic memWriteIn,
    input logic aluSrcIn,
    input logic regWriteIn,

    output logic [31:0] readRegister0Out,
    output logic [31:0] readRegister1Out,
    output logic [31:0] immediateExtendedOut,
    output logic [31:0] pcMore4Out,
    output logic [20:16] addressRegisterRtOut,
    output logic [15:11] addressRegisterRdOut,
    output logic regDstOut,
    output logic jumpOut,
    output logic [1:0] branchOut,
    output logic memReadOut,
    output logic memToRegOut,
    output logic [3:0] aluOpOut,
    output logic memWriteOut,
    output logic aluSrcOut,
    output logic regWriteOut
);

always_ff @(posedge clk) begin 
    readRegister0Out<=readRegister0In;
    readRegister1Out<=readRegister1In;
    immediateExtendedOut<=immediateExtendedIn;
    pcMore4Out<=pcMore4In;
    addressRegisterRtOut<=addressRegisterRtIn;
    addressRegisterRdOut<=addressRegisterRdIn;
    regDstOut<=regDstIn;
    jumpOut<=jumpIn;
    branchOut<=branchIn;
    memReadOut<=memReadIn;
    memToRegOut<=memToRegIn;
    aluOpOut<=aluOpIn;
    memWriteOut<=memWriteIn;
    aluSrcOut<=aluSrcIn;
    regWriteOut<=regWriteIn;
end

endmodule