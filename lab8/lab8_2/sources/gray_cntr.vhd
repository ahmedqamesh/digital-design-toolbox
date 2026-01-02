 library ieee;
 use ieee.std_logic_1164.all;
 --use ieee.std_logic_unsigned.all;
 USE ieee.std_logic_arith.all;

 entity gray_cntr is
	 port (
          gcntr   :out std_logic_vector (7 downto 0); -- Output of the counter
          clk    :in  std_logic;                     -- Input clock
          srst  :in  std_logic                      -- Input reset
 	     );
 end entity;

 architecture rtl of gray_cntr is
    signal count :std_logic_vector (7 downto 0);
 begin
     process (clk) begin
      if (rising_edge(clk)) then
         if (srst = '1') then
             count <= (others=>'0');
         else
                 count <= UNSIGNED (count) + 1;
         end if;
      end if;
     end process;
     gcntr <= (count(7) &
             (count(7) xor count(6)) &
             (count(6) xor count(5)) &
             (count(5) xor count(4)) &
             (count(4) xor count(3)) &
             (count(3) xor count(2)) &
             (count(2) xor count(1)) &
             (count(1) xor count(0)) );
             
end architecture;