library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.WateringSystem_pkg.all;

entity WateringSystem_tb is
end WateringSystem_tb;

architecture Behavioral of WateringSystem_tb is

    component WateringSystem
        Port ( reset : in STD_LOGIC;
               CLK : in STD_LOGIC;
               M : in STD_LOGIC_VECTOR (2 downto 0);
               L : in STD_LOGIC;
               T : in STD_LOGIC;
               STATE : out STD_LOGIC;
               SEG : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    signal reset : STD_LOGIC := '0';
    signal CLK : STD_LOGIC := '0';
    signal M : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal L : STD_LOGIC := '0';
    signal T : STD_LOGIC := '0';
    signal STATE : STD_LOGIC;
    signal SEG : STD_LOGIC_VECTOR (6 downto 0);

    constant CLK_period : time := 10 ns;

begin

    uut: WateringSystem Port map (
          reset => reset,
          CLK => CLK,
          M => M,
          L => L,
          T => T,
          STATE => STATE,
          SEG => SEG
        );

    -- Clock process definitions
    CLK_process :process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- reset the system
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;

        -- test case 1: ideal conditions, M > 3
        M <= "100"; L <= '0'; T <= '0';
        wait for 40 ns;

        -- test case 2: ideal conditions, M <= 3
        M <= "011"; L <= '0'; T <= '0';
        wait for 40 ns;

        -- test case 3: not ideal conditions, M <= 1
        M <= "001"; L <= '1'; T <= '1';
        wait for 40 ns;

        -- test case 4: not ideal conditions, M > 1 but <= 3
        M <= "010"; L <= '1'; T <= '1';
        wait for 40 ns;

        -- test case 5: ideal conditions, M = 7
        M <= "111"; L <= '0'; T <= '0';
        wait for 40 ns;

        -- test case 6: transition from ideal to not ideal conditions
        M <= "011"; L <= '0'; T <= '0';
        wait for 40 ns;
        L <= '1'; T <= '1';
        wait for 40 ns;

        -- test case 7: transition from not ideal to ideal conditions
        M <= "001"; L <= '1'; T <= '1';
        wait for 40 ns;
        L <= '0'; T <= '0';
        wait for 40 ns;

        -- test case 8: boundary case, M = 3, ideal conditions
        M <= "011"; L <= '0'; T <= '0';
        wait for 40 ns;

        -- test case 9: boundary case, M = 4, ideal conditions
        M <= "100"; L <= '0'; T <= '0';
        wait for 40 ns;

        -- test case 10: reset while in state ST1
        M <= "011"; L <= '0'; T <= '0';
        wait for 40 ns;
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 40 ns;

        
        wait;
    end process;

end Behavioral;
