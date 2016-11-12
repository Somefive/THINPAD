----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:04:38 11/11/2016 
-- Design Name: 
-- Module Name:    SelectorPCBJ - Behavioral 
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

entity SelectorPCBJ is
    Port ( PCALUResult : in  STD_LOGIC_VECTOR (15 downto 0);
           SignalOfReadRegisterData1 : in  STD_LOGIC_VECTOR (15 downto 0);
           SelectorOfPCBJ : in  STD_LOGIC_VECTOR (1 downto 0);
           PCInput : out  STD_LOGIC_VECTOR (15 downto 0));
end SelectorPCBJ;

architecture Behavioral of SelectorPCBJ is

begin

	with SelectorOfPCBJ select PCInput <=
		PCALUResult when "01",
		SignalOfReadRegisterData1 when "10",
		"0000000000000000" when others;

end Behavioral;

