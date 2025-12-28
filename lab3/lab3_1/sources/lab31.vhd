library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- ===========================================================================
--  File: lab31.vhd
--  Author: Ahmed Qamesh
-- ===========================================================================
--  Description:
--  This VHDL module implements a 4-to-1 multiplexer using processes. The device
--  has 4 data inputs (`din`) coming from buttons, 2 address inputs (`addr`) 
--  coming from switches, and a single output (`dout`) driving an LED. The 
--  multiplexer selects one of the four data inputs based on the address inputs.
--
--  Features:
--  - 4 data inputs (buttons)
--  - 2 address inputs (switches)
--  - 1 output (LED)
--  - Uses process and case statement for selection
-- ===========================================================================
entity lab31 is
    Port ( din  : in STD_LOGIC_VECTOR (3 downto 0);  -- 4 data inputs (buttons)
           addr : in STD_LOGIC_VECTOR (1 downto 0);  -- 2 address inputs (switches)
           dout : out STD_LOGIC);                     -- 1 output (LED)
end lab31;

architecture Behavioral of lab31 is

begin

    -- 4-to-1 Multiplexer process
    mux_process : process(din, addr)
    begin
        case addr is
            when "00" =>
                dout <= din(0);  -- select first input
            when "01" =>
                dout <= din(1);  -- select second input
            when "10" =>
                dout <= din(2);  -- select third input
            when "11" =>
                dout <= din(3);  -- select fourth input
            when others =>
                dout <= '0';     -- default
        end case;
    end process mux_process;

end Behavioral;

