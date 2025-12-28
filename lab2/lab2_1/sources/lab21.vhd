library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ================================================================
-- Title      : lab21 – 3-to-8 Decoder
-- Description:
--   This module implements a 3-input to 8-output binary decoder.
--   The input 'din' represents a 3-bit binary value from switches.
--   Exactly one output bit in 'dout' is asserted HIGH corresponding
--   to the binary value of 'din'.
--
--   Example:
--     din = "000" -> dout = "00000001"
--     din = "101" -> dout = "00100000"
--
-- Author     : Ahmed Qamesh
-- ================================================================

entity lab21 is
    Port (
        din  : in  STD_LOGIC_VECTOR (2 downto 0);
        dout : out STD_LOGIC_VECTOR (7 downto 0)
    );
end lab21;

architecture Behavioral of lab21 is
begin

    -- 3-to-8 decoder logic
    dout <= "00000001" when din = "000" else
            "00000010" when din = "001" else
            "00000100" when din = "010" else
            "00001000" when din = "011" else
            "00010000" when din = "100" else
            "00100000" when din = "101" else
            "01000000" when din = "110" else
            "10000000"; -- din = "111"

end Behavioral;

