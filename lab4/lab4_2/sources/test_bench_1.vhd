library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_bench1 is
--  Port ( );
end test_bench1;

architecture Behavioral of test_bench1 is
    constant CLOCK_PERIOD    : time := 10 ns;
    constant SIMULATION_TIME : time := 10000 ns;
    
    signal clk      : std_logic := '0';
    signal start    : std_logic := '0';
    signal x        : std_logic_vector(6 downto 0) := (others => '0');
    signal y        : std_logic_vector(7 downto 0) := (others=> '0');

    signal res : std_logic_vector(31 downto 0) := (others => '0');

    component lab42 is
    Port ( x : in STD_LOGIC_VECTOR (6 downto 0);
           y : out STD_LOGIC_VECTOR (7 downto 0));
    end component lab42;
    
begin

  -----------------------------------------------------------------------
  -- Generate clock
  -----------------------------------------------------------------------
  clock_gen : process
  begin
    clk <= '0';
    wait for CLOCK_PERIOD;
    loop
      clk <= '1';
      wait for CLOCK_PERIOD/2;
      clk <= '0';
      wait for CLOCK_PERIOD/2;
    end loop;
  end process clock_gen;
  -----------------------------------------------------------------------
  -- Generate start
  -----------------------------------------------------------------------
  start_gen : process
  begin
    start <= '0';
    wait for CLOCK_PERIOD;
    start <= '1';
    wait for CLOCK_PERIOD;
    start <= '0';
    wait;
  end process start_gen;
  ---------------------------------------------------------------------
  -- Instantiate the DUT
  ---------------------------------------------------------------------
  dut : lab42
    port map (
        -- Inputs
        x => x,
        -- Outputs
        y  => y);
   -----------------------------------------------------------------------
   -- Report results of checking
   -----------------------------------------------------------------------
	 process begin
	    x <= "0000001", "1000001" after 200 ns, "1111101" after 400 ns, "0001111" after 600 ns, "1001111" after 800 ns;
	    wait;
	  end process;
end Behavioral;
