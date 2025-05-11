-------------------------------------------------------------------------------
--
-- Title       : decoder
-- Design      : decoder_design
-- Author      : Saleh
-- Company     : s
--
-------------------------------------------------------------------------------
--
-- File        : D:\IUST Legacy\IUST-Legacy\Term 8\CAD\Homeworks\HW2\Q3\decoder\decoder_design\src\decoder.vhd
-- Generated   : Thu May  1 16:11:56 2025
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

entity decoder_2to4 is
    generic (
        DELAY : time := 10 ns 
    );
    port (
        A, B, enable : in std_logic;
        Y0, Y1, Y2, Y3 : out std_logic
    );
end decoder_2to4;

architecture Behavioral of decoder_2to4 is
    signal AB : std_logic_vector(1 downto 0);
    signal decoded : std_logic_vector(3 downto 0);
begin
    AB <= A & B;
    
    with AB select
        decoded <= "0001" when "00",
                   "0010" when "01",
                   "0100" when "10",
                   "1000" when "11",
                   "0000" when others;

    Y0 <= decoded(0) after DELAY when enable = '1' else '0' after DELAY;
    Y1 <= decoded(1) after DELAY when enable = '1' else '0' after DELAY;
    Y2 <= decoded(2) after DELAY when enable = '1' else '0' after DELAY;
    Y3 <= decoded(3) after DELAY when enable = '1' else '0' after DELAY;
end Behavioral;