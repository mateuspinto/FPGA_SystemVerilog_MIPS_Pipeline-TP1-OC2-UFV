module instructionMemory(
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] address,
    output logic [31:0] instruction
);

    logic [31:0] instructionMemory [255:0];

    assign instruction = instructionMemory[address[31:2]];

    always_ff @(posedge clk) begin
        if(reset) begin
        	$readmemb("cores/instructionFetch/instruction.txt",instructionMemory);
        end
    end
    
endmodule