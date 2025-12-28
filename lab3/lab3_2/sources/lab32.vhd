library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ===========================================================================
--  File: lab32.vhd
--  Author: [Your Name]
--  Date: [Today's Date]
-- ===========================================================================
--  Description:
--  This VHDL module implements a 1-to-4 demultiplexer using a process. The 
--  device has a single data input (`din`) coming from a button, 2 address 
--  inputs (`addr`) coming from switches, and 4 outputs (`dout`) driving LEDs. 
--  The demultiplexer routes the input to one of the four outputs based on the 
--  address inputs. All other outputs are set to '0'.
--
--  Features:
--  - 1 data input (button)
--  - 2 address inputs (switches)
--  - 4 outputs (LEDs)
--  - Uses process and case statement for selection
-- ===========================================================================

entity lab32 is
    Port ( din  : in STD_LOGIC;                       -- 1 data input (button)
           addr : in STD_LOGIC_VECTOR (1 downto 0);   -- 2 address inputs (switches)
           dout : out STD_LOGIC_VECTOR (3 downto 0)); -- 4 outputs (LEDs)
end lab32;

architecture Behavioral of lab32 is

begin

    -- 1-to-4 Demultiplexer process
    demux_process : process(din, addr)
    begin
        -- Default all outputs to 0
        dout <= "0000";

        case addr is
            when "00" =>
                dout(0) <= din;  -- route input to dout(0)
            when "01" =>
                dout(1) <= din;  -- route input to dout(1)
            when "10" =>
                dout(2) <= din;  -- route input to dout(2)
            when "11" =>
                dout(3) <= din;  -- route input to dout(3)
            when others =>
                dout <= "0000";  -- safety default
        end case;
    end process demux_process;

end Behavioral;

