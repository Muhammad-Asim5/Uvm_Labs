


class yapp_sequencer extends uvm_sequencer #(yapp_packet);

  `uvm_component_utils(yapp_sequencer)
  
  function new(string name = "yapp_sequencer" , uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(),"Starting Simulation...!", UVM_HIGH)
  endfunction
  

endclass
