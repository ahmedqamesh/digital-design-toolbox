library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ===========================================================================
--  File: lab45.vhd
--  Author: Ahmed Qamesh
--  Date: 28/12/2025
-- ===========================================================================
--  Description: Device which performs logical, arithmetic or cyclic shift of 6-bits input given the command
--  The device has:
--  1-bit input port for shift direction (lr, slider) 
--  2-bit input for shift type (cmd, sliders)
--  6-bit input for input number (din, sliders)
--  6-bit output for input number (dout_din, LEDs) 
--  6-bit output for shifting result (dout_shifted, LEDs)
--  The unused cmd combinations do not change the input number.
-- ===========================================================================

entity lab45 is
    Port ( cmd : in STD_LOGIC_VECTOR (1 downto 0);
           lr : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (5 downto 0);
           dout_din     : out STD_LOGIC_VECTOR (5 downto 0);
           dout_shifted : out STD_LOGIC_VECTOR (5 downto 0));
end lab45;

architecture a of lab45 is

begin
    dout_din <= din;
    
    process (cmd,lr,din) begin
        if lr='0' then -- Left shift
            case cmd is
                when "00"   => -- Logical shift left
                    dout_shifted <= din(4 downto 0) & '0';
                when "01"   => -- -- Arithmetic shift left (same as logical for left)
                    dout_shifted <= din(4 downto 0) & '0';
                when "10" => -- Cyclic shift left
                    dout_shifted <= din(4 downto 0) & din(5);
                when others => -- No shift
                    dout_shifted <= din;  -- No shift
            end case;
        else --Right shift
            case cmd is
                when "00"   => -- Logical shift right
                    dout_shifted <= '0' & din(5 downto 1);
                when "01"   =>  -- Arithmetic shift right (preserve MSB)
                    dout_shifted <=  din(5) & din(5 downto 1);
                when "10" => -- Cyclic shift right
                    dout_shifted <= din(0) & din(5 downto 1);
                when others => -- No shift
                    dout_shifted <=  din; 
            end case;
        end if;
    end process;
end a;
