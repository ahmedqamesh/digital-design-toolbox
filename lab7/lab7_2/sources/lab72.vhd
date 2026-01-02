library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; -- Use numeric_std package:
-- ===========================================================================
--  File: lab71.vhd
--  Author: Ahmed Qamesh
--  Date: 30/12/2025
-- ===========================================================================
--  Description: RAM 3 bits width and 4 words depth.
-- The device has following inputs: 2-bit address, 3-bit data, write enable we button. 
-- ===========================================================================
entity lab72 is
    Port ( 
    	clk  : in STD_LOGIC;
    	we   : in  STD_LOGIC;                     -- write enable (button)
	   address : in STD_LOGIC_VECTOR (1 downto 0);  -- 2-bit address
	   din  : in  STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit data input
	   dout : out STD_LOGIC_VECTOR(2 downto 0));   -- 3-bit data output (LEDs)
end lab72;

architecture Behavioral of lab72 is
    -- RAM: 4 words × 3 bits
    type MY_RAM is array (0 to 3) of std_logic_vector(2 downto 0);
    signal SIG_MY_RAM : MY_RAM:=(others => (others=> '0'));
    signal dout_reg : std_logic_vector(2 downto 0) := (others => '0');

begin
-- Read-first synchronous RAM
 rom_rad_proc:process (clk)
    begin
       if rising_edge(clk) then
        -- Read happens first
        dout_reg <= SIG_MY_RAM(to_integer(unsigned(address)));  -- Read.
         -- Write after read if enabled 
             if (we = '1') then
                SIG_MY_RAM(to_integer(unsigned(address))) <= din; -- Write
          end if;
        end if;
    end process;
    
   dout <= dout_reg;
end Behavioral;

