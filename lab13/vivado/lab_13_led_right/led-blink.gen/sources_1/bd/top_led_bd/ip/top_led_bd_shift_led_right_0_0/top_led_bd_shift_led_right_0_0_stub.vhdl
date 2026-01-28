-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Wed Jan 28 13:47:54 2026
-- Host        : aq-21me000tge running 64-bit Ubuntu 24.04.3 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/aq/git/courses/digital-design-toolbox/lab13/lab_13_1/vivado/lab_13_led_right/led-blink.gen/sources_1/bd/top_led_bd/ip/top_led_bd_shift_led_right_0_0/top_led_bd_shift_led_right_0_0_stub.vhdl
-- Design      : top_led_bd_shift_led_right_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_led_bd_shift_led_right_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    enable_shift : in STD_LOGIC;
    led_o : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end top_led_bd_shift_led_right_0_0;

architecture stub of top_led_bd_shift_led_right_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,enable_shift,led_o[7:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "shift_led_right,Vivado 2022.2";
begin
end;
