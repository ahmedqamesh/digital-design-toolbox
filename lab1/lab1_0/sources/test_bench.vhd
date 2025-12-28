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
    
    signal clk                                        : std_logic := '0';
    signal start                                      : std_logic := '0';
    signal a,b                                        : std_logic := '0';
    signal y_and,y_or,y_xor,y_not,y_nand,y_nor,y_xnor : std_logic := '0';
    signal psp_reg                                    : std_logic_vector(14 downto 0) := "101010001110110";
    
    signal crc_y_and  : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y_or   : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y_xor  : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y_not  : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y_nand : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y_nor  : std_logic_vector(7 downto 0) := (others => '0');
    signal crc_y_xnor : std_logic_vector(7 downto 0) := (others => '0');
    
    signal res : std_logic_vector(31 downto 0) := (others => '0');

    component basic_gates IS
     PORT (a, b: IN STD_LOGIC;
           y_and, y_or, y_xor, y_not,
           y_nand, y_nor, y_xnor:
                OUT STD_LOGIC);
    END component basic_gates;
    
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
  dut : basic_gates
    port map (
        -- Inputs
        a => a,
        b => b,
        -- Outputs
        y_and  => y_and, 
        y_or   => y_or, 
        y_xor  => y_xor, 
        y_not  => y_not,
        y_nand => y_nand, 
        y_nor  => y_nor, 
        y_xnor => y_xnor);

  -----------------------------------------------------------------------
  -- Generate inputs
  -----------------------------------------------------------------------
  gen_inputs_proc : process(clk) begin
    if rising_edge(clk) then
        psp_reg <= psp_reg(13 downto 0) & (psp_reg(14) xor psp_reg(13));
        a <= psp_reg(0);
        b <= psp_reg(1);
    end if;
  end process gen_inputs_proc;
  
  -----------------------------------------------------------------------
  -- Check outputs
  -----------------------------------------------------------------------
  ch0 : crc8_ccitt_calc 
    port map (clk,start,y_and, crc_y_and );
  ch1 : crc8_ccitt_calc 
    port map (clk,start,y_or,  crc_y_or  );
  ch2 : crc8_ccitt_calc 
    port map (clk,start,y_xor, crc_y_xor );
  ch3 : crc8_ccitt_calc 
    port map (clk,start,y_not, crc_y_not );
  ch4 : crc8_ccitt_calc 
    port map (clk,start,y_nand,crc_y_nand);
  ch5 : crc8_ccitt_calc 
    port map (clk,start,y_nor, crc_y_nor );
  ch6 : crc8_ccitt_calc 
    port map (clk,start,y_xnor,crc_y_xnor);

   -----------------------------------------------------------------------
   -- Report results of checking
   -----------------------------------------------------------------------
   res <= (crc_y_and & crc_y_or & crc_y_xor & crc_y_not) xor ("00000000" & crc_y_nand & crc_y_nor & crc_y_xnor);
   process begin
        wait for (SIMULATION_TIME-CLOCK_PERIOD);
        report "============================== The Result Check Number is: " & integer'image(to_integer(unsigned(res)));
        wait for CLOCK_PERIOD;
        report "============================== Simulation and checking finished successfull! Please, save the Result Check Number" severity failure;
        wait;
   end process;
end Behavioral;