library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- ===========================================================================
--  File: lab63.vhd
--  Author: Ahmed Qamesh
--  Date: 30/12/2025
-- ===========================================================================
--  Description: 30-bit width binary bidirectional modulo 2^30 counter with synchronous reset.
-- ===========================================================================
entity lab63 is
    Port ( clk  : in STD_LOGIC;
           srst : in STD_LOGIC;
           mode : in STD_LOGIC;  -- 0 = count up, 1 = count down
           dout : out STD_LOGIC_VECTOR (7 downto 0));
end lab63;

architecture Behavioral of lab63 is
    signal cntr : std_logic_vector(29 downto 0);
begin

    -- Synchronous process for bidirectional counter
    process(clk)
    begin
        if rising_edge(clk) then
            if srst = '1' then
                cntr <= (others => '0');  -- synchronous reset
            else
                if mode = '0' then
                    cntr <= cntr + 1;    -- count up (modulo 2^30)
                else
                    cntr <= cntr - 1;    -- count down (modulo 2^30)
                end if;
            end if;
        end if;
    end process;

    -- Output selection
    -- For on-board testing: 8 MSBs
    -- dout <= cntr(29 downto 22);

    -- For auto-check: bits 8 downto 1
    dout <= cntr(8 downto 1);

end Behavioral;

