----------------------------------------------------------------------------------
-- Company: KIT
-- Engineer: Ahmed Qamesh
-- 
-- Create Date: 11/13/2025 02:01:48 PM
-- Design Name: 
-- Module Name: shift_led_left - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_led_left is
    port (
        clk : in  std_logic;                              -- system clock
        enable_shift : in  std_logic;                     -- enable signal 
        led_o : out std_logic_vector(7 downto 0)           -- 8-bit LED output
    );
end shift_led_left;

architecture rtl of shift_led_left is
    --  Shift register - initialise with only LSB = '1'
    signal led_o_r    : std_logic_vector(7 downto 0) := (7 downto 1 => '0', 0 => '1');  -- start with a single 1 at LSB
begin
     ----------------------------------------------------------------
    --  Shift-register process (triggered on the pulse)
    ----------------------------------------------------------------
   shift_reg : process (clk)
    begin
        if rising_edge(clk) then
            if enable_shift = '1' then
               if led_o_r(7) = '1' then
                    -- Reload with a single '1' in the LSB
                    led_o_r <= (7 downto 1 => '0', 0 => '1');
                else
                    -- Logical left shift by one
                    led_o_r <= led_o_r(6 downto 0) & '0' ;
                end if;
             else
             -- Explicit else - keep the current LED pattern
                led_o_r <= led_o_r;
                
            end if;
        end if;
    end process shift_reg;  
    ----------------------------------------------------------------
    --  Drive the output port
    ----------------------------------------------------------------
    led_o <= led_o_r(7 downto 0);
end rtl;
