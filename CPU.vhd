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

component DigitLights is
    Port ( L : out  STD_LOGIC_VECTOR (6 downto 0);
           NUMBER : in  INTEGER);
end component;

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
	
	with STEP select STEP_NUMBER <=
		0 when PERIOD_IF,
		1 when PERIOD_ID,
		2 when PERIOD_EXE,
		3 when PERIOD_MEM,
		4 when PERIOD_WB;
		
	L1: DigitLights port map(DYP0,STEP_NUMBER);
	
end Behavioral;

