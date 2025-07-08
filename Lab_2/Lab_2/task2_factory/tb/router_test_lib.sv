class base_test extends uvm_test;
	`uvm_component_utils(base_test)
	
	testbench tb;
	
	function new(string name = "base_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("router_test_lib","Build Phase - base_test", UVM_HIGH)
		uvm_config_wrapper::set(this, "tb.yapp_uvc.agent.sequencer.run_phase","default_sequence",yapp_5_packets::get_type());
    	tb = new("tb",this);
		uvm_config_int::set( this, "*", "recording_detail", 1);
	endfunction
	
	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		`uvm_info("router_test_lib","End of Elaboration Phase - testbench", UVM_HIGH)
		uvm_top.print_topology();
	endfunction
	
	function void check_phase(uvm_phase phase);
		super.check_phase(phase);
		`uvm_info("router_test_lib","Check Phase - testbench", UVM_HIGH)
		check_config_usage();
	endfunction
	
endclass

class test2 extends base_test;
	`uvm_component_utils(test2)
	
	function new(string name = "test2", uvm_component parent);
		super.new(name,parent);
	endfunction
	
endclass

class short_packet_test extends base_test;
	
	function new(string name = "short_packet_test" , uvm_component parent);
    	super.new(name, parent);
    endfunction

  	virtual function void build_phase(uvm_phase phase);
  		super.build_phase(phase);
  		`uvm_info("router_test_lib","Build Phase - short_packet_test", UVM_HIGH) 
  		set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
  	endfunction
	
endclass
	
class set_config_test extends base_test;
	`uvm_component_utils(set_config_test)	
	
	function new(string name = "set_config_test" , uvm_component parent = null);
    	super.new(name, parent);
    endfunction
    
   	
  	virtual function void build_phase(uvm_phase phase);
  		super.build_phase(phase);
  		`uvm_info("router_test_lib","Build Phase - set_config_test", UVM_HIGH) 
  		
  		uvm_config_int::set( this, "*", "is_active", UVM_PASSIVE);
  		uvm_config_int::set( this, "*", "recording_detail", 0);
  	endfunction

	function void check_phase(uvm_phase phase);
		super.check_phase(phase);
		`uvm_info("router_test_lib","Check Phase - set_config_test", UVM_HIGH)
		check_config_usage();
	endfunction
endclass