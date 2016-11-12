----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:15:15 11/11/2016 
-- Design Name: 
-- Module Name:    DataMemory - Behavioral 
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

entity DataMemory is
    Port ( Address : in  STD_LOGIC_VECTOR (15 downto 0);
           WriteData : in  STD_LOGIC_VECTOR (15 downto 0);
           ReadData : out  STD_LOGIC_VECTOR (15 downto 0);
           ADDR : out  STD_LOGIC_VECTOR (17 downto 0);
           DATA : inout  STD_LOGIC_VECTOR (15 downto 0);
           EN : out  STD_LOGIC;
           OE : out  STD_LOGIC;
           WE : out  STD_LOGIC;
           CLK : in  STD_LOGIC;
           MODE : in  STD_LOGIC_VECTOR (1 downto 0)); --"00" Disabled; "01" Read; "10" Write; "11" Enabled;
end DataMemory;

architecture Behavioral of DataMemory is
signal Reading: STD_LOGIC:='1';
signal Writing: STD_LOGIC:='1';
begin

	process(CLK,MODE)
	begin
		if(MODE="00")then
			EN<='1';
			OE<='1';
			WE<='1';
			Reading<='1';
			Writing<='1';
		elsif(CLK'event and CLK='1')then
			EN<='0';
			if(Reading='0')then
				ReadData<=DATA;
				Reading<='1';
				OE<='1';
			elsif(Writing='0')then
				WE<='1';
				Writing<='1';
			elsif(MODE="01")then
				WE<='1';
				OE<='0';
				ADDR<="00"&Address;
				DATA<="ZZZZZZZZZZZZZZZZ";
				Reading<='0';
			elsif(MODE="10")then
				WE<='0';
				OE<='1';
				ADDR<="00"&Address;
				DATA<=WriteData;
				Writing<='0';
			else
				WE<='1';
				OE<='1';
				Reading<='1';
				Writing<='1';
			end if;
		end if;
	end process;

end Behavioral;

