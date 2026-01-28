set design_name [get_bd_designs]
open_bd_design $design_name.bd
# ----------------------------------------------------------------
# 4.2  INSERT THE RTL BLOCKS 
# ----------------------------------------------------------------
disconnect_bd_net /shift_led_right_0_led_o [get_bd_pins shift_led_right_0/led_o]

# add signals to shift_led_left_0
create_bd_cell -type module -reference shift_led_left shift_led_left_0
connect_bd_net [get_bd_pins shift_led_left_0/clk] [get_bd_pins processing_system7_0/FCLK_CLK0]

# add signals to mux
connect_bd_net [get_bd_pins shift_led_left_0/led_o] [get_bd_pins mux2to1_0/led_1]
connect_bd_net [get_bd_pins shift_led_right_0/led_o] [get_bd_pins mux2to1_0/led_0]
connect_bd_net [get_bd_ports led_o] [get_bd_pins mux2to1_0/led_o]


# ----------------------------------------------------------------
# 1.  INSERT THE Virtual Input/Output (VIO)
# ----------------------------------------------------------------
create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0
after 1000
set_property -dict [list CONFIG.C_PROBE_IN0_WIDTH {8}] [get_bd_cells vio_0]
after 1000
# Connect ILA clock
connect_bd_net [get_bd_pins vio_0/clk] [get_bd_pins processing_system7_0/FCLK_CLK0]
after 1000
# Wire the probes
after 1000
set_property -dict [list CONFIG.C_NUM_PROBE_IN {2}] [get_bd_cells vio_0]
connect_bd_net [get_bd_pins vio_0/probe_in0] [get_bd_pins mux2to1_0/led_o]
connect_bd_net [get_bd_pins vio_0/probe_in1] [get_bd_pins blink_counter_0/led]
connect_bd_net [get_bd_pins vio_0/probe_out0] [get_bd_pins mux2to1_0/sel]

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

