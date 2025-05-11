-------------------------------------------------------------------------------
--
-- Title       : bit_processor_tb
-- Design      : BitProcessorDesign
-- Author      : Saleh
-- Company     : s
--
-------------------------------------------------------------------------------
--
-- File        : D:\IUST Legacy\IUST-Legacy\Term 8\CAD\Homeworks\HW2\Q5\BitProcessor\BitProcessorDesign\src\bit_processor_tb.vhd
-- Generated   : Fri May  2 00:34:24 2025
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
use STD.ENV.ALL;

entity tb_bit_processor is
end tb_bit_processor;

architecture Behavioral of tb_bit_processor is
    -- Component declaration
    component bit_processor
        Port (
            input_vec : in  std_logic_vector(7 downto 0);
            shifted_output : out std_logic_vector(7 downto 0);
            output_rotated : out std_logic_vector(7 downto 0);
            zero_is : out boolean;
            time_event_last : out time
        );
    end component;

    -- Test signals
    signal input_vec : std_logic_vector(7 downto 0) := (others => '0');
    signal shifted_output : std_logic_vector(7 downto 0);
    signal output_rotated : std_logic_vector(7 downto 0);
    signal zero_is : boolean;
    signal time_event_last : time;

begin
    -- Instantiate the unit under test (UUT)
    uut: bit_processor port map (
        input_vec => input_vec,
        shifted_output => shifted_output,
        output_rotated => output_rotated,
        zero_is => zero_is,
        time_event_last => time_event_last
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1: All zeros
        input_vec <= "00000000";
        wait for 10 ns;
        assert zero_is = true report "Test 1: zero_is failed" severity error;
        assert shifted_output = "00000000" report "Test 1: shifted_output failed" severity error;
        assert output_rotated = "00000000" report "Test 1: output_rotated failed" severity error;

        -- Test case 2: Simple pattern
        input_vec <= "00000001";
        wait for 10 ns;
        assert zero_is = false report "Test 2: zero_is failed" severity error;
        assert shifted_output = "00000100" report "Test 2: shifted_output failed" severity error;
        assert output_rotated = "00100000" report "Test 2: output_rotated failed" severity error;

        -- Test case 3: Full pattern
        input_vec <= "11001010";
        wait for 10 ns;
        assert zero_is = false report "Test 3: zero_is failed" severity error;
        assert shifted_output = "00101000" report "Test 3: shifted_output failed" severity error;
        assert output_rotated = "01011001" report "Test 3: output_rotated failed" severity error;

        -- Test case 4: All ones
        input_vec <= "11111111";
        wait for 10 ns;
        assert zero_is = false report "Test 4: zero_is failed" severity error;
        assert shifted_output = "11111100" report "Test 4: shifted_output failed" severity error;
        assert output_rotated = "11111111" report "Test 4: output_rotated failed" severity error;

        -- Test case 5: Pattern with wrap-around
        input_vec <= "10000001";
        wait for 10 ns;
        assert zero_is = false report "Test 5: zero_is failed" severity error;
        assert shifted_output = "00000100" report "Test 5: shifted_output failed" severity error;
        assert output_rotated = "00110000" report "Test 5: output_rotated failed" severity error;

        -- Print completion message
        report "All tests completed successfully!";
        
        -- Finish the simulation
        stop(0);
    end process;
end Behavioral;
