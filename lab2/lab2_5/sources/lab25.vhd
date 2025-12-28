-- ================================================================
-- Title      : lab25 – log2() function for 5-bit integers.
-- Board      : Digilent Basys3 FPGA Board
--  Description:
--  This VHDL module implements an integer log2(x) function for 5-bit 
--  non-negative integers using a priority encoder. The input `din` is a 
--  5-bit binary number set by switches. The output `dout` drives a single 
--  7-segment display showing the integer part of log2(din). Only the 
--  rightmost digit of a 4-digit 7-segment display is enabled.
--
--  Features:
--  - 5-bit input (0 to 31)
--  - Output is integer log2(x) displayed on 7-segment
--  - Priority encoder determines the position of the most significant '1'
--
-- Author     : Ahmed Qamesh
-- Date       : 25/12/2025
-- ================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab25 is
    Port ( din  : in STD_LOGIC_VECTOR (4 downto 0);
           dout : out STD_LOGIC_VECTOR (6 downto 0);
           an   : out STD_LOGIC_VECTOR (3 downto 0));
end lab25;

architecture Behavioral of lab25 is

    -- Function to convert a 3-bit number to 7-segment encoding
    function seg7(input : in STD_LOGIC_VECTOR(2 downto 0)) return STD_LOGIC_VECTOR is
        variable seg : STD_LOGIC_VECTOR(6 downto 0);
    begin
        case input is
            when "000" => seg := "1000000"; -- 0
            when "001" => seg := "1111001"; -- 1
            when "010" => seg := "0100100"; -- 2
            when "011" => seg := "0110000"; -- 3
            when "100" => seg := "0011001"; -- 4
            when "101" => seg := "0010010"; -- 5
            when "110" => seg := "0000010"; -- 6
            when "111" => seg := "1111000"; -- 7 (not used here)
            when others => seg := "1111111"; -- blank
        end case;
        return seg;
    end function;

    signal log_val : STD_LOGIC_VECTOR(2 downto 0);

begin

    -- Priority encoder for log2(x)
    process(din)
    begin
        case din is
            when "00000" => log_val <= "000"; -- log2(0) undefined, set to 0
            when "00001" => log_val <= "000"; -- log2(1) = 0
            when "0001?" => log_val <= "001"; -- log2(2,3) = 1
            when "001??" => log_val <= "010"; -- log2(4-7) = 2
            when "01???" => log_val <= "011"; -- log2(8-15) = 3
            when "1????" => log_val <= "100"; -- log2(16-31) = 4
            when others => log_val <= "000";
        end case;
    end process;

    -- Output the 7-segment code
    dout <= seg7(log_val);

    -- Enable only the rightmost digit of 4-digit 7-segment display
    an <= "1110";

end Behavioral;

