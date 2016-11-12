----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:06:06 11/11/2016 
-- Design Name: 
-- Module Name:    SelectorSPInput - Behavioral 
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

entity SelectorSPInput is
    Port ( ReadRegisterData1 : in  STD_LOGIC_VECTOR (15 downto 0);
           ALUResult : in  STD_LOGIC_VECTOR (15 downto 0);
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
           SPInput : out  STD_LOGIC_VECTOR (15 downto 0));
end SelectorSPInput;

architecture Behavioral of SelectorSPInput is

begin

	with selector select SPInput <=
		ReadRegisterData1 when "01",
		ALUResult when "10",
		"0000000000000000" when others;

end Behavioral;

