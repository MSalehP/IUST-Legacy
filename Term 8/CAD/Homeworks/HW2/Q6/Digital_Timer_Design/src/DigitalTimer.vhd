-------------------------------------------------------------------------------
--
-- Title       : DigitalTimer
-- Design      : Digital_Timer_Design
-- Author      : Saleh
-- Company     : s
--
-------------------------------------------------------------------------------
--
-- File        : d:\Softwares\Active HDL\Digital_Timer\Digital_Timer_Design\src\DigitalTimer.vhd
-- Generated   : Fri May  2 17:33:10 2025
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity digital_timer is
    Generic (
        FREQUENCY : integer := 100000000 -- Default frequency 100 MHz
    );
    Port (
        clk     : in  STD_LOGIC;   -- Clock input
        rst     : in  STD_LOGIC;   -- Reset signal (active high)
        run     : in  STD_LOGIC;   -- Run control signal (1=count, 0=stop)
        digit1  : out STD_LOGIC_VECTOR(6 downto 0); -- Seconds (units digit)
        digit2  : out STD_LOGIC_VECTOR(6 downto 0); -- Seconds (tens digit)
        digit3  : out STD_LOGIC_VECTOR(6 downto 0)  -- Minutes
    );
end digital_timer;

architecture Behavioral of digital_timer is
    signal counter      : integer range 0 to FREQUENCY-1 := 0; -- Clock divider counter
    signal second_pulse : STD_LOGIC := '0';                   -- 1Hz pulse signal
    signal seconds      : integer range 0 to 59 := 0;         -- Seconds counter
    signal minutes      : integer range 0 to 9 := 0;         -- Minutes counter
    
    -- Function to convert integer to 7-segment display pattern
    function int_to_7seg(num : integer) return STD_LOGIC_VECTOR is
    begin
        case num is
            when 0 => return "1000000"; -- 0
            when 1 => return "1111001"; -- 1
            when 2 => return "0100100"; -- 2
            when 3 => return "0110000"; -- 3
            when 4 => return "0011001"; -- 4
            when 5 => return "0010010"; -- 5
            when 6 => return "0000010"; -- 6
            when 7 => return "1111000"; -- 7
            when 8 => return "0000000"; -- 8
            when 9 => return "0010000"; -- 9
            when others => return "1111111"; -- Blank display
        end case;
    end function;
    
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                -- Reset all counters
                counter <= 0;
                seconds <= 0;
                minutes <= 0;
                second_pulse <= '0';
            else
                -- Generate 1Hz pulse from main clock
                if counter = FREQUENCY-1 then
                    counter <= 0;
                    second_pulse <= '1';
                else
                    counter <= counter + 1;
                    second_pulse <= '0';
                end if;
                
                -- Time counting when run is active
                if run = '1' and second_pulse = '1' then
                    if seconds = 59 then
                        seconds <= 0;
                        if minutes = 9 then
                            minutes <= 0;
                        else
                            minutes <= minutes + 1;
                        end if;
                    else
                        seconds <= seconds + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    -- Convert values to 7-segment display patterns
    digit1 <= int_to_7seg(seconds mod 10);       -- Seconds units digit
    digit2 <= int_to_7seg(seconds / 10);        -- Seconds tens digit
    digit3 <= int_to_7seg(minutes);              -- Minutes digit
end Behavioral;