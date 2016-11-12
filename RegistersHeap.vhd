----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:41:06 11/10/2016 
-- Design Name: 
-- Module Name:    RegistersHeap - Behavioral 
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

entity RegistersHeap is
    Port ( ReadRegister1 : in  STD_LOGIC_VECTOR (2 downto 0);
           ReadRegister2 : in  STD_LOGIC_VECTOR (2 downto 0);
           WriteRegister : in  STD_LOGIC_VECTOR (2 downto 0);
           WriteData : in  STD_LOGIC_VECTOR (15 downto 0);
           ReadData1 : out  STD_LOGIC_VECTOR (15 downto 0);
           ReadData2 : out  STD_LOGIC_VECTOR (15 downto 0);
           WriteEN : in  STD_LOGIC);
end RegistersHeap;

architecture Behavioral of RegistersHeap is
	
signal REG0: STD_LOGIC_VECTOR (15 downto 0);
signal REG1: STD_LOGIC_VECTOR (15 downto 0);
signal REG2: STD_LOGIC_VECTOR (15 downto 0);
signal REG3: STD_LOGIC_VECTOR (15 downto 0);
signal REG4: STD_LOGIC_VECTOR (15 downto 0);
signal REG5: STD_LOGIC_VECTOR (15 downto 0);
signal REG6: STD_LOGIC_VECTOR (15 downto 0);
signal REG7: STD_LOGIC_VECTOR (15 downto 0);

begin
	
	with ReadRegister1 select ReadData1 <=
			REG0 when "000",
			REG1 when "001",
			REG2 when "010",
			REG3 when "011",
			REG4 when "100",
			REG5 when "101",
			REG6 when "110",
			REG7 when "111",
			"0000000000000000" when others;
			
	with ReadRegister2 select ReadData2 <=
			REG0 when "000",
			REG1 when "001",
			REG2 when "010",
			REG3 when "011",
			REG4 when "100",
			REG5 when "101",
			REG6 when "110",
			REG7 when "111",
			"0000000000000000" when others;

	process(WriteData,WriteRegister,WriteEN)
	begin
	if(WriteEN'event and WriteEN='1')then
		case WriteRegister is
			when "000" => REG0 <= WriteData;
			when "001" => REG1 <= WriteData;
			when "010" => REG2 <= WriteData;
			when "011" => REG3 <= WriteData;
			when "100" => REG4 <= WriteData;
			when "101" => REG5 <= WriteData;
			when "110" => REG6 <= WriteData;
			when "111" => REG7 <= WriteData;
			when others =>
		end case;
	end if;
	end process;
	
end Behavioral;

