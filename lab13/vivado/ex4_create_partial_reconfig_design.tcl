# ============================================================
# Project recreation script for projectlab_13_2
# Vivado version: works with 2020+ (XSim)
# ============================================================

# 1. Generate the Reconfig Wrapper

set script_dir [file dirname [info script]]          ;# Tcl script location (/vivado)
set origin_dir [file normalize "$script_dir/.."]    ;# project directory (projectlab_13_2)
set cfg_dir       "$origin_dir/cfg"

set led_reconfig_design_name "top_led_reconfig"
create_bd_design $led_reconfig_design_name
current_bd_design [get_bd_designs $led_reconfig_design_name.bd]

# 2. Define the list of modules required for your design
# -------- Create Clk --------
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
update_compile_order -fileset sources_1
set_property -dict [list \
  CONFIG.CLKOUT1_JITTER {117.368} \
  CONFIG.CLKOUT1_PHASE_ERROR {88.161} \
  CONFIG.CLKOUT1_REQUESTED_PHASE {11.52} \
  CONFIG.CLK_OUT1_PORT {clk} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {11.750} \
  CONFIG.MMCM_CLKOUT0_DIVIDE_F {11.750} \
  CONFIG.MMCM_CLKOUT0_PHASE {11.489} \
  CONFIG.USE_LOCKED {false} \
  CONFIG.USE_RESET {false} \
] [get_bd_cells clk_wiz_0]


set br_modules [list \
    "shift_led_left" \
    "decoupling" \
    "uart_interface" \
    "icap_sm" \
    "interface" \
    "startupe2_primitve" \
    "protocol_unit" \
]

# 3. Iterate through and create cells
foreach mod $br_modules {
    puts "Searching for module source: $mod"
    
    # Check if the module is already in the project sources
    set mod_obj [get_files -quiet ${mod}.v]
    if { [llength $mod_obj] == 0 } {
        set mod_obj [get_files -quiet ${mod}.vhd]
    }
    if { [llength $mod_obj] > 0 } {
        puts "Adding Module Reference: $mod"
        # Create the BD cell of type 'module'
        create_bd_cell -type module -reference $mod ${mod}_0
    } else {
        common::send_gid_msg -ssname BD::TCL -id 2099 -severity "WARNING" \
            "Source for $mod not found in project. Please add the HDL file first."
    }
}

# 1. Connect Clock and Reset (Main Backbone)
# Assuming clk_wiz_0 is already present in your BD
connect_bd_net [get_bd_pins clk_wiz_0/clk] \
	       [get_bd_pins uart_interface_0/clk] \
	       [get_bd_pins protocol_unit_0/clk] \
	       [get_bd_pins icap_sm_0/clk] \
	       [get_bd_pins decoupling_0/clk] \
	       [get_bd_pins interface_0/clk] \
	       [get_bd_pins shift_led_left_0/clk]

make_bd_pins_external  [get_bd_pins clk_wiz_0/clk_in1]
set_property name sysclk [get_bd_ports clk_in1_0]

make_bd_pins_external  [get_bd_pins protocol_unit_0/rstn]
set_property name rstn [get_bd_ports rstn_0]

connect_bd_net [get_bd_ports rstn] \
    [get_bd_pins uart_interface_0/rstn] \
    [get_bd_pins protocol_unit_0/rstn] \
    [get_bd_pins icap_sm_0/rstn] \
    [get_bd_pins decoupling_0/rstn] \
    [get_bd_pins interface_0/rstn]
    
# 2. UART to Protocol Unit
make_bd_pins_external  [get_bd_pins uart_interface_0/uart_txd_in]
make_bd_pins_external  [get_bd_pins uart_interface_0/uart_rxd_out]
set_property name uart_txd_in [get_bd_ports uart_txd_in_0]
set_property name uart_rxd_out [get_bd_ports uart_rxd_out_0]

connect_bd_net [get_bd_pins uart_interface_0/data_rx] [get_bd_pins protocol_unit_0/data_rx]
connect_bd_net [get_bd_pins uart_interface_0/new_data_rx] [get_bd_pins protocol_unit_0/new_data_rx]

regenerate_bd_layout

# 3. DFX Decoupling Logic
# The EOS (End of Startup) from Startup primitive enables the decoupling logic
connect_bd_net [get_bd_pins startupe2_primitve_0/EOS] [get_bd_pins decoupling_0/enable]
connect_bd_net [get_bd_pins shift_led_left_0/led_o] [get_bd_pins decoupling_0/led]
make_bd_pins_external  [get_bd_pins decoupling_0/ledd]
set_property name led_o [get_bd_ports ledd_0]


# 4. Protocol Unit to Interface (Addressing Logic)
connect_bd_net [get_bd_pins protocol_unit_0/address] [get_bd_pins interface_0/address]
connect_bd_net [get_bd_pins protocol_unit_0/data] [get_bd_pins interface_0/wrdata]
connect_bd_net [get_bd_pins protocol_unit_0/data_received] [get_bd_pins interface_0/wready]

# 5. Interface to ICAP State Machine
connect_bd_net [get_bd_pins interface_0/icap_wrdata] [get_bd_pins icap_sm_0/icap_in]
connect_bd_net [get_bd_pins interface_0/write_req] [get_bd_pins icap_sm_0/write_req]
connect_bd_net [get_bd_pins interface_0/read_req] [get_bd_pins icap_sm_0/read_req]
connect_bd_net [get_bd_pins icap_sm_0/busy] [get_bd_pins interface_0/icap_busy]

regenerate_bd_layout
# 6. Interface to the shifter
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0
connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins shift_led_left_0/enable_shift]

regenerate_bd_layout
validate_bd_design
save_bd_design
make_wrapper -files [get_files $led_reconfig_design_name.bd] -top -import
set_property top top_led_reconfig_wrapper [current_fileset]
update_compile_order -fileset sources_1

open_bd_design $led_reconfig_design_name.bd

set_property target_constrs_file $cfg_dir/redpitaya-ports.xdc [current_fileset -constrset]
save_constraints -force
reset_run synth_1


puts "=============================================="
puts " Design '$led_reconfig_design_name' created successfully  "
puts "=============================================="
after 1000
set temp_files [list "*.jou" "*.log" "*.str"]
foreach f $temp_files {
    if {[file exists $f]} {
        file delete -force $f
        puts "Cleaned up $f"
    }
}
