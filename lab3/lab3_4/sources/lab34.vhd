library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ===========================================================================
--  File: lab34.vhd
--  Author: Ahmed Qamesh
-- ===========================================================================
--  Description:
--  This VHDL module implements a 4-to-1 multiplexer that connects one of four 
--  4-bit binary inputs (din0–din3) to the rightmost digit of a 7-segment 
--  display. The selection is controlled by a 2-bit address input. The module 
--  outputs both the 7-segment signals (dout) and the anode control signals (an)
--  for the display. Only the rightmost digit is enabled.
--
--  Features:
--  - 4 4-bit data inputs (din0–din3) from switches
--  - 2-bit address input to select which input is displayed
--  - 7-bit output for seven-segment display
--  - 4-bit anode control output (`an`), only rightmost digit enabled
-- ===========================================================================

entity lab34 is
    Port ( din0 : in STD_LOGIC_VECTOR (3 downto 0);
           din1 : in STD_LOGIC_VECTOR (3 downto 0);
           din2 : in STD_LOGIC_VECTOR (3 downto 0);
           din3 : in STD_LOGIC_VECTOR (3 downto 0); 
           addr : in STD_LOGIC_VECTOR (1 downto 0);
           an   : out STD_LOGIC_VECTOR (3 downto 0);
           dout : out STD_LOGIC_VECTOR (6 downto 0));
end lab34;

architecture Behavioral of lab34 is

    signal selected : STD_LOGIC_VECTOR(3 downto 0);  -- selected 4-bit input

    -- Function to convert 4-bit binary to 7-segment encoding
    function seg7(input : in STD_LOGIC_VECTOR(3 downto 0)) return STD_LOGIC_VECTOR is
        variable seg : STD_LOGIC_VECTOR(6 downto 0);
    begin
        case input is
            when "0000" => seg := "1000000"; -- 0
            when "0001" => seg := "1111001"; -- 1
            when "0010" => seg := "0100100"; -- 2
            when "0011" => seg := "0110000"; -- 3
            when "0100" => seg := "0011001"; -- 4
            when "0101" => seg := "0010010"; -- 5
            when "0110" => seg := "0000010"; -- 6
            when "0111" => seg := "1111000"; -- 7
            when "1000" => seg := "0000000"; -- 8
            when "1001" => seg := "0010000"; -- 9
            when "1010" => seg := "0001000"; -- A
            when "1011" => seg := "0000011"; -- b
            when "1100" => seg := "1000110"; -- C
            when "1101" => seg := "0100001"; -- d
            when "1110" => seg := "0000110"; -- E
            when "1111" => seg := "0001110"; -- F
            when others => seg := "1111111"; -- blank
        end case;
        return seg;
    end function;

begin

    -- Multiplexer process
    process(din0, din1, din2, din3, addr)
    begin
        case addr is
            when "00" =>
                selected <= din0;
            when "01" =>
                selected <= din1;
            when "10" =>
                selected <= din2;
            when "11" =>
                selected <= din3;
            when others =>
                selected <= "0000";
        end case;
    end process;

    -- Assign 7-segment output
    dout <= seg7(selected);

    -- Enable only the rightmost digit of 4-digit 7-segment display
    an <= "1110";

end Behavioral;

