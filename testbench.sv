module testbench();

	logic clk, reset;

	logic hazard, branchControlId, jumpId, flushId, memToRegId, regWriteId, memWriteId, memReadId, aluSrcId, regDstId, memToRegEx, regWriteEx, memWriteEx, memReadEx, aluSrcEx, regDstEx, memToRegExOutput, regWriteExOutput, memWriteExOutput, memReadExOutput, aluResultZeroEx, memToRegMemInput, regWriteMemInput, memWriteMemInput, memReadMemInput, memToRegMemOutput, regWriteMemOutput, memToRegWbInput, regWriteWbInput;

	logic [1:0] forwardingMux0Ex, forwardingMux1Ex;

	logic [3:0] aluOpId, aluOpEx;

	logic [4:0] addressRsId, addressRtId, addressRdId, addressRsEx, addressRtEx, addressRdEx, regWriteRegisterEx, regWriteRegisterMemInput, regWriteAddressMemOutput, regWriteAddressWbInput;

	logic [5:0] funcId, funcEx;

	logic [31:0] pcBranchId, pcJumpId, instructionIf, pcIf, instructionId, pcId, writeDataWbOutput, immediateExtendedId, dataRsId, dataRtId, immediateExtendedEx, dataRsEx, dataRtEx, regWriteDataWb, aluResultMem, aluResultEx, memWriteDataEx, aluResultMemInput, dataMemoryMemOutput, memWriteDataMemInput, aluResultMemOutput, dataMemoryWbInput, aluResultWbInput;

    always begin
		clk<= 1; #1;
		clk<=0; #1;
	end

    initial begin
		$dumpfile("mips.vcd");
      	$dumpvars(0, testbench);
        reset<=1; #3;
		reset<=0; hazard<=0; forwardingMux0Ex<=0; forwardingMux1Ex<=0; regWriteDataWb<=0; aluResultMem<=0; #1;
	end

	instructionFetch instructionFetch0 (clk, reset, hazard, branchControlId, pcBranchId, jumpId, pcJumpId, instructionIf, pcIf);
	if_id if_id0 (clk, reset, hazard, flushId, pcIf, instructionIf, pcId, instructionId);
	instructionDecode instructionDecode0 (clk, reset, instructionId, pcId, regWriteWbInput, regWriteAddressWbInput, writeDataWbOutput, memToRegId, regWriteId, memWriteId, memReadId, aluOpId, aluSrcId, regDstId, immediateExtendedId, addressRsId, addressRtId, addressRdId, dataRsId, dataRtId, branchControlId, pcBranchId, jumpId, pcJumpId, funcId, flushId);
	id_ex id_ex0 (clk, reset, hazard, memToRegId, regWriteId, memWriteId, memReadId, aluOpId, aluSrcId, regDstId, immediateExtendedId, addressRsId, addressRtId, addressRdId, dataRsId, dataRtId, funcId, memToRegEx, regWriteEx, memWriteEx, memReadEx, aluOpEx, aluSrcEx, regDstEx, immediateExtendedEx, addressRsEx, addressRtEx, addressRdEx, dataRsEx, dataRtEx, funcEx);    
	executing executing0 (clk, reset, memToRegEx, regWriteEx, memWriteEx, memReadEx, aluOpEx, aluSrcEx, regDstEx, immediateExtendedEx, addressRsEx, addressRtEx, addressRdEx, dataRsEx, dataRtEx, funcEx, forwardingMux0Ex, forwardingMux1Ex, regWriteDataWb, aluResultMemInput, memToRegExOutput, regWriteExOutput, memWriteExOutput, memReadExOutput, aluResultEx, memWriteDataEx, regWriteRegisterEx, aluResultZeroEx);
	ex_men ex_men0 (clk, reset, memToRegExOutput, regWriteExOutput, memWriteExOutput, memReadExOutput, aluResultEx, memWriteDataEx, regWriteRegisterEx, memToRegMemInput, regWriteMemInput, memWriteMemInput, memReadMemInput, aluResultMemInput, memWriteDataMemInput, regWriteRegisterMemInput);
	memory memory0 (clk, reset, memToRegMemInput, regWriteMemInput, memWriteMemInput, memReadMemInput, aluResultMemInput, memWriteDataMemInput, regWriteRegisterMemInput, memToRegMemOutput, regWriteMemOutput, dataMemoryMemOutput, aluResultMemOutput, regWriteAddressMemOutput);
	mem_wb mem_wb0 (clk, reset, memToRegMemOutput, regWriteMemOutput, dataMemoryMemOutput, aluResultMemOutput, regWriteAddressMemOutput, memToRegWbInput, regWriteWbInput, dataMemoryWbInput, aluResultWbInput, regWriteAddressWbInput);
	writeBack writeBack0 (memToRegWbInput, aluResultWbInput, dataMemoryWbInput, writeDataWbOutput);

endmodule