
class router_tb extends uvm_env;

  `uvm_component_utils(router_tb)
  

  function new (string name = "router_tb", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  router_mcsequencer mcseqr;

  yapp_env env;

  channel_env chan0;
  channel_env chan1;
  channel_env chan2;

  hbus_env hbus;

  clock_and_reset_env clock_and_reset; 
  yapp_sequencer yapp_seqr;
  hbus_master_sequencer hbus_seqr;
  
  

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("","Build Phase of testbench is being executed...!", UVM_HIGH)
    env = yapp_env::type_id::create("env", this);

    uvm_config_int::set(this,"chan0","channel_id",0);
    uvm_config_int::set(this,"chan1","channel_id",1);
    uvm_config_int::set(this,"chan2","channel_id",2);

    uvm_config_int::set(this,"hbus","num_masters",1);
    uvm_config_int::set(this,"hbus","num_slaves ",0);

    chan0 = channel_env::type_id::create("chan0",this);
    chan1 = channel_env::type_id::create("chan1",this);
    chan2 = channel_env::type_id::create("chan2",this);

    hbus = hbus_env::type_id::create("hbus",this);

    clock_and_reset = clock_and_reset_env::type_id::create("clock_and_reset",this);

    mcseqr = router_mcsequencer::type_id::create("mcseqr",this);
  endfunction
  
    function void connect_phase (uvm_phase phase);
    mcseqr.hbus_seqr = hbus.masters[0].sequencer;
    mcseqr.yapp_seqr = env.agent.sequencer;
  endfunction
  
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(),"Starting Simulation...!", UVM_HIGH)
  endfunction
 
endclass
