library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
-- ===========================================================================
--  File: lab55.vhd
--  Author: Ahmed Qamesh
--  Date: 28/12/2025
-- ===========================================================================
--  Description: Convolutional encoder for (171,133) code and testbench for it. Perform simulations.
--  The device has reset and clocking inputs and 2-bit width output for encoded bits.
--  The 2 bits are generated at the coder output for each one input bit. 
-- ===========================================================================
entity lab55 is
    Port ( clk  : in STD_LOGIC;
           srst : in STD_LOGIC;
           coded : out STD_LOGIC_VECTOR (1 downto 0)); -- [MSB, LSB]
end lab55;

architecture Behavioral of lab55 is
    signal info_bit  : std_logic;
    signal coder_reg : std_logic_vector(5 downto 0); -- 7-bit shift register

    -- Component declaration for PRSG (from previous task)
    component lab54 is
        Port ( clk     : in STD_LOGIC;
               srst    : in STD_LOGIC;
               psp_bit : out STD_LOGIC);
    end component lab54;
    
begin
  ---------------------------------------------------------------------
  -- Instantiate the DUT
  ---------------------------------------------------------------------
  dut_lab54 : lab54
    port map (
        -- Inputs
        clk => clk,
        srst => srst,
        -- Outputs
        psp_bit  => info_bit);

process (clk ) begin  
	if rising_edge(clk) then
        if srst='1' then
         coder_reg <=  (others => '0');  -- Initialize shift register to zero
        else
        -- Shift in new bit from PRSG
        coder_reg <= info_bit & coder_reg(5 downto 1);
 
        end if;
	end if;
end process;
-- Compute XORs for each branch (generator polynomials)
-- 171 branch (LSB): use bits 6, 5,4,3,0
coded(0) <=  info_bit xor coder_reg(5) xor coder_reg(4) xor coder_reg(3) xor coder_reg(0); --171 1111001
 -- 133 branch (MSB): use bits 4,3,1,0
coded(1) <=  info_bit xor coder_reg(4) xor coder_reg(3) xor coder_reg(1) xor coder_reg(0);-- 133 1011011 

end Behavioral;
