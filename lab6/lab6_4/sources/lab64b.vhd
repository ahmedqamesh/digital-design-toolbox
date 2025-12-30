library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
-- ===========================================================================
--  File: lab64b.vhd
--  Author: Ahmed Qamesh
--  Date: 30/12/2025
-- ===========================================================================
--  Description: Ring counter with approximately 1 s period using shifter and counter based clock divider from previous tasks.  
-- ===========================================================================

entity lab64b is
    Port (
        clk  : in  STD_LOGIC;
        rst  : in  STD_LOGIC;
        dout : out STD_LOGIC_VECTOR (7 downto 0)
    );
end lab64b;

architecture Behavioral of lab64b is
    signal cntr   : std_logic_vector(26 downto 0);
    signal shifter: std_logic_vector(7 downto 0);
begin

    cntr_proc : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                cntr    <= (others => '0');
                shifter <= x"01";
            else
                cntr <= unsigned(cntr) + 1;
                -- Trigger depends on full counter equality
                if unsigned(cntr) = 0 then
                    shifter <= shifter(0) & shifter(7 downto 1);
                end if;
            end if;
        end if;
    end process;

    dout <= shifter;

end Behavioral;

