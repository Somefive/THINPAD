----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:36:59 11/10/2016 
-- Design Name: 
-- Module Name:    SelectorALUParam1 - Behavioral 
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

entity SelectorALUParam1 is
    Port ( ReadRegisterData1 : in  STD_LOGIC_VECTOR (15 downto 0);
           SP : in  STD_LOGIC_VECTOR (15 downto 0);
           Instruction4to2ShiftResult : in  STD_LOGIC_VECTOR (15 downto 0);
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
           ALUOperandA : out  STD_LOGIC_VECTOR (15 downto 0));
end SelectorALUParam1;

architecture Behavioral of SelectorALUParam1 is

begin

	with selector select ALUOperandA <=
		ReadRegisterData1 when "01",
		SP when "10",
		Instruction4to2ShiftResult when "11",
		"0000000000000000" when others;

end Behavioral;

