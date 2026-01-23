# ============================================================
# Project recreation script for projectlab_13_2
# Vivado version: works with 2020+ (XSim)
# ============================================================

# -------- Determine directories relative to this script --------
set script_dir [file dirname [info script]]          ;# Tcl script location (/vivado)
set origin_dir [file normalize "$script_dir/.."]    ;# project directory (projectlab_13_2)

puts "Creating a project in $script_dir"
# -------- User-adjustable variables --------
set proj_name lab_13_proj
set project_dir [file normalize "$script_dir/.."] 
set part_name xc7a200tfbg676-2   ; 
# Construct the full path to the .xpr project file
set project_file "$origin_dir/vivado/$proj_name/$proj_name.xpr"
# -------- Create project --------
create_project $proj_name ./$proj_name -part $part_name -force

puts "=============================================="
puts " Open '$project_file' "
puts "=============================================="

# -------- Add RTL sources --------
if {[file exists "$origin_dir/src/rtl"]} {
    add_files -fileset sources_1 [glob -nocomplain $origin_dir/src/rtl/*.{vhd,vhdl,sv,v}]
}

# -------- Add IP repository --------
if {[file exists "$origin_dir/ip_repo"]} {
    set_property ip_repo_paths "$origin_dir/ip_repo" [current_project]
    add_files -fileset sources_1 [glob -nocomplain $origin_dir/ip_repo/*.{xci}]
    
    update_ip_catalog
}

# -------- Add constraints --------
if {[file exists "$origin_dir/xdc"]} {
    add_files -fileset constrs_1 [glob -nocomplain $origin_dir/xdc/*.xdc]
}

# -------- Add testbench sources --------
if {[file exists "$origin_dir/sim"]} {
    add_files -fileset sources_1 [glob -nocomplain $origin_dir/sim/*.{vhd,vhdl,sv,v}]
    set_property used_in_synthesis false [get_files  $origin_dir/sim/*]
}

update_compile_order -fileset sources_1
# -------- Create ILA --------
create_ip -name ila -vendor xilinx.com -library ip -module_name ila_0
update_compile_order -fileset sources_1
set_property -dict [list \
  CONFIG.ALL_PROBE_SAME_MU_CNT {2} \
  CONFIG.C_ADV_TRIGGER {true} \
  CONFIG.C_DATA_DEPTH {2048} \
  CONFIG.C_EN_STRG_QUAL {1} \
  CONFIG.C_NUM_OF_PROBES {6} \
  CONFIG.C_PROBE2_WIDTH {32} \
  CONFIG.C_PROBE3_WIDTH {32} \
] [get_ips ila_0]
# -------- Create Clk --------
create_ip -vlnv xilinx.com:ip:clk_wiz:6.0 -module_name clk_wiz_0
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
] [get_ips clk_wiz_0]

source $origin_dir/src/bd/reconfig_bd.tcl
# Generate the wrapper
set design_name [get_bd_designs]
make_wrapper -files [get_files $design_name.bd] -top -import

source $origin_dir/src/bd/shift_left_bd.tcl
set shift_left_design_name [get_bd_designs]
make_wrapper -files [get_files $shift_left_design_name.bd] -top -import

source $origin_dir/src/bd/shift_right_bd.tcl
set shift_right_design_name [get_bd_designs]
make_wrapper -files [get_files $shift_right_design_name.bd] -top -import


puts "=============================================="
puts " Project '$proj_name' recreated successfully  "
puts "=============================================="
after 1000
set temp_files [list "*.jou" "*.log" "*.str"]
foreach f $temp_files {
    if {[file exists $f]} {
        file delete -force $f
        puts "Cleaned up $f"
    }
}


open_project $project_file
