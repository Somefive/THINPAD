----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:35:42 11/09/2016 
-- Design Name: 
-- Module Name:    Main - Behavioral 
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

entity Main is
    Port ( FLASH_A : out  STD_LOGIC_VECTOR (22 downto 0);
           FLASH_D : inout  STD_LOGIC_VECTOR (15 downto 0);
           SW_DIP : in  STD_LOGIC_VECTOR (15 downto 0);
           CLK0 : in  STD_LOGIC;
           CLK1 : in  STD_LOGIC;
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
           CLK_FROM_KEY : in  STD_LOGIC;
           RESET : in  STD_LOGIC);
end Main;

architecture Behavioral of Main is

component Timer is
    Port ( CLK_INPUT : in STD_LOGIC;
			  CLK_MINOR : out STD_LOGIC);
end component;

component CPU is
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
end component;

component DigitLights is
    Port ( L : out  STD_LOGIC_VECTOR (6 downto 0);
           NUMBER : in  INTEGER);
end component;

signal CLK_MINOR: STD_LOGIC;

begin
	TIMER_ENTITY: Timer port map (CLK1,CLK_MINOR);
	CPU_ENTITY: CPU port map ( 
		FLASH_A,
		FLASH_D,
		SW_DIP,
		VGA_B,
		VGA_G,
		VGA_R,
		VGA_HHYNC,
		VGA_VHYNC,
		PS2KB_CLOCK,
		PS2KB_DATA,
		RAM1DATA,
		RAM2DATA,
		RAM1ADDR,
		RAM2ADDR,
		FLASH_BYTE,
		FLASH_CE,
		FLASH_CE1,
		FLASH_CE2,
		FLASH_OE,
		FLASH_RP,
		FLASH_STS,
		FLASH_VPEN,
		FLASH_WE,
		U_RXD,
		U_TXD,
		RAM1_EN,
		RAM1_OE,
		RAM1_RW,
		RAM2_EN,
		RAM2_OE,
		RAM2_RW,
		FPGA_LED,
		DYP0,
		DYP1,
		DATA_READY,
      RDN,
      TBRE,
      TSRE,
      WRN,
		CLK_FROM_KEY,
		RESET);
end Behavioral;

