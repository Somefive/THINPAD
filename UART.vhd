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

component DigitLights is
    Port ( L : out  STD_LOGIC_VECTOR (6 downto 0);
           NUMBER : in  INTEGER);
end component;

signal st: INTEGER RANGE 0 TO 15:=0;
signal self_en: STD_LOGIC;
signal to_write: std_logic_vector (15 downto 0);
begin
	--DL: DigitLights port map (DYP,st);
	
	with Address select self_en <=
		'1' when "1011111100000000",
		'1' when "1011111100000001",
		'0' when others;
	
	with MODE select to_write <=
		WriteData when "10",
		"ZZZZZZZZZZZZZZZZ" when others;
	
	process(CLK,MODE)
	begin
		if(self_en='0')then
			WRN<='1';
			RDN<='1';
			st<=0;
			FINISH<='0';
		elsif(CLK'event and CLK='1')then
			if(MODE="00" or MODE="11")then
				WRN<='1';
				RDN<='1';
				st<=0;
				FINISH<='0';
			else
				case st is
					when 0 =>
						DATA<=to_write;
						if(MODE="01")then
							RDN<='1';
							st<=1;
						elsif(MODE="10")then
							WRN<='0';
							st<=2;
						end if;
					when 1 =>
						if(DATA_READY='0')then
							RDN<='1';
							DATA<="ZZZZZZZZZZZZZZZZ";
						elsif(DATA_READY='1')then
							RDN<='0';
							st<=4;
						end if;
					when 2 =>
						WRN<='1';
						if(TBRE='1')then
							st<=3;
						end if;
					when 3 =>
						if(TSRE='1')then
							st<=5;
						end if;
					when 4 =>
						ReadData<="00000000"&DATA(7 downto 0);
						RDN<='1';
						st<=5;
					when 5 =>
						FINISH<='1';
					when others =>
				end case;
			end if;
		end if;
	end process;

	WE<='1';
	OE<='1';
	EN<='1';
end Behavioral;

