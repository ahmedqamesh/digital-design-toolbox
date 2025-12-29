library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- ===========================================================================
--  File: lab11_0.vhd
--  Author: Ahmed Qamesh
-- ===========================================================================
--  Description:
--  This module introduces some basic gates operations
--
-- ===========================================================================


ENTITY basic_gates IS
     PORT (a, b: IN STD_LOGIC;
           y_and, y_or, y_xor, y_not,
           y_nand, y_nor, y_xnor:
                OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE rtl OF basic_gates IS
BEGIN
     y_and <= a AND b;
     y_or <= a OR b;
     y_xor <= a XOR b;
     y_not <= NOT a;
     y_nand <= a NAND b;
     y_nor <= a NOR b;
     y_xnor <= a XNOR b;
END ARCHITECTURE;
