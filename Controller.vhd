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
		     ALUWriteEN : out STD_LOGIC;
           RegisterHeapEN : out  STD_LOGIC;
			  InstructionWriteEn : out STD_LOGIC;
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

shared variable Period: INTEGER RANGE 0 TO 15:= 0;
signal CLK_MAJOR: STD_LOGIC:='0';

begin

	process(Instruction)
	begin
		if(RUNNABLE='0')then
			Period:=1;
		elsif(CLK_MINOR'event and CLK_MINOR='1')then
			CLK_MAJOR <= not CLK_MAJOR;
			
			case Instruction(15 downto 11) is
				when "00000" => 								-- 28.A28.ADDSP3
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 5;
					elsif(Period = 5) then
						Period := 6;
					elsif(Period = 6) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
				when "00001" => 								-- 19.NOP
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
				when "00010" => 								-- 6.B
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
				when "00100" => 								-- 7.BEQZ
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
				when "00101" => 								-- 8.BNEZ
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
				when "00110" =>
					case Instruction(1 downto 0) is
						when "00" => 							-- 21.SLL
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 5;
							elsif(Period = 5) then
								Period := 6;
							elsif(Period = 6) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
							
							end if;
						when "11" => 							-- 22.SRA
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 5;
							elsif(Period = 5) then
								Period := 6;
							elsif(Period = 6) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
							
							end if;
						when others =>
					end case;
				when "01000" => 								-- 2.ADDIU3
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 5;
					elsif(Period = 5) then
						Period := 6;
					elsif(Period = 6) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
				when "01001" => 								-- 1.ADDIU
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 5;
					elsif(Period = 5) then
						Period := 6;
					elsif(Period = 6) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
						
				when "01100" =>
					case Instruction(10 downto 8) is
						when "011" => 							-- 3.ADDSP
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 5;
							elsif(Period = 5) then
								Period := 6;
							elsif(Period = 6) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
							
							end if;
						when "000" => 							-- 9.BTEQZ
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
							
							end if;
						when "100" => 							-- 18.MTSP
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
							
							end if;
						when others =>
					end case;
				when "01101" => 								-- 12.LI
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
					
				when "01110" => 								-- 29.CMPI
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
				when "01111" => 								-- 26.MOVE
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
				when "10010" => 								-- 14.LW_SP
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 5;
					elsif(Period = 5) then
						Period := 6;
					elsif(Period = 6) then
						Period := 7;
					elsif(Period = 7) then
						Period := 8;
					elsif(Period = 8) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
				when "10011" => 								-- 13.LW
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 5;
					elsif(Period = 5) then
						Period := 6;
					elsif(Period = 6) then
						Period := 7;
					elsif(Period = 7) then
						Period := 8;
					elsif(Period = 8) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
				when "11010" => 								-- 25.SW_SP
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 5;
					elsif(Period = 5) then
						Period := 6;
					elsif(Period = 6) then
						Period := 7;
					elsif(Period = 7) then
						Period := 8;
					elsif(Period = 8) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
				when "11011" => 								-- 24.SW
					if(Period = 1) then
						Period := 2;
					elsif(Period = 2) then
						Period := 3;
					elsif(Period = 3) then
						Period := 4;
					elsif(Period = 4) then
						Period := 5;
					elsif(Period = 5) then
						Period := 6;
					elsif(Period = 6) then
						Period := 7;
					elsif(Period = 7) then
						Period := 8;
					elsif(Period = 8) then
						Period := 9;
					elsif(Period = 9) then
						Period := 10;
					elsif(Period = 10) then
						Period := 1;
					else
					
					end if;
				when "11100" => 								
					case Instruction(1 downto 0) is
						when "01" =>							-- 4.ADDU
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 5;
							elsif(Period = 5) then
								Period := 6;
							elsif(Period = 6) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
							
							end if;
						when "11" =>							-- 23.SUBU
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 5;
							elsif(Period = 5) then
								Period := 6;
							elsif(Period = 6) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
							
							end if;
						when others =>
					end case;
				when "11101" =>
					case Instruction(4 downto 0) is
						when "01100" =>						-- 5.AND
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 5;
							elsif(Period = 5) then
								Period := 6;
							elsif(Period = 6) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
							
							end if;
						when "01010" =>						-- 10.CMP
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
							
							end if;
						when "00000" =>						
							case Instruction(7 downto 5) is
								when "000" =>					-- 11.JR
									if(Period = 1) then
										Period := 2;
									elsif(Period = 2) then
										Period := 3;
									elsif(Period = 3) then
										Period := 4;
									elsif(Period = 4) then
										Period := 9;
									elsif(Period = 9) then
										Period := 10;
									elsif(Period = 10) then
										Period := 1;
									else
									
									end if;
								when "010" =>					-- 16.MFPC
									if(Period = 1) then
										Period := 2;
									elsif(Period = 2) then
										Period := 3;
									elsif(Period = 3) then
										Period := 4;
									elsif(Period = 4) then
										Period := 9;
									elsif(Period = 9) then
										Period := 10;
									elsif(Period = 10) then
										Period := 1;
									else
									
									end if;
								when others =>
							end case;
						when "01101" =>						-- 20.OR
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 5;
							elsif(Period = 5) then
								Period := 6;
							elsif(Period = 6) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
							
							end if;
							
						when "00100" =>						-- 27.SLLV
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 5;
							elsif(Period = 5) then
								Period := 6;
							elsif(Period = 6) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
							
							end if;
						when "01011" =>						-- 30.NEG
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 5;
							elsif(Period = 5) then
								Period := 6;
							elsif(Period = 6) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
							
							end if;
						when others =>
					end case;
				when "11110" => 								
					case Instruction(7 downto 0) is
						when "00000000" =>					-- 15.MFIH
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
					
							end if;
						when "00000001" =>					-- 17.MTIH
							if(Period = 1) then
								Period := 2;
							elsif(Period = 2) then
								Period := 3;
							elsif(Period = 3) then
								Period := 4;
							elsif(Period = 4) then
								Period := 9;
							elsif(Period = 9) then
								Period := 10;
							elsif(Period = 10) then
								Period := 1;
							else
							
							end if;
						when others =>
					end case;
				when others =>
			end case;
			
		end if;
		
	end process;
	
	process(Instruction)
	begin
		if(Period = 2) then
			InstructionMemoryMode <= "11";
			
		elsif(Period = 3) then
			case Instruction(15 downto 11) is
				when "00000" => 								-- 28.ADDSP3
					SelectorOfWriteRegister <= "01";
					SelectorOfWriteRegisterData <= "100";
					SelectorOfALUParam1 <= "10";
					SelectorOfALUParam2 <= "11";
					SelectorOfImmediate <= "01";
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "101";
					ALUOperator <= "0001";
				when "00001" => 								-- 19.NOP
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "010";
				when "00010" => 								-- 6.B
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "100";
				when "00100" => 								-- 7.BEQZ
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "110";
				when "00101" => 								-- 8.BNEZ
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "111";
				when "00110" =>
					case Instruction(1 downto 0) is
						when "00" => 							-- 21.SLL
							SelectorOfWriteRegister <= "01";
							SelectorOfWriteRegisterData <= "100";
							SelectorOfALUParam1 <= "11";
							SelectorOfALUParam2 <= "10";
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "101";
							ALUOperator <= "0101";
						when "11" => 							-- 22.SRA
							SelectorOfWriteRegister <= "01";
							SelectorOfWriteRegisterData <= "100";
							SelectorOfALUParam1 <= "11";
							SelectorOfALUParam2 <= "10";
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "101";
							ALUOperator <= "0110";
						when others =>
					end case;
				when "01000" => 								-- 2.ADDIU3
					SelectorOfWriteRegister <= "10";
					SelectorOfWriteRegisterData <= "100";
					SelectorOfALUParam1 <= "01";
					SelectorOfALUParam2 <= "11";
					SelectorOfImmediate <= "10";
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "101";
					ALUOperator <= "0001";
				when "01001" => 								-- 1.ADDIU
					SelectorOfWriteRegister <= "01";
					SelectorOfWriteRegisterData <= "100";
					SelectorOfALUParam1 <= "01";
					SelectorOfALUParam2 <= "11";
					SelectorOfImmediate <= "01";
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "101";
					ALUOperator <= "0001";
				when "01100" =>
					case Instruction(10 downto 8) is
						when "011" => 							-- 3.ADDSP
							SelectorOfALUParam1 <= "10";
							SelectorOfALUParam2 <= "11";
							SelectorOfImmediate <= "01";
							SelectorOfSPInput <= "10";
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "101";
							ALUOperator <= "0001";
						when "000" => 							-- 9.BTEQZ
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "010";
						when "100" => 							-- 18.MTSP
							SelectorOfSPInput <= "01";
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "010";
						when others =>
					end case;
				when "01101" => 								-- 12.LI
					SelectorOfWriteRegister <= "01";
					SelectorOfWriteRegisterData <= "011";
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "101";
					
				when "01110" => 								-- 29.CMPI
					SelectorOfCMPParam <= "10";
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "101";
				when "01111" => 								-- 26.MOVE
					SelectorOfWriteRegister <= "01";
					SelectorOfWriteRegisterData <= "010";
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "101";
				when "10010" => 								-- 14.LW_SP
					SelectorOfWriteRegister <= "01";
					SelectorOfWriteRegisterData <= "101";
					SelectorOfALUParam1 <= "10";
					SelectorOfALUParam2 <= "11";
					SelectorOfImmediate <= "01";
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "101";
					ALUOperator <= "0001";
				when "10011" => 								-- 13.LW
					SelectorOfWriteRegister <= "10";
					SelectorOfWriteRegisterData <= "101";
					SelectorOfALUParam1 <= "01";
					SelectorOfALUParam2 <= "01";
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "101";
					ALUOperator <= "0001";
				when "11010" => 								-- 25.SW_SP
					SelectorOfALUParam1 <= "10";
					SelectorOfALUParam2 <= "11";
					SelectorOfImmediate <= "01";
					SelectorOfDataMemoryWriteData <= "10";
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "101";
					ALUOperator <= "0001";
				when "11011" => 								-- 24.SW
					SelectorOfALUParam1 <= "01";
					SelectorOfALUParam2 <= "01";
					SelectorOfDataMemoryWriteData <= "01";
					SelectorOfPCBJ <= "01";
					SelectorOfPCALUOp <= "101";
					ALUOperator <= "0001";
				when "11100" => 								
					case Instruction(1 downto 0) is
						when "01" =>							-- 4.ADDU
							SelectorOfWriteRegister <= "11";
							SelectorOfWriteRegisterData <= "100";
							SelectorOfALUParam1 <= "01";
							SelectorOfALUParam2 <= "10";
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "101";
							ALUOperator <= "0001";
						when "11" =>							-- 23.SUBU
							SelectorOfWriteRegister <= "11";
							SelectorOfWriteRegisterData <= "100";
							SelectorOfALUParam1 <= "01";
							SelectorOfALUParam2 <= "10";
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "101";
							ALUOperator <= "0010";
						when others =>
					end case;
				when "11101" =>
					case Instruction(4 downto 0) is
						when "01100" =>						-- 5.AND
							SelectorOfWriteRegister <= "01";
							SelectorOfWriteRegisterData <= "100";
							SelectorOfALUParam1 <= "01";
							SelectorOfALUParam2 <= "10";
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "101";
							ALUOperator <= "0011";
						when "01010" =>						-- 10.CMP
							SelectorOfCMPParam <= "01";
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "101";
						when "00000" =>						
							case Instruction(7 downto 5) is
								when "000" =>					-- 11.JR
									SelectorOfPCBJ <= "10";
								when "010" =>					-- 16.MFPC
									SelectorOfWriteRegister <= "01";
									SelectorOfWriteRegisterData <= "001";
									SelectorOfPCBJ <= "01";
									SelectorOfPCALUOp <= "101";
								when others =>
							end case;
						when "01101" =>						-- 20.OR
							SelectorOfWriteRegister <= "01";
							SelectorOfWriteRegisterData <= "100";
							SelectorOfALUParam1 <= "01";
							SelectorOfALUParam2 <= "10";
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "101";
							ALUOperator <= "0100";
						when "00100" =>						-- 27.SLLV
							SelectorOfWriteRegister <= "10";
							SelectorOfWriteRegisterData <= "100";
							SelectorOfALUParam1 <= "01";
							SelectorOfALUParam2 <= "10";
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "101";
							ALUOperator <= "0101";
						when "01011" =>						-- 30.NEG
							SelectorOfWriteRegister <= "01";
							SelectorOfWriteRegisterData <= "100";
							SelectorOfALUParam2 <= "10";
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "101";
							ALUOperator <= "0111";
						when others =>
					end case;
				when "11110" => 								
					case Instruction(7 downto 0) is
						when "00000000" =>					-- 15.MFIH
							SelectorOfWriteRegister <= "01";
							SelectorOfWriteRegisterData <= "110";
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "101";
						when "00000001" =>					-- 17.MTIH
							SelectorOfPCBJ <= "01";
							SelectorOfPCALUOp <= "101";
						when others =>
					end case;
				when others =>
			end case;
		
		elsif(Period = 5) then
			ALUWriteEN <= '0';
			
		elsif(Period = 6) then
			ALUWriteEN <= '1';
			case Instruction(15 downto 11) is
				when "10010" => 								-- 14.LW_SP
					DataMemoryMode <= "01";
				when "10011" => 								-- 13.LW
					DataMemoryMode <= "01";
				when "11010" => 								-- 25.SW_SP
					DataMemoryMode <= "10";
				when "11011" => 								-- 24.SW
					DataMemoryMode <= "10";
				
				when others =>
			end case;
		
		elsif(Period = 8) then
			DataMemoryMode <="11";
		
		elsif(Period = 9) then
			RegisterHeapEN <= '0';
		
		elsif(Period = 10) then
			RegisterHeapEN <= '1';
			InstructionMemoryMode <= "01";
		
		else
		
		end if;
		
		
	end process;
	
	
	process(CLK_MAJOR)
	begin
		
	end process;

end Behavioral;

