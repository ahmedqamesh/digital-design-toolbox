library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_lab81 is
end tb_lab81;

architecture sim of tb_lab81 is

    signal clk   : STD_LOGIC := '0';
    signal srst  : STD_LOGIC := '1';
    signal info  : STD_LOGIC := '1';
    signal coded : STD_LOGIC_VECTOR(1 downto 0);

begin

    -- DUT
    uut: entity work.lab81
        port map (
            clk   => clk,
            srst  => srst,
            info  => info,
            coded => coded
        );

    -- clock generation (10 ns period)
    clk <= not clk after 5 ns;

    -- stimulus
    process
    begin
        srst <= '1';
        wait for 20 ns;
        srst <= '0';

        -- keep input = '1'
        wait for 200 ns;
        wait;
    end process;

end sim;

