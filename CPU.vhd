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
use IEEE.std_logic_signed.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

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
			  DATA_READY : in  STD_LOGIC;
           RDN : out  STD_LOGIC;
           TBRE : in  STD_LOGIC;
           TSRE : in  STD_LOGIC;
           WRN : out  STD_LOGIC;
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
			  UARTReadData : in STD_LOGIC_VECTOR (15 downto 0);
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

component PCALU is
    Port ( Adder : in  STD_LOGIC_VECTOR (15 downto 0);
           PC : in  STD_LOGIC_VECTOR (15 downto 0);
           Result : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component Comparator is
    Port ( First : in  STD_LOGIC_VECTOR (15 downto 0);
           Second : in  STD_LOGIC_VECTOR (15 downto 0);
           Result : out  STD_LOGIC);
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

component SelectorImmediate is
    Port ( Instruction7to0 : in  STD_LOGIC_VECTOR (7 downto 0);
           Instruction3to0 : in  STD_LOGIC_VECTOR (3 downto 0);
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
           SelectedImmediate : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component SelectorSPInput is
    Port ( ReadRegisterData1 : in  STD_LOGIC_VECTOR (15 downto 0);
           ALUResult : in  STD_LOGIC_VECTOR (15 downto 0);
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
           SPInput : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component SelectorDataMemoryWriteData is
    Port ( SignalOfReadRegisterData2 : in  STD_LOGIC_VECTOR (15 downto 0);
           SignalOfReadRegisterData1 : in  STD_LOGIC_VECTOR (15 downto 0);
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
           DataMemoryWriteData : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component SelectorCMPParam is
    Port ( SignalOfReadRegisterData2 : in  STD_LOGIC_VECTOR (15 downto 0);
           Instruction7to0 : in  STD_LOGIC_VECTOR (7 downto 0);
           SelectorOfCMPParam : in  STD_LOGIC_VECTOR (1 downto 0);
           ComparatorParam2 : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component SelectorPCBJ is
    Port ( PCALUResult : in  STD_LOGIC_VECTOR (15 downto 0);
           SignalOfReadRegisterData1 : in  STD_LOGIC_VECTOR (15 downto 0);
           SelectorOfPCBJ : in  STD_LOGIC_VECTOR (1 downto 0);
           PCInput : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component SelectorPCALUAdder is
    Port ( Instruction7to0 : in  STD_LOGIC_VECTOR (7 downto 0);
           Instruction10to0 : in  STD_LOGIC_VECTOR (10 downto 0);
           SelectorOfPCALUAdder : in  STD_LOGIC_VECTOR (1 downto 0);
           PCALUAdder : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component SingleRegister is
    Port ( Input : in  STD_LOGIC_VECTOR (15 downto 0);
           Output : out  STD_LOGIC_VECTOR (15 downto 0);
           WriteEN : in  STD_LOGIC);
end component;

component OneBitRegister is
    Port ( Input : in  STD_LOGIC;
           Output : out  STD_LOGIC;
           WriteEN : in  STD_LOGIC);
end component;

component SelectorPCALUOp is
    Port ( TOutput : in  STD_LOGIC;
           SignalOfReadRegisterData1 : in  STD_LOGIC_VECTOR (15 downto 0);
           SelectorOfPCALUOp : in  STD_LOGIC_VECTOR (2 downto 0);
           SelectorOfPCALUAdder : out  STD_LOGIC_VECTOR (1 downto 0));
end component;

component SelectorMemoryAddress is
	Port ( ALUResult : in  STD_LOGIC_VECTOR (15 downto 0);
           PCOutput : in  STD_LOGIC_VECTOR (15 downto 0);
           selector : in  STD_LOGIC_VECTOR (1 downto 0);
           SelectedMemoryAddress : out  STD_LOGIC_VECTOR (15 downto 0));
end component;
			
			 

component InstructionMemory is
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
end component;

component DataMemory is
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
end component;

component Memory is
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
end component;

component UART is
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
end component;

component Controller is
    Port ( Instruction : in  STD_LOGIC_VECTOR (15 downto 0);
           PCWriteEN : out  STD_LOGIC;
           SPWriteEN : out  STD_LOGIC;
           IHWriteEN : out  STD_LOGIC;
           TWriteEN : out  STD_LOGIC;
           RegisterHeapEN : out  STD_LOGIC;
			  InstructionWriteEn : out STD_LOGIC;--InstructionWritenEN
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
           SelectorOfPCALUOp : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

-- Control Signals
signal SelectorOfWriteRegister: STD_LOGIC_VECTOR (1 downto 0):="00";
signal SelectorOfWriteRegisterData: STD_LOGIC_VECTOR (2 downto 0):="000";
signal RegisterHeapEN: STD_LOGIC:='1';

signal SelectorOfALUParam1: STD_LOGIC_VECTOR (1 downto 0):="00";
signal SelectorOfALUParam2: STD_LOGIC_VECTOR (1 downto 0):="00";
signal SelectorOfImmediate: STD_LOGIC_VECTOR (1 downto 0):="00";
signal SelectorOfSPInput: STD_LOGIC_VECTOR (1 downto 0):="00";
signal SelectorOfDataMemoryWriteData: STD_LOGIC_VECTOR (1 downto 0):="00";
signal SelectorOfCMPParam: STD_LOGIC_VECTOR (1 downto 0):="00";
signal SelectorOfPCBJ: STD_LOGIC_VECTOR (1 downto 0):="00";
signal SelectorOfPCALUOp: STD_LOGIC_VECTOR (2 downto 0):="000";


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

-- PCALU Signals
signal PCALUAdder: STD_LOGIC_VECTOR (15 downto 0);
signal PCALUResult: STD_LOGIC_VECTOR (15 downto 0);
signal SelectorOfPCALUAdder: STD_LOGIC_VECTOR (1 downto 0);

-- DataMemory Signals
signal DataMemoryWriteData: STD_LOGIC_VECTOR (15 downto 0);
signal DataMemoryReadData: STD_LOGIC_VECTOR (15 downto 0);
signal DataMemoryMode: STD_LOGIC_VECTOR (1 downto 0);

-- Single Registers
  -- SP
  signal SPInput: STD_LOGIC_VECTOR (15 downto 0);
  signal SPOutput: STD_LOGIC_VECTOR (15 downto 0);
  signal SPWriteEN: STD_LOGIC;
  -- IH
  signal IHInput: STD_LOGIC_VECTOR (15 downto 0);
  signal IHOutput: STD_LOGIC_VECTOR (15 downto 0);
  signal IHWriteEN: STD_LOGIC;
  -- T
  signal TInput: STD_LOGIC;
  signal TOutput: STD_LOGIC;
  signal TWriteEN: STD_LOGIC;
  -- PC
  signal PCInput: STD_LOGIC_VECTOR (15 downto 0);
  signal PCOutput: STD_LOGIC_VECTOR (15 downto 0);
  signal PCWriteEN: STD_LOGIC;
  -- Instruction
  --signal InstructionInput: STD_LOGIC_VECTOR (15 downto 0);
  --signal InstructionOutput: STD_LOGIC_VECTOR (15 downto 0);
  signal InstructionWriteEN: STD_LOGIC;

-- Between Selectors
signal Instruction4to2ShiftResult: STD_LOGIC_VECTOR (15 downto 0);
signal SelectedImmediate: STD_LOGIC_VECTOR (15 downto 0);
signal ComparatorParam2: STD_LOGIC_VECTOR (15 downto 0);

-- Instruction Memory
signal Instruction: STD_LOGIC_VECTOR (15 downto 0);
signal InstructionMemoryMode: STD_LOGIC_VECTOR (1 downto 0);
signal InstructionMemoryBoot: STD_LOGIC;

--Memory
signal MemoryAddress : STD_LOGIC_VECTOR (15 downto 0);

--UART
signal UARTReadData : STD_LOGIC_VECTOR (15 downto 0); 
signal UARTFINISH : STD_LOGIC;


signal st: INTEGER RANGE 0 TO 63:=0;
signal st_high: INTEGER RANGE 0 TO 63:=0;
signal st_low: INTEGER RANGE 0 TO 63:=0;

begin
	FLASH_A<="00000000000000000000000";
   FLASH_D<="0000000000000000";
	VGA_B<="000";
   VGA_G<="000";
   VGA_R<="000";
   VGA_HHYNC<='1';
   VGA_VHYNC<='1';
   PS2KB_CLOCK<='1';
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
   --DYP1(6 downto 3)<="1111";
	--DYP1(0)<=PS2KB_DATA;
	--DYP1(1)<=CLK;
	--DYP1(2)<=RESET;
	FPGA_LED<=SW_DIP;
	
	-- Instruction Debug Mode
	-- Instruction <= SW_DIP;
	
   -- Modules
	st_high <= st/16;
	st_low <= st mod 16;
	L1: DigitLights port map(DYP0,st_low);
	L2: DigitLights port map(DYP1,st_high);
	
	RegisterHeap_Entity: RegistersHeap port map ( 
	        Instruction(10 downto 8),
           Instruction(7 downto 5),
           SignalOfWriteRegister,
           SignalOfWriteRegisterData,
           SignalOfReadRegisterData1,
           SignalOfReadRegisterData2,
			  RegisterHeapEN);
   ALU_Entity: ALU port map (
	        ALUOperandA,
           ALUOperandB,
           ALUOperator,
           ALUResult);
   PCALU_Entity: PCALU port map ( 
	        PCALUAdder,
           PCOutput,
           PCALUResult);
   Comparator_Entity: Comparator port map ( 
	        SignalOfReadRegisterData1,
           ComparatorParam2,
           TInput);

	InstructionMemory_Entity: InstructionMemory port map (
	        PCOutput,
	        Instruction,
           RAM2ADDR,
           RAM2DATA,
           RAM2_EN,
			  RAM2_OE,
           RAM2_RW,
           CLK,
           InstructionMemoryBoot,
           InstructionMemoryMode);
	DataMemory_Entity: DataMemory port map ( 
	        ALUResult,
           DataMemoryWriteData,
           DataMemoryReadData,
           RAM1ADDR,
           RAM1DATA,
           RAM1_EN,
           RAM1_OE,
           RAM1_RW,
			  DATA_READY,
			  RDN,
			  TBRE,
			  TSRE,
			  WRN,
           CLK,
           DataMemoryMode);
			  
	Memory_Entity: Memory port map ( 
			  MemoryAddress,
           DataMemoryWriteData,
           DataMemoryReadData,
           RAM2ADDR,
           RAM2DATA,
           RAM2_EN,
           RAM2_OE,
           RAM2_RW,
           CLK,
           DataMemoryMode);
	
	UART_Entity:UART port map (
			  ALUResult,
           DataMemoryWriteData,
           UARTReadData,
           RAM1ADDR,
           RAM1DATA,
           RAM1_EN,
           RAM1_OE,
           RAM1_RW,
			  DATA_READY,
			  RDN,
			  TBRE,
			  TSRE,
			  WRN,
           CLK,
           DataMemoryMode,
			  UARTFINISH);

			  
   SelectorWriteRegister_Entity: SelectorWriteRegister port map (
           Instruction(10 downto 8),
           Instruction(7 downto 5),
           Instruction(4 downto 2),
           SelectorOfWriteRegister,
           SignalOfWriteRegister);
	SelectorWriteRegisterData_Entity: SelectorWriteRegisterData port map ( 
	        PCOutput,
           SignalOfReadRegisterData2,
           Instruction(7 downto 0),
           ALUResult,
           DataMemoryReadData,
           IHOutput,
			  UARTReadData,
           SelectorOfWriteRegisterData,
			  SignalOfWriteRegisterData);
	SelectorALUParam1_Entity: SelectorALUParam1 port map ( 
	        SignalOfReadRegisterData1,
           SPOutput,
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
	SelectorImmediate_Entity: SelectorImmediate port map ( 
	        Instruction(7 downto 0),
           Instruction(3 downto 0),
           SelectorOfImmediate,
           SelectedImmediate);
	SelectorSPInput_Entity: SelectorSPInput port map (
 	        SignalOfReadRegisterData1,
           ALUResult,
           SelectorOfSPInput,
           SPInput);
	SelectorDataMemoryWriteData_Entity: SelectorDataMemoryWriteData port map ( 
	        SignalOfReadRegisterData2,
           SignalOfReadRegisterData1,
           SelectorOfDataMemoryWriteData,
           DataMemoryWriteData);
	SelectorCMPParam_Entity: SelectorCMPParam port map (
           SignalOfReadRegisterData2,
           Instruction(7 downto 0),
           SelectorOfCMPParam,
           ComparatorParam2);
	SelectorPCBJ_Entity: SelectorPCBJ port map ( 
	        PCALUResult,
           SignalOfReadRegisterData1,
           SelectorOfPCBJ,
           PCInput);
	SelectorPCALUAdder_Entity: SelectorPCALUAdder port map (
           Instruction(7 downto 0),
           Instruction(10 downto 0),
           SelectorOfPCALUAdder,
           PCALUAdder);
   SelectorPCALUOp_Entity: SelectorPCALUOp port map (
 	        TOutput,
           SignalOfReadRegisterData1,
           SelectorOfPCALUOp,
           SelectorOfPCALUAdder);
   SelectorMemoryAddress_Entity: SelectorMemoryAddress port map(
			  ALUResult,
			  PCOutput,
			  SelectorOfDataMemoryWriteData,
			  MemoryAddress);
			  
	-- Single Registers
	SPRegister: SingleRegister port map (
	        SPInput,
           SPOutput,
           SPWriteEN);
   IHRegister: SingleRegister port map (
	        IHInput,
           IHOutput,
           IHWriteEN);
	IHInput <= SignalOfReadRegisterData1;
	
	InstructionRegister: SingleRegister port map (
	        DataMemoryReadData,
           Instruction,
           InstructionWriteEN);
	
	PCRegister: SingleRegister port map (
	        PCInput,
           PCOutput,
           PCWriteEN);
	TRegister: OneBitRegister port map ( 
	        TInput,
           TOutput,
           TWriteEN);
			
	-- Controller
		
	--process
	process(CLK)
	begin
		if(CLK'event and CLK='1')then
			case st is
				when others=>
					st <= st+1;
			end case;
		end if;
	end process;
end Behavioral;

