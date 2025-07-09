
class base_test extends uvm_test;
  // factory registration
  `uvm_component_utils(base_test)
  
  // constructor
  function new (string name = "base_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  // testbench class handle
  router_tb tb;
  
  //build phase for the test
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("","Build Phase of test is being executed...!", UVM_HIGH)
   
    tb = router_tb::type_id::create("tb",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    uvm_objection obj = phase.get_objection();
    obj.set_drain_time(this,200ns);
  endtask
  
  // end of elaboration phase
  function void end_of_elaboration_phase (uvm_phase phase);
    uvm_top.print_topology();
  endfunction
  
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(),"Starting Simulation...!", UVM_HIGH)
  endfunction
  
  function void check_phase(uvm_phase phase);
    check_config_usage();
  endfunction
  
endclass


class test_2 extends base_test;
  // factory registration
  `uvm_component_utils(test_2)
  
  // constructor for test 2
  function new (string name = "test_2", uvm_component parent = null);
    super.new(name,parent);
    `uvm_info("Test2", "You are in Test2",UVM_HIGH)
  endfunction
  
endclass



class short_packet_test extends base_test;
  
  `uvm_component_utils(short_packet_test)
  
  function new(string name = "short_packet_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    set_type_override_by_type( yapp_packet::get_type(), short_yapp_packet::get_type() );
  endfunction
  
endclass


class set_config_test extends base_test;

  `uvm_component_utils(set_config_test)
  
  function new(string name = "set_config_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    uvm_config_int::set(this,"tb.env.agent","is_active",UVM_PASSIVE);
   // uvm_config_db#(int)::set(null,"uvm_test_top","verbosity",UVM_DEBUG);  // supressing configuration msgs from printing
    super.build_phase(phase);
  endfunction

endclass


class incr_payload_test extends base_test;

  `uvm_component_utils(incr_payload_test)
  
  function new(string name = "incr_payload_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    set_type_override_by_type( yapp_packet::get_type(), short_yapp_packet::get_type() );
    super.build_phase(phase);
    uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase",
                                 "default_sequence",
                                 yapp_incr_payload_seq::get_type());
  endfunction

endclass


class exhaustive_seq_test extends base_test;

  `uvm_component_utils(exhaustive_seq_test)
  
  function new(string name = "exhaustive_seq_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    set_type_override_by_type( yapp_packet::get_type(), short_yapp_packet::get_type() );
    super.build_phase(phase);
    uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase",
                                 "default_sequence",
                                 yapp_exhaustive_seq::get_type());
  endfunction

endclass


class yapp_test extends base_test;

  `uvm_component_utils(yapp_test)
  
  function new(string name = "yapp_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    set_type_override_by_type( yapp_packet::get_type(), short_yapp_packet::get_type() );
    super.build_phase(phase);
    uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase",
                                 "default_sequence",
                                 yapp_012_seq::get_type());
  endfunction

endclass



class simple_test extends base_test;
  
  `uvm_component_utils(simple_test)
  
  function new(string name="simple_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
    super.build_phase(phase);
    uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase",
                                 "default_sequence",
                                 yapp_012_seq::get_type());
    uvm_config_wrapper::set(this, "tb.chan?.rx_agent.sequencer.run_phase",
                            "default_sequence",
                            channel_rx_resp_seq::get_type());
    uvm_config_wrapper::set(this, "tb.clock_and_reset.agent.sequencer.run_phase",
							"default_sequence",
							clk10_rst5_seq::get_type());	
                                 
  endfunction
endclass



class test_uvc_integration extends base_test;
  
  `uvm_component_utils(test_uvc_integration)
  
  function new(string name="test_uvc_integration", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
    super.build_phase(phase);
    uvm_config_wrapper::set(this, "tb.env.agent.sequencer.run_phase",
                                 "default_sequence",
                                 simple_seq::get_type());
    uvm_config_wrapper::set(this, "tb.chan?.rx_agent.sequencer.run_phase",
                            "default_sequence",
                            channel_rx_resp_seq::get_type());
    uvm_config_wrapper::set(this, "tb.clock_and_reset.agent.sequencer.run_phase",
							"default_sequence",
							clk10_rst5_seq::get_type());
    uvm_config_wrapper::set(this, "tb.hbus.masters[0].sequencer.run_phase",
							"default_sequence",
							hbus_small_packet_seq::get_type());	
                                 
  endfunction
endclass

class multi_channel_seq_test extends base_test;
  
  `uvm_component_utils(multi_channel_seq_test)
  
  function new(string name="multi_channel_seq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
    super.build_phase(phase);
    uvm_config_wrapper::set(this, "tb.mcseqr.run_phase",
                                 "default_sequence",
                                 router_simple_mcseq::get_type());
    uvm_config_wrapper::set(this, "tb.chan?.rx_agent.sequencer.run_phase",
                            "default_sequence",
                            channel_rx_resp_seq::get_type());
    uvm_config_wrapper::set(this, "tb.clock_and_reset.agent.sequencer.run_phase",
							"default_sequence",
							clk10_rst5_seq::get_type());
                            
  endfunction
endclass : multi_channel_seq_test


class  uvm_reset_test extends base_test;

    uvm_reg_hw_reset_seq reset_seq;

  // component macro
  `uvm_component_utils(uvm_reset_test)

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
      uvm_reg::include_coverage("*", UVM_NO_COVERAGE);
      reset_seq = uvm_reg_hw_reset_seq::type_id::create("uvm_reset_seq");
      super.build_phase(phase);
  endfunction : build_phase

  virtual task run_phase (uvm_phase phase);
     phase.raise_objection(this, "Raising Objection to run uvm built in reset test");
     // Set the model property of the sequence to our Register Model instance
     // Update the RHS of this assignment to match your instance names. Syntax is:
     //  <testbench instance>.<register model instance>
     reset_seq.model = tb.yapp_rm;
     uvm_config_wrapper::set(this, "tb.clock_and_reset.agent.sequencer.run_phase",
			"default_sequence",
				clk10_rst5_seq::get_type());
     // Execute the sequence (sequencer is already set in the testbench)
     reset_seq.start(null);
     phase.drop_objection(this," Dropping Objection to uvm built reset test finished");
     
     
  endtask

endclass : uvm_reset_test

class  uvm_mem_walk_test extends base_test;

    uvm_mem_walk_seq mem_walk_seq;

  // component macro
  `uvm_component_utils(uvm_mem_walk_test)

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
      uvm_reg::include_coverage("*", UVM_NO_COVERAGE);
      mem_walk_seq = uvm_mem_walk_seq::type_id::create("mem_walk_seq");
      super.build_phase(phase);
  endfunction : build_phase

  virtual task run_phase (uvm_phase phase);
     phase.raise_objection(this, "Raising Objection to run uvm built in reset test");
     // Set the model property of the sequence to our Register Model instance
     // Update the RHS of this assignment to match your instance names. Syntax is:
     //  <testbench instance>.<register model instance>
     mem_walk_seq.model = tb.yapp_rm;
     uvm_config_wrapper::set(this, "tb.clock_and_reset.agent.sequencer.run_phase",
			"default_sequence",
				clk10_rst5_seq::get_type());
     // Execute the sequence (sequencer is already set in the testbench)
     mem_walk_seq.start(null);
     phase.drop_objection(this," Dropping Objection to uvm built reset test finished");
     
     
  endtask

endclass : uvm_mem_walk_test

class reg_access_test extends base_test;

    //reg_access_test reg_access_seq;
	yapp_regs_c yapp_regs;
	uvm_status_e status;
	logic [7:0] rdata;
  // component macro
  `uvm_component_utils(reg_access_test)

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
      uvm_reg::include_coverage("*", UVM_NO_COVERAGE);
      //yapp_regs = yapp_regs_c::type_id::create("yapp_regs");
      super.build_phase(phase);
  endfunction : build_phase
	
  virtual task run_phase (uvm_phase phase);
     phase.raise_objection(this, "Raising Objection to run uvm built in reset test");
     // Set the model property of the sequence to our Register Model instance
     // Update the RHS of this assignment to match your instance names. Syntax is:
     //  <testbench instance>.<register model instance>
    // reg_access_seq.model = tb.yapp_rm;
     uvm_config_wrapper::set(this, "tb.clock_and_reset.agent.sequencer.run_phase",
			"default_sequence",
				clk10_rst5_seq::get_type());
     // Execute the sequence (sequencer is already set in the testbench)
     //reg_access_seq.start(null);
     $display("rdata before peek is %0d",rdata);
     ///////////////////////////////// RW Resgister Test /////////////////////
     uvm_report_info("Register Access","RW Register Testing ",UVM_NONE);
     //yapp_regs.en_reg.set(8'hff);
       yapp_regs.en_reg.poke(status, 8'h52);
     yapp_regs.en_reg.read(status, rdata);
  
  
     yapp_regs.en_reg.write(status, 8'hA5);
     yapp_regs.en_reg.peek(status, rdata);
     $display("rdata after peek is %0d",rdata);
     assert(rdata == 8'hA5)
     else 
     	$error("RW Register Mismatch After Peek!");
     	
     	  

     
     assert(rdata == 8'h52)
     else 
     	$error("RW Register Mismatch After Read!");     	
     
     
     ////////RO Register Checking ///////////////////
     uvm_report_info("Register Access","RO Register Testing ",UVM_NONE);
     yapp_regs.addr0_cnt_reg.poke(status, 8'h85);
     yapp_regs.addr0_cnt_reg.read(status, rdata);
     
     assert(rdata == 8'h85)
     else 
     	$error("RO Register Mismatch After Peek!");
     	
     	
     yapp_regs.addr0_cnt_reg.write(status, 8'h75);
     yapp_regs.addr0_cnt_reg.peek(status, rdata);
     
     assert(rdata != 8'h75)
     else 
     	$error("RO Register Mismatch After Read!"); 
     phase.drop_objection(this," Dropping Objection to uvm built reset test finished");
          
  endtask
  
  function void connect_phase(uvm_phase phase);
  		yapp_regs = tb.yapp_rm.router_yapp_regs;
  endfunction
endclass : reg_access_test



class  reg_function_test extends base_test;

    

  // component macro
  `uvm_component_utils(reg_function_test)
  
  // convenience handle
  yapp_regs_c yapp_regs;
  uvm_status_e status;
  bit [7:0] rdata;

  yapp_sequencer sequencer;

  yapp_012_seq yapp_012;

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
      uvm_reg::include_coverage("*", UVM_NO_COVERAGE);
      super.build_phase(phase);
      uvm_config_wrapper::set(this, "tb.chan?.rx_agent.sequencer.run_phase",
                            "default_sequence",
                            channel_rx_resp_seq::get_type());
      uvm_config_wrapper::set(this, "tb.clock_and_reset.agent.sequencer.run_phase",
							"default_sequence",
							clk10_rst5_seq::get_type());
	  yapp_012 = yapp_012_seq::type_id::create("yapp_012", this);
  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
  yapp_regs = tb.yapp_rm.router_yapp_regs;
  sequencer = tb.env.agent.sequencer;
  
  
  endfunction

  virtual task run_phase (uvm_phase phase);
     phase.raise_objection(this, "Raising Objection to run uvm built in reset test");
     tb.yapp_rm.default_map.set_check_on_read(1);

     yapp_regs.en_reg.router_en.write(status, 1'b1);

     yapp_regs.en_reg.router_en.peek(status,rdata);

     yapp_012.start(sequencer);

     yapp_regs.addr0_cnt_reg.read(status,rdata);
     yapp_regs.addr1_cnt_reg.read(status,rdata);
     yapp_regs.addr2_cnt_reg.read(status,rdata);
     yapp_regs.addr3_cnt_reg.read(status,rdata);

     yapp_regs.en_reg.write(status, 8'hFF);

     repeat (2)
     yapp_012.start(sequencer);
     yapp_regs.addr0_cnt_reg.predict('h2);
     yapp_regs.addr1_cnt_reg.predict('h2);
     yapp_regs.addr2_cnt_reg.predict('h2);
     yapp_regs.addr3_cnt_reg.predict('h0);
     yapp_regs.addr0_cnt_reg.read(status,rdata);
     yapp_regs.addr1_cnt_reg.read(status,rdata);
     yapp_regs.addr2_cnt_reg.read(status,rdata);
     yapp_regs.addr3_cnt_reg.read(status,rdata);
     yapp_regs.oversized_pkt_cnt_reg.read(status,rdata);
     yapp_regs.parity_err_cnt_reg.read(status,rdata);
     phase.drop_objection(this," Dropping Objection to uvm built reset test finished");          
  endtask

endclass : reg_function_test


class  reg_introspection_test extends base_test;

    

  // component macro
  `uvm_component_utils(reg_introspection_test)
  

  yapp_regs_c yapp_regs;

  uvm_status_e status;

  bit [7:0] rdata;

  uvm_reg qregs[$], rwregs[$], roregs[$];
  

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
      uvm_reg::include_coverage("*", UVM_NO_COVERAGE);
      super.build_phase(phase);
      uvm_config_wrapper::set(this, "tb.clock_and_reset.agent.sequencer.run_phase",
							"default_sequence",
							clk10_rst5_seq::get_type());
  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
  yapp_regs = tb.yapp_rm.router_yapp_regs;  
  endfunction

  virtual task run_phase (uvm_phase phase);
     phase.raise_objection(this, "Raising Objection to run uvm built in reset test");
    yapp_regs.get_registers(qregs);
    foreach(qregs[i]) begin
      if (qregs[i].get_rights() == "RO") begin
        roregs.push_back(qregs[i]);
      end else if (qregs[i].get_rights() == "RW") begin
        rwregs.push_back(qregs[i]);
      end
    end
    foreach (rwregs[i]) begin
      rwregs[i].write(status, 8'h5A);
      rwregs[i].read(status, rdata);
      `uvm_info("RW_REGS", $sformatf("RW Register %0d: %s, Read Data: 0x%0h", 
                                      i, rwregs[i].get_name(), rdata), UVM_LOW)
    end
    
    `uvm_info("RW_REGS", "Read-Write Registers:", UVM_LOW)
    foreach (rwregs[i]) begin
      `uvm_info("RW_REGS", $sformatf("RW Register %0d: %s", i, rwregs[i].get_name()), UVM_LOW)
    end
    `uvm_info("RO_REGS", "Read-Only Registers:", UVM_LOW)
    foreach (roregs[i]) begin
      `uvm_info("RO_REGS", $sformatf("RO Register %0d: %s", i, roregs[i].get_name()), UVM_LOW)
    end

    phase.drop_objection(this, "Dropping Objection to indicate the test has finished");          
  endtask
     
     
  
endclass : reg_introspection_test






