class router_module_env extends uvm_env;

	`uvm_component_utils(router_module_env)

	//router_reference router_reference_handle;
	router_scoreboard router_scoreboard_handle;
	///////////////////////Export Declarations for Yapp and HBUS imports respectively/////////
	//uvm_analysis_export#(yapp_packet) valid_data_out_to_sb;
	uvm_analysis_export#(yapp_packet) yapp_in_export;
	uvm_analysis_export#(hbus_transaction) hbus_in_export;
	uvm_analysis_export#(channel_packet) chan0_in_export;
	uvm_analysis_export#(channel_packet) chan1_in_export;
	uvm_analysis_export#(channel_packet) chan2_in_export;
  function new (string name, uvm_component parent);
    super.new(name, parent);    
     yapp_in_export  = new("yapp_in_export", this);
     hbus_in_export =  new("hbus_in_export", this);
     chan0_in_export = new("chan0_in_export", this);
     chan1_in_export = new("chan1_in_export", this);
     chan2_in_export = new("chan2_in_export", this);
  endfunction
	
	virtual function void build_phase (uvm_phase phase);
	set_config_int( "*", "recording_detail", 1);
    	super.build_phase(phase);
    	//router_reference_handle = router_reference::type_id::create("router_reference_handle",this);
		router_scoreboard_handle = router_scoreboard::type_id::create("router_scoreboard_handle",this);
  	endfunction
  	
  	function void connect_phase(uvm_phase phase);
  		  yapp_in_export.connect(router_scoreboard_handle.yapp_fifo.analysis_export);
  		  hbus_in_export.connect(router_scoreboard_handle.Hbus_fifo.analysis_export);
  		  chan0_in_export.connect(router_scoreboard_handle.Channel0_fifo.analysis_export);
  		  chan1_in_export.connect(router_scoreboard_handle.Channel1_fifo.analysis_export);
  		  chan2_in_export.connect(router_scoreboard_handle.Channel2_fifo.analysis_export);
    	  //router_reference_handle.valid_data_out_to_sb.connect(router_scoreboard_handle.yapp_in);
  	endfunction
endclass
