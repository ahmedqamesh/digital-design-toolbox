
################################################################
# This is a generated script based on design: reconfig_bd
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source reconfig_bd_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# decoupling, ecc_wrapper, reconfig_core, startupe2_primitve, uart_interface, icap_sm, interface

# Please add the sources of those modules before sourcing this Tcl script.


# The design that will be created by this Tcl script contains the following 
# block design container source references:
# shift_led_left, shift_led_right

# Please add the sources before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a35ticsg324-1L
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name reconfig_bd

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:clk_wiz:6.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
decoupling\
startupe2_primitve\
uart_interface\
protocol_unit\
icap_sm\
interface\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

##################################################################
# CHECK Block Design Container Sources
##################################################################
set bCheckSources 1
set list_bdc_active "shift_led_left"
set list_bdc_dfx "shift_led_right"

array set map_bdc_missing {}
set map_bdc_missing(ACTIVE) ""
set map_bdc_missing(DFX) ""
set map_bdc_missing(BDC) ""

if { $bCheckSources == 1 } {
   set list_check_srcs "\ 
shift_led_left \
shift_led_right \
"

   common::send_gid_msg -ssname BD::TCL -id 2056 -severity "INFO" "Checking if the following sources for block design container exist in the project: $list_check_srcs .\n\n"

   foreach src $list_check_srcs {
      if { [can_resolve_reference $src] == 0 } {
         if { [lsearch $list_bdc_active $src] != -1 } {
            set map_bdc_missing(ACTIVE) "$map_bdc_missing(ACTIVE) $src"
         } elseif { [lsearch $list_bdc_dfx $src] != -1 } {
            set map_bdc_missing(DFX) "$map_bdc_missing(DFX) $src"
         } else {
            set map_bdc_missing(BDC) "$map_bdc_missing(BDC) $src"
         }
      }
   }

   if { [llength $map_bdc_missing(ACTIVE)] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2057 -severity "ERROR" "The following source(s) of Active variants are not found in the project: $map_bdc_missing(ACTIVE)" }
      common::send_gid_msg -ssname BD::TCL -id 2060 -severity "INFO" "Please add source files for the missing source(s) above."
      set bCheckIPsPassed 0
   }
   if { [llength $map_bdc_missing(DFX)] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2058 -severity "ERROR" "The following source(s) of DFX variants are not found in the project: $map_bdc_missing(DFX)" }
      common::send_gid_msg -ssname BD::TCL -id 2060 -severity "INFO" "Please add source files for the missing source(s) above."
      set bCheckIPsPassed 0
   }
   if { [llength $map_bdc_missing(BDC)] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2059 -severity "WARNING" "The following source(s) of variants are not found in the project: $map_bdc_missing(BDC)" }
      common::send_gid_msg -ssname BD::TCL -id 2060 -severity "INFO" "Please add source files for the missing source(s) above."
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: icap_controller
proc create_hier_cell_icap_controller { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_icap_controller() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 7 -to 0 address
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn
  create_bd_pin -dir I -from 7 -to 0 wrdata
  create_bd_pin -dir I wready

  # Create instance: icap_sm_0, and set properties
  set block_name icap_sm
  set block_cell_name icap_sm_0
  if { [catch {set icap_sm_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $icap_sm_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: interface_0, and set properties
  set block_name interface
  set block_cell_name interface_0
  if { [catch {set interface_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $interface_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net address_1 [get_bd_pins address] [get_bd_pins interface_0/address]

  connect_bd_net -net icap_sm_0_busy [get_bd_pins icap_sm_0/busy] [get_bd_pins interface_0/icap_busy]
  connect_bd_net -net interface_0_icap_wrdata [get_bd_pins icap_sm_0/icap_in] [get_bd_pins interface_0/icap_wrdata]
  connect_bd_net -net interface_0_read_req [get_bd_pins icap_sm_0/read_req] [get_bd_pins interface_0/read_req]
  connect_bd_net -net interface_0_write_req [get_bd_pins icap_sm_0/write_req] [get_bd_pins interface_0/write_req]
  connect_bd_net -net rstn_0_1 [get_bd_pins rstn] [get_bd_pins icap_sm_0/rstn] [get_bd_pins interface_0/rstn]
  connect_bd_net -net wrdata_1 [get_bd_pins wrdata] [get_bd_pins interface_0/wrdata]
  connect_bd_net -net wready_1 [get_bd_pins wready] [get_bd_pins interface_0/wready]
  connect_bd_net [get_bd_pins startupe2_primitve_0/EOS] [get_bd_pins decoupling_0/enable]
  connect_bd_net [get_bd_pins clk_wiz_0/clk] [get_bd_pins icap_controller/clk]
connect_bd_net [get_bd_ports ext_rstn] [get_bd_pins decoupling_0/rstn]
connect_bd_net [get_bd_ports ext_rstn] [get_bd_pins icap_controller/rstn]
connect_bd_net [get_bd_ports ext_rstn] [get_bd_pins protocol_unit_0/rstn]
connect_bd_net [get_bd_pins decoupling_0/clkd] [get_bd_pins partition/sys_clk]
connect_bd_net [get_bd_pins decoupling_0/clk] [get_bd_pins clk_wiz_0/clk]
connect_bd_net [get_bd_pins uart_interface_0/clk] [get_bd_pins clk_wiz_0/clk]
connect_bd_net [get_bd_pins protocol_unit_0/clk] [get_bd_pins clk_wiz_0/clk]
connect_bd_net -net clk_wiz_0 [get_bd_pins clk] [get_bd_pins icap_sm_0/clk] [get_bd_pins interface_0/clk]
connect_bd_net [get_bd_pins uart_interface_0/new_data_rx] [get_bd_pins protocol_unit_0/new_data_rx]
connect_bd_net [get_bd_pins protocol_unit_0/data_rx] [get_bd_pins uart_interface_0/data_rx]
connect_bd_net [get_bd_pins protocol_unit_0/address] [get_bd_pins icap_controller/address]
connect_bd_net [get_bd_pins protocol_unit_0/data] [get_bd_pins icap_controller/wrdata]
connect_bd_net [get_bd_pins protocol_unit_0/data_received] [get_bd_pins icap_controller/wready]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set LED [ create_bd_port -dir O -from 15 -to 0 LED ]
  set ext_rstn [ create_bd_port -dir I -type rst ext_rstn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $ext_rstn
  set sysclk [ create_bd_port -dir I -type clk sysclk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_RESET {ext_rstn} \
 ] $sysclk
  set uart_rxd_out [ create_bd_port -dir O uart_rxd_out ]
  set uart_txd_in [ create_bd_port -dir I uart_txd_in ]

  # Create instance: clk_wiz_0, and set properties
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
set_property -dict [list \
  CONFIG.CLKOUT1_JITTER {213.446} \
  CONFIG.CLKOUT1_PHASE_ERROR {105.461} \
  CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {11.52} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {9.000} \
  CONFIG.MMCM_CLKOUT0_DIVIDE_F {78.125} \
  CONFIG.USE_LOCKED {false} \
  CONFIG.CLK_OUT1_PORT {clk} \
  CONFIG.USE_RESET {false} \
] [get_bd_cells clk_wiz_0]
  # Create instance: decoupling_0, and set properties
  set block_name decoupling
  set block_cell_name decoupling_0
  if { [catch {set decoupling_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $decoupling_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }

  
  # Create instance: icap_controller
  create_hier_cell_icap_controller [current_bd_instance .] icap_controller

  # Create instance: partition, and set properties
  set partition [ create_bd_cell -type container -reference shift_led_left partition ]
  set_property -dict [ list \
   CONFIG.ACTIVE_SIM_BD {shift_led_left.bd} \
   CONFIG.ACTIVE_SYNTH_BD {shift_led_left.bd} \
   CONFIG.ENABLE_DFX {1} \
   CONFIG.LIST_SIM_BD {shift_led_left.bd:shift_led_right.bd} \
   CONFIG.LIST_SYNTH_BD {shift_led_left.bd:shift_led_right.bd} \
   CONFIG.LOCK_PROPAGATE {true} \
   CONFIG.TRAINING_MODULE {shift_led_left.bd} \
 ] $partition

  # Create instance: startupe2_primitve_0, and set properties
  set block_name startupe2_primitve
  set block_cell_name startupe2_primitve_0
  if { [catch {set startupe2_primitve_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $startupe2_primitve_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: uart_interface_0, and set properties
  set block_name uart_interface
  set block_cell_name uart_interface_0
  if { [catch {set uart_interface_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $uart_interface_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net clk_in1_0_1 [get_bd_ports sysclk] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net decoupling_0_ledd [get_bd_ports LED] [get_bd_pins decoupling_0/ledd]
  connect_bd_net -net partition_led [get_bd_pins decoupling_0/led] [get_bd_pins partition/led]
  connect_bd_net -net uart_interface_0_uart_rxd_out [get_bd_ports uart_rxd_out] [get_bd_pins uart_interface_0/uart_rxd_out]
  connect_bd_net -net uart_txd_in_0_1 [get_bd_ports uart_txd_in] [get_bd_pins uart_interface_0/uart_txd_in]
  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


