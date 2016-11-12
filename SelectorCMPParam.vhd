----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:46:25 11/11/2016 
-- Design Name: 
-- Module Name:    SelectorCMPParam - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SelectorCMPParam is
    Port ( SignalOfReadRegisterData2 : in  STD_LOGIC_VECTOR (15 downto 0);
           Instruction7to0 : in  STD_LOGIC_VECTOR (7 downto 0);
           SelectorOfCMPParam : in  STD_LOGIC_VECTOR (1 downto 0);
           ComparatorParam2 : out  STD_LOGIC_VECTOR (15 downto 0));
end SelectorCMPParam;

architecture Behavioral of SelectorCMPParam is

begin

	with SelectorOfCMPParam select ComparatorParam2 <=
			SignalOfReadRegisterData2 when "01",
			std_logic_vector(resize(signed(Instruction7to0), 16)) when "10",
			"0000000000000000" when others;

end Behavioral;

