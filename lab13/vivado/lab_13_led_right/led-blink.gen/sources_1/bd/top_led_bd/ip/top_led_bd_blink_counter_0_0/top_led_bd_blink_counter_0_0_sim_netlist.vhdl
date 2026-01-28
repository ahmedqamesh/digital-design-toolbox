-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Wed Jan 28 13:47:54 2026
-- Host        : aq-21me000tge running 64-bit Ubuntu 24.04.3 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/aq/git/courses/digital-design-toolbox/lab13/lab_13_1/vivado/lab_13_led_right/led-blink.gen/sources_1/bd/top_led_bd/ip/top_led_bd_blink_counter_0_0/top_led_bd_blink_counter_0_0_sim_netlist.vhdl
-- Design      : top_led_bd_blink_counter_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity top_led_bd_blink_counter_0_0 is
  port (
    clk : in STD_LOGIC;
    led : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of top_led_bd_blink_counter_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of top_led_bd_blink_counter_0_0 : entity is "top_led_bd_blink_counter_0_0,blink_counter,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of top_led_bd_blink_counter_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of top_led_bd_blink_counter_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of top_led_bd_blink_counter_0_0 : entity is "blink_counter,Vivado 2022.2";
end top_led_bd_blink_counter_0_0;

architecture STRUCTURE of top_led_bd_blink_counter_0_0 is
  signal \<const0>\ : STD_LOGIC;
  attribute x_interface_info : string;
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN top_led_bd_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
begin
  led <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
end STRUCTURE;
