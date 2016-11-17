----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:10:12 11/17/2016 
-- Design Name: 
-- Module Name:    UART - Behavioral 
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

entity UART is
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
           MODE : in  STD_LOGIC_VECTOR (1 downto 0); --"00" Disabled; "01" Read; "10" Write; "11" Enabled;
			  FINISH: out STD_LOGIC);
end UART;

architecture Behavioral of UART is
shared variable st: INTEGER RANGE 0 TO 15:=0;
begin
	process(CLK,MODE)
	begin
		if(MODE="00")then
			WRN<='1';
			RDN<='1';
			st:=0;
		elsif(CLK'event and CLK='1')then
			case st is
				when 0 =>
					if(MODE="01")then --Read
						DATA<="ZZZZZZZZZZZZZZZZ";
						WRN<='1';
						RDN<='0';
						FINISH<='0';
						st:=1;
					elsif(MODE="10")then --Writing
						RDN<='1';
						WRN<='0';
						FINISH<='0';
						if(Address="1011111100000000")then
							DATA<="00000000"&WriteData(7 downto 0);
						elsif(Address="1011111100000001")then
							DATA<="000000000000000"&DATA_READY;
						else
							DATA<=WriteData;
						end if;
						st:=2;
					else
						WRN<='1';
						RDN<='1';
						Finish<='1';
					end if;
				
				when 1 =>
					if(DATA_READY='0')then
						st:=0;
					elsif(DATA_READY='1')then
						ReadData<="00000000"&DATA(7 downto 0);
						RDN<='1';
						WRN<='1';
						FINISH<='0';
						st:=4;
					end if;
			
				when 2 =>
					WRN<='1';
					RDN<='1';
					if(TBRE='1')then
						st:=3;
					end if;
				when 3 =>
					if(TSRE='1')then
						st:=4;
					end if;
					FINISH<='0';
					
				when others =>
			end case;
		end if;
	end process;

	WE<='1';
	OE<='1';
	EN<='1';
end Behavioral;

