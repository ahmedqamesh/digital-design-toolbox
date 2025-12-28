----------------------------------------------------------------------------------
-- Company: Super Engineer
-- Engineer: Yujiang Wu
-- 
-- Create Date: 02/04/2023 12:51:45 PM
-- Design Name: 
-- Module Name: filter_cell - Behavioral
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

entity filter_cell is
    Port ( clk : in STD_LOGIC;
           dinvalid : in STD_LOGIC;-- assuming this is a one clock duration pulse that comes every 1/11Mhz period
           din : in STD_LOGIC_VECTOR (15 downto 0);--(1,16,0)
           coefficient : in STD_LOGIC_VECTOR (7 downto 0);--(1,8,0)
           partial_sum : in STD_LOGIC_VECTOR (31 downto 0);--(1,32,0)
           doutvalid : out STD_LOGIC;-- latency is between doutvalid and dinvalid
           dout : out STD_LOGIC_VECTOR (31 downto 0));--(1,32,10)
end filter_cell;

architecture Behavioral of filter_cell is
    signal din_q  : std_logic_vector(15 downto 0);
    signal coefficient_q  : std_logic_vector(7 downto 0);
    signal partial_sum_q : std_logic_vector(31 downto 0);
    signal stage1_ready_q: std_logic:='0';
    signal product_d : std_logic_vector(23 downto 0);
    signal product_q : std_logic_vector(23 downto 0) := (others=>'0');
    signal stage2_ready_d: std_logic:='0';
    signal stage2_ready_q: std_logic:='0';
    signal sum_d :std_logic_vector(31 downto 0);
    signal sum_q :std_logic_vector(31 downto 0);
    signal stage3_ready_d: std_logic:='0';
    signal stage3_ready_q: std_logic:='0';
    --signal output_ready_d: std_logic:='0';
    --signal output_ready_q: std_logic:='0';
begin
    --stage1 register inputs
    
    --stage2 Multiply
    stage2_ready_d<=stage1_ready_q;   
    process(stage2_ready_q)
    begin
        product_d<=std_logic_vector(signed(din_q)*signed(coefficient_q));
    end process;
    --stage3 Sum
    stage3_ready_d<=stage2_ready_q;
    process(stage3_ready_q,partial_sum,product_q)
    begin
        --sum_d<=std_logic_vector(resize(signed(product_q),sum_d'length)+signed(partial_sum_q));
        sum_d<=std_logic_vector(resize(signed(product_q),sum_d'length)+signed(partial_sum));
    end process;
    doutvalid<=stage3_ready_q;
    dout<=sum_d;
    --Final: Assign Output
    --output_ready_d<=stage3_ready_q;
    --dout<=sum_q;
    --doutvalid<=output_ready_q;
    process(clk) begin
        if rising_edge(clk) then
            if (dinvalid='1') then
                din_q<=din;
                coefficient_q<=coefficient;
                --partial_sum_q<=partial_sum;
            end if;
            stage1_ready_q<=dinvalid;
            stage2_ready_q<=stage2_ready_d;
            product_q<=product_d;
            stage3_ready_q<=stage3_ready_d;
            --sum_q<=sum_d;
            --output_ready_q<=output_ready_d;
        end if;
    end process;
end Behavioral;
