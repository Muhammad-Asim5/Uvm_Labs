class testbench extends uvm_env;
	`uvm_component_utils(testbench)
	
	yapp_tx_env yapp_uvc;
	channel_env ch0_uvc, ch1_uvc, ch2_uvc;
	hbus_env hbus_uvc;
	clock_and_reset_env clk_rst_uvc;
	
	function new(string name = "testbench", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("router_tb","Build Phase - testbench", UVM_HIGH)
		
		yapp_uvc = new("yapp_uvc", this);
		ch0_uvc = new("ch0_uvc", this);
		ch1_uvc = new("ch1_uvc", this);
		ch2_uvc = new("ch2_uvc", this);
		uvm_config_int::set(this, "ch0_uvc", "channel_id", 0);
		uvm_config_int::set(this, "ch1_uvc", "channel_id", 1);
		uvm_config_int::set(this, "ch2_uvc", "channel_id", 2);
		
		hbus_uvc = new("hbus_uvc", this);
		uvm_config_int::set(this, "hbus_uvc", "num_masters", 1);
		uvm_config_int::set(this, "hbus_uvc", "num_slaves", 0);
		
		clk_rst_uvc = new("clk_rst_uvc", this);
	endfunction
	
	function void start_of_simulation_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "Simulation Phase - testbench", UVM_HIGH);
	endfunction
	
endclass