library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_bench_53 is
end test_bench_53;

architecture Behavioral of test_bench_53 is

    signal clk      : std_logic := '0';
    signal din      : STD_LOGIC_VECTOR (7 downto 0);
    signal dout     : std_logic_vector(7 downto 0);

    component  lab53 is
    Port ( clk  : in STD_LOGIC;
           din  : in STD_LOGIC_VECTOR (7 downto 0);
           dout : out STD_LOGIC_VECTOR (7 downto 0));
    end component lab53;
    
    
begin

  ---------------------------------------------------------------------
  -- Instantiate the DUT
  ---------------------------------------------------------------------
  dut : lab53
    port map (
        -- Inputs
        clk => clk,
        din => din,
        -- Outputs
        dout  => dout);


    -- 100 MHz clock generation
    clk <= not clk after 5 ns;
    -- Input stimulus
    stimulus: process
        type data_array is array (0 to 2) of std_logic_vector(7 downto 0);
        constant seq : data_array := (x"05", x"0A", x"0F"); -- 5, 10, 15
        variable idx : integer := 0;
    begin
        wait for 10 ns; -- wait for first rising edge
        for i in 0 to 2 loop
            din <= seq(i);
            wait for 10 ns; -- one clock period per value
        end loop;

        -- Hold last value
        din <= seq(2);
        wait for 50 ns;

        wait; -- stop simulation
    end process;

end Behavioral;

