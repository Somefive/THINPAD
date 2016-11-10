----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:53:19 11/10/2016 
-- Design Name: 
-- Module Name:    SelectorShiftParam - Behavioral 
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

entity SelectorShiftParam is
    Port ( Instruction4to2 : in  STD_LOGIC_VECTOR (2 downto 0);
           Instruction4to2ShiftResult : out  STD_LOGIC_VECTOR (15 downto 0));
end SelectorShiftParam;

architecture Behavioral of SelectorShiftParam is

begin
	
	with Instruction4to2 select Instruction4to2ShiftResult <=
		"0000000000001000" when "000",
		"0000000000000" & Instruction4to2 when others;

end Behavioral;

