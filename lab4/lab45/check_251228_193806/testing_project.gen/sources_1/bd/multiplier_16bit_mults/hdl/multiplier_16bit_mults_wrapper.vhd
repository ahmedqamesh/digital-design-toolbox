--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
--Date        : Sun Dec 28 19:57:28 2025
--Host        : aq-21me000tge running 64-bit Ubuntu 24.04.3 LTS
--Command     : generate_target multiplier_16bit_mults_wrapper.bd
--Design      : multiplier_16bit_mults_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity multiplier_16bit_mults_wrapper is
  port (
    A_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    B_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK_0 : in STD_LOGIC;
    P_0 : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end multiplier_16bit_mults_wrapper;

architecture STRUCTURE of multiplier_16bit_mults_wrapper is
  component multiplier_16bit_mults is
  port (
    A_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    B_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK_0 : in STD_LOGIC;
    P_0 : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component multiplier_16bit_mults;
begin
multiplier_16bit_mults_i: component multiplier_16bit_mults
     port map (
      A_0(15 downto 0) => A_0(15 downto 0),
      B_0(15 downto 0) => B_0(15 downto 0),
      CLK_0 => CLK_0,
      P_0(31 downto 0) => P_0(31 downto 0)
    );
end STRUCTURE;
