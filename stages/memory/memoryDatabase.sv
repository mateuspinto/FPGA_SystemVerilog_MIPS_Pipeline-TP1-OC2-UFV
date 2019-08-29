module memoryDatabase(
    input logic clk,
    input logic reset,
    input logic memWrite,
    input logic [31:0] address,
    input logic [31:0] writeData,
    output logic [31:0] readData
);


logic [31:0] memory [1023:0];
assign readData = memory[address[11:2]];

always_ff @(posedge clk) begin
    if (reset) begin
        $readmemb("stages/memory/memory.txt",memory);
    end

    else begin
        if (memWrite) begin
            memory[address[31:2]] <= writeData;
        end
    end
end

endmodule