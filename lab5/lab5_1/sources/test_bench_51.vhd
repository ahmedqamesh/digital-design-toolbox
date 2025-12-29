library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_bench_51 is
-- Testbench has no ports
end test_bench_51;

architecture Behavioral of test_bench_51 is

    -- Signals to connect to DUT
    signal clk     : std_logic := '0';
    signal clear   : std_logic := '1';
    signal preset  : std_logic := '1';
    signal j       : std_logic := '0';
    signal k       : std_logic := '0';
    signal e       : std_logic := '0';
    signal jk_out  : std_logic;

    -- Clock period
    constant clk_period : time := 10 ns; -- 100 MHz

begin

    -- Instantiate the DUT
    lab51_m: entity work.lab51
        port map (
            clk     => clk,
            clear   => clear,
            preset  => preset,
            j       => j,
            k       => k,
            e       => e,
            jk_out  => jk_out
        );

    -- Clock generation
    clk_process : process
    begin
        while True loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize inputs
        clear <= '1';
        preset <= '1';
        e <= '0';
        j <= '0';
        k <= '0';

        wait for 20 ns;

        -- Test asynchronous clear
        clear <= '0';
        wait for 20 ns;
        clear <= '1';
        wait for 20 ns;

        -- Test asynchronous preset
        preset <= '0';
        wait for 20 ns;
        preset <= '1';
        wait for 20 ns;

        -- Enable the flip-flop
        e <= '1';

        -- Test all JK combinations
        j <= '0'; k <= '0'; wait for 20 ns; -- Hold
        j <= '0'; k <= '1'; wait for 20 ns; -- Reset
        j <= '1'; k <= '0'; wait for 20 ns; -- Set
        j <= '1'; k <= '1'; wait for 20 ns; -- Toggle
        j <= '1'; k <= '1'; wait for 20 ns; -- Toggle again
        j <= '0'; k <= '0'; wait for 20 ns; -- Hold
        j <= '0'; k <= '1'; wait for 20 ns; -- Reset

        -- Disable the flip-flop
        e <= '0';
        j <= '1'; k <= '1';
        wait for 20 ns; -- Should hold value

        -- Finish simulation
        wait;
    end process;

end Behavioral;
