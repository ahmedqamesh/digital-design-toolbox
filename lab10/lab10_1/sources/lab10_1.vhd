library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lab101 is
    Port ( clk  : in  STD_LOGIC;
           din  : in  STD_LOGIC_VECTOR (15 downto 0);
           dout : out STD_LOGIC_VECTOR (31 downto 0));
end lab101;

architecture Behavioral of lab101 is
    -- Stage 1 Signals
    signal s1_abs  : std_logic_vector(15 downto 0) := (others => '0');
    signal s1_sign : std_logic := '0';
begin

    process(clk)
        variable v_abs      : std_logic_vector(15 downto 0);
        variable v_mantissa : std_logic_vector(22 downto 0);
        variable v_exp      : std_logic_vector(7 downto 0);
    begin
        if rising_edge(clk) then
            -- STAGE 1: Calculate Absolute Value and Sign (1st Clock Cycle)
            s1_sign <= din(15);
            if din(15) = '1' then
                s1_abs <= conv_std_logic_vector(unsigned(not din) + 1, 16);
            else
                s1_abs <= din;
            end if;

            -- STAGE 2: Normalize and Assemble (2nd Clock Cycle)
            -- Checking s1_abs (which is the input from 1 cycle ago)
            v_abs := s1_abs;
            
            if v_abs = x"0000" then
                dout <= (others => '0'); -- Positive Zero
            else
                -- Priority Encoder for Normalization
                if    v_abs(15) = '1' then v_exp := x"8E"; v_mantissa := v_abs(14 downto 0) & "00000000";
                elsif v_abs(14) = '1' then v_exp := x"8D"; v_mantissa := v_abs(13 downto 0) & "000000000";
                elsif v_abs(13) = '1' then v_exp := x"8C"; v_mantissa := v_abs(12 downto 0) & "0000000000";
                elsif v_abs(12) = '1' then v_exp := x"8B"; v_mantissa := v_abs(11 downto 0) & "00000000000";
                elsif v_abs(11) = '1' then v_exp := x"8A"; v_mantissa := v_abs(10 downto 0) & "000000000000";
                elsif v_abs(10) = '1' then v_exp := x"89"; v_mantissa := v_abs(9 downto 0)  & "0000000000000";
                elsif v_abs(9)  = '1' then v_exp := x"88"; v_mantissa := v_abs(8 downto 0)  & "00000000000000";
                elsif v_abs(8)  = '1' then v_exp := x"87"; v_mantissa := v_abs(7 downto 0)  & "000000000000000";
                elsif v_abs(7)  = '1' then v_exp := x"86"; v_mantissa := v_abs(6 downto 0)  & "0000000000000000";
                elsif v_abs(6)  = '1' then v_exp := x"85"; v_mantissa := v_abs(5 downto 0)  & "00000000000000000";
                elsif v_abs(5)  = '1' then v_exp := x"84"; v_mantissa := v_abs(4 downto 0)  & "000000000000000000";
                elsif v_abs(4)  = '1' then v_exp := x"83"; v_mantissa := v_abs(3 downto 0)  & "0000000000000000000";
                elsif v_abs(3)  = '1' then v_exp := x"82"; v_mantissa := v_abs(2 downto 0)  & "00000000000000000000";
                elsif v_abs(2)  = '1' then v_exp := x"81"; v_mantissa := v_abs(1 downto 0)  & "000000000000000000000";
                elsif v_abs(1)  = '1' then v_exp := x"80"; v_mantissa := v_abs(0)           & "0000000000000000000000";
                else                       v_exp := x"7F"; v_mantissa := (others => '0');
                end if;

                dout <= s1_sign & v_exp & v_mantissa;
            end if;
        end if;
    end process;
end Behavioral;
