/*-----------------------------------------------------------------
File name     : hw_top.sv
Developers    : Kathleen Meade, Brian Dickinson
Created       : 01/04/11
Description   : lab06_vif hardware top module for acceleration
              : Instantiates clock generator and YAPP interface only for testing - no DUT
Notes         : From the Cadence "SystemVerilog Accelerated Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module hw_top;

  // Clock and reset signals
  logic [31:0]  clock_period;
  logic         run_clock;
  logic         clock;
  logic         reset;

  // YAPP Interface to the DUT
  yapp_if in0(clock, reset);

  clock_and_reset_if clk_rst_intf(.clock(clock), .run_clock(run_clock), .reset(reset), .clock_period(clock_period));
  
  hbus_if hbus_intf(clock, reset);
  
  channel_if ch0_intf(clock, reset);
  channel_if ch1_intf(clock, reset);
  channel_if ch2_intf(clock, reset);
  
  
  
  

	yapp_router dut(
    .reset(reset),
    .clock(clock),
    .error(),

    // YAPP interface
    .in_data(in0.in_data),
    .in_data_vld(in0.in_data_vld),
    .in_suspend(in0.in_suspend),

    // Output Channels
    //Channel 0
    .data_0(ch0_intf.data),
    .data_vld_0(ch0_intf.data_vld),
    .suspend_0(ch0_intf.suspend),
    //Channel 1
    .data_1(ch1_intf.data),
    .data_vld_1(ch1_intf.data_vld),
    .suspend_1(ch1_intf.suspend),
    //Channel 2
    .data_2(ch2_intf.data),
    .data_vld_2(ch2_intf.data_vld),
    .suspend_2(ch2_intf.suspend),

    // HBUS Interface 
    .haddr(hbus_intf.haddr),
    .hdata(hbus_intf.hdata_w),
    .hen(hbus_intf.hen),
    .hwr_rd(hbus_intf.hwr_rd));

	
  // CLKGEN module generates clock
  clkgen clkgen (
    .clock(clock),
    .run_clock(clk_rst_intf.run_clock),
    .clock_period(clk_rst_intf.clock_period)
  );


endmodule
