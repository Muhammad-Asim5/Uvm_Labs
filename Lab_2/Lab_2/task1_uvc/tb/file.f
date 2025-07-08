// 64 bit option for AWS labs
-64

-uvmhome /home/cc/mnt/XCELIUM2309/tools/methodology/UVM/CDNS-1.1d

// include directories
//*** add incdir include directories here
-incdir ../sv // include directory for sv files

// compile files
//*** add compile files here

../sv/yapp_pkg.sv // compile YAPP package
top.sv // compile top level module

+UVM_TESTNAME=base_test
+UVM_VERBOSITY=UVM_HIGH
+SVSEED=random
