module forward(
	input logic [4:0] IDEX_src1, IDEX_src2,
	input logic       EXMEM_RegWrite,
	input logic [4:0] EXMEM_dest,
	input logic       MEMWB_RegWrite,
	input logic [4:0] MEMWB_dest,

	output logic [1:0] fwdA, fwdB
);

	always_comb begin
		if (EXMEM_RegWrite && EXMEM_dest != 0 && EXMEM_dest == IDEX_src1)
			fwdA <= 1;
		else if (MEMWB_RegWrite && MEMWB_dest != 0 && MEMWB_dest == IDEX_src1)
			fwdA <= 2;
		else
			fwdA <= 0; 

		if (EXMEM_RegWrite && EXMEM_dest != 0 && EXMEM_dest == IDEX_src2)
			fwdB <= 1;
		else if (MEMWB_RegWrite && MEMWB_dest != 0 && MEMWB_dest == IDEX_src2)
			fwdB <= 2;
		else
			fwdB <= 0;
	end

endmodule