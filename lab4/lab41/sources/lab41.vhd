library IEEE;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;  -- This is required for 'unsigned' and arithmetic operations
-- ===========================================================================
--  File: lab41.vhd
--  Author: Ahmed Qamesh
--  Date: 28/12/2025
-- ===========================================================================
--  Description: 2 input summator of 3-bit unsigned integers.
--  This VHDL module implements 2 input summator of 3-bit unsigned integers. 
--  The device has two three-bit inputs (sliders) and four outputs (LEDs). 
-- ===========================================================================
entity lab41 is
    Port ( x1 : in STD_LOGIC_VECTOR (2 downto 0);
           x2 : in STD_LOGIC_VECTOR (2 downto 0);
           y : out STD_LOGIC_VECTOR (3 downto 0));
end lab41;
architecture Behavioral of lab41 is
	signal sum : unsigned(3 downto 0);  -- 4-bit signal to handle overflow
begin
	-- Addition is performed as unsigned arithmetic 
	sum <= unsigned('0' & x1) + unsigned('0' & x2);
    -- Convert sum back to std_logic_vector for output
    y <= std_logic_vector(sum);

end Behavioral;

