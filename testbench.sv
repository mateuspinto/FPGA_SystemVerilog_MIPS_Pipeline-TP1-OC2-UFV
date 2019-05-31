module testbench();    

    always begin
		clk <= 1; #1;
		clk<=0; #1;
	end

    initial begin
		$dumpfile("mips.vcd");
      	$dumpvars(0, testbench);
        reset<=1; #1;
		reset<=0; #1;
	end

endmodule