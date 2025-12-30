library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- ===========================================================================
--  File: lab64_clkdiv.vhd
--  Author: Ahmed Qamesh
--  Date: 30/12/2025
-- ===========================================================================
--  Description: Ring counter with approximately 1 s period using shifter and counter based clock divider from previous tasks.  
-- ===========================================================================

entity lab64_clkdiv is
    Port ( clk : in STD_LOGIC;
           srst : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (7 downto 0));
end lab64_clkdiv;

architecture Behavioral of lab64_clkdiv is
    signal cntr    : std_logic_vector(26 downto 0); -- size of 26 
    signal shifter : std_logic_vector(7 downto 0);
    signal cntr26d : std_logic; -- delayed MSB of shifter
    signal en      : std_logic;

begin
-- A free-running counter divides the clock
-- Counter that provide a signal which has 1 sec

cntr_proc : process(clk) begin
    if rising_edge(clk) then
        if (srst = '1') then
            cntr <= (others =>'0'); -- intialize the counter
        else
            cntr <= cntr+1;
        end if;
    end if;
end process;
-- Generate one-clock enable pulse is generated
--  cntr(26) toggles every 2**26 clocks
-- Rising edge happens every 2**26 clocks
-- With a 50 MHz clock → ≈ 0.67 s
-- With a 33 MHz clock → ≈ 1 s
-- en <= cntr(1) and (not cntr26d); --For implementation
en <= cntr(26) and (not cntr26d);--For auto checking

delay_proc : process(clk) begin
    if rising_edge(clk) then
     -- This creates a registered edge detector which is Synchronous and  Deterministic
--      cntr26d <= cntr(1); --For implementation
        cntr26d <= cntr(26); --For auto checking
    end if;
end process;

-- Simple shift register rotates once per second
--shifter_proc: process(clk) begin
--    if rising_edge(clk) then
--        if (srst = '1') then
--            shifter <= X"01"; -- intialize the shifter
--        else
--            if (en='1') then
--                shifter <= shifter(0) & shifter(7 downto 1);
--            end if;
--        end if;
--    end if;

shifter_proc: process(cntr(26)) begin
    if rising_edge(cntr(26)) then
        if (srst = '1') then
            shifter <= X"01"; -- intialize the shifter
        else
            shifter <= shifter(0) & shifter(7 downto 1);
        end if;
    end if;
    
end process;
    dout <= shifter;
    
end Behavioral;

