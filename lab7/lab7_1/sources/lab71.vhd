library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- ===========================================================================
--  File: lab71.vhd
--  Author: Ahmed Qamesh
--  Date: 30/12/2025
-- ===========================================================================
--  Description: Sine wave generator using ROM (16 words, each 8 bits width) and testbench for it. 
-- The tasks (RAM type is "read first"):
-- The ROM contains 16 samples of one sine period. 
-- The sine wave has frequency equal to 1/16 of sampling frequency.


-- ===========================================================================

entity lab71 is
    Port ( clk : in STD_LOGIC;
           srst : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (7 downto 0));
end lab71;

architecture Behavioral of lab71 is
    -- 4-bit address counter (16 samples)
    signal addr : unsigned(3 downto 0) := (others => '0');
        -- ROM declaration
    type rom_t is array (0 to 15) of signed(7 downto 0);
    -- In order to obtain a binary representation of these sample values, 
    -- the original values are multiplied by 127
    -- rounded by truncating the fractional part and converted to 8-bit binary. 
    -- sin(2πn/16) ≈floor(127*sin(2πn/16))
    constant ROM : rom_t := (
        to_signed(   0, 8),
        to_signed(  48, 8),
        to_signed(  89, 8),
        to_signed( 117, 8),
        to_signed( 127, 8),
        to_signed( 117, 8),
        to_signed(  89, 8),
        to_signed(  48, 8),
        to_signed(   0, 8),
        to_signed( -49, 8),
        to_signed( -90, 8),
        to_signed(-118, 8),
        to_signed(-127, 8),
        to_signed(-118, 8),
        to_signed( -90, 8),
        to_signed( -49, 8)
    );
     signal rom_q : signed(7 downto 0);
begin
    -- Address counter
addr_cnt_proc:process(clk)
    begin
        if rising_edge(clk) then
            if srst = '1' then
                addr <= (others => '0');
            else
                addr <= addr + 1;
            end if;
        end if;
    end process;
    
    -- Read-first ROM (1 clock latency)
 rom_rad_proc:process(clk)
    begin
        if rising_edge(clk) then
            rom_q <= ROM(to_integer(addr));
        end if;
    end process;   
    
   dout <= std_logic_vector(rom_q);
end Behavioral;

