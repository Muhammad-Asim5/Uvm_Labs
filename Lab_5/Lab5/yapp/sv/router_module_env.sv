class router_module_env extends uvm_env;

	`uvm_component_utils(router_module_env)

	router_reference router_reference_handle;
	router_scoreboard router_scoreboard_handle;
	
	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction
	
	virtual function void build_phase (uvm_phase phase);
	set_config_int( "*", "recording_detail", 1);
    	super.build_phase(phase);
    	router_reference_handle = router_reference::type_id::create("router_reference_handle",this);
		router_scoreboard_handle = router_scoreboard::type_id::create("router_scoreboard_handle",this);
  	endfunction
  	
  	function void connect_phase(uvm_phase phase);
    	  router_reference_handle.valid_data_out_to_sb.connect(router_scoreboard_handle.yapp_in);
  	endfunction
endclass
