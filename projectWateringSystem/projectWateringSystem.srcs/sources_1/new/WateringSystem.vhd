----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/09/2024 01:06:37 AM
-- Design Name: 
-- Module Name: WateringSystem - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WateringSystem is
    Port ( reset : in STD_LOGIC;
           CLK : in STD_LOGIC;
           M : in STD_LOGIC_VECTOR (2 downto 0);
           L : in STD_LOGIC;
           T : in STD_LOGIC;
           STATE : out STD_LOGIC;
           SEG : out STD_LOGIC_VECTOR (6 downto 0));
end WateringSystem;

architecture Behavioral of WateringSystem is
    type state_type is (ST0, ST1);
    signal current_state, next_state : state_type;
    signal ideal_conditions : std_logic;
begin
    -- Determine if conditions are ideal
    process(L, T)
    begin
        if (L = '0' and T = '0') then
            ideal_conditions <= '1';
        else
            ideal_conditions <= '0';
        end if;
    end process;

    -- State transition logic
    process(current_state, M, ideal_conditions)
    begin
        case current_state is
            when ST0 =>
                if (ideal_conditions = '1' and M > "011") then
                    next_state <= ST0;
                elsif (ideal_conditions = '1' and M <= "011") then
                    next_state <= ST1;
                elsif (ideal_conditions = '0' and M <= "001") then
                    next_state <= ST1;
                else
                    next_state <= ST0;
                end if;
            when ST1 =>
                if (ideal_conditions = '1' and M < "111") then
                    next_state <= ST1;
                elsif (M >= "111") then
                    next_state <= ST0;
                elsif (ideal_conditions = '0' and M < "011") then
                    next_state <= ST1;
                else
                    next_state <= ST0;
                end if;
            when others =>
                next_state <= ST0;
        end case;
    end process;

    -- State register
    process(CLK, reset)
    begin
        if reset = '1' then
            current_state <= ST0;
        elsif rising_edge(CLK) then
            current_state <= next_state;
        end if;
    end process;

    -- Output logic
    process(current_state)
    begin
        case current_state is
            when ST0 =>
                STATE <= '0';
                SEG <= "1111110"; -- "-" on 7-segment display
            when ST1 =>
                STATE <= '1';
                SEG <= "1111001"; -- "H" on 7-segment display
            when others =>
                STATE <= '0';
                SEG <= "1111110"; -- "-"
        end case;
    end process;
end Behavioral;
