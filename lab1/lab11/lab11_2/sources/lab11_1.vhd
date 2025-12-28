library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- ===========================================================================
--  File: lab11_1.vhd
--  Author: Ahmed Qamesh
-- ===========================================================================
--  Description:
--  This module implements an 8-sample moving average low-pass filter.
--  The input sample width is 16 bits. The filter computes the average of
--  the current input sample and the previous seven samples.
--
--  A running sum is maintained with full internal precision. The final
--  averaging operation is performed by truncation (division by 8) at the
--  output stage.
--
--  The filter output is registered and appears with a latency of one
--  clock cycle relative to the input.
--
--  The testbench provides a free-running 4-bit counter as input, which
--  increments on every clock cycle.
--
--  No reset signal is used. All internal registers, including the
--  accumulator and delay line, are initialized to zero at declaration.
--
-- ===========================================================================


entity lab111 is
    Port ( clk : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (15 downto 0); -- Input samples width - 16 bit. 
           dout : out STD_LOGIC_VECTOR (15 downto 0)); -- Output samples width - 16 bit. 
end lab111;

architecture Behavioral of lab111 is
    constant N : integer := 8; -- Filter window width - 8 samples
    
    -- sdelay is  an array of size N with elements of the required bit width (16 bit)
    type tdelay is array (N-1 downto 0) of std_logic_vector(15 downto 0);
    -- As the reset signal is not applied, 
    -- the 19 bit accumulator (res) and delay lines signals are initialized with zeros. 
    signal sdelay    : tdelay:=(others => (others => '0'));
    signal res        : unsigned(18 downto 0):=(others => '0');
    
begin
    ------------------------------------------------------------------
    -- Shift-register delay line + running sum
    --  the delay line (tdelay) for N samples is implemented using shift register
    ------------------------------------------------------------------

process (clk)
     variable sum_new : unsigned(18 downto 0);
     begin
	if rising_edge(clk) then
			sdelay <= din & sdelay(N-1 downto 1);
			-- Running sum: new sum = previous sum + new sample - oldest sample
			sum_new:= res + unsigned(din) - unsigned(sdelay(0));
			res <= sum_new;
		end if;
	   
end process;
dout       <= std_logic_vector(res(18 downto 3));  -- average / divide by 8
end Behavioral;

