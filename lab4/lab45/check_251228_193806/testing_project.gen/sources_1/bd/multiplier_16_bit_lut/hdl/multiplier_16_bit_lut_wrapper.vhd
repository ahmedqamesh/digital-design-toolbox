--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
--Date        : Sun Dec 28 19:58:04 2025
--Host        : aq-21me000tge running 64-bit Ubuntu 24.04.3 LTS
--Command     : generate_target multiplier_16_bit_lut_wrapper.bd
--Design      : multiplier_16_bit_lut_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity multiplier_16_bit_lut_wrapper is
  port (
    A_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    B_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK_0 : in STD_LOGIC;
    P_0 : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end multiplier_16_bit_lut_wrapper;

architecture STRUCTURE of multiplier_16_bit_lut_wrapper is
  component multiplier_16_bit_lut is
  port (
    A_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    B_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK_0 : in STD_LOGIC;
    P_0 : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component multiplier_16_bit_lut;
begin
multiplier_16_bit_lut_i: component multiplier_16_bit_lut
     port map (
      A_0(15 downto 0) => A_0(15 downto 0),
      B_0(15 downto 0) => B_0(15 downto 0),
      CLK_0 => CLK_0,
      P_0(31 downto 0) => P_0(31 downto 0)
    );
end STRUCTURE;
