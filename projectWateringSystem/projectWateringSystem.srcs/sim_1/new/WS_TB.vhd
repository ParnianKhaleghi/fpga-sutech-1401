library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity WateringSystem_tb is
-- Testbench does not have any ports
end WateringSystem_tb;

architecture behavior of WateringSystem_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component WateringSystem
    Port(
         reset : in STD_LOGIC;
         CLK : in STD_LOGIC;
         M : in STD_LOGIC_VECTOR (2 downto 0);
         L : in STD_LOGIC;
         T : in STD_LOGIC;
         STATE : out STD_LOGIC;
         SEG : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    --Inputs
    signal reset : STD_LOGIC := '0';
    signal CLK : STD_LOGIC := '0';
    signal M : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
    signal L : STD_LOGIC := '0';
    signal T : STD_LOGIC := '0';

    --Outputs
    signal STATE : STD_LOGIC;
    signal SEG : STD_LOGIC_VECTOR (6 downto 0);

    -- Clock period definitions
    constant CLK_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: WateringSystem port map (
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
        -- hold reset state for 100 ns.
        reset <= '1';
        wait for 100 ns;

        reset <= '0';

        -- Set inputs and wait for results
        L <= '0';
        T <= '0';
        M <= "100";
        wait for 50 ns;

        M <= "011";
        wait for 50 ns;

        L <= '1';
        T <= '1';
        wait for 50 ns;

        M <= "000";
        wait for 50 ns;

        L <= '0';
        T <= '0';
        M <= "111";
        wait for 50 ns;

        -- Add more test vectors as needed
        wait;
    end process;
end behavior;

