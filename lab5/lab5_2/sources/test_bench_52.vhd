library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_bench_52 is
end test_bench_52;

architecture Behavioral of test_bench_52 is

    signal clk   : std_logic := '0';
    signal srst : std_logic := '0';
    signal dout    : std_logic_vector(15 downto 0);

    component  lab52 is
    Port ( clk : in STD_LOGIC;
           srst : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (15 downto 0));
    end component lab52;
    
    
begin

  ---------------------------------------------------------------------
  -- Instantiate the DUT
  ---------------------------------------------------------------------
  dut : lab52
    port map (
        -- Inputs
        clk => clk,
        srst => srst,
        -- Outputs
        dout  => dout);


    -- 100 MHz clock generation
    clk <= not clk after 5 ns;

    stimulus: process
    begin
        -- Apply synchronous reset
        srst <= '1';
        wait for 20 ns;
        srst <= '0';

        -- Let it shift for several cycles
        wait for 200 ns;
        wait;
    end process;

end Behavioral;

