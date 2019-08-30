module hazard(
	input  logic       IDEX_MemRead,
	input  logic [4:0] IFID_rs,IFID_rt,
	input  logic [4:0] IDEX_dest,
	output logic       hazard
);

	assign hazard = IDEX_MemRead & (IDEX_dest != 0) & ((IDEX_dest == IFID_rs) | (IDEX_dest == IFID_rt));

endmodule