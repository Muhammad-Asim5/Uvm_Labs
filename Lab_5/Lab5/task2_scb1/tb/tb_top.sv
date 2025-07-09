//`include "yapp_pkg.sv"

module top;
// import the UVM library
// include the UVM macros
  import uvm_pkg::*;
  `include "uvm_macros.svh"
// import the YAPP package
  import yapp_pkg::*;
// other UVC packages
  import hbus_pkg::*;
  import channel_pkg::*;
  import clock_and_reset_pkg::*;
  `include "router_mcsequencer.sv"
  `include "router_mcseqs_lib.sv"
  `include "router_scoreboard.sv"
  `include "router_tb.sv"
  `include "router_test_lib.sv"

  
  initial begin
    yapp_vif_config::set( null, "uvm_test_top.tb.env.agent.*", "vif", hw_top.in0);
    hbus_vif_config::set(null,"*.tb.hbus.*","vif", hw_top.hbus0);
    clock_and_reset_vif_config::set(null,"*.tb.clock_and_reset.*","vif", hw_top.clk_n_rst0);
    channel_vif_config::set(null,"*.tb.chan0.*","vif", hw_top.ch0);
    channel_vif_config::set(null,"*.tb.chan1.*","vif", hw_top.ch1);
    channel_vif_config::set(null,"*.tb.chan2.*","vif", hw_top.ch2);
    run_test("base_test");    
  end

endmodule : top
