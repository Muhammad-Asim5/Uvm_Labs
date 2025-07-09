class router_simple_mcseq extends uvm_sequence #(yapp_packet);

  hbus_small_packet_seq hbus_small_packet_seq_handle;
  hbus_read_max_pkt_seq hbus_read_max_pkt_seq_handle;
  hbus_set_default_regs_seq hbus_set_default_regs_seq_handle;
  yapp6_consective_012_seq yapp6_consective_012_seq_handle;
  six_yapp_seq six_yapp_seq_handle;
  `uvm_object_utils(router_simple_mcseq)
  `uvm_declare_p_sequencer(router_mcsequencer)

  function new(string name="router_simple_mcseq");
    super.new(name);
  endfunction
  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2

      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

  virtual task body();
   `uvm_do_on(hbus_small_packet_seq_handle, p_sequencer.hbus_seqr)
   `uvm_do_on(hbus_read_max_pkt_seq_handle, p_sequencer.hbus_seqr)
   `uvm_do_on(yapp6_consective_012_seq_handle, p_sequencer.yapp_seqr)
   `uvm_do_on(hbus_set_default_regs_seq_handle, p_sequencer.hbus_seqr)
   `uvm_do_on(hbus_read_max_pkt_seq_handle, p_sequencer.hbus_seqr)
   `uvm_do_on(six_yapp_seq_handle, p_sequencer.yapp_seqr)

   endtask

  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass : router_simple_mcseq



