library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity blink_counter is
    Port ( 
        clk : in STD_LOGIC;
        led : out STD_LOGIC);
end blink_counter;

architecture rtl of blink_counter is

    ----------------------------------------------------------------
    --  Constants
    ----------------------------------------------------------------
    constant MAX_CNT   : natural := 20_000_000;   -- counter wrap-around
    ----------------------------------------------------------------
    --  Signals
    ----------------------------------------------------------------
    -- 24 bits are enough to count 
    signal counter : unsigned(24 downto 0) := (others => '0');
    --  One-cycle pulse
    signal led_pulse_r :  std_logic:= '0';   
        
    type state is (LED_ON, LED_OFF);
    signal s : state := LED_OFF; 
    
begin

    blink_counter : process(clk) 
    begin
    if rising_edge(clk) then
        case s is 
            when LED_ON => 
                led_pulse_r <= '1';
            when LED_OFF => 
                led_pulse_r <= '0';
        end case; 
         
        if (counter >= MAX_CNT)then 
            if (s = LED_ON) then 
               s <= LED_OFF;
            else 
               s <= LED_ON; 
            end if;
            counter <= to_unsigned(0,25);
        else 
            counter <= counter + 1; 
        end if;
    end if;
    end process;
    ----------------------------------------------------------------
    --  Drive the output port
    ----------------------------------------------------------------    
    led <= led_pulse_r;
end rtl;
