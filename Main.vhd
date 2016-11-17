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
			  FINISH: out STD_LOGIC;
			  DYP: out STD_LOGIC_VECTOR (6 downto 0));
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

signal CLK_MINOR: STD_LOGIC;
signal st:integer:=0;
signal Address : STD_LOGIC_VECTOR(15 downto 0)  :="0000000000000000";
signal WriteData : STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
signal Mode : STD_LOGIC_VECTOR(1 downto 0):="11";
signal state : integer range 0 to 63 :=0;
begin
	TIMER_ENTITY: Timer port map (CLK1,CLK_MINOR);
	DL:DigitLights port map (DYP1, state);
	ME : Memory port map(Address, WriteData, FPGA_LED, RAM2ADDR, RAM2DATA, RAM2_EN, RAM2_OE, RAM2_RW, CLK1, Mode);
	process(CLK_FROM_KEY, state)
	begin
	if(CLK_FROM_KEY'event and CLK_FROM_KEY='1')then
		case state is
			when 0 =>
				Address <= SW_DIP;
				state <= 1;
			when 1 =>
				WriteData <= SW_DIP;
				state <= 2;
			when 2 =>
				Mode <= "10";
				state <= 3;
			when 3 =>
				Mode <= "11";
				state <= 5;
			when 5 =>
				Address <= SW_DIP;
				state <= 6;
			when 6 =>
				Mode <= "01";
				state <= 7;
			when 7 =>
				Mode <= "11";
				state <= 9;
			when others =>
				state <= 0;
		end case;
	end if;
	end process;
	
	FLASH_A <= "00000000000000000000000";
	FLASH_D <= "0000000000000000";
	VGA_B <= "000";
	VGA_G <= "000";
	VGA_R <= "000";
	VGA_HHYNC <= '1';
	VGA_VHYNC <= '1';
	PS2KB_CLOCK <= '1';
	RAM1DATA <= "0000000000000000";
	--RAM2DATA <= "0000000000000000";
	RAM1ADDR <= "000000000000000000";
	--RAM2ADDR <= "000000000000000000";
	FLASH_BYTE <= '1';
	FLASH_CE <= '1';
	FLASH_CE1 <= '1';
	FLASH_CE2 <= '1';
	FLASH_OE <= '1';
	FLASH_RP <= '1';
	FLASH_STS <= '1';
	FLASH_VPEN <= '1';
	FLASH_WE <= '1';
	U_RXD <= '1';
	U_TXD <= '1';
	RAM1_EN <= '1';
	RAM1_OE <= '1';
	RAM1_RW <= '1';
	--RAM2_EN <= '1';
	--RAM2_OE <= '1';
	--RAM2_RW <= '1';
	--FPGA_LED <= "0000000000000000";
	DYP0 <= "0000000";
	--DYP1 <= "0000000";
	RDN <= '1';
	WRN <= '1';
end Behavioral;

