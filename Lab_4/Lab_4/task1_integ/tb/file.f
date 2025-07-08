// 64 bit option for AWS labs
-64

-uvmhome /home/cc/mnt/XCELIUM2309/tools/methodology/UVM/CDNS-1.1d

// include directories
//*** add incdir include directories here
-incdir ../sv // include directory for sv files
-incdir ../../channel/sv
-incdir ../../hbus/sv
-incdir ../../clock_and_reset/sv

// compile files
//*** add compile files here

../sv/yapp_pkg.sv // compile YAPP package
../sv/yapp_if.sv
../../router_rtl/yapp_router.sv
../../channel/sv/channel_if.sv
../../channel/sv/channel_pkg.sv
../../hbus/sv/hbus_if.sv
../../hbus/sv/hbus_pkg.sv
../../clock_and_reset/sv/clock_and_reset_if.sv
../../clock_and_reset/sv/clock_and_reset_pkg.sv
clkgen.sv
hw_top.sv
tb_top.sv // compile top level 

+UVM_TESTNAME=test_uvc_integration
+UVM_VERBOSITY=UVM_HIGH
+SVSEED=random

-timescale 1ns/1ns
