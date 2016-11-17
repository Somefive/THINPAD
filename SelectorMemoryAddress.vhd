----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:21:28 11/17/2016 
-- Design Name: 
-- Module Name:    SelectorMemoryAddress - Behavioral 
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

entity SelectorMemoryAddress is
	Port ( ALUResult : in  STD_LOGIC_VECTOR (15 downto 0);
           PCOutput : in  STD_LOGIC_VECTOR (15 downto 0);
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
           SelectedMemoryAddress : out  STD_LOGIC_VECTOR (15 downto 0));
end SelectorMemoryAddress;

architecture Behavioral of SelectorMemoryAddress is
	
begin
	with selector select SelectedMemoryAddress <=
		ALUResult when "01",
		PCOutput when "10",
		"0000000000000000" when others;

end Behavioral;

