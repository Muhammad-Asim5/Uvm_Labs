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
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_1_seq)

  // Constructor
  function new(string name= "yapp_1_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_1_seq sequence", UVM_LOW)     
    `uvm_do_with(req,{addr == 1;})
  endtask 
 
  
endclass : yapp_1_seq


class yapp_012_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_012_seq)

  // Constructor
  function new(string name= "yapp_012_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_012_seq sequence", UVM_LOW)     
    `uvm_do_with(req,{addr == 0;})
    `uvm_do_with(req,{addr == 1;})
    `uvm_do_with(req,{addr == 2;})
  endtask

endclass : yapp_012_seq  
  
class yapp_111_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_111_seq)

  yapp_1_seq  yapp_1;

  // Constructor
  function new(string name= "yapp_111_seq");
    super.new(name);
  endfunction

  
  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_111_seq sequence", UVM_LOW)     
    repeat(3)
      `uvm_do(yapp_1)
 
  endtask
 
  
endclass : yapp_111_seq


class yapp_repeat_addr_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_repeat_addr_seq)

  rand bit [1:0] ran_addr;
  constraint c1 {ran_addr <= 2;}


  // Constructor
  function new(string name= "yapp_repeat_addr_seq");
    super.new(name);
  endfunction

  
  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_repeat_addr_seq sequence", UVM_LOW)     
    repeat(2)
      `uvm_do_with(req,{addr == ran_addr;})
 
  endtask
 
  
endclass : yapp_repeat_addr_seq





class yapp_incr_payload_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_incr_payload_seq)
   
  int ok;
 
  // Constructor
  function new(string name= "yapp_incr_payload_seq");
    super.new(name);
  endfunction

  
  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_incr_payload_seq sequence", UVM_LOW)     
    `uvm_create(req)
    ok = req.randomize();
    foreach(req.payload[i])
    begin
      req.payload[i] = i;
    end
   req.set_parity();
   `uvm_send(req);
  endtask
 
  
endclass : yapp_incr_payload_seq





class yapp_rnd_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_rnd_seq)


  // Constructor
  function new(string name= "yapp_rnd_seq");
    super.new(name);
  endfunction
  
  
  rand int countin;
  constraint c1 { countin > 0; countin <11;}
  

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_rnd_seq sequence", UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("Current no. of packets are %d", countin), UVM_LOW)
    repeat(countin)     
    `uvm_do(req)
  endtask
 
  
endclass : yapp_rnd_seq






class six_yapp_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(six_yapp_seq )


  // Constructor
  function new(string name= "six_yapp_seq ");
    super.new(name);
  endfunction
  
  int ok;
  // creating handle of yapp_rnd_seq
  rand yapp_rnd_seq yapp_rnd; 
  
  //constraint c2 {yapp_rnd.countin == 6;}


  
  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing six_yapp_seq  sequence", UVM_LOW)     
    `uvm_create(yapp_rnd)
    ok = yapp_rnd.randomize();
    yapp_rnd.countin = 6;
    `uvm_send(yapp_rnd)
  endtask
 
  
endclass : six_yapp_seq  




class yapp_exhaustive_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_exhaustive_seq)


  // Constructor
  function new(string name= "yapp_exhaustive_seq");
    super.new(name);
  endfunction
  
  // creating handles of all the sequences
  yapp_1_seq yapp_1;
  yapp_012_seq yapp_012;
  yapp_111_seq yapp_111;
  yapp_repeat_addr_seq yapp_repeat_addr;
  yapp_incr_payload_seq yapp_incr_payload;
  yapp_rnd_seq yapp_rnd;
  six_yapp_seq six_yapp;

  
  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_exhaustive_seq sequence", UVM_LOW)     
    `uvm_do(yapp_1)
    `uvm_do(yapp_012)
    `uvm_do(yapp_111)
    `uvm_do(yapp_repeat_addr)
    `uvm_do(yapp_incr_payload)
    `uvm_do(yapp_rnd)
    `uvm_do(six_yapp)
  endtask
 
  
endclass : yapp_exhaustive_seq





class simple_seq extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(simple_seq)


  // Constructor
  function new(string name= "simple_seq");
    super.new(name);
  endfunction
  
  int ok;
  
  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing simple_seq  sequence", UVM_LOW)
    for (int i = 0; i < 4; i++)
    begin     
      for(int j = 1; j<23; j++)
      begin
        `uvm_create(req)
        //req.address.constraint_mode(0);
        req.length.rand_mode(0);
        req.length = j;
        ok = req.randomize();
        req.addr = i;
        
//        req.payload.size() = j;
        req.set_parity();
        `uvm_send(req)
      end
    end
  endtask
 
  
endclass : simple_seq


class yapp6_consective_012_seq extends yapp_base_seq;
  yapp_012_seq obj;
  // Required macro for sequences automation
  `uvm_object_utils(yapp6_consective_012_seq)

  // Constructor
  function new(string name= "yapp6_consective_012_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp6_consective_012_seq sequence", UVM_LOW)     
    repeat(6)
	`uvm_do(obj)
  endtask

endclass : yapp6_consective_012_seq  


 
