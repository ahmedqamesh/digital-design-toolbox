# 1. Create the Pblock
create_pblock pblock_partition
# 2. Assign your partition to it
add_cells_to_pblock [get_pblocks pblock_partition] [get_cells -quiet [list top_led_reconfig_i/partition]]
# 3. Force the physical location to a specific rectangle
# This region is safe on the xc7z010 (Red Pitaya)
# On the Red Pitaya (Zynq 7010), ICAP is usually at ICAP_X0Y0
resize_pblock [get_pblocks pblock_partition] -add {SLICE_X10Y20:SLICE_X20Y50}
# 4. Allow resetting after reonfig
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_partition]
# 5. SNAPPING_MODE to  align Pblock boundaries to valid resource boundaries and Prevents Pblocks from cutting through CLBs, BRAM,...etc
set_property SNAPPING_MODE ON [get_pblocks pblock_partition]
# 6. Lock the boundaries
set_property IS_SOFT FALSE [get_pblocks pblock_partition]

