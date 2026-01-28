--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
--Date        : Wed Jan 28 14:29:08 2026
--Host        : aq-21me000tge running 64-bit Ubuntu 24.04.3 LTS
--Command     : generate_target top_led_reonfig_wrapper.bd
--Design      : top_led_reonfig_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity top_led_reonfig_wrapper is
end top_led_reonfig_wrapper;

architecture STRUCTURE of top_led_reonfig_wrapper is
  component top_led_reonfig is
  end component top_led_reonfig;
begin
top_led_reonfig_i: component top_led_reonfig
 ;
end STRUCTURE;
