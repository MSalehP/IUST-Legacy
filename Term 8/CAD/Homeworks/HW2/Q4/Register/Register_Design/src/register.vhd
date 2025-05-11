-------------------------------------------------------------------------------
--
-- Title       : \register\
-- Design      : Register_Design
-- Author      : Saleh
-- Company     : s
--
-------------------------------------------------------------------------------
--
-- File        : D:\IUST Legacy\IUST-Legacy\Term 8\CAD\Homeworks\HW2\Q4\Register\Register_Design\src\register.vhd
-- Generated   : Thu May  1 16:52:00 2025
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

entity axf_register is
    Port (
        Clk     : in  STD_LOGIC;                     -- Clock input
        wr_en   : in  STD_LOGIC;                     -- Write enable
        wr_addr : in  STD_LOGIC_VECTOR(1 downto 0);  -- 2-bit row address
        data_in : in  STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit input data
        Mem     : out STD_LOGIC_VECTOR(31 downto 0)  -- Output for viewing internal memory (4 rows × 8 bits)
    );
end axf_register;

architecture Behavioral of axf_register is
    -- Define a custom type for the 2D array
    type memory_array is array (0 to 3) of STD_LOGIC_VECTOR(7 downto 0);
    
    -- Signal declaration for the internal memory
    signal mem_array : memory_array := (others => (others => '0'));
    
begin
    process(Clk)
    begin
        if rising_edge(Clk) then
            -- Write operation when write enable is active
            if wr_en = '1' then
                mem_array(to_integer(unsigned(wr_addr))) <= data_in;
            end if;
        end if;
    end process;
    
    -- Output the entire memory for observation
    -- Concatenate all 4 rows (each 8 bits) into a 32-bit output
    Mem <= mem_array(3) & mem_array(2) & mem_array(1) & mem_array(0);
    
end Behavioral;