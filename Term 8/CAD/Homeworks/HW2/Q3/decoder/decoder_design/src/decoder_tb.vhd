-------------------------------------------------------------------------------
--
-- Title       : decoder_tb
-- Design      : decoder_design
-- Author      : Saleh
-- Company     : s
--
-------------------------------------------------------------------------------
--
-- File        : D:\IUST Legacy\IUST-Legacy\Term 8\CAD\Homeworks\HW2\Q3\decoder\decoder_design\src\decoder_tb.vhd
-- Generated   : Thu May  1 16:13:59 2025
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_decoder_2to4 is
end tb_decoder_2to4;

architecture Behavioral of tb_decoder_2to4 is
    component decoder_2to4
        generic (
            DELAY : time := 10 ns
        );
        port (
            A, B, enable : in std_logic;
            Y0, Y1, Y2, Y3 : out std_logic
        );
    end component;

    signal A, B, enable : std_logic := '0';
    signal Y0, Y1, Y2, Y3 : std_logic;
    
    -- Instance with default delay (10 ns)
    signal DELAY_DEFAULT : time := 10 ns;
    
    -- Instance with custom delay for testing (5 ns)
    signal DELAY_CUSTOM : time := 5 ns;
begin
    -- Decoder instantiation with default delay
    uut_default: decoder_2to4 
        generic map (DELAY => DELAY_DEFAULT)
        port map (
            A => A,
            B => B,
            enable => enable,
            Y0 => Y0,
            Y1 => Y1,
            Y2 => Y2,
            Y3 => Y3
        );

    -- Test stimulus generation process
    stimulus_process: process
    begin
        -- Test disabled state (enable = '0')
        enable <= '0';
        A <= '0'; B <= '0'; wait for 20 ns;
        A <= '0'; B <= '1'; wait for 20 ns;
        A <= '1'; B <= '0'; wait for 20 ns;
        A <= '1'; B <= '1'; wait for 20 ns;
        
        -- Test enabled state (enable = '1')
        enable <= '1';
        
        -- Test all input combinations
        A <= '0'; B <= '0'; wait for 20 ns;  -- Expect Y0 to activate
        A <= '0'; B <= '1'; wait for 20 ns;  -- Expect Y1 to activate
        A <= '1'; B <= '0'; wait for 20 ns;  -- Expect Y2 to activate
        A <= '1'; B <= '1'; wait for 20 ns;  -- Expect Y3 to activate
        
        -- Test rapid input changes
        A <= '0'; B <= '0'; wait for 5 ns;
        A <= '1'; B <= '0'; wait for 5 ns;
        A <= '1'; B <= '1'; wait for 5 ns;
        A <= '0'; B <= '1'; wait for 5 ns;
        
        -- End of test
        wait;
    end process;

end Behavioral;