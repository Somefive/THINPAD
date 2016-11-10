----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:52:28 11/10/2016 
-- Design Name: 
-- Module Name:    SelectorWriteRegisterData - Behavioral 
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

entity SelectorWriteRegisterData is
    Port ( PC : in  STD_LOGIC_VECTOR (15 downto 0);
           RegistersReadData2 : in  STD_LOGIC_VECTOR (15 downto 0);
           Instruction7to0 : in  STD_LOGIC_VECTOR (7 downto 0);
           ALUResult : in  STD_LOGIC_VECTOR (15 downto 0);
           DataMemoryReadData : in  STD_LOGIC_VECTOR (15 downto 0);
           IH : in  STD_LOGIC_VECTOR (15 downto 0);
           selector : in  STD_LOGIC_VECTOR (2 downto 0);
			  WriteRegisterData : out  STD_LOGIC_VECTOR (15 downto 0));
end SelectorWriteRegisterData;

architecture Behavioral of SelectorWriteRegisterData is

begin

	with selector select WriteRegisterData <=
		PC when "001",
		RegistersReadData2 when "010",
		"00000000" & Instruction7to0 when "011",
		ALUResult when "100",
		DataMemoryReadData when "101",
		IH when "110",
		"0000000000000000" when others;

end Behavioral;

