LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY PS2 IS
	PORT (
		CLK : IN STD_LOGIC;
		DATA : IN STD_LOGIC;
		PS2_Clock : INOUT STD_LOGIC;
		sel_seg : OUT STD_LOGIC;
		output : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END PS2;

ARCHITECTURE Behavioral OF PS2 IS

	SIGNAL clock_10ms : STD_LOGIC := '0';
	SIGNAL PS2_DATA : STD_LOGIC_VECTOR (7 DOWNTO 0) := (OTHERS => '0');

BEGIN

	WITH PS2_DATA SELECT
		output <= "0111111" WHEN x"45",
		"0000110" WHEN x"16",
		"1011011" WHEN x"1e",
		"1001111" WHEN x"26",
		"1100110" WHEN x"25",
		"1101101" WHEN x"2e",
		"1111101" WHEN x"36",
		"0000111" WHEN x"3d",
		"1111111" WHEN x"3e",
		"1101111" WHEN x"46",
		"0000000" WHEN OTHERS;

	PROCESS (CLK)
		VARIABLE count_div : INTEGER RANGE 0 TO 50000 := 0;
	BEGIN
		IF (rising_edge(CLK)) THEN
			IF (count_div < 50000) THEN
				count_div := count_div + 1;
			ELSE
				count_div := 0;
				clock10ms <= NOT clock10ms;
			END IF;
		END IF;
	END PROCESS;

	PROCESS (clock_10ms)
	BEGIN
		IF rising_edge(clock_10ms) THEN
			IF (sel_seg = '0') THEN
				sel_seg <= '1';
			ELSE
				sel_seg <= '0';
			END IF;
		END IF;
	END PROCESS;

	PROCESS (CLK)
		VARIABLE counter : INTEGER RANGE 0 TO 100000 := 0;
		VARIABLE is_clock_set : STD_LOGIC := '0';
	BEGIN
		IF (rising_edge(CLK) AND is_clock_set = '0') THEN
			IF (counter < 750000) THEN
				counter := counter + 1;
			ELSE
				counter := 0;
				PS2_Clock <= '1';
				is_clock_set = '1';
			END IF;
		END IF;
	END PROCESS;

	PROCESS (PS2_Clock)
		VARIABLE PS2_DATA_TEMP : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
		VARIABLE counter : INTEGER RANGE 0 TO 10 := 0;
		VARIABLE finish : STD_LOGIC := '1';
		VARIABLE one_c : INTEGER RANGE 0 TO 10 := 0;
	BEGIN
		IF falling_edge(PS2_Clock) THEN
			IF finish = '0' THEN
				IF counter < 8 THEN
					PS2_DATA_TEMP(counter) := DATA;

					IF (DATA = '1') THEN
						one_c := one_c + 1;
					END IF;

					counter := counter + 1;
				ELSIF counter = 8 THEN
					IF DATA = '1' THEN
						one_c := one_c + 1;
					END IF;

					IF one_c REM 2 = '1' THEN
						PS2_DATA <= PS2_DATA_TEMP;
					END IF;

					counter := counter + 1;
				ELSIF counter = 9 THEN
					counter := 0;
					finish := '1';
					one_c := 0;
				END IF;
			ELSIF DATA = '0' THEN
				finish = '0';
			END IF;
		END IF;
	END PROCESS;

END Behavioral;