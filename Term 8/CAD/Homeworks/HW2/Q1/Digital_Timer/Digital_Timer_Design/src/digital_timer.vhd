-------------------------------------------------------------------------------
--
-- Title       : digital_timer
-- Design      : Digital_Timer_Design
-- Author      : Saleh
-- Company     : s
--
-------------------------------------------------------------------------------
--
-- File        : D:\IUST Legacy\IUST-Legacy\Term 8\CAD\Homeworks\HW2\Q1\Digital_Timer\Digital_Timer_Design\src\digital_timer.vhd
-- Generated   : Wed Apr 30 15:24:09 2025
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
    Port (
        clk      : in  STD_LOGIC;                     -- 1 MHz clock input
        reset    : in  STD_LOGIC;                     -- Reset signal
        alarm_in : in  STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit alarm value
        seconds  : out STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit seconds counter
        alarming : out STD_LOGIC                      -- Alarm output
    );
end digital_timer;

architecture Behavioral of digital_timer is
    signal counter      : unsigned(19 downto 0) := (others => '0');  -- Counts to 1,000,000 for 1 second
    signal sec_counter  : unsigned(7 downto 0) := (others => '0');   -- Seconds counter
    signal alarm_flag   : STD_LOGIC := '0';                          -- Indicates alarm reached
    signal blink_counter: unsigned(23 downto 0) := (others => '0');  -- For blinking LED
    signal blink        : STD_LOGIC := '0';                          -- Blinking signal
    constant MAX_COUNT  : integer := 1000000;                        -- 1,000,000 counts = 1 second
begin
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset all counters and flags
            counter <= (others => '0');
            sec_counter <= (others => '0');
            alarm_flag <= '0';
            blink_counter <= (others => '0');
            blink <= '0';
        elsif rising_edge(clk) then
            if alarm_flag = '0' then
                -- Normal counting operation
                if counter = MAX_COUNT - 1 then
                    counter <= (others => '0');
                    sec_counter <= sec_counter + 1;
                    
                    -- Check if we reached alarm value
                    if sec_counter + 1 = unsigned(alarm_in) then
                        alarm_flag <= '1';
                    end if;
                else
                    counter <= counter + 1;
                end if;
            else
                -- Alarm reached - blink the alarming signal
                blink_counter <= blink_counter + 1;
                if blink_counter = 500000 then  -- Blink at ~1Hz (0.5s on, 0.5s off)
                    blink <= not blink;
                    blink_counter <= (others => '0');
                end if;
            end if;
        end if;
    end process;

    -- Output assignments
    seconds <= STD_LOGIC_VECTOR(sec_counter) when alarm_flag = '0' else alarm_in;
    alarming <= blink when alarm_flag = '1' else '0';
end Behavioral;