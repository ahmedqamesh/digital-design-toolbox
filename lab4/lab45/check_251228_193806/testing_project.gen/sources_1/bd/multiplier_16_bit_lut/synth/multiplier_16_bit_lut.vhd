--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
--Date        : Sun Dec 28 19:58:04 2025
--Host        : aq-21me000tge running 64-bit Ubuntu 24.04.3 LTS
--Command     : generate_target multiplier_16_bit_lut.bd
--Design      : multiplier_16_bit_lut
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity multiplier_16_bit_lut is
  port (
    A_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    B_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK_0 : in STD_LOGIC;
    P_0 : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of multiplier_16_bit_lut : entity is "multiplier_16_bit_lut,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=multiplier_16_bit_lut,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of multiplier_16_bit_lut : entity is "multiplier_16_bit_lut.hwdef";
end multiplier_16_bit_lut;

architecture STRUCTURE of multiplier_16_bit_lut is
  component multiplier_16_bit_lut_mult_gen_0_0 is
  port (
    CLK : in STD_LOGIC;
    A : in STD_LOGIC_VECTOR ( 15 downto 0 );
    B : in STD_LOGIC_VECTOR ( 15 downto 0 );
    P : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component multiplier_16_bit_lut_mult_gen_0_0;
  signal A_0_1 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal B_0_1 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal CLK_0_1 : STD_LOGIC;
  signal mult_gen_0_P : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of CLK_0 : signal is "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of CLK_0 : signal is "XIL_INTERFACENAME CLK.CLK_0, CLK_DOMAIN multiplier_16_bit_lut_CLK_0, FREQ_HZ 10000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
  attribute X_INTERFACE_INFO of A_0 : signal is "xilinx.com:signal:data:1.0 DATA.A_0 DATA";
  attribute X_INTERFACE_PARAMETER of A_0 : signal is "XIL_INTERFACENAME DATA.A_0, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of B_0 : signal is "xilinx.com:signal:data:1.0 DATA.B_0 DATA";
  attribute X_INTERFACE_PARAMETER of B_0 : signal is "XIL_INTERFACENAME DATA.B_0, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of P_0 : signal is "xilinx.com:signal:data:1.0 DATA.P_0 DATA";
  attribute X_INTERFACE_PARAMETER of P_0 : signal is "XIL_INTERFACENAME DATA.P_0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency bitwidth format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type generated dependency signed format bool minimum {} maximum {}} value TRUE}}}} DATA_WIDTH 32}";
begin
  A_0_1(15 downto 0) <= A_0(15 downto 0);
  B_0_1(15 downto 0) <= B_0(15 downto 0);
  CLK_0_1 <= CLK_0;
  P_0(31 downto 0) <= mult_gen_0_P(31 downto 0);
mult_gen_0: component multiplier_16_bit_lut_mult_gen_0_0
     port map (
      A(15 downto 0) => A_0_1(15 downto 0),
      B(15 downto 0) => B_0_1(15 downto 0),
      CLK => CLK_0_1,
      P(31 downto 0) => mult_gen_0_P(31 downto 0)
    );
end STRUCTURE;
