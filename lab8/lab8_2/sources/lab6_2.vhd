library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.all;
-- ===========================================================================
--  File: lab62.vhd
--  Author: Ahmed Qamesh
--  Date: 31/12/2025
-- ===========================================================================
--  Description: Simple Counter
-- ===========================================================================


entity lab62 is
    Port ( clk : in STD_LOGIC;
           srst : in std_logic;
           dout : out STD_LOGIC_VECTOR(7 downto 0));
           
end lab62;

architecture a of lab62 is
    signal cntr : std_logic_vector(26 downto 0):=(others => '0');
begin
    dout <= (others => cntr(7));   -- for auto_check
    cnt_proc : process(clk)
    begin
        if (rising_edge(clk)) then
            if srst = '1' then
                cntr <= (others => '0');
            else     
                cntr <= unsigned(cntr)+1;
            end if;    
        end if;
    end process cnt_proc;
end a;
