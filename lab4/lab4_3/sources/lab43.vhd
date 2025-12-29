library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
-- ===========================================================================
--  File: lab43.vhd
--  Author: Ahmed Qamesh
--  Date: 28/12/2025
-- ===========================================================================
--  Description: Cyclic left shifter by 2 bits.
--  The device has one 4-bit input port for input number (sliders) and two 4-bit outputs (LEDs).  
--  The first output is for original number 
--  The second – for the shifter result.
--  LSBs of output are for the original number. 
-- ===========================================================================
entity lab43 is
  Port (x : in  std_logic_vector(3 downto 0);
        y : out std_logic_vector(7 downto 0));
end lab43;
architecture Behavioral of lab43 is
begin
    -- Lower 4 bits: original number
    y(3 downto 0) <= x;
    -- Upper 4 bits: cyclic left shift by 2
    -- x(1 downto 0) → LSBs move to MSB positions.
    -- x(3 downto 2) → MSBs move to LSB positions.
    y(7 downto 4) <= x(1 downto 0) & x(3 downto 2);
end Behavioral;

