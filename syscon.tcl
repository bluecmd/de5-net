set d [lindex [get_service_paths device] 0]
set sof [file join de5net.sof]

set masters [get_service_paths master]

if {[llength $masters] == 0} {
  puts " ==> WARNING: No masters found <=="
  puts "To program the device, run 'device_download_sof \$d \$sof'"
  return
}

set m [lindex $masters 0]
open_service master $m

puts ""
puts "=> De5net system console initialized"
puts ""
puts " Master is available at \$m"
puts ""

if {![jtag_debug_sense_clock $m]} {
  puts " ==> WARNING: Clock not detected as running <=="
  puts ""
}

puts " E.g:"
puts " - master_write_32 \$m 0x000e0000 5"
puts " - jtag_debug_reset_system \$m"
puts " - sfp \[1-4]"
puts " - clocks"
puts " - id"

proc id {} {
  global m
  set off [expr 0x0]
  master_write_32 $m [expr $off] 0
  puts [format " Version  : %s" [master_read_8 $m [expr $off + 0x2] 1]]
  set po [master_read_8 $m [expr $off + 0x3] 1]
  puts [format " Git rev. : %s" [master_read_32 $m [expr $off + 0x4] 1]]
}

proc sfp {id} {
  if {$id <= 0} {
    puts [format "Port IDs start at 1"]
    return
  }
  if {$id > 4} {
    puts [format "Port IDs end at 4"]
    return
  }
  global m
  set off [expr 0x100 * $id]
  set status [master_read_8 $m $off 1]
  puts [format " SFP status: %s" $status]

  if {[expr $status & 1] != 0} {
    puts [format " - SFP present"]
  } else {
    puts [format " - SFP *not* present"]
  }

  if {[expr $status & 2] != 0} {
    puts [format " - Loss of signal detected"]
  }

  if {[expr $status & 4] != 0} {
    puts [format " - TX fault detected"]
  }

  if {[expr $status & 8] != 0} {
    puts [format " - TX is disabled"]
  } else {
    puts [format " - TX is enabled"]
  }

  if {[expr $status & 1] == 0} {
    # Only probe the SFP port if it is reported as present
    return
  }

  master_write_32 $m [expr $off + 0x48] 0
  # Configure ISER, SCL_LOW, SCL_HIGH, SDA_HOLD register
  master_write_32 $m [expr $off + 0x4c] 0x0 ; # No interrupts
  master_write_32 $m [expr $off + 0x60] 250
  master_write_32 $m [expr $off + 0x64] 250
  master_write_32 $m [expr $off + 0x68] 15
  master_write_32 $m [expr $off + 0x48] 1
  # Read three byte @ 0x0
  master_write_32 $m [expr $off + 0x40] 0x2A0
  master_write_32 $m [expr $off + 0x40] 0x000
  master_write_32 $m [expr $off + 0x40] 0x2A1
  master_write_32 $m [expr $off + 0x40] 0x000
  master_write_32 $m [expr $off + 0x40] 0x000
  master_write_32 $m [expr $off + 0x40] 0x100

  puts [format " SFP identifier: %s" [master_read_8 $m [expr $off + 0x44] 1]]
  puts [format " SFP ext. identifier: %s" [master_read_8 $m [expr $off + 0x44] 1]]
  puts [format " SFP connector: %s" [master_read_8 $m [expr $off + 0x44] 1]]

  # Read vendor @ 0x14
  master_write_32 $m [expr $off + 0x40] 0x2A0
  master_write_32 $m [expr $off + 0x40] 0x014
  master_write_32 $m [expr $off + 0x40] 0x2A1

  master_write_32 $m [expr $off + 0x40] 0x000
  set vendor [master_read_8 $m [expr $off + 0x44] 1]

  for {set i 0} {$i < 14} {incr i} {
    master_write_32 $m [expr $off + 0x40] 0x000
    lappend vendor [master_read_8 $m [expr $off + 0x44] 1]
  }

  master_write_32 $m [expr $off + 0x40] 0x100
  lappend vendor [master_read_8 $m [expr $off + 0x44] 1]

  puts [format " SFP vendor: '%s'" [binary format c* $vendor]]

  # Read vendor PN @ 0x28
  master_write_32 $m [expr $off + 0x40] 0x2A0
  master_write_32 $m [expr $off + 0x40] 0x028
  master_write_32 $m [expr $off + 0x40] 0x2A1

  master_write_32 $m [expr $off + 0x40] 0x000
  set vendor [master_read_8 $m [expr $off + 0x44] 1]

  for {set i 0} {$i < 14} {incr i} {
    master_write_32 $m [expr $off + 0x40] 0x000
    lappend vendor [master_read_8 $m [expr $off + 0x44] 1]
  }

  master_write_32 $m [expr $off + 0x40] 0x100
  lappend vendor [master_read_8 $m [expr $off + 0x44] 1]

  puts [format " SFP vendor PN: '%s'" [binary format c* $vendor]]

  # Read vendor SN @ 0x44
  master_write_32 $m [expr $off + 0x40] 0x2A0
  master_write_32 $m [expr $off + 0x40] 0x044
  master_write_32 $m [expr $off + 0x40] 0x2A1

  master_write_32 $m [expr $off + 0x40] 0x000
  set vendor [master_read_8 $m [expr $off + 0x44] 1]

  for {set i 0} {$i < 14} {incr i} {
    master_write_32 $m [expr $off + 0x40] 0x000
    lappend vendor [master_read_8 $m [expr $off + 0x44] 1]
  }

  master_write_32 $m [expr $off + 0x40] 0x100
  lappend vendor [master_read_8 $m [expr $off + 0x44] 1]

  puts [format " SFP vendor SN: '%s'" [binary format c* $vendor]]
}

proc clocks {} {
  global m
  set off [expr 0x20]
  puts [format " PHY  : %s MHz" [format "%.3f" [expr [master_read_32 $m [expr $off + 0x00] 1] / 1000000.0]]]
}
