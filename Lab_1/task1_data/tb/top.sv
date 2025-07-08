module top;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import yapp_pkg::*;

	yapp_packet pkt1;
	yapp_packet pkt1_cpy;
	yapp_packet pkt1_clone;
	
	initial
	begin
		pkt1 = new("pkt1");
		pkt1_cpy = new("pkt1_cpy");
		
		repeat(5)
		begin
			pkt1.randomize();
			pkt1.print();
		end
		
		pkt1_cpy.copy(pkt1);
		$cast (pkt1_clone, pkt1.clone());
		
		if (pkt1_cpy.compare(pkt1)) 
			`uvm_info("COMPARE", "Copied Packet == Original Packet", UVM_NONE)
		else
			`uvm_error("COMPARE", "Copied Packet != Original Packet")

		if (pkt1_clone.compare(pkt1))
			`uvm_info("COMPARE", "Cloned Packet == Original Packet", UVM_NONE)
		else
			`uvm_error("COMPARE", "Cloned Packet != Original Packet")
		$finish;
		
	end
	
endmodule