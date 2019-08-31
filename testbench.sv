module testbench();

	logic clk, reset;

	logic hazard, jumpIdOutput, memToRegId, regWriteId, memWriteId, memReadId, aluSrcId, regDstId, memToRegEx, regWriteEx, memWriteEx, memReadEx, aluSrcEx, regDstEx, memToRegExOutput, regWriteExOutput, memWriteExOutput, memReadExOutput, aluResultZeroEx, memToRegMemInput, regWriteMemInput, memWriteMemInput, memReadMemInput, memToRegMemOutput, regWriteMemOutput, memToRegWbInput, regWriteWbInput, branchControlExOutput;

	logic [1:0] forwardingMux0Ex, forwardingMux1Ex, forwardC, branchIdOutput, branchExInput;

	logic [3:0] aluOpId, aluOpEx;

	logic [4:0] addressRsId, addressRtId, addressRdId, addressRsEx, addressRtEx, addressRdEx, regWriteRegisterEx, regWriteRegisterMemInput, regWriteAddressMemOutput, regWriteAddressWbInput;

	logic [5:0] funcId, funcEx;

	logic [31:0] pcBranchExOutput, pcJumpIdOutput, instructionIfInput, pcIfInput, instructionIdInput, pcIdInput, writeDataWbOutput, immediateExtendedId, dataRsId, dataRtId, immediateExtendedEx, dataRsEx, dataRtEx, aluResultEx, memWriteDataEx, aluResultMemInput, dataMemoryMemOutput, memWriteDataMemInput, aluResultMemOutput, dataMemoryWbInput, aluResultWbInput, pc4IdOutput, pc4ExInput;

    always begin
		clk<= 1; #1;
		clk<=0; #1;
	end

    initial begin
		$dumpfile("mips.vcd");
      	$dumpvars(0, testbench);
        reset<=1; #3;
		reset<=0; #1;
	end

	hazard hazard0 (memReadEx, addressRsId, addressRtId, regWriteRegisterEx, hazard);
	forward forward0 (addressRsEx, addressRtEx, addressRdEx, regWriteMemInput, regWriteAddressMemOutput, regWriteWbInput, regWriteAddressWbInput, forwardingMux0Ex, forwardingMux1Ex, forwardC);

	instructionFetch instructionFetch0 (clk, reset, hazard, branchControlExOutput, pcBranchExOutput, jumpIdOutput, pcJumpIdOutput, instructionIfInput, pcIfInput);
	if_id if_id0 (clk, reset, hazard, branchControlExOutput, jumpIdOutput, pcIfInput, instructionIfInput, pcIdInput, instructionIdInput);
	instructionDecode instructionDecode0 (clk, reset, instructionIdInput, pcIdInput, regWriteWbInput, regWriteAddressWbInput, writeDataWbOutput, pc4IdOutput, memToRegId, regWriteId, memWriteId, memReadId, aluOpId, aluSrcId, regDstId, branchIdOutput, immediateExtendedId, addressRsId, addressRtId, addressRdId, dataRsId, dataRtId, jumpIdOutput, pcJumpIdOutput, funcId);
	id_ex id_ex0 (clk, reset, hazard, branchControlExOutput, pc4IdOutput, memToRegId, regWriteId, memWriteId, memReadId, aluOpId, aluSrcId, regDstId, branchIdOutput, immediateExtendedId, addressRsId, addressRtId, addressRdId, dataRsId, dataRtId, funcId, pc4ExInput, memToRegEx, regWriteEx, memWriteEx, memReadEx, aluOpEx, aluSrcEx, regDstEx, branchExInput, immediateExtendedEx, addressRsEx, addressRtEx, addressRdEx, dataRsEx, dataRtEx, funcEx);    
	executing executing0 (clk, reset, pc4ExInput, memToRegEx, regWriteEx, memWriteEx, memReadEx, aluOpEx, aluSrcEx, regDstEx, branchExInput, immediateExtendedEx, addressRsEx, addressRtEx, addressRdEx, dataRsEx, dataRtEx, funcEx, forwardingMux0Ex, forwardingMux1Ex, writeDataWbOutput, aluResultMemInput, memToRegExOutput, regWriteExOutput, memWriteExOutput, memReadExOutput, aluResultEx, memWriteDataEx, regWriteRegisterEx, aluResultZeroEx, branchControlExOutput, pcBranchExOutput);
	ex_men ex_men0 (clk, reset, memToRegExOutput, regWriteExOutput, memWriteExOutput, memReadExOutput, aluResultEx, memWriteDataEx, regWriteRegisterEx, memToRegMemInput, regWriteMemInput, memWriteMemInput, memReadMemInput, aluResultMemInput, memWriteDataMemInput, regWriteRegisterMemInput);
	memory memory0 (clk, reset, memToRegMemInput, regWriteMemInput, memWriteMemInput, memReadMemInput, aluResultMemInput, memWriteDataMemInput, regWriteRegisterMemInput, memToRegMemOutput, regWriteMemOutput, dataMemoryMemOutput, aluResultMemOutput, regWriteAddressMemOutput);
	mem_wb mem_wb0 (clk, reset, memToRegMemOutput, regWriteMemOutput, dataMemoryMemOutput, aluResultMemOutput, regWriteAddressMemOutput, memToRegWbInput, regWriteWbInput, dataMemoryWbInput, aluResultWbInput, regWriteAddressWbInput);
	writeBack writeBack0 (memToRegWbInput, aluResultWbInput, dataMemoryWbInput, writeDataWbOutput);

endmodule