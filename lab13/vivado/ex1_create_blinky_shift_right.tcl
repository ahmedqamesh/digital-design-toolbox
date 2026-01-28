# --------------------------------------------------------------------
# 1.  Define directories (relative to where you launch the script)
# --------------------------------------------------------------------

set script_dir [file dirname [info script]]          ;# Tcl script location (/vivado)
set origin_dir [file normalize "$script_dir/.."]    ;# project directory (projectlab_13_2)

#set origin_dir "."                         ;# you can change this if you run the script from another folder
set project_dir   "$script_dir/lab_13_led_right"
set rtl_dir       "$origin_dir/sources/rtl"
set sim_dir       "$origin_dir/sim"
set cfg_dir       "$origin_dir/cfg"
set ip_repo       "$origin_dir/ip_repo"
# --------------------------------------------------------------------
# 2.  Open an existing project or create a new one
# --------------------------------------------------------------------
puts "Creating new project $project_dir ..."
create_project led-blink $project_dir -part xc7z010clg400-1 -force
set_property board_part redpitaya.com:redpitaya:part0:1.1 [current_project]
set_property target_language VHDL [current_project]
    
# --------------------------------------------------------------------
# 3.  Add RTL files
# --------------------------------------------------------------------
# -------- Add RTL sources --------
puts "Adding [llength $rtl_files] RTL files ..."
if {[file exists "$rtl_dir"]} {
    add_files -fileset sources_1 [glob -nocomplain $rtl_dir/*.{vhd,vhdl,sv,v}]
}
update_compile_order -fileset sources_1
# ----------------------------------------------------------------
# 4. CREATE BLOCK DESIGN
# ----------------------------------------------------------------
create_bd_design "top_led_bd"
current_bd_design [get_bd_designs top_led_bd]
# ----------------------------------------------------------------
# 4.1  INSERT the PS BLOCK
# ----------------------------------------------------------------
after 500
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
# ----------------------------------------------------------------
# 4.2  INSERT THE RTL BLOCKS 
# ----------------------------------------------------------------
after 1000
create_bd_cell -type module -reference blink_counter blink_counter_0
after 1000
create_bd_cell -type module -reference shift_led_right shift_led_right_0
# ----------------------------------------------------------------
# 4.3  GLOBAL CLOCK & RESET (shared by all three blocks)
# ----------------------------------------------------------------
after 1000
connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK]
connect_bd_net [get_bd_pins shift_led_right_0/clk] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net [get_bd_pins blink_counter_0/clk] [get_bd_pins processing_system7_0/FCLK_CLK0]
# ----------------------------------------------------------------
# 4.4  INTERNAL and EXTERNAL I/Os
# ----------------------------------------------------------------
after 1000
connect_bd_net [get_bd_pins blink_counter_0/led] [get_bd_pins shift_led_right_0/enable_shift]
make_bd_pins_external  [get_bd_pins shift_led_right_0/led_o]
set_property name led_o [get_bd_ports led_o_0]

# ----------------------------------------------------------------
# 5.  VALIDATE, SAVE, AND GENERATE OUTPUT PRODUCTS
# ----------------------------------------------------------------
validate_bd_design
regenerate_bd_layout
save_bd_design
# Export the BD as a wrapper (so synthesis sees the modulearchy)
set design_name [get_bd_designs]
after 2000
make_wrapper -files [get_files $design_name.bd] -top
set wrapper_path [make_wrapper -fileset sources_1 -files [ get_files -norecurse $design_name.bd] -top]
add_files -norecurse -fileset sources_1 $wrapper_path
update_compile_order -fileset sources_1

# --------------------------------------------------------------------
# 4.  Add simulation files (create the sim fileset if needed)
# --------------------------------------------------------------------
#puts "=== Launching simulation ==="
# -------- Add testbench sources --------
if {[file exists "$sim_dir"]} {
    add_files -fileset sources_1 [glob -nocomplain $origin_dir/sim/*.{vhd,vhdl,sv,v}]
    set_property used_in_synthesis false [get_files  $origin_dir/sim/*]
}
#update_compile_order -fileset sim_1
#launch_simulation
# --------------------------------------------------------------------
# 4.  Add the constraints
# --------------------------------------------------------------------
if {[file exists "$cfg_dir"]} {
    add_files -fileset constrs_1 [glob -nocomplain $cfg_dir/*.xdc]
}

# --------------------------------------------------------------------
# 5.  Run the design flow
# --------------------------------------------------------------------
update_compile_order -fileset sources_1
puts "=== Launching synthesis ==="
reset_run synth_1
launch_runs synth_1 -jobs 6
wait_on_run synth_1

puts "=== Launching implementation ==="
launch_runs impl_1 -jobs 6
wait_on_run impl_1
open_run impl_1
puts "=== Writing bitstream ==="
launch_runs impl_1 -to_step write_bitstream -jobs 6
wait_on_run impl_1
puts "Bitstream generation finished."

open_bd_design $design_name.bd


after 1000
set temp_files [list "*.jou" "*.log" "*.str"]
foreach f $temp_files {
    if {[file exists $f]} {
        file delete -force $f
        puts "Cleaned up $f"
    }
}
