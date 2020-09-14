# TCL File Generated by Component Editor 19.1
# Tue Oct 15 20:04:41 CEST 2019
# DO NOT MODIFY


# 
# de5net_identity "DE5-Net Identity" v1.0
# bluecmd 2019.10.15.20:04:41
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module de5net_identity
# 
set_module_property DESCRIPTION ""
set_module_property NAME de5net_identity
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR bluecmd
set_module_property DISPLAY_NAME "DE5-Net Identity"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL de5net_identity
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file de5net_identity.sv VERILOG PATH de5net_identity.sv TOP_LEVEL_FILE
add_fileset_file version.sv VERILOG PATH version.sv

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL de5net_identity
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file de5net_identity.sv VERILOG PATH de5net_identity.sv
add_fileset_file version.sv VERILOG PATH version.sv


# 
# parameters
# 


# 
# display items
# 


# 
# connection point mm
# 
add_interface mm avalon end
set_interface_property mm addressUnits WORDS
set_interface_property mm associatedClock clk
set_interface_property mm associatedReset reset
set_interface_property mm bitsPerSymbol 8
set_interface_property mm burstOnBurstBoundariesOnly false
set_interface_property mm burstcountUnits WORDS
set_interface_property mm explicitAddressSpan 0
set_interface_property mm holdTime 0
set_interface_property mm linewrapBursts false
set_interface_property mm maximumPendingReadTransactions 0
set_interface_property mm maximumPendingWriteTransactions 0
set_interface_property mm readLatency 0
set_interface_property mm readWaitTime 1
set_interface_property mm setupTime 0
set_interface_property mm timingUnits Cycles
set_interface_property mm writeWaitTime 0
set_interface_property mm ENABLED true
set_interface_property mm EXPORT_OF ""
set_interface_property mm PORT_NAME_MAP ""
set_interface_property mm CMSIS_SVD_VARIABLES ""
set_interface_property mm SVD_ADDRESS_GROUP ""

add_interface_port mm mm_readdata readdata Output 32
add_interface_port mm mm_address address Input 1
set_interface_assignment mm embeddedsw.configuration.isFlash 0
set_interface_assignment mm embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment mm embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment mm embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clk
# 
add_interface clk clock end
set_interface_property clk clockRate 0
set_interface_property clk ENABLED true
set_interface_property clk EXPORT_OF ""
set_interface_property clk PORT_NAME_MAP ""
set_interface_property clk CMSIS_SVD_VARIABLES ""
set_interface_property clk SVD_ADDRESS_GROUP ""

add_interface_port clk clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clk
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1
