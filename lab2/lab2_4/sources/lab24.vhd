-- ================================================================
-- Title      : lab21 – Hexadecimal to Seven-Segment Decoder
-- Board      : Digilent Basys3 FPGA Board
-- Description:
--   This module implements a 4-bit hexadecimal (0–F) to seven-
--   segment display decoder. The input 'din' is provided by four
--   onboard switches (SW3–SW0). The output is displayed on the
--   rightmost digit of the Basys3 seven-segment indicator.
--
--   The Basys3 seven-segment display is common-anode with active-
--   LOW segment cathodes and inverted anode control signals.
--   Therefore, a segment is illuminated when both its anode and
--   cathode are driven LOW.
--
--   Only the rightmost digit is enabled using:
--       an <= "1110";
--
--   The decimal point (DP) is not used and remains off.
--
-- Author     : Ahmed Qamesh
-- Date       : 25/12/2025
-- ================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lab24 is
    Port ( din  : in STD_LOGIC_VECTOR (3 downto 0);
           dout : out STD_LOGIC_VECTOR (6 downto 0);
           an   : out STD_LOGIC_VECTOR (3 downto 0));
end lab21;

architecture Behavioral of lab24 is
begin

    -- Enable ONLY the rightmost digit (active LOW due to inverter)
    an <= "1110";

    -- Hexadecimal to 7-segment decoder
    -- Segment order: a b c d e f g
    -- Active LOW (0 lights the segment)
    dout <= "1000000" when din = "0000" else -- 0
            "1111001" when din = "0001" else -- 1
            "0100100" when din = "0010" else -- 2
            "0110000" when din = "0011" else -- 3
            "0011001" when din = "0100" else -- 4
            "0010010" when din = "0101" else -- 5
            "0000010" when din = "0110" else -- 6
            "1111000" when din = "0111" else -- 7
            "0000000" when din = "1000" else -- 8
            "0010000" when din = "1001" else -- 9
            "0001000" when din = "1010" else -- A
            "0000011" when din = "1011" else -- b
            "1000110" when din = "1100" else -- C
            "0100001" when din = "1101" else -- d
            "0000110" when din = "1110" else -- E
            "0001110";                        -- F

end Behavioral;
