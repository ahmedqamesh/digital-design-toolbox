
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_lab112 is
--  Port ( );
end tb_lab112;

architecture Behavioral of tb_lab112 is
    constant CLOCK_PERIOD    : time := 10 ns;
    constant SIMULATION_TIME : time := 100012522*CLOCK_PERIOD;
    constant NUMOFBITS : integer := 16;
    signal clk      : std_logic := '0';
    signal noisydata      : std_logic_vector((NUMOFBITS-1) downto 0):= (others => '0');
    signal filtereddata      : std_logic_vector((NUMOFBITS-1) downto 0):= (others => '0');
    signal datavalid : std_logic :='0';
    signal reset : std_logic :='1';
    signal readfiledata : std_logic :='0';
    constant PERIOD: integer:=(12500-1);--clock cycles: -- for cosimulation with matlab
    --constant PERIOD: integer:=(125-1);--clock cycles: -- for behavioral simulation, will get 1000 Hz noisy signal instead of 10Hz signal
    signal cntr : STD_LOGIC_VECTOR (24 downto 0);
    signal en: STD_LOGIC:='0';
    signal srst: STD_LOGIC:='1';
    
    component ReadFile is
    generic(
        numOfBits  : integer :=NUMOFBITS ;
        file_name : string := "/home/aq/git/courses/digital-design-toolbox/lab11/lab11_2/Matlab/data2fpga.dat"
        );

    Port ( data : out std_logic_vector ((numOfBits-1) downto 0);
            dv: out std_logic;
            rst : in std_logic;
            rfd : in std_logic;
            clk : in std_logic);
    end component ReadFile;
    
    component lab111 is 
        Port ( clk : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (15 downto 0);--16 bit
           dout : out STD_LOGIC_VECTOR (15 downto 0));--16 bit
    end component lab111;
    
    component WriteFile is
    generic(
        numOfBits  : integer :=NUMOFBITS ;
        file_name : string := "/home/aq/git/courses/digital-design-toolbox/lab11/lab11_2/Matlab/datafromfpga.dat"
        );
    port ( 
            clk : in std_logic;
            dv: in std_logic;
            sign: in std_logic;
            DataIn : in std_logic_vector ((numOfBits-1) downto 0)
            );
    end component WriteFile;
   
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
    -----------------------------------------------------------
  ---- Generate readfiledata
  -----------------------------------------------------------
     ---------------------------------------------------------------------
  -- 25 bit synchronous binary counter with srst for periodic control
  ---------------------------------------------------------------------    
        period_task1: process (clk)
        begin
           if rising_edge(clk) then
              if srst = '1' then
                 cntr<=(others => '0');
                 en<='0';
              else
                if cntr=STD_LOGIC_VECTOR(to_unsigned(PERIOD,cntr'length)) then
                    cntr<=(others => '0');
                    en<='1';
                else
                    cntr<=std_logic_vector(unsigned(cntr)+1);
                    en<='0';
                end if;
              end if;
           end if;
        end process period_task1;
        readfiledata<=en;
        reset<=srst;
    
      srst_gen: process
      begin
        srst<='1';
        wait for 20*CLOCK_PERIOD;
        srst<='0';
        wait;
      end process srst_gen;
  
  -----------------------------------------------------------------------
  -- filereader1 instantiation
  -----------------------------------------------------------------------
  filereader1 : ReadFile
  generic map(  
   numOfBits =>16)
  port map(
  data=>noisydata,
  dv=>datavalid,
  rst=>reset,
  rfd=>readfiledata,
  clk=>clk
  );
  --------------------------------------------
  -- Moving average filter instantiation
  --------------------------------------------
    lab_111_m: lab111 
    port map ( clk=>datavalid,
           din=>noisydata ,--16 bit
           dout=>filtereddata);--16 bit
           
  -----------------------------------------------------------------------
  -- filewriter instantiation
  -----------------------------------------------------------------------
  filewriter1 : WriteFile
  generic map(  
   numOfBits =>16,
   file_name => "/home/aq/git/courses/digital-design-toolbox/lab11/lab11_2/Matlab/datafromfpga.dat")
  port map(
  clk=>clk,-- connect with 100MHz clock
  dv=>datavalid,
  sign=>'1',
  DataIn=>filtereddata
  );

  -----------------------------------------------------------------------
  -- Terminate Simulation
  -----------------------------------------------------------------------
  term_sim: process
  begin
    wait for SIMULATION_TIME;
    assert false report "Test: OK" severity failure;
  end process term_sim;
end Behavioral;
