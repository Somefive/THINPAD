----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:30:29 11/10/2016 
-- Design Name: 
-- Module Name:    Comparator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Comparator is
    Port ( First : in  STD_LOGIC_VECTOR (15 downto 0);
           Second : in  STD_LOGIC_VECTOR (15 downto 0);
           Result : out  STD_LOGIC);
end Comparator;

architecture Behavioral of Comparator is

begin
	process(First,Second)
	begin
		if(First=Second)then
			Result<='0';
		else
			Result<='1';
		end if;
	end process;
end Behavioral;

