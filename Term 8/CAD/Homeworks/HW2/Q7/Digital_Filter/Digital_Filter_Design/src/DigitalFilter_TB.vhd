-------------------------------------------------------------------------------
--
-- Title       : DigitalFilter_TB
-- Design      : Digital_Filter_Design
-- Author      : Saleh
-- Company     : s
--
-------------------------------------------------------------------------------
--
-- File        : D:\IUST Legacy\IUST-Legacy\Term 8\CAD\Homeworks\HW2\Q7\Digital_Filter\Digital_Filter_Design\src\DigitalFilter_TB.vhd
-- Generated   : Fri May  2 19:32:56 2025
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

entity DigitalFilter_TB is
end DigitalFilter_TB;

architecture Behavioral of DigitalFilter_TB is
    constant n : integer := 4;
    constant m : integer := 8;
    
    signal clk      : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    signal load     : STD_LOGIC := '0';
    signal run      : STD_LOGIC := '0';
    signal x_coeff  : STD_LOGIC_VECTOR(m-1 downto 0) := (others => '0');
    signal y_coeff  : STD_LOGIC_VECTOR(m-1 downto 0) := (others => '0');
    signal z_coeff  : STD_LOGIC_VECTOR(m-1 downto 0) := (others => '0');
    signal data_in  : STD_LOGIC_VECTOR(m-1 downto 0) := (others => '0');
    signal data_out : STD_LOGIC_VECTOR(m-1 downto 0);
    signal overflow : STD_LOGIC;
    
    constant clk_period : time := 10 ns;
begin

    uut: entity work.DigitalFilter
        generic map (
            n => n,
            m => m
        )
        port map (
            clk      => clk,
            reset    => reset,
            load     => load,
            run      => run,
            x_coeff  => x_coeff,
            y_coeff  => y_coeff,
            z_coeff  => z_coeff,
            data_in  => data_in,
            data_out => data_out,
            overflow => overflow
        );
        
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    stim_proc: process
    begin
        -- Reset the system
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for clk_period;
        
        -- Load coefficients
        load <= '1';
        x_coeff <= std_logic_vector(to_signed(2, m));
        y_coeff <= std_logic_vector(to_signed(-3, m));
        z_coeff <= std_logic_vector(to_signed(1, m));
        wait for clk_period;
        load <= '0';
        
        -- Test inputs
        run <= '1';
        data_in <= std_logic_vector(to_signed(10, m));  -- First input
        wait for clk_period;
        
        data_in <= std_logic_vector(to_signed(20, m));  -- Second input
        wait for clk_period;
        
        data_in <= std_logic_vector(to_signed(30, m));  -- Third input
        wait for clk_period;
        
        data_in <= std_logic_vector(to_signed(40, m));  -- Fourth input
        wait for clk_period;
        
        -- Now the first output should be calculated
        -- Manual calculation for verification:
        -- 40*2 + 30*(-3) + 20*1 + 10*2 = 80 - 90 + 20 + 20 = 30
        wait for clk_period;
        
        -- Test overflow
        data_in <= std_logic_vector(to_signed(100, m));
        wait for clk_period;
        data_in <= std_logic_vector(to_signed(100, m));
        wait for clk_period;
        data_in <= std_logic_vector(to_signed(100, m));
        wait for clk_period;
        data_in <= std_logic_vector(to_signed(100, m));
        wait for clk_period;
        
        -- Overflow should occur here
        wait for clk_period;
        
        -- End of test
        run <= '0';
        wait;
    end process;

end Behavioral;