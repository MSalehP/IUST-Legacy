-------------------------------------------------------------------------------
--
-- Title       : DigitalTimer_TB
-- Design      : Digital_Timer_Design
-- Author      : Saleh
-- Company     : s
--
-------------------------------------------------------------------------------
--
-- File        : d:\Softwares\Active HDL\Digital_Timer\Digital_Timer_Design\src\DigitalTimer_TB.vhd
-- Generated   : Fri May  2 17:33:51 2025
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

entity timer_tb is
end timer_tb;

architecture Behavioral of timer_tb is
    component digital_timer
        Generic (
            FREQUENCY : integer := 100000000
        );
        Port (
            clk     : in  STD_LOGIC;
            rst     : in  STD_LOGIC;
            run     : in  STD_LOGIC;
            digit1  : out STD_LOGIC_VECTOR(6 downto 0);
            digit2  : out STD_LOGIC_VECTOR(6 downto 0);
            digit3  : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;
    
    -- Reduced frequency for faster simulation
    constant TEST_FREQUENCY : integer := 10; -- 10Hz for testing
    
    -- Test signals
    signal clk     : STD_LOGIC := '0';
    signal rst     : STD_LOGIC := '0';
    signal run     : STD_LOGIC := '0';
    signal digit1  : STD_LOGIC_VECTOR(6 downto 0);
    signal digit2  : STD_LOGIC_VECTOR(6 downto 0);
    signal digit3  : STD_LOGIC_VECTOR(6 downto 0);
    
    constant clk_period : time := 10 ns; -- 100MHz clock (10ns period)
    
begin
    -- Instantiate Unit Under Test (UUT)
    uut: digital_timer
        Generic map (
            FREQUENCY => TEST_FREQUENCY
        )
        Port map (
            clk => clk,
            rst => rst,
            run => run,
            digit1 => digit1,
            digit2 => digit2,
            digit3 => digit3
        );
        
    -- Clock generation process
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
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        
        -- Start counting
        run <= '1';
        wait for 200 ns; -- Let it run for 20 clock cycles
        
        -- Pause counting
        run <= '0';
        wait for 50 ns;
        
        -- Resume counting
        run <= '1';
        wait for 300 ns;
        
        -- Reset while running
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        
        -- Count until rollover
        run <= '1';
        wait for 2000 ns; -- To observe rollback to 00:00
        
        wait;
    end process;
end Behavioral;