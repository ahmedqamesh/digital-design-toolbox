library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ================================================================
-- Title      : lab22 – 8-input Encoder
-- Description:
--   This module implements an 8-input encoder. Valid input words
--   are one-hot encoded (exactly one input bit set to '1').
--   For valid inputs, dout(2 downto 0) outputs the binary index
--   of the active input and dout(3) = '0'.
--
--   For forbidden input combinations (no bits or multiple bits
--   set), the output is forced to "1000".
-- Author     : Ahmed Qamesh
-- ================================================================

entity lab22 is
    Port (
        din  : in  STD_LOGIC_VECTOR (7 downto 0);
        dout : out STD_LOGIC_VECTOR (3 downto 0)
    );
end lab22;

architecture Behavioral of lab22 is
begin

    dout <= "0000" when din = "00000001" else -- input 0
            "0001" when din = "00000010" else -- input 1
            "0010" when din = "00000100" else -- input 2
            "0011" when din = "00001000" else -- input 3
            "0100" when din = "00010000" else -- input 4
            "0101" when din = "00100000" else -- input 5
            "0110" when din = "01000000" else -- input 6
            "0111" when din = "10000000" else -- input 7
            "1000";                          -- forbidden input

end Behavioral;

