----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:22:10 11/11/2016 
-- Design Name: 
-- Module Name:    SelectorPCALUOp - Behavioral 
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

entity SelectorPCALUOp is
    Port ( TOutput : in  STD_LOGIC;
           SignalOfReadRegisterData1 : in  STD_LOGIC_VECTOR (15 downto 0);
           SelectorOfPCALUOp : in  STD_LOGIC_VECTOR (2 downto 0);
           SelectorOfPCALUAdder : out  STD_LOGIC_VECTOR (1 downto 0));
end SelectorPCALUOp;

architecture Behavioral of SelectorPCALUOp is

begin

	process(TOutput,SignalOfReadRegisterData1,SelectorOfPCALUOp)
	begin
		case SelectorOfPCALUOp is
			when "010" =>
				if(TOutput='0')then
					SelectorOfPCALUAdder <= "01";
				else
					SelectorOfPCALUAdder <= "11";
				end if;
			when "011" =>
				if(TOutput/='0')then
					SelectorOfPCALUAdder <= "01";
				else
					SelectorOfPCALUAdder <= "11";
				end if;
			when "110" =>
				if(SignalOfReadRegisterData1="0000000000000000")then
					SelectorOfPCALUAdder <= "01";
				else
					SelectorOfPCALUAdder <= "11";
				end if;
			when "111" =>
				if(SignalOfReadRegisterData1/="0000000000000000")then
					SelectorOfPCALUAdder <= "01";
				else
					SelectorOfPCALUAdder <= "11";
				end if;
			when "001" => SelectorOfPCALUAdder <= "01";
			when "100" => SelectorOfPCALUAdder <= "10";
			when "101" => SelectorOfPCALUAdder <= "11";
			when others => SelectorOfPCALUAdder <= "00";
		end case;
	end process;

end Behavioral;

