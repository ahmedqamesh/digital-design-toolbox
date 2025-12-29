library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ===========================================================================
--  File: lab51.vhd
--  Author: Ahmed Qamesh
--  Date: 28/12/2025
-- ===========================================================================
--  Description: JK-flip-flop with enable and asynchronous clear and preset inputs.
--  Implement JK-flip-flop, cyclic shifter, delay module, pseudo random sequence generator and convolutional encoder.   
-- ===========================================================================

entity lab51 is
    Port ( clk    : in STD_LOGIC;
           clear  : in STD_LOGIC; -- Asynchronous clear   (active low)
           preset : in STD_LOGIC; -- Asynchronous preset  (active low)
           j      : in STD_LOGIC; -- Slider (SW)
           k      : in STD_LOGIC; -- Slider (SW)
           
           e      : in STD_LOGIC; --Enable Signal
           jk_out : out STD_LOGIC);
end lab51;
architecture Behavioral of lab51 is
 signal jk_reg : std_logic;
begin
process (clk, clear, preset) 
begin
        if clear = '1' then
            jk_reg <= '0';                 -- Asynchronous clear
        elsif preset = '1' then
            jk_reg <= '1';                 -- Asynchronous preset
        elsif rising_edge(clk) then
		if e='1' then
            if  (j = '0' and k = '0') then
                jk_reg <= jk_reg;       -- Hold
            elsif (j = '0' and k = '1') then
                jk_reg <= '0';         -- Reset
            elsif (j = '1' and k = '0') then
                jk_reg <= '1';         -- Set
            elsif (j = '1' and k = '1') then
                jk_reg <= not jk_reg;   -- Toggle
            end if;
		end if;
	end if;
end process;
jk_out <= jk_reg;
end Behavioral;

