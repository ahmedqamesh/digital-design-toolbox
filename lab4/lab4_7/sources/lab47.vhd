library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- ===========================================================================
--  File: lab47.vhd
--  Author: Ahmed Qamesh
--  Date: 28/12/2025
-- ===========================================================================
--  Description: Multiplier of unsigned 8-bit integer by the rational constant 5/7.
--  The resulting number is to be 10 bits depth including 2 bits for fractional part. 
--  Find such a binary representation of 5/7, for which the multiplication for any 8-bit unsigned integer 
-- input gives valid result in 10 bits with 2-bit fractional part. 
-- The rounding method is truncation.
-- ===========================================================================

entity lab47 is
    Port ( x : in STD_LOGIC_VECTOR (7 downto 0);
           y : out STD_LOGIC_VECTOR (9 downto 0));
end lab47;

architecture Behavioral of lab47 is
    -- scaled constant 5/7 in fixed-point (2 fractional bits)
    constant cnst :  unsigned(10 downto 0) := to_unsigned(1463, 11);
    -- 00101110 is 46 in dec (with 6 fractional bits)
    -- Real value = 46
    signal x_unsigned : unsigned(7 downto 0);
    signal product : unsigned(18 downto 0);
begin

    x_unsigned <= unsigned(x);
    -- multiply by constant and truncate fractional bits
    product <= x_unsigned * cnst;   
     -- Right shift by 6 bits -> keep 2 fractional bits
    -- Output format: (0,10,2)
    y <=  std_logic_vector(product(18 downto 9));  -- 10-bit output

end Behavioral;
