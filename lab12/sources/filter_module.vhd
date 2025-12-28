----------------------------------------------------------------------------------
-- Company: Super Engineer
-- Engineer: Yujiang Wu
-- 
-- Create Date: 02/05/2023 03:35:21 PM
-- Design Name: 
-- Module Name: filter_module - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
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

entity filter_module is
    Port (clk:in STD_LOGIC;
          dinvalid : in STD_LOGIC;-- assuming this is a one clock duration pulse that comes every 1/11Mhz period indicating that input data is valid
          din : in STD_LOGIC_VECTOR (15 downto 0);--(1,16,0)
          initsum: in STD_LOGIC_VECTOR (31 downto 0);--(1,32,0): initial condition
          doutvalid: out std_logic;-- output data valid indicator
          dout: out STD_LOGIC_VECTOR (31 downto 0)--filtered output
     );
end filter_module;

architecture Behavioral of filter_module is
    constant tapLineLength : integer:=11;
    type tMY_ROM    is array (0 to tapLineLength-1)     of std_logic_vector(7 downto 0);
    signal my_rom : tMY_ROM :=(X"01",
    X"01",
    X"01",
    X"FF",
    X"FF",
    X"FF",
    X"01",
    X"FF",
    X"FF",
    X"01",
    X"FF");
   -- type delayline_11e_16b    is array (0 to tapLineLength-1)     of std_logic_vector(15 downto 0);
   type delayline_11e_16b    is array (tapLineLength-1 downto 0)     of std_logic_vector(15 downto 0);
    signal dinline :delayline_11e_16b:=(others => (others => '0'));
    signal dinvalid_q: std_logic:='0';
    type delayline_12e_32b    is array (0 to tapLineLength)     of std_logic_vector(31 downto 0);
    signal part_sum :delayline_12e_32b:=(others => (others => '0'));
    
    type delayline_12e_bit    is array (0 to tapLineLength)     of std_logic;
    signal datavalidline: delayline_12e_bit:=(others => '0');-- datain valid line.
    component filter_cell is 
    Port ( clk  : in STD_LOGIC;
           dinvalid : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (15 downto 0);
           coefficient : in STD_LOGIC_VECTOR (7 downto 0);--(1,8,0)
           partial_sum : in STD_LOGIC_VECTOR (31 downto 0);--(1,32,0)
           doutvalid : out STD_LOGIC;-- latency is between doutvalid and dinvalid
           dout : out STD_LOGIC_VECTOR (31 downto 0));--(1,32,10)
    end component filter_cell;
begin
    -- Use Case 1: Replicating logic
    -- instantiate 11 filter tap cells connecting one after another
    OUTERLOOP: for I in 0 to (tapLineLength-1) generate
        INNERLOOP: if (I=0) generate
        part_sum(I)<=initsum;
        datavalidline(I)<=dinvalid_q;
        end generate INNERLOOP;
        
     filtertap: filter_cell  port map (
            clk     => clk,
            dinvalid   => dinvalid_q,--previous tap
            din    => dinline(tapLineLength-1-I),-- this index is flipped from the others because din shift into MSB
            coefficient    => my_rom(tapLineLength-1-I),-- coefficient vector has to be flipped to match sequence in dinline
            partial_sum   => part_sum(I),--previous tap
            doutvalid   => datavalidline(I+1),--next tap, when  I=tapLineLength-1, this stores the final filtered result
            dout   => part_sum(I+1));-- next tap. When I=tapLineLength-1, this stores the final filtered result
    end generate OUTERLOOP;
    process(clk) begin
        if rising_edge(clk) then
            if dinvalid='1' then
                --dinline<=din & dinline(tapLineLength-1 downto 1);-- shift new sample in from MSB
                dinline( tapLineLength-2 downto 0)<=dinline(tapLineLength-1 downto 1);
                dinline(tapLineLength-1)<=din;
            end if;
            dinvalid_q<=dinvalid;
            doutvalid<=datavalidline(tapLineLength);
            dout<=part_sum(tapLineLength);
        end if;
    end process;
end Behavioral;
