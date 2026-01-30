create_pblock pblock_partition
add_cells_to_pblock [get_pblocks pblock_partition] [get_cells -quiet [list top_led_reconfig_i/partition]]
#set_property HD.RECONFIGURABLE true [get_cells top_led_reconfig_i/partition]
#resize_pblock [get_pblocks pblock_partition] -add {SLICE_X6Y70:SLICE_X11Y75}
#resize_pblock [get_pblocks pblock_partition] -add {DSP48_X0Y28:DSP48_X0Y29}
#resize_pblock [get_pblocks pblock_partition] -add {RAMB18_X0Y28:RAMB18_X0Y29}
#resize_pblock [get_pblocks pblock_partition] -add {RAMB36_X0Y14:RAMB36_X0Y14}
#set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_partition]
#set_property SNAPPING_MODE ON [get_pblocks pblock_partition]
#set_property IS_SOFT FALSE [get_pblocks pblock_partition]


# UART Interface 
set_property PACKAGE_PIN G17 [get_ports uart_txd_in]
set_property PACKAGE_PIN G18 [get_ports uart_rxd_out]
set_property IOSTANDARD LVCMOS33 [get_ports uart_txd_in]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rxd_out]

set_property PACKAGE_PIN L16 [get_ports sysclk]
set_property PACKAGE_PIN L17 [get_ports rstn]
set_property IOSTANDARD LVCMOS33 [get_ports rstn]

set_property IOSTANDARD LVCMOS33 [get_ports sysclk]