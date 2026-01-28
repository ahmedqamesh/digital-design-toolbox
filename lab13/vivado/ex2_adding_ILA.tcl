set design_name [get_bd_designs]
open_bd_design $design_name.bd
# ----------------------------------------------------------------
# 1.  INSERT THE INTEGRATED LOGIC ANALYZER (ILA)
# ----------------------------------------------------------------
create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_debug
set_property -dict [list \
  CONFIG.C_MONITOR_TYPE {Native} \
  CONFIG.C_NUM_OF_PROBES {4} \
] [get_bd_cells ila_debug]
after 1000
set_property -dict [list CONFIG.C_PROBE1_WIDTH {8} CONFIG.C_PROBE3_WIDTH {8} CONFIG.C_PROBE2_WIDTH {8} CONFIG.C_NUM_OF_PROBES {4}] [get_bd_cells ila_debug]
after 1000
# Connect ILA clock
connect_bd_net [get_bd_pins ila_debug/clk] [get_bd_pins processing_system7_0/FCLK_CLK0]
after 1000
# Wire the probes
after 1000
connect_bd_net [get_bd_pins ila_debug/probe0] [get_bd_pins blink_counter_0/led]
connect_bd_net [get_bd_pins ila_debug/probe1] [get_bd_pins shift_led_right_0/led_o]
connect_bd_net [get_bd_pins ila_debug/probe2] [get_bd_pins shift_led_right_0/led_o]
connect_bd_net [get_bd_pins ila_debug/probe3] [get_bd_pins shift_led_left_0/led_o]

# ----------------------------------------------------------------
# 2.  VALIDATE, SAVE, AND GENERATE OUTPUT PRODUCTS
# ----------------------------------------------------------------
validate_bd_design
regenerate_bd_layout
save_bd_design
# --------------------------------------------------------------------
# 3.  Run the design flow
# --------------------------------------------------------------------
update_compile_order -fileset sources_1
puts "=== Launching synthesis ==="
reset_run synth_1
launch_runs synth_1 -jobs 6
wait_on_run synth_1
#open_run synth_1 -name synth_1
#refresh_design

puts "=== Launching implementation ==="
launch_runs impl_1 -jobs 6
wait_on_run impl_1
open_run impl_1
puts "=== Writing bitstream ==="
launch_runs impl_1 -to_step write_bitstream -jobs 6
wait_on_run impl_1
puts "Bitstream generation finished."
open_bd_design $design_name.bd
