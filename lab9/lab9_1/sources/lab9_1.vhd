library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- ===========================================================================
--  File: lab91.vhd
--  Author: Ahmed Qamesh
--  Date: 01/01/2026
-- ===========================================================================
--  Description: Fixed-point numbers adder.
-- Lab 9.1 - Fixed-Point Adder
-- x1: (1,16,8), x2: (1,8,12), dout: 21-bit full precision
-- ===========================================================================

entity lab91 is
    Port ( clk : in STD_LOGIC;
           x1 : in STD_LOGIC_VECTOR (15 downto 0); -- 16 bits total: 1 sign bit, 7 integer bits, 8 fractional bits.
           x2 : in STD_LOGIC_VECTOR (7 downto 0); -- 8 bits total: 1 sign bit, -5 integer bits (implied), 12 fractional bits.
           dout : out STD_LOGIC_VECTOR (20 downto 0));
end lab91;
-- we can decide 1 (sign) + 8 (integer) + 12 (fractional) = 21 bits
architecture Behavioral of lab91 is
    -- Convert inputs to signed
    -- x1 has 8 fractional bits. Shift left by 4 ( 12-8= 4 bits) to align with 12 bits.
    --now the bit width of x1 increases from 16 to 20.
    -- To prevents overflow and correctly zero-extends
    -- perform sign extension. This provides the extra "carry" bit needed to handle the sum of two  20-bit signed numbers
begin
    process(clk)
        variable x1_ext  : signed(20 downto 0);
        variable x2_ext : signed(20 downto 0);
    -- Synchronous process without reset  
    begin
        if rising_edge(clk) then
            -- 1. Align binary points by shifting x1 left by 4 
            -- and resizing to 21 bits for overflow protection.
            x1_ext := resize(signed(x1) & "0000", 21);
            
            -- 2. Sign-extend x2 to 21 bits.
            x2_ext := resize(signed(x2), 21);
            
            -- 3. Perform addition; result is registered on the next clock edge.
            dout <= std_logic_vector(x1_ext + x2_ext);
        end if;
    end process;
end Behavioral;
