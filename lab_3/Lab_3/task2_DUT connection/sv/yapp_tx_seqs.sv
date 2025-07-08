class yapp_base_seq extends uvm_sequence #(yapp_packet);
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_base_seq)

  // Constructor
  function new(string name="yapp_base_seq");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

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

endclass : yapp_base_seq

//------------------------------------------------------------------------------
//
// SEQUENCE: yapp_5_packets
//
//  Configuration setting for this sequence
//    - update <path> to be hierarchial path to sequencer 
//
//  uvm_config_wrapper::set(this, "<path>.run_phase",
//                                 "default_sequence",
//                                 yapp_5_packets::get_type());
//
//------------------------------------------------------------------------------
class yapp_5_packets extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_5_packets)

  // Constructor
  function new(string name="yapp_5_packets");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_5_packets sequence", UVM_LOW)
     repeat(5)
      `uvm_do(req)
  endtask
  
endclass : yapp_5_packets

class yapp_1_seq extends yapp_base_seq;
	`uvm_object_utils(yapp_1_seq)
	
  function new(string name="yapp_1_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_1_seq sequence", UVM_LOW)
      `uvm_do_with(req,{addr == 1;})
  endtask

endclass

class yapp_012_seq extends yapp_base_seq;
	`uvm_object_utils(yapp_012_seq)
	
  function new(string name="yapp_012_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_012_seq sequence", UVM_LOW)
      `uvm_do_with(req,{addr == 0;})
      `uvm_do_with(req,{addr == 1;})
      `uvm_do_with(req,{addr == 2;})
  endtask

endclass

class yapp_111_seq extends yapp_base_seq;
	`uvm_object_utils(yapp_111_seq)
	
  function new(string name="yapp_111_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_111_seq sequence", UVM_LOW)
    repeat(3)
      `uvm_do_with(req,{addr == 1;})
  endtask

endclass

class yapp_repeat_addr_seq extends yapp_base_seq;
	`uvm_object_utils(yapp_repeat_addr_seq)
	bit [1:0] addr_local;
  function new(string name="yapp_repeat_addr_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_repeat_addr_seq sequence", UVM_LOW)
      `uvm_do(req)
      addr_local = req.addr;
      `uvm_do_with(req,{addr == addr_local;})
  endtask

endclass

class yapp_incr_payload_seq extends yapp_base_seq;
	`uvm_object_utils(yapp_incr_payload_seq)
	
  function new(string name="yapp_incr_payload_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_incr_payload_seq sequence", UVM_LOW)
      `uvm_create(req)
      //req.randomize();
      foreach (req.payload[i])
      	req.payload[i] = i;
      req.set_parity();
      `uvm_send(req)
  endtask

endclass

class yapp_rnd_seq extends yapp_base_seq;
	`uvm_object_utils(yapp_rnd_seq)
	
	rand int countin;
	
	constraint c_countin {countin inside {[1:10]};}
	
  function new(string name="yapp_rnd_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_rnd_seq sequence", UVM_LOW)
   // countin.randomize();
    repeat(countin)
      `uvm_do(req)
  endtask
  
endclass

class six_yapp_seq extends yapp_base_seq;
	`uvm_object_utils(six_yapp_seq)
	
	yapp_rnd_seq rnd_seq;
	
	
  function new(string name="six_yapp_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing six_yapp_seq sequence", UVM_LOW)
      `uvm_do_with(rnd_seq, {rnd_seq.countin == 6;})
  endtask
  
endclass

class yapp_exhaustive_seq extends yapp_base_seq;
	`uvm_object_utils(yapp_exhaustive_seq)
	
	yapp_1_seq y1;
	yapp_012_seq y012;
	yapp_111_seq y111;
	yapp_repeat_addr_seq y_addr;
	yapp_incr_payload_seq y_payload;
	yapp_rnd_seq y_rnd_seq;
	six_yapp_seq y_six_seq;
	
	
  function new(string name="yapp_exhaustive_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_exhaustive_seq sequence", UVM_LOW)
      `uvm_do(y1)
      `uvm_do(y012)
      `uvm_do(y111)
      `uvm_do(y_addr)
      `uvm_do(y_payload)
      `uvm_do(y_rnd_seq)
      `uvm_do(y_six_seq)
  endtask
  
endclass
