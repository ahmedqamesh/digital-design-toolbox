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



# UART Interface on E1
# DIO0_P (Pin 3)
set_property PACKAGE_PIN G17 [get_ports uart_txd_in]
# DIO0_N (Pin 4)
set_property PACKAGE_PIN G18 [get_ports uart_rxd_out]
set_property IOSTANDARD LVCMOS33 [get_ports uart_txd_in]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rxd_out]

set_property PACKAGE_PIN L17 [get_ports rstn]
set_property IOSTANDARD LVCMOS33 [get_ports rstn]


