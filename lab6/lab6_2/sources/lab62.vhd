library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- ===========================================================================
--  File: lab62.vhd
--  Author: Ahmed Qamesh
--  Date: 30/12/2025
-- ===========================================================================
--  Description: The clock divider based on counter. The result is a meander with 1 s period.
-- ===========================================================================

entity lab62 is
    Port ( clk : in STD_LOGIC;
           dout : out STD_LOGIC);
end lab62;
architecture Behavioral of lab62 is
    signal cntr : std_logic_vector(26 downto 0):=(others => '0');-- 27-bit counter
begin
-- A free-running counter divides the clock
-- Counter that provide a signal which has 1 sec

cntr_proc : process(clk) begin
    if rising_edge(clk) then
            cntr <= unsigned(cntr)+1;
    end if;
end process;
--    dout <= cntr(26);   -- for implementation 
 	dout <= cntr(7);   -- for auto_check  
end Behavioral;

