library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_bench_54 is
end test_bench_54;

architecture Behavioral of test_bench_54 is
    signal clk     : std_logic := '0';
    signal srst    : std_logic := '1';
    signal psp_bit : std_logic;
begin
    -- Instantiate UUT
    lab54_t: entity work.lab54
        port map (
            clk     => clk,
            srst    => srst,
            psp_bit => psp_bit
        );

    -- Clock generation (100 MHz)
    clk <= not clk after 5 ns;

    -- Stimulus
    stimulus: process
    begin
        wait for 20 ns;
        srst <= '0'; -- Release reset

        -- Run simulation for several cycles
        wait for 500 ns;

        wait; -- Stop
    end process;

end Behavioral;
