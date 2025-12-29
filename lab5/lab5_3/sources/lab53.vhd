library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
-- ===========================================================================
--  File: lab53.vhd
--  Author: Ahmed Qamesh
--  Date: 28/12/2025
-- ===========================================================================
--  Description: 1 cycle delay block for 8-bit width words and testbench for it. Perform simulations.   
--  The delay block has two inputs (clocking and 8-bit width data) and one output (8-bit data word). 
-- ===========================================================================

entity lab53 is
    Port ( clk  : in STD_LOGIC;
           din  : in STD_LOGIC_VECTOR (7 downto 0);
           dout : out STD_LOGIC_VECTOR (7 downto 0));
end lab53;
architecture Behavioral of lab53 is
signal d_reg : STD_LOGIC_VECTOR(7 downto 0); 
begin
process (clk) begin
	if rising_edge(clk) then
		-- Cyclic right shift
		  d_reg <= din;
		end if;
end process;
dout <= d_reg;
end Behavioral;

