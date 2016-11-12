----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:28:27 11/11/2016 
-- Design Name: 
-- Module Name:    SelectorDataMemoryWriteData - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SelectorDataMemoryWriteData is
    Port ( SignalOfReadRegisterData2 : in  STD_LOGIC_VECTOR (15 downto 0);
           SignalOfReadRegisterData1 : in  STD_LOGIC_VECTOR (15 downto 0);
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
           DataMemoryWriteData : out  STD_LOGIC_VECTOR (15 downto 0));
end SelectorDataMemoryWriteData;

architecture Behavioral of SelectorDataMemoryWriteData is

begin
	
	with selector select DataMemoryWriteData <=
		SignalOfReadRegisterData2 when "01",
		SignalOfReadRegisterData1 when "10",
		"0000000000000000" when others;

end Behavioral;

