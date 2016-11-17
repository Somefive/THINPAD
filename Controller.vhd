----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:12:25 11/11/2016 
-- Design Name: 
-- Module Name:    Controller - Behavioral 
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

entity Controller is
    Port ( Instruction : in  STD_LOGIC_VECTOR (15 downto 0);
			  CLK_MINOR: in STD_LOGIC;
           PCWriteEN : out  STD_LOGIC;
           SPWriteEN : out  STD_LOGIC;
           IHWriteEN : out  STD_LOGIC;
           TWriteEN : out  STD_LOGIC;
           RegisterHeapEN : out  STD_LOGIC;
           InstructionMemoryMode : out  STD_LOGIC_VECTOR (1 downto 0);
           DataMemoryMode : out  STD_LOGIC_VECTOR (1 downto 0);
           ALUOperator : out  STD_LOGIC_VECTOR (3 downto 0);
           SelectorOfWriteRegister : out  STD_LOGIC_VECTOR (1 downto 0);
           SelectorOfWriteRegisterData : out  STD_LOGIC_VECTOR (2 downto 0);
           SelectorOfALUParam1 : out  STD_LOGIC_VECTOR (1 downto 0);
           SelectorOfALUParam2 : out  STD_LOGIC_VECTOR (1 downto 0);
           SelectorOfImmediate : out  STD_LOGIC_VECTOR (1 downto 0);
           SelectorOfSPInput : out  STD_LOGIC_VECTOR (1 downto 0);
           SelectorOfDataMemoryWriteData : out  STD_LOGIC_VECTOR (1 downto 0);
           SelectorOfCMPParam : out  STD_LOGIC_VECTOR (1 downto 0);
           SelectorOfPCBJ : out  STD_LOGIC_VECTOR (1 downto 0);
           SelectorOfPCALUOp : out  STD_LOGIC_VECTOR (2 downto 0);
			  RUNNABLE: in STD_LOGIC);
end Controller;

architecture Behavioral of Controller is

shared variable Period: INTEGER RANGE 0 TO 15:=0;
signal CLK_MAJOR: STD_LOGIC:='0';

begin

	process(Instruction,Period)
	begin
		if(RUNNABLE='0')then
			Period:=0;
		elsif(CLK_MINOR'event and CLK_MINOR='1')then
			CLK_MAJOR <= not CLK_MAJOR;
			
			case Instruction(15 downto 11) is
				when "00000" => 								-- 28.ADDSP3
				when "00001" => 								-- 19.NOP
				when "00010" => 								-- 6.B
				when "00100" => 								-- 7.BEQZ
				when "00101" => 								-- 8.BNEZ
				when "00110" =>
					case Instruction(1 downto 0) is
						when "00" => 							-- 21.SLL
						when "11" => 							-- 22.SRA
						when others =>
					end case;
				when "01000" => 								-- 2.ADDIU3
				when "01001" => 								-- 1.ADDIU
					
				when "01100" =>
					case Instruction(10 downto 8) is
						when "011" => 							-- 3.ADDSP
						when "000" => 							-- 9.BTEQZ
						when "100" => 							-- 18.MTSP
						when others =>
					end case;
				when "01101" => 								-- 12.LI
				when "01110" => 								-- 29.CMPI
				when "01111" => 								-- 26.MOVE
				when "10010" => 								-- 14.LW_SP
				when "10011" => 								-- 13.LW
				when "11010" => 								-- 25.SW_SP
				when "11011" => 								-- 24.SW
				when "11100" => 								
					case Instruction(1 downto 0) is
						when "01" =>							-- 4.ADDU
						when "11" =>							-- 23.SUBU
						when others =>
					end case;
				when "11101" =>
					case Instruction(4 downto 0) is
						when "01100" =>						-- 5.AND
						when "01010" =>						-- 10.CMP
						when "00000" =>						
							case Instruction(7 downto 5) is
								when "000" =>					-- 11.JR
								when "010" =>					-- 16.MFPC
								when others =>
							end case;
						when "01101" =>						-- 20.OR
						when "00100" =>						-- 27.SLLV
						when "01011" =>						-- 30.NEG
						when others =>
					end case;
				when "11110" => 								
					case Instruction(7 downto 0) is
						when "00000000" =>					-- 15.MFIH
						when "00000001" =>					-- 17.MTIH
						when others =>
					end case;
				when others =>
			end case;
			
		end if;
		
	end process;

	
	process(CLK_MAJOR)
	begin
		
	end process;

end Behavioral;

