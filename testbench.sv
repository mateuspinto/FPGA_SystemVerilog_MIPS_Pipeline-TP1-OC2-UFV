module testbench();

	logic clk, reset;

	logic hazard, branchControlId, jumpId, flushId, regWriteWb, memToRegId, regWriteId, memWriteId, memReadId, aluSrcId, regDstId, memToRegEx, regWriteEx, memWriteEx, memReadEx, aluSrcEx, regDstEx;

	logic [3:0] aluOpId, aluOpEx;

	logic [4:0] writeRegisterWb, addressRsId, addressRtId, addressRdId, addressRsEx, addressRtEx, addressRdEx;

	logic [31:0] pcBranchId, pcJumpId, instructionIf, pcIf, instructionId, pcId, writeData, immediateExtendedId, dataRsId, dataRtId, immediateExtendedEx, dataRsEx, dataRtEx;

    always begin
		clk<= 1; #1;
		clk<=0; #1;
	end

    initial begin
		$dumpfile("mips.vcd");
      	$dumpvars(0, testbench);
        reset<=1; #1;
		reset<=0; hazard<=0; regWriteWb<=0; writeRegisterWb<=0; writeData<=0; #1;
	end

	instructionFetch instructionFetch0 (clk, reset, hazard, branchControlId, pcBranchId, jumpId, pcJumpId, instructionIf, pcIf);
	if_id if_id0 (clk, reset, hazard, flushId, pcIf, instructionIf, pcId, instructionId);
	instructionDecode instructionDecode0 (clk, reset, instructionId, pcId, regWriteWb, writeRegisterWb, writeData, memToRegId, regWriteId, memWriteId, memReadId, aluOpId, aluSrcId, regDstId, immediateExtendedId, addressRsId, addressRtId, addressRdId, dataRsId, dataRtId, branchControlId, pcBranchId, jumpId, pcJumpId, flushId);
	id_ex id_ex0 (clk, reset, hazard, memToRegId, regWriteId, memWriteId, memReadId, aluOpId, aluSrcId, regDstId, immediateExtendedId, addressRsId, addressRtId, addressRdId, dataRsId, dataRtId, memToRegEx, regWriteEx, memWriteEx, memReadEx, aluOpEx, aluSrcEx, regDstEx, immediateExtendedEx, addressRsEx, addressRtEx, addressRdEx, dataRsEx, dataRtEx);    



endmodule