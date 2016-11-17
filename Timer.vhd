----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:36:37 11/10/2016 
-- Design Name: 
-- Module Name:    Timer - Behavioral 
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

-- ·ÖÊ±Æ÷
entity Timer is
    Port ( CLK_INPUT : in STD_LOGIC;
			  CLK_MINOR : out STD_LOGIC);
end Timer;

architecture Behavioral of Timer is

signal CLK_MINOR_CURRENT: STD_LOGIC:='0'; 
shared variable count: INTEGER RANGE 0 TO 64:= 0;

begin
	
	CLK_MINOR <= CLK_MINOR_CURRENT;
	
	process(CLK_INPUT)
	begin
		if(CLK_INPUT'event and CLK_INPUT='1')then
			if(count=1)then
				CLK_MINOR_CURRENT<=not CLK_MINOR_CURRENT;
				count:=0;
			else
				count:=count+1;
			end if;
		end if;
	end process;

end Behavioral;

