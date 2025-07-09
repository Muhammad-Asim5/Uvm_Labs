

class yapp_agent extends uvm_agent;

  `uvm_component_utils_begin(yapp_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_component_utils_end
  
  function new(string name = "yapp_agent" , uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  yapp_monitor monitor;
  yapp_driver driver;
  yapp_sequencer sequencer;
  
  
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    monitor = yapp_monitor::type_id::create("monitor",this);
    if(is_active == UVM_ACTIVE)
    begin
      driver = yapp_driver::type_id::create("driver",this);
      sequencer = yapp_sequencer::type_id::create("sequencer",this);
    end 
  endfunction
  
  
  function void connect_phase (uvm_phase phase);
    if(is_active == UVM_ACTIVE)
      driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
  
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(),"Starting Simulation...!", UVM_HIGH)
  endfunction
  
  
  
  

endclass
