-------------------------------------------------------------------------------
--
-- Title       : digital_timer_tb
-- Design      : Digital_Timer_Design
-- Author      : Saleh
-- Company     : s
--
-------------------------------------------------------------------------------
--
-- File        : D:\IUST Legacy\IUST-Legacy\Term 8\CAD\Homeworks\HW2\Q1\Digital_Timer\Digital_Timer_Design\src\digital_timer_tb.vhd
-- Generated   : Wed Apr 30 15:26:43 2025
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

entity digital_timer_tb is
end digital_timer_tb;

architecture Behavioral of digital_timer_tb is
    component digital_timer
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            alarm_in : in  STD_LOGIC_VECTOR(7 downto 0);
            seconds  : out STD_LOGIC_VECTOR(7 downto 0);
            alarming : out STD_LOGIC
        );
    end component;

    signal clk      : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    signal alarm_in: STD_LOGIC_VECTOR(7 downto 0) := "00000101"; -- Alarm at 5 seconds
    signal seconds : STD_LOGIC_VECTOR(7 downto 0);
    signal alarming: STD_LOGIC;

    constant clk_period : time := 1 us; -- 1 MHz clock
begin
    uut: digital_timer port map (
        clk => clk,
        reset => reset,
        alarm_in => alarm_in,
        seconds => seconds,
        alarming => alarming
    );

    -- Clock generation
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial reset
        reset <= '1';
        wait for 10 us;
        reset <= '0';
        
        -- Let it run to alarm (5 seconds)
        wait for 6 sec;
        
        -- Test reset during operation
        reset <= '1';
        wait for 10 us;
        reset <= '0';
        
        -- Change alarm value and test again
        alarm_in <= "00000011"; -- Alarm at 3 seconds
        wait for 4 sec;
        
        -- Test reset when alarm is active
        wait for 1 sec; -- Let it blink for 1 sec
        reset <= '1';
        wait for 10 us;
        reset <= '0';
        
        wait;
    end process;
end Behavioral;
