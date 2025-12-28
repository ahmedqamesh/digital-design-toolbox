----------------------------------------------------------------------------------
-- Company: Super Engineer
-- Engineer: Yujiang Wu
-- 
-- Create Date: 02/05/2023 06:12:44 PM
-- Design Name: 
-- Module Name: filter_module_testbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:  
-- 1. This test bench should instantiate two filter modules, one for filtering the real part of the data of WIFI.
-- One for filtering the imaginary part of the data of the WIFI.
-- 2. This test bench should instantiate two file readers. One for reading the real part of the data of WIFI. One for reading
-- the imaginary part of the data of the WIFI
-- 3. This test bench should instantiate two file writers. One for writing the real part (filtered) data into a file.
-- One for writing the imaginary part (filtered) data into a file. 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity tb_filter_module is
--  Port ( );
end tb_filter_module;

architecture Behavioral of tb_filter_module is
    constant CLOCK_PERIOD    : time := 10 ns;
    constant SIMULATION_TIME : time := 191*CLOCK_PERIOD;
    signal clk      : std_logic := '0';
    signal en_11Mhz: STD_LOGIC:='0';
    signal cntr_4bit : STD_LOGIC_VECTOR (6 downto 0):=(others => '0');
    signal srst: std_logic := '1';
    signal period: integer:=(9-1);--clock cycles: -- for implementation
    constant NUMOFBITS : integer := 16;
    signal real_data_in      : std_logic_vector((NUMOFBITS-1) downto 0):= (others => '0');
    signal real_datavalid : std_logic :='0';
    
    signal filter_real_doutvalid : std_logic :='0';
    signal filter_real_dout : std_logic_vector(31 downto 0):=(others => '0');
    
    signal img_data_in      : std_logic_vector((NUMOFBITS-1) downto 0):= (others => '0');
    signal img_datavalid : std_logic :='0';
    
    signal filter_img_doutvalid : std_logic :='0';
    signal filter_img_dout : std_logic_vector(31 downto 0):=(others => '0');
    
    component ReadFile is
    generic(
        numOfBits  : integer :=NUMOFBITS;
        file_name : string := ""
        );

    Port ( data : out std_logic_vector ((numOfBits-1) downto 0);
            dv: out std_logic;
            rst : in std_logic;
            rfd : in std_logic;
            clk : in std_logic);
    end component ReadFile;
    
    component filter_module is
        Port (
          clk:in STD_LOGIC;
          dinvalid : in STD_LOGIC;-- assuming this is a one clock duration pulse that comes every 1/11Mhz period indicating that input data is valid
          din : in STD_LOGIC_VECTOR (15 downto 0);--(1,16,0)
          initsum: in STD_LOGIC_VECTOR (31 downto 0);--(1,32,0): initial condition
          doutvalid: out std_logic;-- output data valid indicator
          dout: out STD_LOGIC_VECTOR (31 downto 0)--filtered output
        );
     end component filter_module;
     
    component WriteFile is
        generic(
            numOfBits  : integer :=NUMOFBITS ;
            file_name : string := ""
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
  -----------------------------------------------------------------------
  -- Generate srst
  -----------------------------------------------------------------------
  srst_gen : process
  begin
    srst <= '0';
    wait;
  end process srst_gen;
  -----------------------------------------------------------
  ---- Generate dinvalid
  -----------------------------------------------------------
  ---------------------------------------------------------------------
  -- Pulse generator for generate a pulsed enable signal 'en'
  ---------------------------------------------------------------------   
  ---------------------------------------------------------------------
  -- 4 bit synchronous binary counter with reset for periodic control
  ---------------------------------------------------------------------    
    process (clk)
    begin
       if rising_edge(clk) then
          if srst = '1' then
             cntr_4bit<=(others => '0');
             en_11Mhz<='0';
          else
            if cntr_4bit=STD_LOGIC_VECTOR(to_unsigned(period,cntr_4bit'length)) then
                cntr_4bit<=(others => '0');
                en_11Mhz<='1';
            else
                cntr_4bit<=std_logic_vector(unsigned(cntr_4bit)+1);
                en_11Mhz<='0';
            end if;
          end if;
       end if;
    end process;

  -----------------------------------------------------------------------
  -- filereader1 instantiation: for real part of the data
  -----------------------------------------------------------------------
  filereader1 : ReadFile
  generic map(  
   numOfBits =>16,
   file_name =>"D:\PG_tclAuto_MatchFilter\matlabfiles\data2fpga_real_final.dat")
  port map(
  data=>real_data_in,
  dv=>real_datavalid,
  rst=>srst,
  rfd=>en_11Mhz,
  clk=>clk
  );
    -----------------------------------------------------------------------
  -- real_filter instantiation: for real part of the data
  -----------------------------------------------------------------------
      matchfilter_real: filter_module
        Port map (
          clk=>clk,
          dinvalid=>real_datavalid,-- assuming this is a one clock duration pulse that comes every 1/11Mhz period indicating that input data is valid
          din=>real_data_in,--(1,16,0)
          initsum=>std_logic_vector(to_signed(0,32)),--(1,32,0): initial condition
          doutvalid=>filter_real_doutvalid,-- output data valid indicator
          dout=>filter_real_dout
        );
        
  -----------------------------------------------------------------------
  -- filewriter instantiation
  -----------------------------------------------------------------------
  filewriter1 : WriteFile
  generic map(  
   numOfBits =>32,
   file_name => "D:\PG_tclAuto_MatchFilter\matlabfiles\datafromfpga_real_final.dat")
  port map(
  clk=>clk,-- connect with 100MHz clock
  dv=>filter_real_doutvalid,
  sign=>'1',
  DataIn=>filter_real_dout
  );
  
 -----------------------------------------------------------------------
  -- filereader2 instantiation: for img part of the data
  -----------------------------------------------------------------------
  filereader2 : ReadFile
  generic map(  
   numOfBits =>16,
   file_name => "D:\PG_tclAuto_MatchFilter\matlabfiles\data2fpga_img_final.dat")
  port map(
  data=>img_data_in,
  dv=>img_datavalid,
  rst=>srst,
  rfd=>en_11Mhz,
  clk=>clk
  );
  -----------------------------------------------------------------------
  -- imag_filter instantiation: for img part of the data
  -----------------------------------------------------------------------
      matchfilter_img: filter_module
        Port map (
          clk=>clk,
          dinvalid=>img_datavalid,-- assuming this is a one clock duration pulse that comes every 1/11Mhz period indicating that input data is valid
          din=>img_data_in,--(1,16,0)
          initsum=>std_logic_vector(to_signed(0,32)),--(1,32,0): initial condition
          doutvalid=>filter_img_doutvalid,-- output data valid indicator
          dout=>filter_img_dout
        );
        
   -----------------------------------------------------------------------
  -- filewriter instantiation
  -----------------------------------------------------------------------
  filewriter2 : WriteFile
  generic map(  
   numOfBits =>32,
   file_name => "D:\PG_tclAuto_MatchFilter\matlabfiles\datafromfpga_img_final.dat")
  port map(
  clk=>clk,-- connect with 100MHz clock
  dv=>filter_img_doutvalid,
  sign=>'1',
  DataIn=>filter_img_dout
  );
   -----------------------------------------------------------------------
  -- Terminate Simulation
  -----------------------------------------------------------------------
--  term_sim: process
--  begin
--    wait for SIMULATION_TIME;
--    assert false report "Test: OK" severity failure;
--  end process term_sim;
end Behavioral;
