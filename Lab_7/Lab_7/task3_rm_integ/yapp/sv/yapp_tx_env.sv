
class yapp_env extends uvm_env;

  `uvm_component_utils(yapp_env)
  
  function new(string name = "yapp_env" , uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  yapp_agent agent;
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    agent = yapp_agent::type_id::create("agent",this);
  endfunction
  
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(),"Starting Simulation...!", UVM_HIGH)
  endfunction

endclass
