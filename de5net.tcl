# qsys scripting (.tcl) file for de5net
package require -exact qsys 16.0

create_system {de5net}

set_project_property DEVICE_FAMILY {Stratix V}
set_project_property DEVICE {5SGXEA7N2F45C2}
set_project_property HIDE_FROM_IP_CATALOG {false}

# Instances and instance parameters
# (disabled instances are intentionally culled)
add_instance ext0 clock_source 20.1
set_instance_parameter_value ext0 {clockFrequency} {50000000.0}
set_instance_parameter_value ext0 {clockFrequencyKnown} {1}
set_instance_parameter_value ext0 {resetSynchronousEdges} {NONE}

add_instance ident de5net_identity 1.0

add_instance jtagm altera_jtag_avalon_master 20.1
set_instance_parameter_value jtagm {FAST_VER} {0}
set_instance_parameter_value jtagm {FIFO_DEPTHS} {2}
set_instance_parameter_value jtagm {PLI_PORT} {50000}
set_instance_parameter_value jtagm {USE_PLI} {0}

add_instance phy_clk altera_clock_bridge 20.1
set_instance_parameter_value phy_clk {EXPLICIT_CLOCK_RATE} {106250000.0}
set_instance_parameter_value phy_clk {NUM_CLOCK_OUTPUTS} {1}

add_instance phy_clk_gauge freq_gauge 1.0

add_instance reset_ctrl altera_reset_controller 20.1
set_instance_parameter_value reset_ctrl {MIN_RST_ASSERTION_TIME} {3}
set_instance_parameter_value reset_ctrl {NUM_RESET_INPUTS} {2}
set_instance_parameter_value reset_ctrl {OUTPUT_RESET_SYNC_EDGES} {deassert}
set_instance_parameter_value reset_ctrl {RESET_REQUEST_PRESENT} {0}
set_instance_parameter_value reset_ctrl {RESET_REQ_EARLY_DSRT_TIME} {1}
set_instance_parameter_value reset_ctrl {RESET_REQ_WAIT_TIME} {1}
set_instance_parameter_value reset_ctrl {SYNC_DEPTH} {2}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN0} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN1} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN10} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN11} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN12} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN13} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN14} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN15} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN2} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN3} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN4} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN5} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN6} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN7} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN8} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_IN9} {0}
set_instance_parameter_value reset_ctrl {USE_RESET_REQUEST_INPUT} {0}

add_instance reset_seqencer altera_reset_sequencer 20.1
set_instance_parameter_value reset_seqencer {ENABLE_CSR} {0}
set_instance_parameter_value reset_seqencer {ENABLE_RESET_REQUEST_INPUT} {0}
set_instance_parameter_value reset_seqencer {LIST_ASRT_DELAY} {0 0 0 0 0 0 0 0 0 0}
set_instance_parameter_value reset_seqencer {LIST_ASRT_SEQ} {0 1 2 3 4 5 6 7 8 9}
set_instance_parameter_value reset_seqencer {LIST_DSRT_DELAY} {0 0 0 0 0 0 0 0 0 0}
set_instance_parameter_value reset_seqencer {LIST_DSRT_SEQ} {0 1 2 3 4 5 6 7 8 9}
set_instance_parameter_value reset_seqencer {MIN_ASRT_TIME} {0}
set_instance_parameter_value reset_seqencer {NUM_INPUTS} {1}
set_instance_parameter_value reset_seqencer {NUM_OUTPUTS} {5}
set_instance_parameter_value reset_seqencer {USE_DSRT_QUAL} {0 0 0 0 0 0 0 0 0 0}

add_instance rs422_ctrl rs422_ctrl 1.0

add_instance sfp0 de5net_sfp 1.0

add_instance sfp1 de5net_sfp 1.0

add_instance sfp2 de5net_sfp 1.0

add_instance sfp3 de5net_sfp 1.0

add_instance temp intel_temp 1.0
set_instance_parameter_value temp {FanInvOut} {0}
set_instance_parameter_value temp {FanOut} {1}
set_instance_parameter_value temp {FanTemp} {60}

add_instance temp_sense altera_temp_sense 20.1
set_instance_parameter_value temp_sense {CBX_AUTO_BLACKBOX} {ALL}
set_instance_parameter_value temp_sense {CE_CHECK} {0}
set_instance_parameter_value temp_sense {CLK_FREQUENCY} {50.0}
set_instance_parameter_value temp_sense {CLOCK_DIVIDER_VALUE} {80}
set_instance_parameter_value temp_sense {CLR_CHECK} {1}
set_instance_parameter_value temp_sense {NUMBER_OF_SAMPLES} {128}
set_instance_parameter_value temp_sense {POI_CAL_TEMPERATURE} {85}
set_instance_parameter_value temp_sense {SIM_TSDCALO} {0}
set_instance_parameter_value temp_sense {USER_OFFSET_ENABLE} {off}
set_instance_parameter_value temp_sense {USE_WYS} {on}

add_instance uart altera_avalon_uart 20.1
set_instance_parameter_value uart {baud} {115200}
set_instance_parameter_value uart {dataBits} {8}
set_instance_parameter_value uart {fixedBaud} {1}
set_instance_parameter_value uart {parity} {NONE}
set_instance_parameter_value uart {simCharStream} {}
set_instance_parameter_value uart {simInteractiveInputEnable} {0}
set_instance_parameter_value uart {simInteractiveOutputEnable} {0}
set_instance_parameter_value uart {simTrueBaud} {0}
set_instance_parameter_value uart {stopBits} {1}
set_instance_parameter_value uart {syncRegDepth} {2}
set_instance_parameter_value uart {useCtsRts} {0}
set_instance_parameter_value uart {useEopRegister} {0}
set_instance_parameter_value uart {useRelativePathForSimFile} {0}

# exported interfaces
add_interface clk clock sink
set_interface_property clk EXPORT_OF ext0.clk_in
add_interface fan conduit end
set_interface_property fan EXPORT_OF temp.fan
add_interface phy_clk clock sink
set_interface_property phy_clk EXPORT_OF phy_clk.in_clk
add_interface reset reset sink
set_interface_property reset EXPORT_OF ext0.clk_in_reset
add_interface rs422 conduit end
set_interface_property rs422 EXPORT_OF rs422_ctrl.rs422
add_interface sfp0_sfp conduit end
set_interface_property sfp0_sfp EXPORT_OF sfp0.sfp
add_interface sfp1_sfp conduit end
set_interface_property sfp1_sfp EXPORT_OF sfp1.sfp
add_interface sfp2_sfp conduit end
set_interface_property sfp2_sfp EXPORT_OF sfp2.sfp
add_interface sfp3_sfp conduit end
set_interface_property sfp3_sfp EXPORT_OF sfp3.sfp
add_interface uart conduit end
set_interface_property uart EXPORT_OF uart.external_connection

# connections and connection parameters
add_connection ext0.clk ident.clk

add_connection ext0.clk jtagm.clk

add_connection ext0.clk phy_clk_gauge.ref_clk

add_connection ext0.clk reset_ctrl.clk

add_connection ext0.clk reset_seqencer.clk

add_connection ext0.clk rs422_ctrl.clk

add_connection ext0.clk sfp0.clk

add_connection ext0.clk sfp1.clk

add_connection ext0.clk sfp2.clk

add_connection ext0.clk sfp3.clk

add_connection ext0.clk temp.clk

add_connection ext0.clk temp_sense.clk

add_connection ext0.clk uart.clk

add_connection ext0.clk_reset jtagm.clk_reset

add_connection ext0.clk_reset reset_ctrl.reset_in0

add_connection jtagm.master ident.mm
set_connection_parameter_value jtagm.master/ident.mm arbitrationPriority {1}
set_connection_parameter_value jtagm.master/ident.mm baseAddress {0x0000}
set_connection_parameter_value jtagm.master/ident.mm defaultConnection {0}

add_connection jtagm.master phy_clk_gauge.mm
set_connection_parameter_value jtagm.master/phy_clk_gauge.mm arbitrationPriority {1}
set_connection_parameter_value jtagm.master/phy_clk_gauge.mm baseAddress {0x0020}
set_connection_parameter_value jtagm.master/phy_clk_gauge.mm defaultConnection {0}

add_connection jtagm.master sfp0.mm
set_connection_parameter_value jtagm.master/sfp0.mm arbitrationPriority {1}
set_connection_parameter_value jtagm.master/sfp0.mm baseAddress {0x0100}
set_connection_parameter_value jtagm.master/sfp0.mm defaultConnection {0}

add_connection jtagm.master sfp1.mm
set_connection_parameter_value jtagm.master/sfp1.mm arbitrationPriority {1}
set_connection_parameter_value jtagm.master/sfp1.mm baseAddress {0x0200}
set_connection_parameter_value jtagm.master/sfp1.mm defaultConnection {0}

add_connection jtagm.master sfp2.mm
set_connection_parameter_value jtagm.master/sfp2.mm arbitrationPriority {1}
set_connection_parameter_value jtagm.master/sfp2.mm baseAddress {0x0300}
set_connection_parameter_value jtagm.master/sfp2.mm defaultConnection {0}

add_connection jtagm.master sfp3.mm
set_connection_parameter_value jtagm.master/sfp3.mm arbitrationPriority {1}
set_connection_parameter_value jtagm.master/sfp3.mm baseAddress {0x0400}
set_connection_parameter_value jtagm.master/sfp3.mm defaultConnection {0}

add_connection jtagm.master temp.temp_mm
set_connection_parameter_value jtagm.master/temp.temp_mm arbitrationPriority {1}
set_connection_parameter_value jtagm.master/temp.temp_mm baseAddress {0x0010}
set_connection_parameter_value jtagm.master/temp.temp_mm defaultConnection {0}

add_connection jtagm.master uart.s1
set_connection_parameter_value jtagm.master/uart.s1 arbitrationPriority {1}
set_connection_parameter_value jtagm.master/uart.s1 baseAddress {0x00c0}
set_connection_parameter_value jtagm.master/uart.s1 defaultConnection {0}

add_connection jtagm.master_reset reset_ctrl.reset_in1

add_connection phy_clk.out_clk phy_clk_gauge.probe_clk

add_connection reset_ctrl.reset_out reset_seqencer.reset_in0

add_connection reset_seqencer.reset_out0 ident.reset

add_connection reset_seqencer.reset_out0 phy_clk_gauge.reset

add_connection reset_seqencer.reset_out0 sfp0.reset

add_connection reset_seqencer.reset_out0 sfp1.reset

add_connection reset_seqencer.reset_out0 sfp2.reset

add_connection reset_seqencer.reset_out0 sfp3.reset

add_connection reset_seqencer.reset_out0 temp.reset

add_connection reset_seqencer.reset_out4 rs422_ctrl.reset

add_connection reset_seqencer.reset_out4 uart.reset

add_connection temp.clr temp_sense.clr

add_connection temp.tsdcaldone temp_sense.tsdcaldone
set_connection_parameter_value temp.tsdcaldone/temp_sense.tsdcaldone endPort {}
set_connection_parameter_value temp.tsdcaldone/temp_sense.tsdcaldone endPortLSB {0}
set_connection_parameter_value temp.tsdcaldone/temp_sense.tsdcaldone startPort {}
set_connection_parameter_value temp.tsdcaldone/temp_sense.tsdcaldone startPortLSB {0}
set_connection_parameter_value temp.tsdcaldone/temp_sense.tsdcaldone width {0}

add_connection temp_sense.tsdcalo temp.tsdcalo
set_connection_parameter_value temp_sense.tsdcalo/temp.tsdcalo endPort {}
set_connection_parameter_value temp_sense.tsdcalo/temp.tsdcalo endPortLSB {0}
set_connection_parameter_value temp_sense.tsdcalo/temp.tsdcalo startPort {}
set_connection_parameter_value temp_sense.tsdcalo/temp.tsdcalo startPortLSB {0}
set_connection_parameter_value temp_sense.tsdcalo/temp.tsdcalo width {0}

# interconnect requirements
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
set_interconnect_requirement {$system} {qsys_mm.enableInstrumentation} {TRUE}
set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
set_interconnect_requirement {ident.mm} {qsys_mm.insertPerformanceMonitor} {FALSE}
set_interconnect_requirement {jtagm.master} {qsys_mm.insertPerformanceMonitor} {TRUE}
set_interconnect_requirement {phy_clk_gauge.mm} {qsys_mm.insertPerformanceMonitor} {FALSE}
set_interconnect_requirement {sfp0.mm} {qsys_mm.insertPerformanceMonitor} {FALSE}
set_interconnect_requirement {sfp1.mm} {qsys_mm.insertPerformanceMonitor} {FALSE}
set_interconnect_requirement {sfp2.mm} {qsys_mm.insertPerformanceMonitor} {FALSE}
set_interconnect_requirement {sfp3.mm} {qsys_mm.insertPerformanceMonitor} {FALSE}
set_interconnect_requirement {temp.temp_mm} {qsys_mm.insertPerformanceMonitor} {FALSE}

save_system {de5net.qsys}
