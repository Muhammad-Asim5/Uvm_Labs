class router_mcsequencer extends uvm_sequencer #(yapp_packet);

  `uvm_component_utils(router_mcsequencer)
  
  yapp_sequencer yapp_seqr;
  hbus_master_sequencer hbus_seqr;

  function new(string name = "router_mcsequencer" , uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(),"Starting Simulation...!", UVM_HIGH)
  endfunction
endclass: router_mcsequencer
