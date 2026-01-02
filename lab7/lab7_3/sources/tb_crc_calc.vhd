LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY crc8_ccitt_calc IS
  port(
    clk     : in std_logic;
    start   : in std_logic;
    bit_in  : in std_logic;
    crc_out : out std_logic_vector(7 downto 0));
END ENTITY crc8_ccitt_calc;

--
ARCHITECTURE a OF crc8_ccitt_calc IS
  signal crc_reg : std_logic_vector(0 to 7);
BEGIN
  crc8_ccitt :  process(clk)
    variable bit0,bit1,bit2 : std_logic;
  begin
    if rising_edge(clk) then-- Регистр расчета контрольной суммы
      if start='1' then
        crc_reg <= "00000000";
      else
        bit0 := bit_in xor crc_reg(7);
        bit1 := bit0   xor crc_reg(0);
        bit2 := bit0   xor crc_reg(1);
        crc_reg <= bit0 & bit1 & bit2 & crc_reg(2 to 6);
      end if;
    end if;
  end process;
  
  crc_out <= crc_reg;
END ARCHITECTURE a;