library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_bench is
--  Port ( );
end test_bench;

architecture a of test_bench is
    constant CLOCK_PERIOD    : time := 1 ns;
    constant SIMULATION_TIME : time := 10000 ns;
    
    signal clk      : std_logic := '0';
    signal start    : std_logic := '0';
    signal we       : std_logic := '0';
    signal address  : std_logic_vector(1 downto 0);
    signal din,dout : std_logic_vector(2 downto 0);
    signal psp_reg  : std_logic_vector(14 downto 0) := "101010001110110";
    
    signal crc_y0 : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y1 : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y2 : std_logic_vector(7 downto 0) := (others => '0');
    
    signal res : std_logic_vector(31 downto 0) := (others => '0');
    
    component lab72 is
        Port ( clk : in STD_LOGIC;
               we : in STD_LOGIC;
               address : in STD_LOGIC_VECTOR (1 downto 0);
               din : in STD_LOGIC_VECTOR (2 downto 0);
               dout : out STD_LOGIC_VECTOR (2 downto 0));
    end component lab72;
    
    component crc8_ccitt_calc IS
      port(
        clk     : in std_logic;
        start   : in std_logic;
        bit_in  : in std_logic;
        crc_out : out std_logic_vector(7 downto 0));
    END component crc8_ccitt_calc;
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
    wait for CLOCK_PERIOD;
    wait for CLOCK_PERIOD;
    start <= '1';
    wait for CLOCK_PERIOD;
    start <= '0';
    wait;
  end process start_gen;
  ---------------------------------------------------------------------
  -- Instantiate the DUT
  ---------------------------------------------------------------------
  dut : lab72
    port map (
        -- Inputs
        clk => clk,
        we  => we,
        address => address,
        din   => din,
        -- Outputs
        dout  => dout);

  -----------------------------------------------------------------------
  -- Generate inputs
  -----------------------------------------------------------------------
  gen_inputs_proc2 : process(clk) begin
    if rising_edge(clk) then
        psp_reg <= psp_reg(13 downto 0) & (psp_reg(14) xor psp_reg(13));
        we      <= psp_reg(7);
        address <= psp_reg(1 downto 0);
        din     <= psp_reg(2 downto 0);
    end if;
  end process gen_inputs_proc2;
  -----------------------------------------------------------------------
  -- Check outputs
  -----------------------------------------------------------------------
  ch0 : crc8_ccitt_calc 
    port map (clk,start,dout(0),crc_y0);
  ch1 : crc8_ccitt_calc 
    port map (clk,start,dout(1),crc_y1);
  ch2 : crc8_ccitt_calc 
    port map (clk,start,dout(2),crc_y2);
   -----------------------------------------------------------------------
   -- Report results of checking
   -----------------------------------------------------------------------
   res <= crc_y0 & crc_y1 & crc_y2 & X"FF";
   process begin
        wait for (SIMULATION_TIME-CLOCK_PERIOD);
        report "============================== The Result Check Number is: " & integer'image(to_integer(unsigned(res)));
        wait for CLOCK_PERIOD;
        report "============================== Simulation and checking finished successfull! Please, save the Result Check Number" severity failure;
        wait;
   end process;
end a;