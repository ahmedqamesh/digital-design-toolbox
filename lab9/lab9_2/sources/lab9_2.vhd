library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_SIGNED.ALL; -- To treat std_logic_vector as signed
-- ===========================================================================
--  File: lab92.vhd
--  Author: Ahmed Qamesh
--  Date: 01/01/2026
-- ===========================================================================
--  Description: Fixed-point numbers multiplier.
-- Lab 9.2 - Fixed-Point Multiplier
-- x1, x2: (1,8,4), dout: (1,8,4) with truncation


-- ===========================================================================

entity lab92 is
    Port ( clk : in STD_LOGIC;
           x1 : in STD_LOGIC_VECTOR (7 downto 0);
           x2 : in STD_LOGIC_VECTOR (7 downto 0);
           dout : out STD_LOGIC_VECTOR (7 downto 0));
end lab92;

architecture Behavioral of lab92 is
begin
    process(clk)
        variable product_full : std_logic_vector(15 downto 0);
    begin
        if rising_edge(clk) then
            -- 1. Full precision multiplication (16 bits)
            -- With std_logic_signed, '*' performs signed multiplication
            product_full := x1 * x2;
            
            -- 2. Truncation to (1, 8, 4) format
            -- product_full has 8 fractional bits (bits 7 down to 0)
            -- We need bits 11 down to 4 (8 bits total, with 4 fractional bits)
            dout <= product_full(11 downto 4);
        end if;
    end process;
end Behavioral;
