
### Blinky LEDs
#set_property IOSTANDARD LVCMOS33 [get_ports {led}]
#set_property SLEW SLOW [get_ports {led}]
#set_property DRIVE 8 [get_ports {led}]
#set_property PACKAGE_PIN J14 [get_ports {led}]

### Shift LEDs
set_property IOSTANDARD LVCMOS33 [get_ports {led_o[*]}]
set_property SLEW SLOW [get_ports {led_o[*]}]
set_property DRIVE 8 [get_ports {led_o[*]}]

set_property PACKAGE_PIN F16 [get_ports {led_o[0]}]
set_property PACKAGE_PIN F17 [get_ports {led_o[1]}]
set_property PACKAGE_PIN G15 [get_ports {led_o[2]}]
set_property PACKAGE_PIN H15 [get_ports {led_o[3]}]
set_property PACKAGE_PIN K14 [get_ports {led_o[4]}]
set_property PACKAGE_PIN G14 [get_ports {led_o[5]}]
set_property PACKAGE_PIN J15 [get_ports {led_o[6]}]
set_property PACKAGE_PIN J14 [get_ports {led_o[7]}]

#set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports clk_p]
#set_property PACKAGE_PIN U18           [get_ports clk_p]
#set_property PACKAGE_PIN U19           [get_ports clk_n]

set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
