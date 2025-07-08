module top;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import yapp_pkg::*;
	`include "router_tb.sv"
	`include "router_test_lib.sv"
	
	yapp_packet pkt1;
	
	initial
	begin
		pkt1 = new();
		run_test();
	end
	
endmodule