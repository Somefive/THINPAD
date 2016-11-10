----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:41:47 11/10/2016 
-- Design Name: 
-- Module Name:    SelectorALUParam2 - Behavioral 
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

entity SelectorALUParam2 is
    Port ( Instruction4to0 : in  STD_LOGIC_VECTOR (4 downto 0);
           ReadRegisterData2 : in  STD_LOGIC_VECTOR (15 downto 0);
           SelectedImmediate : in  STD_LOGIC_VECTOR (15 downto 0);
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
           ALUOperandB : out  STD_LOGIC_VECTOR (15 downto 0));
end SelectorALUParam2;

architecture Behavioral of SelectorALUParam2 is
begin

	with selector select ALUOperandB <=
		std_logic_vector(resize(signed(Instruction4to0), 16)) when "01",
		ReadRegisterData2 when "10",
		SelectedImmediate when "11",
		"0000000000000000" when others;

end Behavioral;

