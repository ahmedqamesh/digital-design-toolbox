library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
-- ===========================================================================
--  File: lab44.vhd
--  Author: Ahmed Qamesh
--  Date: 28/12/2025
-- ===========================================================================
--  Description: 2 input 2-bit unsigned integers multiplier.
--  The device has two 2-bits inputs for input numbers (sliders) and one 7-bit output (seven-segment indicator)  
--  for multiplier result. 
--  for seven-segment indicator, ach digit has 7 LEDs labeled a–g
--        a
--       ---
--    f |   | b
--      | g |
--       ---
--    e |   | c
--      |   |
--       ---
--        d        
-- Turning on/off these LEDs in the correct pattern forms numbers 0–9
-- ===========================================================================
entity lab44 is
    Port ( x1 : in STD_LOGIC_VECTOR (1 downto 0);
           x2 : in STD_LOGIC_VECTOR (1 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0); -- control which digit of a multi-digit seven-segment display is active
           y  : out STD_LOGIC_VECTOR (6 downto 0));
end lab44;
architecture Behavioral of lab44 is
signal product : unsigned(3 downto 0);  -- 2-bit x 2-bit = 4-bit product
begin
    -- Multiplication
    product <= unsigned(x1) * unsigned(x2);
    -- Decoder: Seven-segment display (common cathode, simple mapping for 0..9)
    process(product)
    begin
        case product is
            when "0000" => y <= "1000000"; -- 0
            when "0001" => y <= "1111001"; -- 1
            when "0010" => y <= "0100100"; -- 2
            when "0011" => y <= "0110000"; -- 3
            when "0100" => y <= "0011001"; -- 4
            when "0101" => y <= "0010010"; -- 5
            when "0110" => y <= "0000010"; -- 6
            when "0111" => y <= "1111000"; -- 7
            when "1000" => y <= "0000000"; -- 8
            when "1001" => y <= "0010000"; -- 9
            when others => y <= "1111111"; -- blank for undefined values
        end case;
    end process;    
    
    -- Enable only one digit (for simplicity)
    an <= "1110";  -- turn on first 7-segment digit, others off
end Behavioral;

