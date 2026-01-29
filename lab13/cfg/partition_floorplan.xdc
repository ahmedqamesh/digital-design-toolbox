#create_pblock pblock_partition
#add_cells_to_pblock [get_pblocks pblock_partition] [get_cells -quiet [list mopshub_reconfig_bd_i/partition]]
#resize_pblock [get_pblocks pblock_partition] -add {SLICE_X36Y51:SLICE_X47Y63}
#set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_partition]
#set_property SNAPPING_MODE ON [get_pblocks pblock_partition]
#set_property IS_SOFT FALSE [get_pblocks pblock_partition]


