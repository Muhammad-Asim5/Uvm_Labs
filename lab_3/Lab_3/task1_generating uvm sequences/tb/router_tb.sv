class testbench extends uvm_env;
	`uvm_component_utils(testbench)
	
	yapp_tx_env yapp_uvc;
	
	function new(string name = "testbench", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("router_tb","Build Phase - testbench", UVM_HIGH)
		yapp_uvc = new("yapp_uvc", this);
		
	endfunction
	
	function void start_of_simulation_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "Simulation Phase - testbench", UVM_HIGH);
	endfunction
	
endclass