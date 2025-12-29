library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_bench_55 is
end test_bench_55;

architecture Behavioral of test_bench_55 is
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '1';
    signal enc_out : std_logic_vector(1 downto 0);
begin

    -- Instantiate top-level encoder
    uut_lab55: entity work.lab55
        port map(
            clk     => clk,
            srst   => reset,
            coded => enc_out
        );

    -- Clock generation: 100 MHz
    clk <= not clk after 5 ns;

    -- Stimulus
    process
    begin
        wait for 20 ns;  -- Hold reset for 2 cycles
        reset <= '0';

        -- Run simulation for 300 ns (~30 cycles)
        wait for 300 ns;

        wait;  -- Stop simulation
    end process;

end Behavioral;
