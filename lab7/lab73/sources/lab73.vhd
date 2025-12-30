library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- ===========================================================================
--  File: lab73.vhd
--  Author: Ahmed Qamesh
--  Date: 30/12/2025
-- ===========================================================================
--  Description: 4-bit Gray counter using ROM.
-- The counter should count approximately once a second, display the result on LEDs, and set to zero upon a reset signal. 
-- The ROM should contain the output values of all states of the Gray counter.
-- ===========================================================================
entity lab73 is
    Port ( clk : in STD_LOGIC;
           srst : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (3 downto 0));
end lab73;

architecture Behavioral of lab73 is
    signal cntr26d : std_logic; -- delayed MSB of shifter
    signal en      : std_logic;
    -- Clock divider counter (≈1 s)
    signal cntr : unsigned(26 downto 0) := (others => '0');
    -- Slow counter (Gray index)
        -- Slow counter (Gray index)
    signal gray_cnt : unsigned(3 downto 0) := (others => '0');
    -- ROM declaration 16 Gray-code states
    --  ROM depth must equal the number of counter states.
    --  A 4-bit counter has 16 states array (0 to 15)
    type rom_t is array (0 to 15) of std_logic_vector(3 downto 0);
    constant ROM : rom_t := (
    -- counter state → ROM address → Gray output
        x"0", -- 0000 -> 0000
        x"1", -- 0001 -> 0001
        x"3", -- 0010 -> 0011
        x"2", -- 0011 -> 0010
        x"6", -- 0100 -> 0110
        x"7", -- 0101 -> 0111
        x"5", -- 0110 -> 0101
        x"4", -- 0111 -> 0100
        x"C", -- 1000 -> 1100
        x"D", -- 1001 -> 1101
        x"F", -- 1010 -> 1111
        x"E", -- 1011 -> 1110
        x"A", -- 1100 -> 1010
        x"B", -- 1101 -> 1011
        x"9", -- 1110 -> 1001
        x"8"  -- 1111 -> 1000
    );
    signal rom_q : std_logic_vector(3 downto 0);
begin 

-- A free-running counter divides the clock
-- Counter that provide a signal which has 1 sec
cntr_proc : process(clk) begin
    if rising_edge(clk) then
        if (srst = '1') then
            cntr <= (others =>'0'); -- intialize the counter
        else
            cntr <= cntr+1;
        end if;
    end if;
end process;

-- Generate one-clock enable pulse is generated
--    en <= cntr(26) and (not cntr26d); -- For implementation
en <= cntr(1) and (not cntr26d); -- For simulation
delay_proc : process(clk) begin
    if rising_edge(clk) then
--            cntr26d <= cntr(26); -- For implementation
        cntr26d <= cntr(1); -- For simulation
    end if;
end process;

    gray_cntr_proc : process(clk)
    begin
        if rising_edge(clk) then
            if srst = '1' then
                gray_cnt <= (others =>'0');
            elsif en = '1' then
                gray_cnt <= gray_cnt + 1;
            end if;
        end if;
    end process;

    ------------------------------------------------------------------
    -- ROM output
    ------------------------------------------------------------------
    -- Read-first ROM (1 clock latency)
 rom_rad_proc:process(clk)
    begin
        if rising_edge(clk) then
            rom_q <= ROM(to_integer(gray_cnt));
        end if;
    end process; 
    
  --  dout <= ROM(to_integer(gray_cnt));
       dout <= rom_q;  
end Behavioral;

