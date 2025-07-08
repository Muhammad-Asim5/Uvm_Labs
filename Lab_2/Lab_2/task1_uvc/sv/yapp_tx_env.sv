class yapp_tx_env extends uvm_env;

	yapp_tx_agent agent;
	
	`uvm_component_utils(yapp_tx_env)

	function new(string name = "yapp_tx_env", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "This is Env - Build Phase", UVM_LOW)
		agent = new("agent", this);
	endfunction
	
	function void start_of_simulation_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "Simulation Phase - env", UVM_HIGH);
	endfunction
	
endclass: yapp_packet
