----------------------------------------------------------------------------------
-- Company: KIT
-- Engineer: Ahmed Qamesh
-- 
-- Create Date: 11/13/2025 02:01:48 PM
-- Module Name: shift_led_right - Behavioral
-- Project Name: Advanced FPGA Course for KSETA 
-- Target Devices: Red Pitaya STEMLab-14 (xc7z010clg400-1)
-- Tool Versions: Vivado .
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_led_right is
    port (
        clk : in  std_logic;                              -- system clock
        enable_shift : in  std_logic;                     -- enable signal 
        led_o : out std_logic_vector(7 downto 0)          -- 8-bit LED output
    );
end shift_led_right;

architecture rtl of shift_led_right is
     --  Shift register - initialise with only MSB = '1'
    signal led_o_r    : std_logic_vector(7 downto 0) :=  (7 => '1' ,6 downto 0 => '0');  -- start with a single 1 at MSB
     
begin
     ----------------------------------------------------------------
    --  Shift-register process (triggered on the pulse)
    ----------------------------------------------------------------
   shift_reg : process (clk)
    begin
        if rising_edge(clk) then
            if enable_shift = '1' then
                if led_o_r(0) = '1' then
                -- Reload with a single '1' in the MSB
                    led_o_r <= (7 => '1', 6 downto 0 => '0');
                else
                -- Logical right shift by one
                   led_o_r <= '0' & led_o_r(7 downto 1); 
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
