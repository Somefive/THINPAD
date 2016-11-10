----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:34:36 11/10/2016 
-- Design Name: 
-- Module Name:    CPU - Behavioral 
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

entity CPU is
    Port ( FLASH_A : out  STD_LOGIC_VECTOR (22 downto 0);
           FLASH_D : inout  STD_LOGIC_VECTOR (15 downto 0);
           SW_DIP : in  STD_LOGIC_VECTOR (15 downto 0);
           VGA_B : out  STD_LOGIC_VECTOR (2 downto 0);
           VGA_G : out  STD_LOGIC_VECTOR (2 downto 0);
           VGA_R : out  STD_LOGIC_VECTOR (2 downto 0);
           VGA_HHYNC : out  STD_LOGIC;
           VGA_VHYNC : out  STD_LOGIC;
           PS2KB_CLOCK : out  STD_LOGIC;
           PS2KB_DATA : in  STD_LOGIC;
           RAM1DATA : inout  STD_LOGIC_VECTOR (15 downto 0);
           RAM2DATA : inout  STD_LOGIC_VECTOR (15 downto 0);
           RAM1ADDR : out  STD_LOGIC_VECTOR (17 downto 0);
           RAM2ADDR : out  STD_LOGIC_VECTOR (17 downto 0);
           FLASH_BYTE : out  STD_LOGIC;
           FLASH_CE : out  STD_LOGIC;
           FLASH_CE1 : out  STD_LOGIC;
           FLASH_CE2 : out  STD_LOGIC;
           FLASH_OE : out  STD_LOGIC;
           FLASH_RP : out  STD_LOGIC;
           FLASH_STS : out  STD_LOGIC;
           FLASH_VPEN : out  STD_LOGIC;
           FLASH_WE : out  STD_LOGIC;
           U_RXD : out  STD_LOGIC;
           U_TXD : out  STD_LOGIC;
           RAM1_EN : out  STD_LOGIC;
           RAM1_OE : out  STD_LOGIC;
           RAM1_RW : out  STD_LOGIC;
           RAM2_EN : out  STD_LOGIC;
           RAM2_OE : out  STD_LOGIC;
           RAM2_RW : out  STD_LOGIC;
           FPGA_LED : out  STD_LOGIC_VECTOR (15 downto 0);
			  DYP0 : out  STD_LOGIC_VECTOR (6 downto 0);
           DYP1 : out  STD_LOGIC_VECTOR (6 downto 0);
           CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC);
end CPU;

architecture Behavioral of CPU is

--components

component DigitLights is
    Port ( L : out  STD_LOGIC_VECTOR (6 downto 0);
           NUMBER : in  INTEGER);
end component;

component SelectorWriteRegister is
    Port ( rx : in  STD_LOGIC_VECTOR (2 downto 0);
           ry : in  STD_LOGIC_VECTOR (2 downto 0);
           rz : in  STD_LOGIC_VECTOR (2 downto 0);
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
           output : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component SelectorWriteRegisterData is
    Port ( PC : in  STD_LOGIC_VECTOR (15 downto 0);
           RegistersReadData2 : in  STD_LOGIC_VECTOR (15 downto 0);
           Instruction7to0 : in  STD_LOGIC_VECTOR (7 downto 0);
           ALUResult : in  STD_LOGIC_VECTOR (15 downto 0);
           DataMemoryReadData : in  STD_LOGIC_VECTOR (15 downto 0);
           IH : in  STD_LOGIC_VECTOR (15 downto 0);
           selector : in  STD_LOGIC_VECTOR (2 downto 0);
			  WriteRegisterData : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component RegistersHeap is
    Port ( ReadRegister1 : in  STD_LOGIC_VECTOR (2 downto 0);
           ReadRegister2 : in  STD_LOGIC_VECTOR (2 downto 0);
           WriteRegister : in  STD_LOGIC_VECTOR (2 downto 0);
           WriteData : in  STD_LOGIC_VECTOR (15 downto 0);
           ReadData1 : out  STD_LOGIC_VECTOR (15 downto 0);
           ReadData2 : out  STD_LOGIC_VECTOR (15 downto 0);
           WriteEN : in  STD_LOGIC);
end component;

component ALU is
    Port ( OperandA : in  STD_LOGIC_VECTOR (15 downto 0);
           OperandB : in  STD_LOGIC_VECTOR (15 downto 0);
           ALUOp : in  STD_LOGIC_VECTOR (3 downto 0);
           Result : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component SelectorALUParam1 is
    Port ( ReadRegisterData1 : in  STD_LOGIC_VECTOR (15 downto 0);
           SP : in  STD_LOGIC_VECTOR (15 downto 0);
           Instruction4to2ShiftResult : in  STD_LOGIC_VECTOR (15 downto 0);
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
           ALUOperandA : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component SelectorALUParam2 is
    Port ( Instruction4to0 : in  STD_LOGIC_VECTOR (4 downto 0);
           ReadRegisterData2 : in  STD_LOGIC_VECTOR (15 downto 0);
           SelectedImmediate : in  STD_LOGIC_VECTOR (15 downto 0);
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
           ALUOperandB : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component SelectorShiftParam is
    Port ( Instruction4to2 : in  STD_LOGIC_VECTOR (2 downto 0);
           Instruction4to2ShiftResult : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

-- Control Signals
signal SelectorOfWriteRegister: STD_LOGIC_VECTOR (1 downto 0):="00";
signal SelectorOfWriteRegisterData: STD_LOGIC_VECTOR (2 downto 0):="000";
signal RegisterHeapEN: STD_LOGIC:='1';
signal SelectorOfALUParam1: STD_LOGIC_VECTOR (1 downto 0):="00";
signal SelectorOfALUParam2: STD_LOGIC_VECTOR (1 downto 0):="00";

-- RegisterHeap Signals
signal SignalOfWriteRegister: STD_LOGIC_VECTOR (2 downto 0);
signal SignalOfWriteRegisterData: STD_LOGIC_VECTOR (15 downto 0);
signal SignalOfReadRegisterData1: STD_LOGIC_VECTOR (15 downto 0);
signal SignalOfReadRegisterData2: STD_LOGIC_VECTOR (15 downto 0);

-- ALU Signals
signal ALUResult: STD_LOGIC_VECTOR (15 downto 0);
signal ALUOperandA: STD_LOGIC_VECTOR (15 downto 0);
signal ALUOperandB: STD_LOGIC_VECTOR (15 downto 0);
signal ALUOperator: STD_LOGIC_VECTOR (3 downto 0);

-- DataMemory Signals
signal DataMemoryWriteData: STD_LOGIC_VECTOR (15 downto 0);
signal DataMemoryReadData: STD_LOGIC_VECTOR (15 downto 0);

-- Single Registers
signal PC: STD_LOGIC_VECTOR (15 downto 0);
signal IH: STD_LOGIC_VECTOR (15 downto 0);
signal SP: STD_LOGIC_VECTOR (15 downto 0);

-- Between Selectors
signal Instruction4to2ShiftResult: STD_LOGIC_VECTOR (15 downto 0);
signal SelectedImmediate: STD_LOGIC_VECTOR (15 downto 0);


signal Instruction: STD_LOGIC_VECTOR (15 downto 0);


type PERIOD is(PERIOD_IF,PERIOD_ID,PERIOD_EXE,PERIOD_MEM,PERIOD_WB);
signal STEP: PERIOD:=PERIOD_IF;
signal STEP_NUMBER: INTEGER RANGE 0 TO 4;




begin
	STEP<=PERIOD_IF;
	FLASH_A<="00000000000000000000000";
   FLASH_D<="0000000000000000";
	VGA_B<="000";
   VGA_G<="000";
   VGA_R<="000";
   VGA_HHYNC<='1';
   VGA_VHYNC<='1';
   PS2KB_CLOCK<='1';
   RAM1DATA<="0000000000000000";
   RAM2DATA<="0000000000000000";
   RAM1ADDR<="000000000000000000";
   RAM2ADDR<="000000000000000000";
   FLASH_BYTE<='1';
   FLASH_CE<='1';
   FLASH_CE1<='1';
   FLASH_CE2<='1';
   FLASH_OE<='1';
   FLASH_RP<='1';
   FLASH_STS<='1';
   FLASH_VPEN<='1';
   FLASH_WE<='1';
   U_RXD<='1';
   U_TXD<='1';
   RAM1_EN<='1';
   RAM1_OE<='1';
   RAM1_RW<='1';
   RAM2_EN<='1';
   RAM2_OE<='1';
   RAM2_RW<='1';
   DYP1(6 downto 3)<="1111";
	DYP1(0)<=PS2KB_DATA;
	DYP1(1)<=CLK;
	DYP1(2)<=RESET;
	FPGA_LED<=SW_DIP;
	
	-- Instruction Debug Mode
	Instruction <= SW_DIP;
	
	with STEP select STEP_NUMBER <=
		0 when PERIOD_IF,
		1 when PERIOD_ID,
		2 when PERIOD_EXE,
		3 when PERIOD_MEM,
		4 when PERIOD_WB;
	
   -- Modules
	L1: DigitLights port map(DYP0,STEP_NUMBER);
	
	RegisterHeap_Entity: RegistersHeap port map ( 
	        Instruction(10 downto 8),
           Instruction(7 downto 5),
           SignalOfWriteRegister,
           SignalOfWriteRegisterData,
           SignalOfReadRegisterData1,
           SignalOfReadRegisterData2,
			  RegisterHeapEN);
   SelectorWriteRegister_Entity: SelectorWriteRegister port map (
           Instruction(10 downto 8),
           Instruction(7 downto 5),
           Instruction(4 downto 2),
           SelectorOfWriteRegister,
           SignalOfWriteRegister);
	SelectorWriteRegisterData_Entity: SelectorWriteRegisterData port map ( 
	        PC,
           SignalOfReadRegisterData2,
           Instruction(7 downto 0),
           ALUResult,
           DataMemoryReadData,
           IH,
           SelectorOfWriteRegisterData,
			  SignalOfWriteRegisterData);
	ALU_Entity: ALU port map (
	        ALUOperandA,
           ALUOperandB,
           ALUOperator,
           ALUResult);
	SelectorALUParam1_Entity: SelectorALUParam1 port map ( 
	        SignalOfReadRegisterData1,
           SP,
           Instruction4to2ShiftResult,
           SelectorOfALUParam1,
           ALUOperandA);
	SelectorALUParam2_Entity: SelectorALUParam2 port map ( 
	        Instruction(4 downto 0),
           SignalOfReadRegisterData2,
           SelectedImmediate,
           SelectorOfALUParam2,
           ALUOperandB);
	SelectorShiftParam_Entity: SelectorShiftParam port map ( 
	        Instruction(4 downto 2),
           Instruction4to2ShiftResult);
end Behavioral;

