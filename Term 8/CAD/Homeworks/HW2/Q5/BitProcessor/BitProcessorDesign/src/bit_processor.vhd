-------------------------------------------------------------------------------
--
-- Title       : bit_processor
-- Design      : BitProcessorDesign
-- Author      : Saleh
-- Company     : s
--
-------------------------------------------------------------------------------
--
-- File        : D:\IUST Legacy\IUST-Legacy\Term 8\CAD\Homeworks\HW2\Q5\BitProcessor\BitProcessorDesign\src\bit_processor.vhd
-- Generated   : Fri May  2 00:34:10 2025
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

entity bit_processor is
    Port (
        input_vec : in  std_logic_vector(7 downto 0);       -- 8-bit input vector
        shifted_output : out std_logic_vector(7 downto 0);   -- Logical shift left by 2
        output_rotated : out std_logic_vector(7 downto 0);   -- Circular rotate right by 3
        zero_is : out boolean;                              -- True if all bits are zero
        time_event_last : out time                          -- Time of last input change
    );
end bit_processor;

architecture Behavioral of bit_processor is
    signal last_change_time : time := 0 ns;  -- Internal signal to store last change time
    
    -- Custom rotate right function for std_logic_vector
    function rotate_right(vec : std_logic_vector; n : natural) return std_logic_vector is
        variable result : std_logic_vector(vec'range);
        constant len : natural := vec'length;
    begin
        result := vec(n-1 downto 0) & vec(len-1 downto n);
        return result;
    end function;
    
begin
    -- Logical shift left by 2 bits (using numeric_std conversion)
    shifted_output <= std_logic_vector(shift_left(unsigned(input_vec), 2));
    
    -- Circular rotate right by 3 bits (using custom function)
    output_rotated <= rotate_right(input_vec, 3);
    
    -- Compare all bits to zero
    zero_is <= (input_vec = "00000000");
    
    -- Process to track last change time using 'LAST_EVENT attribute
    process(input_vec)
    begin
        if input_vec'LAST_EVENT > 0 ns then
            last_change_time <= now;
        end if;
    end process;
    
    -- Output the last change time
    time_event_last <= last_change_time;
end Behavioral;