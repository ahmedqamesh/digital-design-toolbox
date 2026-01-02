library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- ===========================================================================
--  File: lab81.vhd
--  Author: Ahmed Qamesh
--  Date: 31/12/2025
-- ===========================================================================
--  Description: Convolutional encoder of (7,5) code and testbench for it.
-- A (7,5) convolutional encoder typically refers to a rate 1/2  (one input bit, two output bits).
-- This is a Mealy FSM:
-- -- Output depends on current state + input
-- -- State changes every clock
-- ===========================================================================


entity lab81 is
    Port ( clk  : in STD_LOGIC;
           srst : in STD_LOGIC;
           info : in STD_LOGIC;
           coded : out STD_LOGIC_VECTOR (1 downto 0));
end lab81;

architecture Behavioral of lab81 is
-- The state of the encoder is defined by the contents of its memory elements.
-- Constraint Length (K): 3 bits (Current input + 2 memory elements).
-- Number of States: 2^{K-1} =2^{2}=4 states.
type state_type is (S0, S1, S2, S3);
signal state, next_state : state_type;
 signal coded_next : std_logic_vector(1 downto 0);

begin 
    ------------------------------------------------------------------
    -- 1. State register (sequential process)
    ------------------------------------------------------------------
seq_proc:process(clk)
    begin
        if rising_edge(clk) then
            if srst = '1' then
                state <= S0;  -- FSM initialization 
                coded <= "00";
            else
                state <= next_state;
                coded <= coded_next;
            end if;
        end if;
    end process;

    ------------------------------------------------------------------
    -- 2. Next-state and output logic (combinational process)
    ------------------------------------------------------------------    
 -- State control
-- This is a Mealy FSM:
-- -- Output depends on current state + input (info)
-- -- State changes every clock
GET_NEXT_STATE: process (state, info) 
variable m1, m2 : STD_LOGIC;
begin
    -- The initial output value is all zeros.  
    coded_next <= "00"; 
    next_state <= state;  -- Default: do not change current state
   -- Define current state logic
   -- decode current state into memory bits
   case (state) is	
        when S0 =>
 
            m2 := '0'; 
            m1 := '0';
        when S1 => 
            m2 := '0'; 
            m1 := '1';
        when S2 => 
            m2 := '1'; 
            m1 := '0';
        when S3 => 
            m2 := '1'; 
            m1 := '1';
    end case;    
 
    -- convolutional outputs
    -- The (7, 5) code uses two generator polynomials in octal:
    --  (G_{1}=7_{oct} (Binary 111): \(g_{1}(D)=1\cdot D^{0}+1\cdot D^{1}+1\cdot D^{2}=1+D+D^{2}\)
    -- (G_{2}=5_{oct} (Binary 101): \(g_{2}(D)=1\cdot D^{0}+0\cdot D^{1}+1\cdot D^{2}=1+D^{2}\) 
    -- The binary sequences represent the coefficients of the generator polynomials in the transform domain (D)
    -- D^{0}: The current input bit, info
    -- D^{1}: The bit that entered one clock cycle ago, m1
    -- D^{2}: The bit that entered two clock cycles ago m2
    -- The XOR for brunch 7 forward to output MSB, the XOR result for brunch 5 - to output LSB.
        -- output equations (7,5)
        coded_next(1) <= info xor m1 xor m2;
        coded_next(0) <= info xor m2;
           
   -- Define next state logic
    case state is
        when S0 => if info='1' then next_state<=S1; end if;
        when S1 => if info='1' then next_state<=S3; else next_state<=S2; end if;
        when S2 => if info='1' then next_state<=S1; end if;
        when S3 => if info='0' then next_state<=S2; end if;
    end case;


   end process;  
end Behavioral;

