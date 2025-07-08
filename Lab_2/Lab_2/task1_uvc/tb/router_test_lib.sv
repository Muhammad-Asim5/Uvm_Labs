class base_test extends uvm_test;
	`uvm_component_utils(base_test)
	
	router_tb tb;
	
	function new(string name = "base_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("router_test_lib","Build Phase - base_test", UVM_HIGH)
		uvm_config_wrapper::set(this, "tb.yapp_uvc.agent.sequencer.run_phase","default_sequence",yapp_5_packets::get_type());
    	tb = new("tb",this);
	endfunction
	
	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		`uvm_info("router_tb","End of Elaboration Phase - testbench", UVM_HIGH)
		uvm_top.print_topology();
	endfunction
	
endclass

class test2 extends base_test;
	`uvm_component_utils(test2)
	
	function new(string name = "test2", uvm_component parent);
		super.new(name,parent);
	endfunction
	
endclass
