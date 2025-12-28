library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ===========================================================================
--  File: test_bench_2.vhd
--  Author: Ahmed Qamesh
-- ===========================================================================
--  Description:
--  Testbench for lab32 (1-to-4 demultiplexer). 
--  - Generates a sequence '101010...' for the data input `din`.
--  - Generates the sequence "00", "01", "10", "11", "00", ... for the address input `addr`.
--  - Checks that the output selected by the address has the same value as the input.
--  - No automatic checking; for visual inspection in simulation.
-- ===========================================================================

entity test_bench is
--  Port ( );
end test_bench;

architecture struct of test_bench is
    constant INPUT_PERIOD : time := 10 ns;
    constant ADDR_PERIOD  : time := 100 ns;

    signal din      : std_logic;
    signal addr     : std_logic_vector(1 downto 0);
    signal dout     : std_logic_vector(3 downto 0);

    -- DUT declaration
    component lab32 is
        Port ( din  : in STD_LOGIC;
               addr : in STD_LOGIC_VECTOR  (1 downto 0);
               dout : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

begin

  -----------------------------------------------------------------------
  -- Generate input sequence: 101010...
  -----------------------------------------------------------------------
  input_gen : process
  begin
    din <= '0';
    wait for INPUT_PERIOD/2;
    loop
      din <= '1';
      wait for INPUT_PERIOD/2;
      din <= '0';
      wait for INPUT_PERIOD/2;
    end loop;
  end process input_gen;

  -----------------------------------------------------------------------
  -- Generate address sequence: 00, 01, 10, 11, 00, ...
  -----------------------------------------------------------------------
  addr_gen : process
  begin
    loop
      addr <= "00";
      wait for ADDR_PERIOD/4;
      addr <= "01";
      wait for ADDR_PERIOD/4;
      addr <= "10";
      wait for ADDR_PERIOD/4;
      addr <= "11";
      wait for ADDR_PERIOD/4;
    end loop;
  end process addr_gen;

  -----------------------------------------------------------------------
  -- Instantiate the DUT (lab32)
  -----------------------------------------------------------------------
  dut : lab32
    port map (
        din  => din,
        addr => addr,
        dout => dout
    );

end struct;

