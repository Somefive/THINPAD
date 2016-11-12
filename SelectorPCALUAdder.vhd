----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:15:11 11/11/2016 
-- Design Name: 
-- Module Name:    SelectorPCALUAdder - Behavioral 
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

entity SelectorPCALUAdder is
    Port ( Instruction7to0 : in  STD_LOGIC_VECTOR (7 downto 0);
           Instruction10to0 : in  STD_LOGIC_VECTOR (10 downto 0);
           SelectorOfPCALUAdder : in  STD_LOGIC_VECTOR (1 downto 0);
           PCALUAdder : out  STD_LOGIC_VECTOR (15 downto 0));
end SelectorPCALUAdder;

architecture Behavioral of SelectorPCALUAdder is

begin

	with SelectorOfPCALUAdder select PCALUAdder <=
		std_logic_vector(resize(signed(Instruction7to0), 16)) when "01",
		std_logic_vector(resize(signed(Instruction10to0), 16)) when "10",
		"0000000000000010" when "11",
		"0000000000000000" when others;

end Behavioral;

