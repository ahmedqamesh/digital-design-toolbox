library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ===========================================================================
--  File: lab33.vhd
--  Author: Ahmed Qamesh
-- ===========================================================================
--  Description:
--  This VHDL top-level module implements a 4x4 switch of single-bit signals
--  using previously defined multiplexer (lab31) and demultiplexer (lab32)
--  components. The switch routes one of 4 input ports to one of 4 output 
--  ports depending on two sets of 2-bit address inputs (addr1 for multiplexer
--  selection, addr2 for demultiplexer selection). The connection between the
--  multiplexer output and demultiplexer input is handled using an internal
--  signal.
--
--  Features:
--  - 4 data inputs (buttons)
--  - 4 data outputs (LEDs)
--  - 2 sets of 2-bit address inputs (switches)
--  - Uses process-based multiplexer and demultiplexer components
-- ===========================================================================

entity lab33 is
    Port ( din   : in STD_LOGIC_VECTOR (3 downto 0);  -- 4 data inputs (buttons)
           addr1 : in STD_LOGIC_VECTOR (1 downto 0);  -- 2-bit multiplexer address
           addr2 : in STD_LOGIC_VECTOR (1 downto 0);  -- 2-bit demultiplexer address
           dout  : out STD_LOGIC_VECTOR (3 downto 0));-- 4 data outputs (LEDs)
end lab33;

architecture struct of lab33 is
    signal mux2demux : std_logic;  -- internal connection between mux and demux

    -- Component declarations
    component lab31 is
        Port ( din  : in STD_LOGIC_VECTOR (3 downto 0);
               addr : in STD_LOGIC_VECTOR (1 downto 0);
               dout : out STD_LOGIC);
    end component;

    component lab32 is
        Port ( din  : in STD_LOGIC;
               addr : in STD_LOGIC_VECTOR (1 downto 0);
               dout : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

begin

    -- Instantiate multiplexer (lab31)
    U1_mux: lab31
        Port map(
            din  => din,        -- 4 data inputs from buttons
            addr => addr1,      -- address for selecting input
            dout => mux2demux   -- internal signal connected to demux input
        );

    -- Instantiate demultiplexer (lab32)
    U2_demux: lab32
        Port map(
            din  => mux2demux,  -- input from multiplexer output
            addr => addr2,      -- address for selecting output
            dout => dout        -- 4 LEDs
        );

end struct;

