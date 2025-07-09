-timescale 1ns/100ps
// 64 bit option for AWS labs
-64

-uvmhome /home/cc/mnt/XCELIUM2309/tools/methodology/UVM/CDNS-1.1d

// include directories
//* add incdir include directories here

// compile files
//* add compile files here
-incdir ../yapp/sv 
../yapp/sv/yapp_pkg.sv 
../yapp/sv/yapp_if.sv
-incdir ../hbus/sv
../hbus/sv/hbus_pkg.sv
../hbus/sv/hbus_if.sv
-incdir ../channel/sv
../channel/sv/channel_pkg.sv
../channel/sv/channel_if.sv
-incdir ../clock_and_reset/sv
../clock_and_reset/sv/clock_and_reset_pkg.sv
../clock_and_reset/sv/clock_and_reset_if.sv
-incdir ../Module_UVC_env 
../Module_UVC_env/router_env_pkg.sv

cdns_uvmreg_utils_pkg.sv
yapp_router_regs_rdb.sv

tb_top.sv 
clkgen.sv
hw_top.sv

-incdir ../router_rtl
../router_rtl/yapp_router.sv

+UVM_TESTNAME=reg_function_test
+UVM_VERBOSITY=UVM_FULL
