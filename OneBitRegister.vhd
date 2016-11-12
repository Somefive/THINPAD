----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:51:20 11/11/2016 
-- Design Name: 
-- Module Name:    OneBitRegister - Behavioral 
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

entity OneBitRegister is
    Port ( Input : in  STD_LOGIC;
           Output : out  STD_LOGIC;
           WriteEN : in  STD_LOGIC);
end OneBitRegister;

architecture Behavioral of OneBitRegister is

begin

	process(WriteEN,Input)
	begin
		if(WriteEN='1')then
			Output <= Input;
		end if;
	end process;

end Behavioral;

