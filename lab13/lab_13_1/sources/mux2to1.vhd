library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2to1 is
    Port ( 
        led_0 : in std_logic_vector(7 downto 0);	-- input 0
        led_1 : in std_logic_vector(7 downto 0);	-- input 1
        sel   : in  STD_LOGIC;      			    -- select line
        led_o : out std_logic_vector(7 downto 0));	-- output 
end mux2to1;

architecture rtl of mux2to1 is
begin
    -- If sel = '0' → led_o = led_0
    -- If sel = '1' → led_o = led_1
    led_o <= led_0 when sel = '0' else led_1;
end rtl;
