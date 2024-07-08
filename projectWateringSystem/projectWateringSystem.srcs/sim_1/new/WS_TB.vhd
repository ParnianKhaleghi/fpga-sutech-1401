----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/09/2024 01:16:06 AM
-- Design Name: 
-- Module Name: WS_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity WateringSystem_tb is
end;

architecture bench of WateringSystem_tb is

  component WateringSystem
      Port ( reset : in STD_LOGIC;
             CLK : in STD_LOGIC;
             M : in STD_LOGIC_VECTOR (2 downto 0);
             L : in STD_LOGIC;
             T : in STD_LOGIC;
             STATE : out STD_LOGIC;
             SEG : out STD_LOGIC_VECTOR (6 downto 0));
  end component;

  signal reset: STD_LOGIC;
  signal CLK: STD_LOGIC;
  signal M: STD_LOGIC_VECTOR (2 downto 0);
  signal L: STD_LOGIC;
  signal T: STD_LOGIC;
  signal STATE: STD_LOGIC;
  signal SEG: STD_LOGIC_VECTOR (6 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: WateringSystem port map ( reset => reset,
                                 CLK   => CLK,
                                 M     => M,
                                 L     => L,
                                 T     => T,
                                 STATE => STATE,
                                 SEG   => SEG );

  stimulus: process
  begin
  
    -- Put initialisation code here

    reset <= '1';
    wait for 5 ns;
    reset <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
