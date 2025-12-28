library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ================================================================
-- Title      : lab23 – 4-bit Binary to Gray Code Converter
-- Description:
--   This module converts a 4-bit binary input code into its
--   corresponding Gray code representation.
--   The input 'din' is provided by four switches, and the output
--   'dout' is displayed using four LEDs.
--
--   Gray code conversion rule:
--     g(3) = b(3)
--     g(2) = b(3) XOR b(2)
--     g(1) = b(2) XOR b(1)
--     g(0) = b(1) XOR b(0)
--
-- Author     : Ahmed Qamesh
-- ================================================================

entity lab23 is
    Port (
        din  : in  STD_LOGIC_VECTOR (3 downto 0);
        dout : out STD_LOGIC_VECTOR (3 downto 0)
    );
end lab23;

architecture Behavioral of lab23 is
begin

    -- Binary to Gray code conversion
    dout(3) <= din(3);
    dout(2) <= din(3) xor din(2);
    dout(1) <= din(2) xor din(1);
    dout(0) <= din(1) xor din(0);

end Behavioral;

