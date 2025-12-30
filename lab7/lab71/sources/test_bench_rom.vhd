library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_bench_rom is
end test_bench_rom;

architecture Behavioral of test_bench_rom is

    signal clk  : std_logic := '0';
    signal srst  : std_logic := '1';
    signal dout : std_logic_vector(7 downto 0);

    constant CLK_PERIOD : time := 10 ns; -- 100 MHz

begin

    -- DUT
    sine_rom: entity work.lab71
        port map (
            clk  => clk,
            srst  => srst,
            dout => dout
        );

    -- Clock generation
    clk <= not clk after CLK_PERIOD/2;

    -- Stimulus
    process
    begin
        srst <= '1';
        wait for 3 * CLK_PERIOD;
        srst <= '0';

        -- Observe at least 2 periods (32 samples)
        wait for 40 * CLK_PERIOD;
        wait;
    end process;

end Behavioral;

