library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- ===========================================================================
--  File: lab61.vhd
--  Author: Ahmed Qamesh
--  Date: 30/12/2025
-- ===========================================================================
--  Description: 30-bit width binary adding modulo 230 counter with synchronous reset.
-- ===========================================================================

entity lab61 is
    Port ( clk : in STD_LOGIC; -- 100 MHz clock
           srst : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (7 downto 0)); -- 8 MSBs of counter register are to be connected 
end lab61;
architecture Behavioral of lab61 is
    signal cntr : std_logic_vector(29 downto 0);
begin
-- A free-running counter divides the clock
-- Counter that provide a signal which has 1 sec

cntr_proc : process(clk) begin
    if rising_edge(clk) then
        if (srst = '1') then
            cntr <= (others =>'0'); -- intialize the counter
        else
            cntr <= unsigned(cntr)+1;
        end if;
    end if;
end process;
--    dout <= cntr(29 downto 22); -- for implementation
    dout <= cntr(15 downto 8);   -- for auto_check  
end Behavioral;

