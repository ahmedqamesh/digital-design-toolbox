library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.all;

entity lab82 is
    Port ( clk  : in STD_LOGIC;
           srst : in STD_LOGIC;
           x1   : in STD_LOGIC_VECTOR (2 downto 0);
           x2   : in STD_LOGIC_VECTOR (2 downto 0);
           btn  : in STD_LOGIC;
           y    : out STD_LOGIC_VECTOR (7 downto 0));

end lab82;

architecture Behavioral of lab82 is

    TYPE STATE_TYPE IS (s0,s1,s2,s3);
    -- Declare current and next state signals
    SIGNAL current_state : STATE_TYPE ;
    SIGNAL next_state : STATE_TYPE;

    -- Declare any pre-registered internal signals
    SIGNAL y_cld : std_logic_vector(7 downto 0);
    signal y_del : std_logic_vector(7 downto 0);

    signal sum   : std_logic_vector (7 downto 0);
    signal mult  : std_logic_vector (7 downto 0);
    signal gcntr : std_logic_vector (7 downto 0);
    signal led   : std_logic_vector (7 downto 0);

    signal ibtn  : std_logic;

    component lab62 is
        Port ( clk  : in STD_LOGIC;
               srst : in std_logic;
               dout : out std_logic_vector (7 downto 0));
    end component lab62;

    component gray_cntr is
        Port ( clk   : in STD_LOGIC;
               srst  : in STD_LOGIC;
               gcntr : out STD_LOGIC_VECTOR (7 downto 0));
    end component gray_cntr;

begin

    ibtn <= btn; -- For simulation



    --Process for performing addition
    sum_proc : process(x1, x2) begin
        sum <= unsigned("00000" & x1) + unsigned ("00000" & x2);
    end process;

    --Multiplication Process
    mult_proc : process(x1,x2)
    begin
        mult<=('0'& unsigned(x1)) * ('0'& unsigned(x2));
    end process;

    --Using Lab6_2 as the Led blinker
    blinker : lab62
    Port map(clk=>clk,
             srst => srst,
             dout=> led);

    gray_counter : gray_cntr
    Port map (
                clk => clk,
                srst => srst,
                gcntr => gcntr
             );
    --------------------------------------------------------------------------------------------------------------------------------------------
    --Clocked process for selecting which function is going to be used
    clock_process : process(clk) begin
        if rising_edge(clk) then
             if srst = '1' then
                y_cld <= led;
                current_state <= s0;
            else
               case current_state is
                    when s0 =>
                        if ibtn = '0' then
                            y_cld <= led;
                        else
                            current_state <= next_state;
                        end if;
                    when s1 =>
                        if ibtn = '0' then
                            y_cld <= sum;
                        else
                            current_state <= next_state;
                        end if;
                    when s2 =>
                        if ibtn = '0' then
                            y_cld <= mult;
                        else
                            current_state <= next_state;
                        end if;
                    when s3 =>
                        if ibtn = '0' then
                            y_cld <= gcntr;
                        else
                            current_state <= next_state;
                        end if;
                    when others =>
                        NULL;
               end case;
            end if;
        end if;

    end process;


    --------------------------------------------------------------------------------------------------------------------------------------------
    nextstate_proc : PROCESS (current_state, ibtn) BEGIN
      CASE current_state IS
         WHEN s0 =>
               next_state <= s1;
         WHEN s1 =>
               next_state <= s2;
         WHEN s2 =>
               next_state <= s3;
         WHEN s3 =>
               next_state <= s0;
         WHEN others =>
            next_state <= s0;
      END CASE;
   END PROCESS nextstate_proc;

 y <= y_cld;

end Behavioral;