----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:17:26 11/11/2016 
-- Design Name: 
-- Module Name:    InstructionMemory - Behavioral 
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

entity InstructionMemory is
    Port ( ReadAddress : in STD_LOGIC_VECTOR (15 downto 0);
	        Instruction : out STD_LOGIC_VECTOR (15 downto 0);
           ADDR : out  STD_LOGIC_VECTOR (17 downto 0);
           DATA : inout  STD_LOGIC_VECTOR (15 downto 0);
           EN : out  STD_LOGIC;
			  OE : out  STD_LOGIC;
           WE : out  STD_LOGIC;
           CLK : in  STD_LOGIC;
           BOOT : in  STD_LOGIC;
           MODE : in  STD_LOGIC_VECTOR (1 downto 0)); --"00" Disabled; "01" Read; "10" Write; "11" Enabled;
end InstructionMemory;

architecture Behavioral of InstructionMemory is
shared variable step: INTEGER RANGE 0 TO 63:=0;
signal RUNNABLE: STD_LOGIC:='1';
signal Reading: STD_LOGIC:='1';
signal Writing: STD_LOGIC:='1';
begin
	EN<='0';
	process(CLK,BOOT,MODE)
	begin
		if(CLK'event and CLK='1')then
			if(BOOT='0')then
				case step is
					when 0=>
						OE<='1';
						WE<='0';
						ADDR<="000000000000000000";
						DATA<= "01101"&"000"&"00000100"; -- LI R0 0x04
						step:=1;
					when 1=>
						WE<='1';
						ADDR<="000000000000000001";
						step:=2;
					when 2=>
						WE<='0';
						DATA<="01101"&"001"&"00000110"; -- LI R1 0x06
						step:=3;
					when 3=>
						WE<='1';
						ADDR<="000000000000000010";
						step:=4;
					when 4=>
						WE<='0';
						DATA<="11100"&"000"&"001"&"010"&"01"; -- ADDU R0 R1 R2
						step:=5;
					when 5=>
						WE<='1';
						ADDR<="000000000000000011";
						step:=6;
					when 6=>
						WE<='0';
						DATA<="1111111111111111"; -- HALT
						step:=7;
					when others=>
						WE<='1';
						RUNNABLE<='0';
				end case;
			elsif(RUNNABLE='0')then
				if(Reading='0')then
					Instruction<=DATA;
					Reading<='1';
					OE<='1';
				elsif(MODE="01")then
					WE<='1';
					OE<='0';
					ADDR<="00"&ReadAddress;
					DATA<="ZZZZZZZZZZZZZZZZ";
					Reading<='0';
				else
					WE<='1';
					OE<='1';
					Reading<='1';
				end if;
			end if;
		end if;
	end process;
	
end Behavioral;

