-------------------------------------------------------------------------------
--
-- Title       : register_tb
-- Design      : Register_Design
-- Author      : Saleh
-- Company     : s
--
-------------------------------------------------------------------------------
--
-- File        : D:\IUST Legacy\IUST-Legacy\Term 8\CAD\Homeworks\HW2\Q4\Register\Register_Design\src\register_tb.vhd
-- Generated   : Thu May  1 16:52:40 2025
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

entity axf_register_tb is
end axf_register_tb;

architecture Behavioral of axf_register_tb is
    component axf_register
        Port (
            Clk     : in  STD_LOGIC;
            wr_en   : in  STD_LOGIC;
            wr_addr : in  STD_LOGIC_VECTOR(1 downto 0);
            data_in : in  STD_LOGIC_VECTOR(7 downto 0);
            Mem     : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    signal Clk     : STD_LOGIC := '0';
    signal wr_en   : STD_LOGIC := '0';
    signal wr_addr : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal data_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal Mem     : STD_LOGIC_VECTOR(31 downto 0);

    -- Clock period definition
    constant Clk_period : time := 10 ns;

begin
    uut: axf_register port map (
        Clk => Clk,
        wr_en => wr_en,
        wr_addr => wr_addr,
        data_in => data_in,
        Mem => Mem
    );

    -- Clock process definitions
    Clk_process :process
    begin
        Clk <= '0';
        wait for Clk_period/2;
        Clk <= '1';
        wait for Clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin        
        -- Initial wait
        wait for Clk_period;
        
        -- Test 1: Write to address 0
        wr_en <= '1';
        wr_addr <= "00";
        data_in <= "10101010";
        wait for Clk_period;
        
        -- Test 2: Write to address 1
        wr_addr <= "01";
        data_in <= "11001100";
        wait for Clk_period;
        
        -- Test 3: Write to address 2
        wr_addr <= "10";
        data_in <= "11110000";
        wait for Clk_period;
        
        -- Test 4: Write to address 3
        wr_addr <= "11";
        data_in <= "00001111";
        wait for Clk_period;
        
        -- Test 5: Write disabled - should not change memory
        wr_en <= '0';
        wr_addr <= "00";
        data_in <= "11111111";
        wait for Clk_period;
        
        -- Test 6: Read operation - verify memory contents through Mem output
        wait for Clk_period;
        
        -- End simulation
        wait;
    end process;

end Behavioral;