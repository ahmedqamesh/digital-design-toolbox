library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sim_top_led is
end sim_top;

architecture rtl of sim_top_led is

signal clk : std_logic := '1';
signal led : std_logic := '0';
signal led_o_left    : std_logic_vector(7 downto 0);
signal led_o_right   : std_logic_vector(7 downto 0);
begin
blink_counter : entity work.blink_counter
    port map (
    clk => clk,
    led => led
    );
    
    
shift_led_left_0: entity work.shift_led_left
     port map (
      clk => clk,
      enable_shift => led,
      led_o(7 downto 0) => led_o_left(7 downto 0)
    );

shift_led_right_0: entity work.shift_led_right
     port map (
      clk => clk,
      enable_shift => led,
      led_o(7 downto 0) => led_o_right(7 downto 0)
    );
        
clk <= not clk after 1 ns;

end rtl;


