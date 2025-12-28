library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_bench is
--  Port ( );
end test_bench;

architecture Behavioral of test_bench is
    constant CLOCK_PERIOD    : time := 10 ns;
    constant SIMULATION_TIME : time := 10000 ns;
    
    signal clk      : std_logic := '0';
    signal start    : std_logic := '0';
    signal din      : std_logic_vector(4 downto 0) := (others => '0');
    signal dout     : std_logic_vector(6 downto 0) := (others => '0');
    signal an       : std_logic_vector(3 downto 0) := (others => '0');
    signal psp_reg  : std_logic_vector(14 downto 0) := "101010001110110";
    
    signal crc_y0 : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y1 : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y2 : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y3 : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y4 : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y5 : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y6 : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y7 : std_logic_vector(7 downto 0) := (others => '0');
    
    signal res : std_logic_vector(31 downto 0) := (others => '0');

    component lab25 is
        Port ( din  : in STD_LOGIC_VECTOR (4 downto 0);
               dout : out STD_LOGIC_VECTOR (6 downto 0);
               an   : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
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
    start <= '1';
    wait for CLOCK_PERIOD;
    start <= '0';
    wait;
  end process start_gen;
  ---------------------------------------------------------------------
  -- Instantiate the DUT
  ---------------------------------------------------------------------
  dut : lab25
    port map (
        -- Inputs
        din => din,
        -- Outputs
        dout  => dout,
        an    => an);

  -----------------------------------------------------------------------
  -- Generate inputs
  -----------------------------------------------------------------------
  gen_inputs_proc : process(clk) begin
    if rising_edge(clk) then
        psp_reg <= psp_reg + 1;
        din(0) <= psp_reg(0);
        din(1) <= psp_reg(1);
        din(2) <= psp_reg(2);
        din(3) <= psp_reg(3);
        din(4) <= psp_reg(4);
    end if;
  end process gen_inputs_proc;
  
  -----------------------------------------------------------------------
  -- Check outputs
  -----------------------------------------------------------------------
  ch0 : crc8_ccitt_calc 
    port map (clk,start,dout(0),crc_y0);
  ch1 : crc8_ccitt_calc 
    port map (clk,start,dout(1),crc_y1);
  ch2 : crc8_ccitt_calc 
    port map (clk,start,dout(2),crc_y2);
  ch3 : crc8_ccitt_calc 
    port map (clk,start,dout(3),crc_y3);
  ch4 : crc8_ccitt_calc 
    port map (clk,start,dout(4),crc_y4);
  ch5 : crc8_ccitt_calc 
    port map (clk,start,dout(5),crc_y5);
  ch6 : crc8_ccitt_calc 
    port map (clk,start,dout(6),crc_y6);
    
  ch7 : crc8_ccitt_calc 
      port map (clk,start,an(0),crc_y7);
   -----------------------------------------------------------------------
   -- Report results of checking
   -----------------------------------------------------------------------
   res <= (crc_y0 & crc_y1 & crc_y2 & crc_y3) xor (crc_y4 & crc_y5 & crc_y6 & crc_y7);
   process begin
        wait for (SIMULATION_TIME-CLOCK_PERIOD);
        report "============================== The Result Check Number is: " & integer'image(to_integer(unsigned(res)));
        wait for CLOCK_PERIOD;
        report "============================== Simulation and checking finished successfull! Please, save the Result Check Number" severity failure;
        wait;
   end process;
end Behavioral;