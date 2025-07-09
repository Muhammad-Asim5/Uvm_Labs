
class yapp_monitor extends uvm_monitor;

  `uvm_component_utils(yapp_monitor)
  virtual interface yapp_if vif;
    // Collected Data handle
  yapp_packet pkt;

  // Count packets collected
  int num_pkt_col;
  //-------------------------- TLM ports used to connect the monitor to the scoreboard
  uvm_analysis_port #(yapp_packet) yapp_out;
  
  function new(string name = "yapp_monitor" , uvm_component parent = null);
    super.new(name,parent);
    // Create the TLM port
    yapp_out = new("yapp_out", this);
  endfunction

  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(),"Starting Simulation...!", UVM_HIGH)
  endfunction  

	/*3. Modify yapp/sv/yapp_tx_monitor.sv to create an analysis port instance.
	a. Declare an analysis port object, parameterized to the correct type.
	b. Construct the analysis port in the monitor constructor.
	c. Call the port write() at the appropriate point*/

  // UVM run() phase
  task run_phase(uvm_phase phase);
    // Look for packets after reset
    @(posedge vif.reset)
    @(negedge vif.reset)
    `uvm_info(get_type_name(), "Detected Reset Done", UVM_MEDIUM)
    forever begin 
      // Create collected packet instance
      pkt = yapp_packet::type_id::create("pkt", this);

      // concurrent blocks for packet collection and transaction recording
      fork
        // collect packet
        vif.collect_packet(pkt.length, pkt.addr, pkt.payload, pkt.parity);
        // trigger transaction at start of packet
        @(posedge vif.monstart) void'(begin_tr(pkt, "Monitor_YAPP_Packet"));
      join

      pkt.parity_type = (pkt.parity == pkt.calc_parity()) ? GOOD_PARITY : BAD_PARITY;
      // End transaction recording
      end_tr(pkt);
      `uvm_info(get_type_name(), $sformatf("Packet Collected :\n%s", pkt.sprint()), UVM_LOW)
       //------------------------------------------------------------------------------write here      
      yapp_out.write(pkt);
      num_pkt_col++;
    end
  endtask : run_phase
  
  
  // Connect phase
  function void connect_phase(uvm_phase phase);
    if(!yapp_vif_config::get( this, "", "vif", vif ))
      `uvm_info("","Virtual Interface not found...! :(",UVM_LOW)
  endfunction
  

  // UVM report_phase
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: YAPP Monitor Collected %0d Packets", num_pkt_col), UVM_LOW)
  endfunction : report_phase
endclass
