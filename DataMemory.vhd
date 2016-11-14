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
			  DATA_READY : in  STD_LOGIC;
           RDN : out  STD_LOGIC;
           TBRE : in  STD_LOGIC;
           TSRE : in  STD_LOGIC;
           WRN : out  STD_LOGIC;
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
			WRN<='1';
			RDN<='1';
		elsif(CLK'event and CLK='1')then
			if(Reading='0')then
				if(Address="1011111100000000")then
					ReadData<="00000000"&DATA(7 downto 0);
				elsif(Address="1011111100000001")then
					ReadData<="000000000000000"&DATA_READY;
				else
					ReadData<=DATA;
				end if;
				EN<='1';
				OE<='1';
				WE<='1';
				RDN<='1';
				WRN<='1';
				Reading<='1';
			elsif(Writing='0')then
				EN<='1';
				OE<='1';
				WE<='1';
				RDN<='1';
				WRN<='1';
				Writing<='1';
			elsif(MODE="01")then
				Reading<='0';
				DATA<="ZZZZZZZZZZZZZZZZ";
				WE<='1';
				WRN<='1';
				ADDR<="00"&Address;
				if(Address(15 downto 1)="101111110000000")then
					EN<='1';
					OE<='1';
					RDN<='0';
				else
					EN<='0';
					OE<='0';
					RDN<='1';
				end if;
			elsif(MODE="10")then
				RDN<='1';
				OE<='1';
				Writing<='0';
				if(Address="1011111100000000")then
					DATA<="00000000"&WriteData(7 downto 0);
					EN<='1';
					WE<='1';
					WRN<='0';
				elsif(Address="1011111100000001")then
					DATA<="000000000000000"&DATA_READY;
					EN<='1';
					WE<='1';
					WRN<='0';
				else
					ADDR<="00"&Address;
					DATA<=WriteData;
					EN<='0';
					WE<='0';
					WRN<='1';
				end if;
			else
				WE<='1';
				OE<='1';
				EN<='1';
				WRN<='1';
				RDN<='1';
				Reading<='1';
				Writing<='1';
			end if;
		end if;
	end process;

end Behavioral;

