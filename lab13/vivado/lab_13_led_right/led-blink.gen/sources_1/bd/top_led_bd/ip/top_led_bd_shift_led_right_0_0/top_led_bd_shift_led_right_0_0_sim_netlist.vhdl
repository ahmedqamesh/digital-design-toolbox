-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Wed Jan 28 13:47:54 2026
-- Host        : aq-21me000tge running 64-bit Ubuntu 24.04.3 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/aq/git/courses/digital-design-toolbox/lab13/lab_13_1/vivado/lab_13_led_right/led-blink.gen/sources_1/bd/top_led_bd/ip/top_led_bd_shift_led_right_0_0/top_led_bd_shift_led_right_0_0_sim_netlist.vhdl
-- Design      : top_led_bd_shift_led_right_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity top_led_bd_shift_led_right_0_0_shift_led_right is
  port (
    led_o : out STD_LOGIC_VECTOR ( 7 downto 0 );
    enable_shift : in STD_LOGIC;
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of top_led_bd_shift_led_right_0_0_shift_led_right : entity is "shift_led_right";
end top_led_bd_shift_led_right_0_0_shift_led_right;

architecture STRUCTURE of top_led_bd_shift_led_right_0_0_shift_led_right is
  signal \^led_o\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \led_o_r[6]_i_1_n_0\ : STD_LOGIC;
  signal \led_o_r[7]_i_1_n_0\ : STD_LOGIC;
begin
  led_o(7 downto 0) <= \^led_o\(7 downto 0);
\led_o_r[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^led_o\(0),
      I1 => enable_shift,
      O => \led_o_r[6]_i_1_n_0\
    );
\led_o_r[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^led_o\(0),
      I1 => enable_shift,
      I2 => \^led_o\(7),
      O => \led_o_r[7]_i_1_n_0\
    );
\led_o_r_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => enable_shift,
      D => \^led_o\(1),
      Q => \^led_o\(0),
      R => \led_o_r[6]_i_1_n_0\
    );
\led_o_r_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => enable_shift,
      D => \^led_o\(2),
      Q => \^led_o\(1),
      R => \led_o_r[6]_i_1_n_0\
    );
\led_o_r_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => enable_shift,
      D => \^led_o\(3),
      Q => \^led_o\(2),
      R => \led_o_r[6]_i_1_n_0\
    );
\led_o_r_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => enable_shift,
      D => \^led_o\(4),
      Q => \^led_o\(3),
      R => \led_o_r[6]_i_1_n_0\
    );
\led_o_r_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => enable_shift,
      D => \^led_o\(5),
      Q => \^led_o\(4),
      R => \led_o_r[6]_i_1_n_0\
    );
\led_o_r_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => enable_shift,
      D => \^led_o\(6),
      Q => \^led_o\(5),
      R => \led_o_r[6]_i_1_n_0\
    );
\led_o_r_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => enable_shift,
      D => \^led_o\(7),
      Q => \^led_o\(6),
      R => \led_o_r[6]_i_1_n_0\
    );
\led_o_r_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk,
      CE => '1',
      D => \led_o_r[7]_i_1_n_0\,
      Q => \^led_o\(7),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity top_led_bd_shift_led_right_0_0 is
  port (
    clk : in STD_LOGIC;
    enable_shift : in STD_LOGIC;
    led_o : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of top_led_bd_shift_led_right_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of top_led_bd_shift_led_right_0_0 : entity is "top_led_bd_shift_led_right_0_0,shift_led_right,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of top_led_bd_shift_led_right_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of top_led_bd_shift_led_right_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of top_led_bd_shift_led_right_0_0 : entity is "shift_led_right,Vivado 2022.2";
end top_led_bd_shift_led_right_0_0;

architecture STRUCTURE of top_led_bd_shift_led_right_0_0 is
  attribute x_interface_info : string;
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN top_led_bd_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
begin
U0: entity work.top_led_bd_shift_led_right_0_0_shift_led_right
     port map (
      clk => clk,
      enable_shift => enable_shift,
      led_o(7 downto 0) => led_o(7 downto 0)
    );
end STRUCTURE;
