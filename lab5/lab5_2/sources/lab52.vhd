library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
-- ===========================================================================
--  File: lab52.vhd
--  Author: Ahmed Qamesh
--  Date: 28/12/2025
-- ===========================================================================
--  Description: 16-bit cyclic shift register and testbench for it. Perform simulations.   
-- It Perform right shift (from MSB to LSB).
-- ===========================================================================

entity lab52 is
    Port ( clk : in STD_LOGIC;
           srst : in STD_LOGIC;     -- Synchronous reset (button)
           dout : out STD_LOGIC_VECTOR (15 downto 0));  -- LEDs
end lab52;
architecture Behavioral of lab52 is
signal q_reg : STD_LOGIC_VECTOR(15 downto 0); 
begin
process (clk) begin
	if rising_edge(clk) then
		if srst='1' then
           q_reg <=  "1011111010101111" ; -- Initialization value
		else
		-- Cyclic right shift
		  q_reg <= q_reg (0) & q_reg(15 downto 1);
		end if;
	end if;
end process;
dout <= q_reg;
end Behavioral;

