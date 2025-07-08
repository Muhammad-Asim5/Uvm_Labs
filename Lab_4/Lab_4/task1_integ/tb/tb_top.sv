module tb_top;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import yapp_pkg::*;
	import hbus_pkg::*;
	import clock_and_reset_pkg::*;
	import channel_pkg::*;
	`include "router_tb.sv"
	`include "router_test_lib.sv"
	
	initial
	begin
		yapp_vif_config::set(null, "*.tb.yapp_uvc.*", "vif", hw_top.in0);
		clock_and_reset_vif_config::set(null, "*.tb.clk_rst_uvc.*", "vif", hw_top.clk_rst_intf);
		hbus_vif_config::set(null,"*.tb.hbus_uvc.*","vif", hw_top.hbus_intf);
		channel_vif_config::set(null,"*.tb.ch0_uvc.*","vif", hw_top.ch0_intf);
		channel_vif_config::set(null,"*.tb.ch1_uvc.*","vif", hw_top.ch1_intf);
		channel_vif_config::set(null,"*.tb.ch2_uvc.*","vif", hw_top.ch2_intf);
		
  		run_test();	
	end
	
endmodule
