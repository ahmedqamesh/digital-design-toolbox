# 1. Create the Pblock
create_pblock pblock_partition
add_cells_to_pblock [get_pblocks pblock_partition] [get_cells -quiet [list top_led_reconfig_i/partition]]
resize_pblock [get_pblocks pblock_partition] -add {SLICE_X10Y20:SLICE_X20Y50}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_partition]
set_property SNAPPING_MODE ON [get_pblocks pblock_partition]
set_property IS_SOFT FALSE [get_pblocks pblock_partition]
# On the Red Pitaya (Zynq 7010), ICAP is usually at ICAP_X0Y0
# 2. Assign your partition to it
# 3. Force the physical location to a specific rectangle
# This region is safe on the xc7z010 (Red Pitaya)
# Add DSPs and BRAMs in that same region to avoid "long wire" delays

#resize_pblock [get_pblocks pblock_partition] -add {SLICE_X8Y20:SLICE_X15Y40}
#resize_pblock [get_pblocks pblock_partition] -add {DSP48_X0Y8:DSP48_X0Y15}


# 4. Allow resetting after reonfig
# 5. SNAPPING_MODE
# 6. Lock the boundaries


# UART Interface
set_property PACKAGE_PIN G17 [get_ports uart_txd_in]
set_property PACKAGE_PIN G18 [get_ports uart_rxd_out]
set_property IOSTANDARD LVCMOS33 [get_ports uart_txd_in]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rxd_out]

#set_property PACKAGE_PIN L16 [get_ports sysclk]
#set_property IOSTANDARD LVCMOS33 [get_ports sysclk]
set_property PACKAGE_PIN L17 [get_ports rstn]
set_property IOSTANDARD LVCMOS33 [get_ports rstn]


