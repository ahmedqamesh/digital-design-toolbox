library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
-- ===========================================================================
--  File: lab42.vhd
--  Author: Ahmed Qamesh
--  Date: 28/12/2025
-- ===========================================================================
--  Description: Summator of 7-bit signed integer and constant (cnst = 3).
--  The device has one 7-bit input x for input integer (sliders) and one 8-bit output y (LEDs).  
--  It perform the summation considering the sign of input. 
--  I.e. the MSBs of each operand in summation is a sign bit. 
-- ===========================================================================
entity lab42 is
    Port ( x : in STD_LOGIC_VECTOR (6 downto 0);
           y : out STD_LOGIC_VECTOR (7 downto 0));
end lab42;
architecture Behavioral of lab42 is
    constant cnst : std_logic_vector(7 downto 0) := X"03"; -- Signed constant
    signal x_signed   : signed(6 downto 0);
    signal sign_bit : std_logic := '0';
    signal sum : signed(7 downto 0);  -- 4-bit signal to handle overflow
begin
    -- Convert input to signed
    x_signed <= signed(x);
    sign_bit <=x(6); -- x(6) is the MSB of x, i.e., the sign bit.
    -- Addition is performed as signed arithmetic 
    sum <= signed(sign_bit & x) + signed(cnst);
    -- Assign to output
    y <= std_logic_vector(sum);

end Behavioral;

