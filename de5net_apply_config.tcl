# Note: Requires that full designs are available first
source config.tcl

package require -exact qsys 16.0

load_system {de5net.qsys}

# Apply config here

save_system {de5net.qsys}
