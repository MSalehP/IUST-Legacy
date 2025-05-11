-------------------------------------------------------------------------------
--
-- Title       : DigitalFilter
-- Design      : Digital_Filter_Design
-- Author      : Saleh
-- Company     : s
--
-------------------------------------------------------------------------------
--
-- File        : D:\IUST Legacy\IUST-Legacy\Term 8\CAD\Homeworks\HW2\Q7\Digital_Filter\Digital_Filter_Design\src\DigitalFilter.vhd
-- Generated   : Fri May  2 19:32:17 2025
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

entity DigitalFilter is
    Generic (
        n : integer := 4;  -- Number of filter taps
        m : integer := 8   -- Bit width of each input value
    );
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        load     : in  STD_LOGIC;
        run      : in  STD_LOGIC;
        x_coeff  : in  STD_LOGIC_VECTOR(m-1 downto 0);
        y_coeff  : in  STD_LOGIC_VECTOR(m-1 downto 0);
        z_coeff  : in  STD_LOGIC_VECTOR(m-1 downto 0);
        data_in  : in  STD_LOGIC_VECTOR(m-1 downto 0);
        data_out : out STD_LOGIC_VECTOR(m-1 downto 0);
        overflow : out STD_LOGIC
    );
end DigitalFilter;

architecture Behavioral of DigitalFilter is
    type coeff_array is array (0 to n-1) of STD_LOGIC_VECTOR(m-1 downto 0);
    type data_array is array (0 to n-1) of STD_LOGIC_VECTOR(m-1 downto 0);
    
    signal coeff_reg : coeff_array := (others => (others => '0'));
    signal data_reg  : data_array := (others => (others => '0'));
    signal sum       : STD_LOGIC_VECTOR(2*m-1 downto 0) := (others => '0');
    
    -- Constants for overflow handling
    constant MAX_POSITIVE : STD_LOGIC_VECTOR(m-1 downto 0) := '0' & (m-2 downto 0 => '1');
    constant MAX_NEGATIVE : STD_LOGIC_VECTOR(m-1 downto 0) := '1' & (m-2 downto 0 => '0');
begin

    process(clk, reset)
        variable temp_sum : signed(2*m-1 downto 0) := (others => '0');
    begin
        if reset = '1' then
            -- Reset all registers
            coeff_reg <= (others => (others => '0'));
            data_reg  <= (others => (others => '0'));
            sum       <= (others => '0');
            data_out  <= (others => '0');
            overflow  <= '0';
        elsif rising_edge(clk) then
            -- Load coefficients
            if load = '1' then
                coeff_reg(0) <= x_coeff;
                coeff_reg(1) <= y_coeff;
                coeff_reg(2) <= z_coeff;
                -- For coefficients beyond 3, use initial coefficients
                for i in 3 to n-1 loop
                    coeff_reg(i) <= coeff_reg(i-3);
                end loop;
            end if;
            
            -- Process input data
            if run = '1' then
                -- Shift input data
                for i in n-1 downto 1 loop
                    data_reg(i) <= data_reg(i-1);
                end loop;
                data_reg(0) <= data_in;
                
                -- Calculate product and sum
                temp_sum := (others => '0');
                for i in 0 to n-1 loop
                    temp_sum := temp_sum + signed(coeff_reg(i)) * signed(data_reg(i));
                end loop;
                
                -- Check for overflow
                if temp_sum > to_signed(2**(m-1)-1, 2*m) or 
                   temp_sum < to_signed(-2**(m-1), 2*m) then
                    overflow <= '1';
                    -- In case of overflow, set to maximum or minimum value
                    if temp_sum > to_signed(0, 2*m) then
                        data_out <= MAX_POSITIVE;
                    else
                        data_out <= MAX_NEGATIVE;
                    end if;
                else
                    overflow <= '0';
                    data_out <= std_logic_vector(temp_sum(m-1 downto 0));
                end if;
            end if;
        end if;
    end process;

end Behavioral;